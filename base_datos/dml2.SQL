-- DATOS DE EJEMPLO


-- WALLET
INSERT INTO Wallet (Creditos) VALUES
(1000),  -- Para Steve123
(800),   -- Para AlexPro
(1500),  -- Para EnderWarrior
(1200),  -- Para BlockMaster
(500);   -- Para CreeperHunter


-- JUGADORES

INSERT INTO Jugador (Nickname, Contraseña, ID_Wallet) VALUES
('Steve123', MD5('NewPassword2024!'), 1),
('AlexPro', MD5('SafePass2024_1'), 2),
('EnderWarrior', MD5('Warrior#Secure'), 3),
('BlockMaster', MD5('MasterBlock2024!'), 4),
('CreeperHunter', MD5('Hunter123@Creep'), 5);



-- COMPRA PAQUETES

INSERT INTO Compra (ID_Jugador, ID_Paquete) VALUES
(1, 2),  -- Steve123 compra el paquete intermedio
(2, 1),  -- AlexPro compra el paquete básico
(3, 4),  -- EnderWarrior compra el paquete premium
(4, 3),  -- BlockMaster compra el paquete avanzado
(5, 1);  -- CreeperHunter compra el paquete básico


-- TRANSACCIONES

INSERT INTO Transaccion (Origen, Destino, Descripcion, ID_Tipo_transaccion) VALUES
(1, 2, 'Steve123 vendió un bloque de diamante a AlexPro', 2),
(3, 1, 'EnderWarrior transfirió créditos a Steve123', 3),
(4, 5, 'BlockMaster vendió una espada de netherite a CreeperHunter', 2),
(2, 4, 'AlexPro transfirió créditos a BlockMaster', 3),
(5, 3, 'CreeperHunter vendió una manzana dorada a EnderWarrior', 2);


-- APUESTAS

INSERT INTO Apuesta (ID_Jugador, ID_Objeto, Cantidad, Resultado) VALUES
(1, 1, 5, 'Ganador'),  -- Steve123 apuesta 5 bloques de diamante y gana
(2, 4, 10, 'Perdedor'), -- AlexPro apuesta 10 lingotes de oro y pierde
(3, 3, 2, 'Ganador'),  -- EnderWarrior apuesta 2 manzanas doradas y gana
(4, 2, 1, 'Perdedor'), -- BlockMaster apuesta una espada de netherite y pierde
(5, 5, 3, 'Ganador');  -- CreeperHunter apuesta 3 Ender Pearls y gana


-- INVENTARIO


INSERT INTO Inventario (ID_Jugador, ID_Objeto, Cantidad) VALUES
(1, 1, 10),  -- Steve123 tiene 10 bloques de diamante
(2, 4, 15),  -- AlexPro tiene 15 lingotes de oro
(3, 3, 5),   -- EnderWarrior tiene 5 manzanas doradas
(4, 2, 1),   -- BlockMaster tiene 1 espada de netherite
(5, 5, 7);   -- CreeperHunter tiene 7 Ender Pearls


