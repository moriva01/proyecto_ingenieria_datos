-- agregar datos de prueba a la base de datos

--crear el usuario con todos los permisos para la conexion
CREATE USER connector WITH PASSWORD 'connector';
GRANT ALL PRIVILEGES ON DATABASE minecraft_bd TO connector; -- el nombre de la base de datos
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO connector;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO connector;
GRANT CREATE ON SCHEMA public TO connector;


-- objetos (recursos del minecraft)

INSERT INTO Objeto (Nombre_Objeto, Cantidad_max, Valor) VALUES 
('Bloque de diamante', 64, 9000),
('Lingote de hierro', 64, 500),
('Lingote de oro', 64, 800),
('Ender Pearl', 16, 1200),
('Bloque de esmeralda', 64, 10000),
('Manzana dorada', 64, 1500),
('Poción de fuerza', 16, 1200),
('Espada de netherite', 1, 5000),
('Pico de diamante', 1, 1500),
('Totem de inmortalidad', 1, 5000),
('Flecha', 64, 100),
('Bloque de carbón', 64, 400),
('Redstone', 64, 300),
('Ladrillo de piedra', 64, 50),
('Cristal', 64, 70),
('Bloque de obsidiana', 64, 1000),
('Perla del Ender', 16, 800),
('Bloque de Netherite', 64, 20000),
('Bloque de lana blanca', 64, 100),
('Cofre', 64, 200);


-- precios de los creditos

INSERT INTO Paquete_Creditos (Nombre, Cantidad_Creditos, Precio_USD, Bonificacion) VALUES
('Paquete Básico', 500, 4.99, 0),
('Paquete Intermedio', 1200, 9.99, 20),
('Paquete Avanzado', 2500, 19.99, 25),
('Paquete Premium', 5500, 39.99, 37),
('Paquete Épico', 12000, 79.99, 50);


-- tipos de transaccion

INSERT INTO Tipo_transaccion (Nombre_tipo) VALUES
('Compra de Objeto'),
('Venta de Objeto'),
('Transferencia de Créditos'),
('Apuesta Ganada'),
('Apuesta Perdida');
