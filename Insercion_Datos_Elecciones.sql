USE elecciones;

INSERT INTO provincias (id_provincia, nombre) VALUES
(1, 'Loja'),
(2, 'Azuay'),
(3, 'Guayas'),
(4, 'Pichincha'),
(5, 'El Oro');

INSERT INTO cantones (id_canton, nombre, id_provincia) VALUES
(1, 'Loja', 1),
(2, 'Catamayo', 1),
(3, 'Macará', 1),
(4, 'Cuenca', 2),
(5, 'Guayaquil', 3),
(6, 'Quito', 4),
(7, 'Machala', 5);

INSERT INTO organizaciones_politicas (id_organizacion, nombre, siglas) VALUES
(1, 'Movimiento Renovación Ciudadana', 'MRC'),
(2, 'Movimiento Unidos por el Cambio', 'MUC'),
(3, 'Partido Futuro Democrático', 'PFD'),
(4, 'Movimiento Desarrollo Social', 'MDS'),
(5, 'Movimiento Horizonte Cívico', 'MHC');

INSERT INTO dignidades (id_dignidad, nombre) VALUES
(1, 'Alcalde'),
(2, 'Prefecto'),
(3, 'Concejal urbano'),
(4, 'Concejal rural'),
(5, 'Vocal de junta parroquial');

INSERT INTO circunscripciones (id_circunscripcion, nombre, id_provincia, id_canton) VALUES
(1, 'Cantón Loja', 1, 1),
(2, 'Cantón Catamayo', 1, 2),
(3, 'Cantón Macará', 1, 3),
(4, 'Cantón Cuenca', 2, 4),
(5, 'Provincia de Loja', 1, NULL),
(6, 'Provincia del Azuay', 2, NULL),
(7, 'Cantón Guayaquil', 3, 5),
(8, 'Cantón Quito', 4, 6),
(9, 'Cantón Machala', 5, 7),
(10, 'Provincia del Guayas', 3, NULL),
(11, 'Provincia de Pichincha', 4, NULL),
(12, 'Provincia de El Oro', 5, NULL);

INSERT INTO candidatos (id_candidato, nombres, apellidos, id_organizacion, id_dignidad, id_circunscripcion) VALUES
(1, 'Carlos', 'Mendoza', 1, 1, 1),
(2, 'María', 'Torres', 2, 1, 1),
(3, 'José', 'Castillo', 3, 1, 1),
(4, 'Andrea', 'Ramírez', 1, 1, 2),
(5, 'Daniel', 'Vargas', 2, 1, 2),
(6, 'Luis', 'Herrera', 4, 1, 2),
(7, 'Sofía', 'Morales', 1, 1, 3),
(8, 'Miguel', 'Rojas', 3, 1, 3),
(9, 'Gabriela', 'Vega', 2, 1, 4),
(10, 'Fernando', 'Cabrera', 3, 1, 4),
(11, 'Pablo', 'Romero', 1, 2, 5),
(12, 'Lucía', 'Suárez', 2, 2, 5),
(13, 'Diego', 'Silva', 1, 3, 1),
(14, 'Valeria', 'Ortega', 4, 3, 1),
(15, 'Mateo', 'Guerrero', 4, 1, 3),
(16, 'Sebastián', 'Castro', 2, 1, 7),
(17, 'Isabel', 'Méndez', 3, 1, 8),
(18, 'Martín', 'Salazar', 1, 1, 9),
(19, 'Adriana', 'Reyes', 4, 2, 10),
(20, 'Emilio', 'Córdova', 2, 4, 2);

INSERT INTO votantes (id_votante, cedula, nombres, apellidos, id_circunscripcion) VALUES
(1, '0000000001', 'Juan', 'Pérez', 1),
(2, '0000000002', 'Ana', 'Gómez', 1),
(3, '0000000003', 'Pedro', 'López', 2),
(4, '0000000004', 'Elena', 'Díaz', 2),
(5, '0000000005', 'Jorge', 'Martínez', 3),
(6, '0000000006', 'Paula', 'Flores', 3),
(7, '0000000007', 'David', 'Molina', 4),
(8, '0000000008', 'Carolina', 'Reyes', 4),
(9, '0000000009', 'Ricardo', 'Aguilar', 1),
(10, '0000000010', 'Camila', 'Espinoza', 2),
(11, '0000000011', 'Andrés', 'Paredes', 7),
(12, '0000000012', 'Daniela', 'Vera', 7),
(13, '0000000013', 'Cristian', 'Mora', 8),
(14, '0000000014', 'Natalia', 'Rivas', 8),
(15, '0000000015', 'Esteban', 'León', 9);

INSERT INTO resultados (id_resultado, id_candidato, votos) VALUES
(1, 1, 3500),
(2, 2, 2800),
(3, 3, 1500),
(4, 4, 4200),
(5, 5, 4200),
(6, 6, 1700),
(7, 7, 2400),
(8, 8, 2000),
(9, 9, 6000),
(10, 10, 4700),
(11, 11, 8000),
(12, 12, 6500),
(13, 13, 1200),
(14, 14, 900),
(15, 16, 9500),
(16, 17, 8700),
(17, 18, 5200),
(18, 19, 12000),
(19, 20, 1100);

