CREATE TABLE GRUPO_ARTISTICO(
    idGrupo NUMBER PRIMARY KEY NOT NULL,
    nombre_grupo VARCHAR(200) NOT NULL
);

CREATE TABLE EVENTO(
    idEvento NUMBER PRIMARY KEY,
    fecha_evento DATE NOT NULL,
    tipo_evento VARCHAR(200) NOT NULL,
    idGrupo NUMBER NOT NULL,
    FOREIGN KEY (idGrupo) REFERENCES GRUPO_ARTISTICO(idGrupo)
);

CREATE TABLE SEDE(
    idSede NUMBER PRIMARY KEY NOT NULL,
    nombre_sede VARCHAR(200) NOT NULL,
    direccion_sede VARCHAR(200) NOT NULL
);

CREATE TABLE PATROCINADOR(
    idPatrocinador NUMBER PRIMARY KEY NOT NULL,
    nombre_patrocinador VARCHAR(200) NOT NULL,
    monto_patrocinado FLOAT NOT NULL
);

CREATE TABLE EVENTO_PATROCINIO(
    idEvento NUMBER NOT NULL,
    idPatrocinador NUMBER NOT NULL,
    monto_patrocinado FLOAT NOT NULL,
    FOREIGN KEY (idEvento) REFERENCES EVENTO (idEvento),
    FOREIGN KEY (idPatrocinador) REFERENCES PATROCINADOR (idPatrocinador)
);

--INSERTS DE LOS DATOS A TRABAJAR
-- Tabla Grupo_Artistico
INSERT INTO Grupo_Artistico (idGrupo, nombre_grupo) VALUES (1, 'Los Melódicos');
INSERT INTO Grupo_Artistico (idGrupo, nombre_grupo) VALUES (2, 'Armonía Total');
INSERT INTO Grupo_Artistico (idGrupo, nombre_grupo) VALUES (3, 'Ritmo y Sabor');
INSERT INTO Grupo_Artistico (idGrupo, nombre_grupo) VALUES (4, 'Voces Unidas');
INSERT INTO Grupo_Artistico (idGrupo, nombre_grupo) VALUES (5, 'Sonido Urbano');

-- Tabla Evento
INSERT INTO Evento (idEvento, fecha_evento, tipo_evento, idGrupo) VALUES (1, '11-20-2024', 'Local', 1);
INSERT INTO Evento (idEvento, fecha_evento, tipo_evento, idGrupo) VALUES (2, '11-22-2024', 'Foráneo', 2);
INSERT INTO Evento (idEvento, fecha_evento, tipo_evento, idGrupo) VALUES (3, '11-25-2024', 'Local', 3);
INSERT INTO Evento (idEvento, fecha_evento, tipo_evento, idGrupo) VALUES (4, '11-27-2024', 'Foráneo', 4);
INSERT INTO Evento (idEvento, fecha_evento, tipo_evento, idGrupo) VALUES (5, '11-30-2024', 'Local', 5);

-- Tabla Sede
INSERT INTO Sede (idSede, nombre_sede, direccion_sede) VALUES (1, 'Auditorio Central', 'Calle Principal #123');
INSERT INTO Sede (idSede, nombre_sede, direccion_sede) VALUES (2, 'Plaza Cultural', 'Av. Las Rosas #45');
INSERT INTO Sede (idSede, nombre_sede, direccion_sede) VALUES (3, 'Teatro Nacional', 'Paseo de la Reforma #890');
INSERT INTO Sede (idSede, nombre_sede, direccion_sede) VALUES (4, 'Parque del Sol', 'Av. del Parque #33');
INSERT INTO Sede (idSede, nombre_sede, direccion_sede) VALUES (5, 'Estadio Urbano', 'Calle Independencia #12');

-- Tabla Patrocinador
INSERT INTO Patrocinador (idPatrocinador, nombre_patrocinador, monto_patrocinado) VALUES (1, 'Empresa A', 5000);
INSERT INTO Patrocinador (idPatrocinador, nombre_patrocinador, monto_patrocinado) VALUES (2, 'Empresa B', 8000);
INSERT INTO Patrocinador (idPatrocinador, nombre_patrocinador, monto_patrocinado) VALUES (3, 'Fundación C', 10000);
INSERT INTO Patrocinador (idPatrocinador, nombre_patrocinador, monto_patrocinado) VALUES (4, 'Comercio D', 3000);
INSERT INTO Patrocinador (idPatrocinador, nombre_patrocinador, monto_patrocinado) VALUES (5, 'Organización E', 7000);

-- Tabla Evento_Patrocinio
INSERT INTO Evento_Patrocinio (idEvento, idPatrocinador, monto_patrocinado) VALUES (2, 1, 5000);
INSERT INTO Evento_Patrocinio (idEvento, idPatrocinador, monto_patrocinado) VALUES (2, 3, 8000);
INSERT INTO Evento_Patrocinio (idEvento, idPatrocinador, monto_patrocinado) VALUES (4, 2, 10000);
INSERT INTO Evento_Patrocinio (idEvento, idPatrocinador, monto_patrocinado) VALUES (4, 4, 3000);
INSERT INTO Evento_Patrocinio (idEvento, idPatrocinador, monto_patrocinado) VALUES (4, 5, 7000);
