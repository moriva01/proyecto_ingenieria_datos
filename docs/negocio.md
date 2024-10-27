# 📜 Reglas de Negocio

Este documento detalla las reglas de negocio que rigen el sistema de compra, venta y apuesta de recursos en el servidor de Minecraft. Las reglas están organizadas en secciones para abarcar la 💰 generación de ganancias, 🔗 mecanismos de referidos, 📊 niveles, y otras lógicas relevantes.

---

## 💰 Generación de Ganancias

1. **Ganancias por Ventas de Recursos**:
   - Los jugadores pueden generar ganancias al vender recursos a otros jugadores.
   - El precio de cada recurso está fijado en el sistema para asegurar la estabilidad económica del servidor.
   - Las ganancias de cada venta se depositan en la wallet del jugador que realiza la venta.

2. **Ganancias por Apuestas**:
   - Los jugadores pueden apostar recursos para intentar ganar más.
   - Si el jugador gana, el recurso apostado se duplica y se agrega al inventario del jugador.
   - En caso de perder, el recurso apostado se retira del inventario.
   - Este sistema permite que los jugadores aumenten sus recursos o pierdan, fomentando el riesgo y la estrategia.

3. **Ganancias por Referidos**:
   - Los jugadores pueden invitar a otros usuarios al sistema a través de un enlace de referido único.
   - Cada jugador referido otorga una bonificación en créditos al jugador que lo refirió una vez que el referido completa su primera compra de créditos.
   - La bonificación se añade directamente a la wallet del jugador que refirió.

---

## 🔗 Mecanismos de Referidos

1. **Enlace de Referido Único**:
   - Cada jugador tiene un enlace de referido único, que puede compartir con amigos.
   - Cuando un nuevo usuario se registra a través del enlace, se asocia automáticamente con el jugador que lo refirió.

2. **Bonificación por Primer Compra**:
   - Al completar la primera compra de créditos, el nuevo jugador activa una bonificación que se transfiere al wallet del jugador que lo refirió.
   - La bonificación es un porcentaje del valor del paquete de créditos comprado.

3. **Límites y Condiciones**:
   - Cada jugador puede referir a múltiples personas, pero la bonificación solo se activa una vez por jugador referido.
   - La cantidad de la bonificación puede variar en función del paquete de créditos adquirido por el referido.

---

## 📊 Niveles de Jugadores

1. **Sistema de Niveles**:
   - Los jugadores progresan a través de distintos niveles basados en la cantidad de créditos gastados y recursos adquiridos.
   - Cada nivel otorga beneficios adicionales, como descuentos en la compra de créditos o un aumento en las bonificaciones de referidos.

2. **Requisitos de Nivel**:
   - **Nivel 1**: Acceso básico al sistema de compra y venta de recursos.
   - **Nivel 2**: Requiere al menos 5,000 créditos gastados. Beneficios: 5% de descuento en la compra de créditos.
   - **Nivel 3**: Requiere 15,000 créditos gastados. Beneficios: 10% de descuento en la compra de créditos y 10% más en la bonificación de referidos.
   - **Nivel 4**: Requiere 30,000 créditos gastados. Beneficios: 15% de descuento en la compra de créditos y acceso a objetos especiales en el inventario.

3. **Beneficios de Nivel**:
   - Los beneficios de nivel se aplican automáticamente una vez alcanzado el umbral de cada nivel.
   - Los jugadores mantienen su nivel, incluso si los créditos gastados o recursos adquiridos se reducen.

---

## 📌 Otras Lógicas Relevantes

1. **Límites de Créditos y Recursos**:
   - Los jugadores no pueden exceder un límite de 100,000 créditos en su wallet para evitar acumulación excesiva de recursos.
   - Los recursos en el inventario tienen límites de "stack" (por ejemplo, 64 para bloques comunes), lo cual regula la cantidad máxima de cada tipo de recurso.

2. **Mecanismo de Control de Apuestas**:
   - Las apuestas están limitadas a recursos que el jugador posee en su inventario.
   - Si un jugador intenta apostar una cantidad superior a la que tiene, el sistema no permitirá la transacción.
   - Cada apuesta queda registrada en el historial del jugador, incluyendo la fecha, cantidad y resultado.

---

Estas reglas aseguran la equidad y equilibrio en el sistema de comercio y apuestas del servidor, promoviendo un entorno de juego seguro y emocionante.
