# app/models.py

import hashlib
from flask_login import UserMixin
from sqlalchemy import func
from . import db

class Wallet(db.Model):
    __tablename__ = 'wallet'
    id_wallet = db.Column(db.Integer, primary_key=True)
    creditos = db.Column(db.Integer, nullable=False)

    # Relación con Jugador
    jugador = db.relationship('Jugador', back_populates='wallet', uselist=False)

class Jugador(db.Model, UserMixin):
    __tablename__ = 'jugador'
    id_jugador = db.Column(db.Integer, primary_key=True)
    nickname = db.Column(db.String(30), unique=True, nullable=False)
    contraseña = db.Column(db.String(255), nullable=False)
    id_wallet = db.Column(db.Integer, db.ForeignKey('wallet.id_wallet'))

    # Relación con Wallet y otras tablas
    wallet = db.relationship('Wallet', back_populates='jugador')
    transacciones_origen = db.relationship('Transaccion', foreign_keys='Transaccion.origen', back_populates='jugador_origen')
    transacciones_destino = db.relationship('Transaccion', foreign_keys='Transaccion.destino', back_populates='jugador_destino')
    apuestas = db.relationship('Apuesta', back_populates='jugador')
    inventario = db.relationship('Inventario', back_populates='jugador')
    compras = db.relationship('Compra', back_populates='jugador')

    def set_password(self, contraseña):
        self.contraseña = hashlib.md5(contraseña.encode()).hexdigest()

    def check_password(self, contraseña):
        return self.contraseña == hashlib.md5(contraseña.encode()).hexdigest()

    def get_id(self):
        return str(self.id_jugador)

class TipoTransaccion(db.Model):
    __tablename__ = 'tipo_transaccion'
    id_tipo_transaccion = db.Column(db.Integer, primary_key=True)
    nombre_tipo = db.Column(db.String(50), nullable=False)

    # Relación con Transaccion
    transacciones = db.relationship('Transaccion', back_populates='tipo_transaccion')

class Objeto(db.Model):
    __tablename__ = 'objeto'
    id_objeto = db.Column(db.Integer, primary_key=True)
    nombre_objeto = db.Column(db.String(50), nullable=True)
    cantidad_max = db.Column(db.Integer, nullable=False)
    valor = db.Column(db.Integer, nullable=False)

    # Relación con Inventario y Apuesta
    inventarios = db.relationship('Inventario', back_populates='objeto')
    apuestas = db.relationship('Apuesta', back_populates='objeto')

class Transaccion(db.Model):
    __tablename__ = 'transaccion'
    id_transaccion = db.Column(db.Integer, primary_key=True)
    origen = db.Column(db.Integer, db.ForeignKey('jugador.id_jugador'))
    destino = db.Column(db.Integer, db.ForeignKey('jugador.id_jugador'))
    descripcion = db.Column(db.String(80), nullable=False)
    id_tipo_transaccion = db.Column(db.Integer, db.ForeignKey('tipo_transaccion.id_tipo_transaccion'))

    # Relación con Jugador y TipoTransaccion
    jugador_origen = db.relationship('Jugador', foreign_keys=[origen], back_populates='transacciones_origen')
    jugador_destino = db.relationship('Jugador', foreign_keys=[destino], back_populates='transacciones_destino')
    tipo_transaccion = db.relationship('TipoTransaccion', back_populates='transacciones')

class Apuesta(db.Model):
    __tablename__ = 'apuesta'
    id_apuesta = db.Column(db.Integer, primary_key=True)
    id_jugador = db.Column(db.Integer, db.ForeignKey('jugador.id_jugador'))
    id_objeto = db.Column(db.Integer, db.ForeignKey('objeto.id_objeto'))
    cantidad = db.Column(db.Integer, nullable=False)
    resultado = db.Column(db.String(20), nullable=True)

    # Relación con Jugador y Objeto
    jugador = db.relationship('Jugador', back_populates='apuestas')
    objeto = db.relationship('Objeto', back_populates='apuestas')

class Inventario(db.Model):
    __tablename__ = 'inventario'
    id_inventario = db.Column(db.Integer, primary_key=True)
    id_jugador = db.Column(db.Integer, db.ForeignKey('jugador.id_jugador'))
    id_objeto = db.Column(db.Integer, db.ForeignKey('objeto.id_objeto'))
    cantidad = db.Column(db.Integer, nullable=False)

    # Relación con Jugador y Objeto
    jugador = db.relationship('Jugador', back_populates='inventario')
    objeto = db.relationship('Objeto', back_populates='inventarios')

class PaqueteCreditos(db.Model):
    __tablename__ = 'paquete_creditos'
    id_paquete = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)
    cantidad_creditos = db.Column(db.Integer, nullable=False)
    precio_usd = db.Column(db.Numeric(5, 2), nullable=False)
    bonificacion = db.Column(db.Integer, default=0)

    # Relación con Compra
    compras = db.relationship('Compra', back_populates='paquete')

class Compra(db.Model):
    __tablename__ = 'compra'
    id_compra = db.Column(db.Integer, primary_key=True)
    id_jugador = db.Column(db.Integer, db.ForeignKey('jugador.id_jugador'))
    id_paquete = db.Column(db.Integer, db.ForeignKey('paquete_creditos.id_paquete'))
    fecha = db.Column(db.DateTime, server_default=func.now())

    # Relación con Jugador y PaqueteCreditos
    jugador = db.relationship('Jugador', back_populates='compras')
    paquete = db.relationship('PaqueteCreditos', back_populates='compras')
