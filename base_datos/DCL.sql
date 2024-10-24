-- aca los datos para crear las tablas de la base de datos

CREATE TABLE Wallet (
    ID_Wallet SERIAL PRIMARY KEY,
    Creditos INT NOT NULL
);

CREATE TABLE Jugador (
    ID_Jugador SERIAL PRIMARY KEY,
    Nickname VARCHAR(30) NOT NULL UNIQUE,
    Contraseña VARCHAR(255) NOT NULL, 
    ID_Wallet INT REFERENCES Wallet(ID_Wallet)
);



CREATE TABLE Tipo_transaccion (
    ID_Tipo_transaccion SERIAL PRIMARY KEY,
    Nombre_tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Objeto (
    ID_Objeto SERIAL PRIMARY KEY,
    Nombre_Objeto VARCHAR(50),
    Cantidad_max INT NOT NULL,
    Valor INT NOT NULL
);

CREATE TABLE Transaccion (
    ID_Transaccion SERIAL PRIMARY KEY,
    Origen INT REFERENCES Jugador(ID_Jugador),
    Destino INT REFERENCES Jugador(ID_Jugador),
    Descripcion VARCHAR(80) NOT NULL,
    ID_Tipo_transaccion INT REFERENCES Tipo_transaccion(ID_Tipo_transaccion)
);

CREATE TABLE Apuesta (
    ID_apuesta SERIAL PRIMARY KEY,
    ID_Jugador INT REFERENCES Jugador(ID_Jugador),
    ID_Objeto INT REFERENCES Objeto(ID_Objeto),
    Cantidad INT NOT NULL,
    Resultado VARCHAR(20)
);

CREATE TABLE Inventario (
    ID_Inventario SERIAL PRIMARY KEY,
    ID_Jugador INT REFERENCES Jugador(ID_Jugador),
    ID_Objeto INT REFERENCES Objeto(ID_Objeto),
    Cantidad INT NOT NULL
);


-- compra de creditos

CREATE TABLE Paquete_Creditos (
    ID_Paquete SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Cantidad_Creditos INT NOT NULL,
    Precio_USD DECIMAL(5,2) NOT NULL,
    Bonificacion INT DEFAULT 0
);

CREATE TABLE Compra (
    ID_Compra SERIAL PRIMARY KEY,
    ID_Jugador INT REFERENCES Jugador(ID_Jugador),
    ID_Paquete INT REFERENCES Paquete_Creditos(ID_Paquete),
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- actualizar creditos del jugador

CREATE OR REPLACE FUNCTION actualizar_creditos_wallet() RETURNS TRIGGER AS $$
BEGIN
    -- Actualiza la cantidad de créditos en la Wallet del jugador
    UPDATE Wallet
    SET Creditos = Creditos + (SELECT Cantidad_Creditos FROM Paquete_Creditos WHERE ID_Paquete = NEW.ID_Paquete)
    WHERE ID_Wallet = (SELECT ID_Wallet FROM Jugador WHERE ID_Jugador = NEW.ID_Jugador);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- tigger de la funcion

CREATE TRIGGER trigger_actualizar_wallet
AFTER INSERT ON Compra
FOR EACH ROW
EXECUTE FUNCTION actualizar_creditos_wallet();
