# app/routes.py

from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_user, logout_user, login_required, current_user
from .models import db, Jugador, Wallet, Inventario, Objeto, Transaccion, Apuesta, PaqueteCreditos, Compra
import random
from datetime import datetime, timedelta

# Definimos el Blueprint de rutas
routes = Blueprint('routes', __name__)


# Variable para almacenar el estado del dispensador
ultima_apuesta_dispensador = datetime.now()

@routes.route('/apuestas', methods=['GET', 'POST'])
@login_required
def apuestas():
    jugador = current_user
    
    # Obtener el inventario del jugador
    inventario = (
        db.session.query(Objeto, Inventario.cantidad)
        .join(Inventario, Objeto.id_objeto == Inventario.id_objeto)
        .filter(Inventario.id_jugador == jugador.id_jugador)
        .all()
    )

    if request.method == 'POST':
        objeto_id = request.form.get('objeto_id')
        cantidad = int(request.form.get('cantidad'))
        
        # Verificar si el jugador tiene suficientes recursos en su inventario
        inventario_item = Inventario.query.filter_by(id_jugador=jugador.id_jugador, id_objeto=objeto_id).first()
        if not inventario_item or inventario_item.cantidad < cantidad:
            flash("No tienes suficientes recursos para realizar esta apuesta", "error")
            return redirect(url_for('routes.apuestas'))

        # Simular el resultado de la apuesta (50% de ganar o perder)
        resultado = random.choice(['ganado', 'perdido'])

        # Si el jugador gana, duplica los recursos en el inventario
        if resultado == 'ganado':
            inventario_item.cantidad += cantidad  # Duplica la cantidad apostada
            flash("¡Ganaste la apuesta! Tus recursos se han duplicado", "success")
        else:
            # Si pierde, resta los recursos apostados
            inventario_item.cantidad -= cantidad
            if inventario_item.cantidad == 0:
                db.session.delete(inventario_item)
            flash("Perdiste la apuesta. Los recursos apostados se han retirado", "error")

        # Registrar la apuesta en la tabla Apuesta
        apuesta = Apuesta(
            id_jugador=jugador.id_jugador,
            id_objeto=objeto_id,
            cantidad=cantidad,
            resultado=resultado
        )
        db.session.add(apuesta)
        db.session.commit()

        return redirect(url_for('routes.apuestas'))

    return render_template('apuestas.html', inventario=inventario)


# app/routes.py

def apuesta_dispensador():
    global ultima_apuesta_dispensador
    ahora = datetime.now()
    
    # Ejecutar solo si ha pasado una hora desde la última apuesta y si hay al menos un jugador apostando
    if ahora >= ultima_apuesta_dispensador + timedelta(hours=1):
        # Obtener todas las apuestas pendientes en el dispensador
        apuestas_pendientes = Apuesta.query.filter_by(resultado=None).all()

        if not apuestas_pendientes:
            return  # No hay apuestas pendientes

        # Procesar cada apuesta en el dispensador
        for apuesta in apuestas_pendientes:
            resultado = random.choice(['ganado', 'perdido'])

            # Obtener el inventario del jugador
            inventario = Inventario.query.filter_by(id_jugador=apuesta.id_jugador, id_objeto=apuesta.id_objeto).first()

            if resultado == 'ganado':
                inventario.cantidad += apuesta.cantidad  # Duplica la cantidad apostada
                flash(f"¡Jugador {apuesta.id_jugador} ganó la apuesta en el dispensador!", "success")
            else:
                inventario.cantidad -= apuesta.cantidad
                if inventario.cantidad == 0:
                    db.session.delete(inventario)
                flash(f"Jugador {apuesta.id_jugador} perdió la apuesta en el dispensador.", "error")

            # Actualizar el resultado de la apuesta
            apuesta.resultado = resultado

        # Guardar cambios en la base de datos
        db.session.commit()
        ultima_apuesta_dispensador = ahora




@routes.route('/comprar_creditos', methods=['GET', 'POST'])
@login_required
def comprar_creditos():
    jugador = current_user
    wallet = Wallet.query.get(jugador.id_wallet)
    
    # Obtener todos los paquetes de créditos disponibles
    paquetes = PaqueteCreditos.query.all()

    if request.method == 'POST':
        paquete_id = request.form.get('paquete_id')
        
        # Verificar que el paquete seleccionado es válido
        paquete = PaqueteCreditos.query.get(paquete_id)
        if not paquete:
            flash("Paquete no válido", "error")
            return redirect(url_for('routes.comprar_creditos'))

        # Agregar créditos y bonificación al wallet del jugador
        wallet.creditos += paquete.cantidad_creditos + paquete.bonificacion

        # Registrar la compra en la tabla Compra
        compra = Compra(
            id_jugador=jugador.id_jugador,
            id_paquete=paquete.id_paquete
        )
        db.session.add(compra)
        
        # Registrar la transacción de compra de créditos
        transaccion = Transaccion(
            origen=None,  # La compra de créditos no tiene un origen específico
            destino=jugador.id_jugador,
            descripcion=f"Compra de {paquete.cantidad_creditos} créditos + {paquete.bonificacion} de regalo",
            id_tipo_transaccion=4  # Ejemplo: 4 puede representar "compra de créditos"
        )
        db.session.add(transaccion)
        db.session.commit()

        flash("Créditos comprados con éxito", "success")
        return redirect(url_for('routes.home'))

    return render_template('comprar_creditos.html', paquetes=paquetes, wallet=wallet)

@routes.route('/comprar_vender', methods=['GET', 'POST'])
@login_required
def comprar_vender():
    jugador = current_user
    wallet = Wallet.query.get(jugador.id_wallet)
    
    # Obtener todos los objetos y calcular el valor por stack
    objetos = (
        db.session.query(
            Objeto.id_objeto,
            Objeto.nombre_objeto,
            Objeto.valor.label('precio_stack'),  # Usamos el valor total del objeto como precio por stack
            Objeto.cantidad_max
        )
        .all()
    )

    if request.method == 'POST':
        accion = request.form.get('accion')
        objeto_id = request.form.get('objeto_id')
        
        # Verificar que el objeto seleccionado es válido
        objeto = Objeto.query.get(objeto_id)
        if not objeto:
            flash("Objeto no válido", "error")
            return redirect(url_for('routes.comprar_vender'))

        if accion == 'comprar':
            cantidad_stack = int(request.form.get('cantidad_stack'))
            
            # Calcular el costo total basado en stacks
            costo_total = objeto.valor * cantidad_stack

            # Verificar si el jugador tiene suficientes créditos
            if wallet.creditos >= costo_total:
                # Descontar créditos del jugador actual
                wallet.creditos -= costo_total

                # Añadir el objeto al inventario del jugador
                inventario = Inventario.query.filter_by(id_jugador=jugador.id_jugador, id_objeto=objeto_id).first()
                if inventario:
                    inventario.cantidad += objeto.cantidad_max * cantidad_stack  # Agregar cantidad por stack
                else:
                    nuevo_inventario = Inventario(
                        id_jugador=jugador.id_jugador,
                        id_objeto=objeto_id,
                        cantidad=objeto.cantidad_max * cantidad_stack  # Cantidad por stack
                    )
                    db.session.add(nuevo_inventario)

                # Registrar la transacción de compra
                transaccion = Transaccion(
                    origen=jugador.id_jugador,
                    destino=None,  # No hay un destino específico para la compra
                    descripcion=f"Compra de {cantidad_stack} stack(s) de {objeto.nombre_objeto}",
                    id_tipo_transaccion=1  # Ejemplo: 1 puede representar "compra"
                )
                db.session.add(transaccion)
                db.session.commit()

                flash("Compra realizada con éxito", "success")
            else:
                flash("No tienes suficientes créditos", "error")

        elif accion == 'vender':
            cantidad_unidades = int(request.form.get('cantidad_unidades'))

            # Verificar que el jugador tenga suficientes unidades para vender
            inventario = Inventario.query.filter_by(id_jugador=jugador.id_jugador, id_objeto=objeto_id).first()
            if not inventario or inventario.cantidad < cantidad_unidades:
                flash("No tienes suficientes unidades para vender", "error")
                return redirect(url_for('routes.comprar_vender'))

            # Obtener el valor unitario y calcular el crédito a agregar
            credito_ganado = (objeto.valor / objeto.cantidad_max) * cantidad_unidades
            wallet.creditos += credito_ganado

            # Restar la cantidad vendida del inventario
            inventario.cantidad -= cantidad_unidades
            if inventario.cantidad == 0:
                db.session.delete(inventario)

            # Registrar la transacción de venta
            transaccion = Transaccion(
                origen=jugador.id_jugador,
                destino=None,  # Venta al sistema
                descripcion=f"Venta de {cantidad_unidades} unidades de {objeto.nombre_objeto}",
                id_tipo_transaccion=2  # Ejemplo: 2 puede representar "venta"
            )
            db.session.add(transaccion)
            db.session.commit()

            flash("Venta realizada con éxito", "success")

        elif accion == 'transferir':
            cantidad_unidades = int(request.form.get('cantidad_unidades'))
            nickname_destinatario = request.form.get('nickname_destinatario')

            # Verificar que el jugador tenga suficientes unidades para transferir
            inventario = Inventario.query.filter_by(id_jugador=jugador.id_jugador, id_objeto=objeto_id).first()
            if not inventario or inventario.cantidad < cantidad_unidades:
                flash("No tienes suficientes unidades para transferir", "error")
                return redirect(url_for('routes.comprar_vender'))

            # Verificar que el destinatario existe
            destinatario = Jugador.query.filter_by(nickname=nickname_destinatario).first()
            if not destinatario:
                flash("El jugador destinatario no existe", "error")
                return redirect(url_for('routes.comprar_vender'))

            # Restar la cantidad transferida del inventario del jugador actual
            inventario.cantidad -= cantidad_unidades
            if inventario.cantidad == 0:
                db.session.delete(inventario)

            # Añadir la cantidad transferida al inventario del destinatario
            inventario_destinatario = Inventario.query.filter_by(id_jugador=destinatario.id_jugador, id_objeto=objeto_id).first()
            if inventario_destinatario:
                inventario_destinatario.cantidad += cantidad_unidades
            else:
                nuevo_inventario_destinatario = Inventario(
                    id_jugador=destinatario.id_jugador,
                    id_objeto=objeto_id,
                    cantidad=cantidad_unidades
                )
                db.session.add(nuevo_inventario_destinatario)

            # Registrar la transacción de transferencia
            transaccion = Transaccion(
                origen=jugador.id_jugador,
                destino=destinatario.id_jugador,
                descripcion=f"Transferencia de {cantidad_unidades} unidades de {objeto.nombre_objeto} a {nickname_destinatario}",
                id_tipo_transaccion=3  # Ejemplo: 3 puede representar "transferencia"
            )
            db.session.add(transaccion)
            db.session.commit()

            flash("Transferencia realizada con éxito", "success")

        return redirect(url_for('routes.comprar_vender'))

    return render_template('comprar_vender.html', wallet=wallet, objetos=objetos)

@routes.route('/home')
@login_required
def home():
    # Obtener el jugador actual y sus créditos en la wallet
    jugador = current_user
    wallet = Wallet.query.get(jugador.id_wallet)
    
    # Consultar el inventario del jugador con el valor unitario
    inventario = (
        db.session.query(
            Objeto.nombre_objeto,
            Inventario.cantidad,
            (Objeto.valor / Objeto.cantidad_max).label('valor_unitario')  # Calcula el valor unitario
        )
        .join(Inventario, Objeto.id_objeto == Inventario.id_objeto)
        .filter(Inventario.id_jugador == jugador.id_jugador)
        .all()
    )

    return render_template('home.html', jugador=jugador, wallet=wallet, inventario=inventario)

@routes.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        nickname = request.form['nickname']
        contrasena = request.form['contrasena']
        
        # Buscar al jugador en la base de datos por su nickname
        jugador = Jugador.query.filter_by(nickname=nickname).first()
        
        # Verificar que el jugador existe y la contraseña coincide
        if jugador and jugador.check_password(contrasena):
            # Autenticar al jugador
            login_user(jugador)
            return redirect(url_for('routes.home'))  # Redirige al inicio si es exitoso
        else:
            return render_template('login.html', error="Nickname o contraseña incorrecta")
    
    # Si es una petición GET, renderiza el formulario de login
    return render_template('login.html')

@routes.route('/logout')
@login_required
def logout():
    # Cierra la sesión del usuario
    logout_user()
    return redirect(url_for('routes.login'))
