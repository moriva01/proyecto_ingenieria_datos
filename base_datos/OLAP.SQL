-- Tabla de dimensión de tiempo
CREATE TABLE dim_tiempo (
    id_tiempo SERIAL PRIMARY KEY,
    fecha DATE,
    hora TIME,
    dia INT,
    mes INT,
    año INT,
    semana INT
);

-- Tabla de dimensión de usuarios
CREATE TABLE dim_usuario (
    id_usuario INT PRIMARY KEY,
    nickname VARCHAR(50),
    tipo_actividad VARCHAR(20)  -- 'compra' o 'apuesta'
);

-- Tabla de dimensión de transacciones
CREATE TABLE dim_transaccion (
    id_transaccion SERIAL PRIMARY KEY,
    tipo_transaccion VARCHAR(20)  -- 'compra', 'apuesta ganada', 'apuesta perdida'
);

-- Tabla de dimensión de objetos
CREATE TABLE dim_objeto (
    id_objeto INT PRIMARY KEY,
    nombre_objeto VARCHAR(50)
);

-- Tabla de hechos para compras
CREATE TABLE fact_compras (
    id_compra SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES dim_usuario(id_usuario),
    id_tiempo INT REFERENCES dim_tiempo(id_tiempo),
    cantidad_creditos INT,
    bonificacion INT,
    id_transaccion INT REFERENCES dim_transaccion(id_transaccion)
);

-- Tabla de hechos para apuestas
CREATE TABLE fact_apuestas (
    id_apuesta SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES dim_usuario(id_usuario),
    id_tiempo INT REFERENCES dim_tiempo(id_tiempo),
    id_objeto INT REFERENCES dim_objeto(id_objeto),
    cantidad_apostada INT,
    resultado VARCHAR(10)  -- 'ganado' o 'perdido'
);

CREATE OR REPLACE FUNCTION insertar_dim_transaccion(tipo_transaccion VARCHAR) RETURNS INT AS $$
DECLARE
    transaccion_id INT;
BEGIN
    -- Verificar si el tipo de transacción ya existe
    SELECT id_transaccion INTO transaccion_id
    FROM dim_transaccion
    WHERE tipo_transaccion = tipo_transaccion;
    
    -- Si no existe, insertar y devolver el nuevo ID
    IF transaccion_id IS NULL THEN
        INSERT INTO dim_transaccion (tipo_transaccion)
        VALUES (tipo_transaccion)
        RETURNING id_transaccion INTO transaccion_id;
    END IF;
    
    RETURN transaccion_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_fact_apuestas(usuario_id INT, fecha TIMESTAMP, objeto_id INT, cantidad_apostada INT, resultado VARCHAR) RETURNS VOID AS $$
DECLARE
    tiempo_id INT;
BEGIN
    -- Insertar o obtener el ID en la dimensión de tiempo
    tiempo_id := insertar_dim_tiempo(fecha);

    -- Insertar en la tabla de hechos fact_apuestas
    INSERT INTO fact_apuestas (id_usuario, id_tiempo, id_objeto, cantidad_apostada, resultado)
    VALUES (usuario_id, tiempo_id, objeto_id, cantidad_apostada, resultado);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insertar_fact_compras(usuario_id INT, fecha TIMESTAMP, cantidad_creditos INT, bonificacion INT) RETURNS VOID AS $$
DECLARE
    tiempo_id INT;
BEGIN
    -- Insertar o obtener el ID en la dimensión de tiempo
    tiempo_id := insertar_dim_tiempo(fecha);

    -- Insertar en la tabla de hechos fact_compras
    INSERT INTO fact_compras (id_usuario, id_tiempo, cantidad_creditos, bonificacion, id_transaccion)
    VALUES (usuario_id, tiempo_id, cantidad_creditos, bonificacion, 1);  -- Asumimos que el tipo 1 representa "compra"
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_dim_usuario(usuario_id INT, nickname VARCHAR, tipo_actividad VARCHAR) RETURNS VOID AS $$
BEGIN
    -- Verificar si el usuario ya existe en la tabla de usuarios
    IF NOT EXISTS (SELECT 1 FROM dim_usuario WHERE id_usuario = usuario_id) THEN
        INSERT INTO dim_usuario (id_usuario, nickname, tipo_actividad)
        VALUES (usuario_id, nickname, tipo_actividad);
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_dim_tiempo(fecha_param TIMESTAMP) RETURNS INT AS $$
DECLARE
    tiempo_id INT;
BEGIN
    -- Verificar si la fecha ya existe en la tabla de tiempo
    SELECT id_tiempo INTO tiempo_id
    FROM dim_tiempo
    WHERE fecha = fecha_param::date AND hora = fecha_param::time;
    
    -- Si no existe, insertar y devolver el nuevo ID
    IF tiempo_id IS NULL THEN
        INSERT INTO dim_tiempo (fecha, hora, dia, mes, año, semana)
        VALUES (fecha_param::date, fecha_param::time, EXTRACT(DAY FROM fecha_param), EXTRACT(MONTH FROM fecha_param), EXTRACT(YEAR FROM fecha_param), EXTRACT(WEEK FROM fecha_param))
        RETURNING id_tiempo INTO tiempo_id;
    END IF;
    
    RETURN tiempo_id;
END;
$$ LANGUAGE plpgsql;


GRANT SELECT ON ALL TABLES IN SCHEMA public TO connector;



INSERT INTO dim_tiempo (fecha, hora, dia, mes, año, semana) VALUES
('2024-11-10', '14:00:00', 10, 11, 2024, 45),
('2024-11-10', '15:00:00', 10, 11, 2024, 45),
('2024-11-11', '10:00:00', 11, 11, 2024, 45),
('2024-11-11', '11:00:00', 11, 11, 2024, 45);


INSERT INTO dim_usuario (id_usuario, nickname, tipo_actividad) VALUES
(1, 'Steve123', 'compra'),
(2, 'AlexPro', 'compra'),
(3, 'EnderWarrior', 'apuesta'),
(4, 'BlockMaster', 'apuesta');

ALTER TABLE dim_objeto ADD COLUMN cantidad_max INT;
ALTER TABLE dim_objeto ADD COLUMN valor INT;


INSERT INTO dim_objeto (id_objeto, nombre_objeto, cantidad_max, valor) VALUES
(1, 'Diamante', 64, 100),
(2, 'Lingote de Oro', 64, 50),
(3, 'Manzana Dorada', 16, 200),
(4, 'Espada de Netherite', 1, 500);



INSERT INTO dim_transaccion (tipo_transaccion) VALUES
('compra'),
('apuesta ganada'),
('apuesta perdida');


INSERT INTO fact_compras (id_usuario, id_tiempo, cantidad_creditos, bonificacion, id_transaccion) VALUES
(1, 1, 500, 50, 1),
(2, 2, 300, 20, 1),
(1, 3, 1000, 100, 1);


INSERT INTO fact_apuestas (id_usuario, id_tiempo, id_objeto, cantidad_apostada, resultado) VALUES
(3, 1, 1, 10, 'ganado'),
(4, 2, 2, 20, 'perdido'),
(3, 3, 3, 5, 'ganado'),
(4, 4, 4, 1, 'perdido');
