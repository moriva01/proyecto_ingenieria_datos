## 🔍 Información Detallada del Sistema: Dependencias Funcionales

| Dependencia Funcional                  | Descripción                                                                                                   |
|----------------------------------------|---------------------------------------------------------------------------------------------------------------|
| **ID_Jugador » Nickname**              | Si sabemos la ID del jugador, podemos conocer el nombre del jugador.                                          |
| **ID_Jugador » Contraseña**            | Teniendo la ID del jugador, se puede saber la contraseña del jugador.                                         |
| **ID_Jugador » Wallet**                | Si conocemos la ID del jugador, podemos averiguar la cartera del jugador.                                     |
| **ID_Inventario » ID_Jugador**         | Si se tiene la ID del inventario, podemos saber de quién es el inventario.                                    |
| **ID_Inventario » ID_Objeto**          | Al tener la ID del inventario, se puede conocer los objetos que hay en el inventario.                         |
| **ID_Inventario » Cantidad**           | Si se conoce la ID del inventario, podemos averiguar la cantidad de los objetos que hay en el inventario.     |
| **ID_Objeto » Nombre_Objeto**          | Al conocer la ID del objeto, podemos saber el nombre del objeto.                                              |
| **ID_Objeto » Cantidad_max**           | Si sabemos la ID del objeto, podemos averiguar la cantidad máxima de un objeto.                               |
| **ID_Objeto » Valor**                  | Cuando tenemos la ID del objeto, podemos saber el valor del objeto.                                           |
| **Nombre_Objeto » Cantidad_max**       | Cuando se conoce el nombre del objeto, podemos saber la cantidad máxima de un único objeto.                   |
| **Nombre_Objeto » Valor**              | Si tenemos el nombre del objeto, podemos conocer el valor del objeto.                                         |
| **ID_apuesta » ID_Jugador**            | Conociendo la ID de apuesta, podemos averiguar el jugador que realizó la apuesta.                             |
| **ID_apuesta » ID_Objeto**             | Si conocemos la ID de apuesta, podemos saber el objeto apostado.                                              |
| **ID_apuesta » Cantidad**              | Cuando sabemos la ID de apuesta, se puede averiguar la cantidad apostada.                                     |
| **ID_apuesta » Resultado**             | Si tenemos la ID de apuesta, podemos saber el resultado de la apuesta.                                        |
| **ID_Wallet » Creditos**               | Al tener la ID de la cartera, podemos saber la cantidad de créditos que tiene un jugador.                     |
| **ID_Compra » ID_Jugador**             | Cuando conocemos la ID de compra, podemos saber el jugador que hizo la compra.                                |
| **ID_Compra » ID_Paquete**             | Si se sabe la ID de compra, podemos averiguar el paquete de créditos.                                         |
| **ID_Compra » Fecha**                  | Al saber la ID de compra, se puede conocer la fecha en la que hizo la compra.                                 |
| **ID_Paquete » Nombre**                | Cuando se tiene la ID del paquete de créditos, podemos saber el nombre del paquete.                           |
| **ID_Paquete » Cantidad_Creditos**     | Al conocer la ID del paquete, se puede saber la cantidad de créditos del paquete.                             |
| **ID_Paquete » Precio_USD**            | Cuando se conoce la ID del paquete de créditos, se puede averiguar el precio en dólares del paquete.          |
| **Nombre » Cantidad_Creditos**         | Si sabemos el nombre del paquete, entonces podemos conocer el precio del paquete de créditos.                 |
| **Nombre » Precio_USD**                | Al tener el nombre del paquete de créditos, podemos averiguar el precio en dólares del paquete.               |
| **Precio_USD » Bonificación**          | Si se tiene el precio del paquete de créditos, se puede saber la bonificación por la compra del paquete.      |
| **ID_transaccion » Origen**            | Teniendo la ID de la transacción, podemos averiguar quién fue el jugador que originó esta transacción.        |
| **ID_transaccion » Destino**           | Conociendo la ID de la transacción, podemos saber el jugador destinatario de esta transacción.                |
| **ID_transaccion » Descripción**       | Si se sabe la ID de la transacción, entonces podemos conocer los detalles por medio de la descripción.        |
| **ID_transaccion » ID_Tipo_transaccion** | Cuando tenemos la ID de la transacción, podemos saber el tipo de transacción que se realizó.                |
| **ID_Tipo_transaccion » Nombre_tipo**  | Al conocer la ID del tipo de transacción, podemos saber cuál fue la transacción que se realizó.               |
