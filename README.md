# 📦 Minecraft Resource Trading & Betting System

Bienvenido al repositorio del **Sistema de Compra, Venta y Apuesta de Recursos** para servidores de Minecraft. Este sistema permite a los usuarios realizar transacciones, adquirir recursos y apostar en un entorno controlado dentro de un servidor de Minecraft. El proyecto busca ofrecer una experiencia de juego enriquecida, facilitando la economía interna del servidor mediante una estructura de créditos y un sistema de inventario.

## 📄 Resumen del Proyecto

Este proyecto está diseñado para manejar la economía en servidores de Minecraft a través de:
1. **Compra y venta de recursos**: Los usuarios pueden intercambiar recursos con otros jugadores utilizando créditos.
2. **Apuestas**: Los jugadores pueden realizar apuestas con recursos específicos para ganar o perder objetos.
3. **Gestión de créditos**: Los usuarios pueden comprar créditos con dinero real y usarlos para realizar transacciones o apuestas.

## ⚙️ Reglas del Sistema de Transacciones

El sistema de transacciones se basa en las siguientes reglas para asegurar la integridad de las operaciones y el balance de los jugadores:

1. **Créditos y Wallets**:
   - Cada jugador tiene una wallet asociada donde se almacenan sus créditos.
   - Los créditos pueden ser adquiridos mediante la compra de paquetes, disponibles en distintos niveles y con bonificaciones según el valor del paquete.
   - Los créditos son el medio principal para realizar transacciones y apuestas en el sistema.

2. **Compra y Venta de Recursos**:
   - Los jugadores pueden comprar recursos utilizando créditos de su wallet.
   - Las transacciones entre jugadores (compra o venta de recursos) requieren una aprobación de ambos usuarios, y una vez aprobadas, se debitan y acreditan los créditos en las wallets correspondientes.
   - Todos los recursos tienen un valor de mercado establecido, lo que permite precios uniformes y facilita el intercambio.

3. **Sistema de Apuestas**:
   - Los jugadores pueden realizar apuestas utilizando recursos específicos en su inventario.
   - Cada apuesta debe declarar el tipo de recurso, la cantidad y el resultado de la apuesta (ganado o perdido).
   - Si un jugador gana una apuesta, los recursos apostados se duplican y se añaden a su inventario. Si pierde, los recursos se retiran.

4. **Inventario**:
   - Cada jugador tiene un inventario donde se almacenan los recursos adquiridos o ganados en apuestas.
   - Los recursos tienen un límite de cantidad máxima en un "stack" (por ejemplo, 64 unidades para la mayoría de los objetos).
   - Las transacciones de venta y apuestas reducen el inventario del jugador, mientras que las compras y ganancias de apuestas incrementan su inventario.

5. **Registro de Transacciones**:
   - Todas las transacciones, incluyendo compras, ventas y transferencias de créditos entre jugadores, son registradas en el sistema.
   - Las transacciones tienen un tipo asociado, como "Compra de Objeto", "Venta de Objeto", "Transferencia de Créditos", "Apuesta Ganada" o "Apuesta Perdida".
   - Cada transacción indica el jugador de origen y destino, lo que permite mantener un historial completo de todas las actividades.

Este sistema asegura un entorno seguro y transparente para las transacciones, enriqueciendo la experiencia de juego en el servidor y fomentando la economía interna.

