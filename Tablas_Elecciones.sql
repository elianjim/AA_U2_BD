CREATE DATABASE elecciones CHARACTER SET utf8mb4;
USE elecciones;

-- Tabla PROVINCIAS
CREATE TABLE provincias (
    id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla CANTONES
CREATE TABLE cantones (
    id_canton INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
);

-- Tabla ORGANIZACIONES_POLITICAS
CREATE TABLE organizaciones_politicas (
    id_organizacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    siglas VARCHAR(15) NOT NULL
);

-- Tabla DIGNIDADES
CREATE TABLE dignidades (
    id_dignidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla CIRCUNSCRIPCIONES
CREATE TABLE circunscripciones (
    id_circunscripcion INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_provincia INT NOT NULL,
    id_canton INT,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia),
    FOREIGN KEY (id_canton) REFERENCES cantones(id_canton)
);

-- Tabla CANDIDATOS
CREATE TABLE candidatos (
    id_candidato INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    id_organizacion INT NOT NULL,
    id_dignidad INT NOT NULL,
    id_circunscripcion INT NOT NULL,
    FOREIGN KEY (id_organizacion) REFERENCES organizaciones_politicas(id_organizacion),
    FOREIGN KEY (id_dignidad) REFERENCES dignidades(id_dignidad),
    FOREIGN KEY (id_circunscripcion) REFERENCES circunscripciones(id_circunscripcion)
);

-- Tabla VOTANTES
CREATE TABLE votantes (
    id_votante INT AUTO_INCREMENT PRIMARY KEY,
    cedula CHAR(10) NOT NULL UNIQUE,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    id_circunscripcion INT NOT NULL,
    FOREIGN KEY (id_circunscripcion) REFERENCES circunscripciones(id_circunscripcion)
);

-- Tabla RESULTADOS
CREATE TABLE resultados (
    id_resultado INT AUTO_INCREMENT PRIMARY KEY,
    id_candidato INT NOT NULL UNIQUE,
    votos INT NOT NULL,
    FOREIGN KEY (id_candidato) REFERENCES candidatos(id_candidato),
    CHECK (votos >= 0)
);
