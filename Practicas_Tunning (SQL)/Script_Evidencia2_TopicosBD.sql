CREATE DATABASE Estetica;
USE Estetica;

-- Tabla de Clientes
CREATE TABLE Clientes (
    id_cliente SMALLINT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    telefono CHAR(10),
    correo VARCHAR(50) NOT NULL
);

-- Tabla de Personal
CREATE TABLE Personal (
    id_personal TINYINT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de Servicios
CREATE TABLE Servicios (
    id_servicio TINYINT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

-- Tabla de Citas
CREATE TABLE Citas (
    id_cita SMALLINT PRIMARY KEY NOT NULL,
    id_cliente SMALLINT NOT NULL,
    id_personal TINYINT NOT NULL,
    fecha DATE NOT NULL,
    horario VARCHAR(8) NOT NULL,
    UNIQUE (id_cliente, fecha), -- Restricción para que un cliente no tenga dos citas el mismo día
    UNIQUE (id_personal, fecha, horario), -- Restricción para que un personal no tenga dos citas en el mismo horario
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal) ON DELETE CASCADE
);

-- Tabla de Servicios Prestados en cada Cita
CREATE TABLE Servicios_Prestados (
    id_servicio_prestado SMALLINT PRIMARY KEY NOT NULL,
    id_cita SMALLINT NOT NULL,
    id_servicio TINYINT NOT NULL,
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita) ON DELETE CASCADE,
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio) ON DELETE CASCADE
);


-- Seccion de indices
CREATE INDEX idx_servicios_prestados_cita ON Servicios_Prestados(id_cita);
CREATE INDEX idx_servicios_prestados_servicio ON Servicios_Prestados(id_servicio);
CREATE INDEX idx_citas_fecha ON Citas(fecha);
CREATE INDEX idx_citas_horario ON Citas(horario);

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (id_cliente, nombre, telefono, correo) VALUES
(1, 'Ana Pérez', '5551234567', 'ana.perez@example.com'),
(2, 'Luis Gómez', '5559876543', 'luis.gomez@example.com'),
(3, 'María López', '5552345678', 'maria.lopez@example.com'),
(4, 'Carlos Ramírez', '5558765432', 'carlos.ramirez@example.com'),
(5, 'Fernanda Torres', '5557654321', 'fernanda.torres@example.com');

-- Insertar datos en la tabla Personal
INSERT INTO Personal (id_personal, nombre) VALUES
(1, 'Pedro Sánchez'),
(2, 'Laura Méndez'),
(3, 'Diego Fernández'),
(4, 'Sofía Herrera'),
(5, 'Ricardo Morales');

-- Insertar datos en la tabla Servicios
INSERT INTO Servicios (id_servicio, nombre, descripcion, precio) VALUES
(1, 'Corte de cabello', 'Corte de cabello para dama o caballero', 150.00),
(2, 'Manicure', 'Arreglo y decoración de uñas', 200.00),
(3, 'Pedicure', 'Cuidado y embellecimiento de pies', 250.00),
(4, 'Tinte de cabello', 'Cambio de color de cabello', 500.00),
(5, 'Masaje relajante', 'Masaje corporal para aliviar tensiones', 350.00);

-- Insertar datos en la tabla Citas (ajustando horarios a "Mañana", "Mediodía" y "Tarde")
INSERT INTO Citas (id_cita, id_cliente, id_personal, fecha, horario) VALUES
(1, 1, 1, '2025-03-25', 'Mañana'),
(2, 2, 2, '2025-03-25', 'Mediodía'),
(3, 3, 3, '2025-03-26', 'Tarde'),
(4, 4, 4, '2025-03-26', 'Mañana'),
(5, 5, 5, '2025-03-27', 'Mediodía');

-- Insertar datos en la tabla Servicios_Prestados
INSERT INTO Servicios_Prestados (id_servicio_prestado, id_cita, id_servicio) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4),
(5, 4, 5);

-- Un cliente NO puede registrar 2 citas el mismo dia.alter

INSERT INTO Citas (id_cita, id_cliente, id_personal, fecha, horario) VALUES 
(6, 1, 2, '2025-03-25', 'Tarde');


/* Ningún integrante del personal deberá ser programado para dos citas 
en la misma combinación de fecha y horario*/

INSERT INTO Citas (id_cita, id_cliente, id_personal, fecha, horario) VALUES 
(6, 3, 1, '2025-03-25', 'Mañana');


-- Sección de consultas
DELIMITER $$

CREATE PROCEDURE sp_lista_clientes()
BEGIN
    SELECT * FROM Clientes;
END $$

DELIMITER ;
CALL sp_lista_clientes;

DELIMITER $$

CREATE PROCEDURE sp_listado_personal()
BEGIN
	SELECT * FROM Personal;
END $$

DELIMITER ;
CALL sp_listado_personal;

DELIMITER $$

CREATE PROCEDURE consultar_cita(cita_consulta SMALLINT)
BEGIN
	SELECT
		sp.id_servicio_prestado,
		sp.id_servicio,
		s.nombre AS servicio_nombre,
		s.descripcion AS servicio_descripcion,
		s.precio
	FROM
		Servicios_Prestados sp
	JOIN
		Servicios s ON sp.id_servicio = s.id_servicio
	WHERE
		sp.id_cita = cita_consulta; -- Reemplazar 1 con el folio de la cita que desees consultar
END$$

DELIMITER ;
CALL consultar_cita (1);

DELIMITER $$

CREATE PROCEDURE sp_cita_fecha(
	IN fecha_consulta DATE
)
BEGIN
SELECT 
	c.id_cita AS folio_cita,
    c.horario,
    c.id_cliente AS clave_cliente,
    cl.nombre AS nombre_cliente,
    p.nombre AS nombre_personal
FROM
	Citas c
JOIN
	Clientes cl ON c.id_cliente = cl.id_cliente
JOIN
	Personal p ON c.id_personal = p.id_personal
WHERE
	c.fecha = fecha_consulta; -- Reemplaza con la fecha que desees consultar 
END $$

DELIMITER ;
CALL sp_cita_fecha('2025-03-26')



















