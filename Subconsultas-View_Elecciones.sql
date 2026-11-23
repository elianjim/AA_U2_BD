USE elecciones;

SELECT nombres, apellidos FROM candidatos WHERE id_organizacion = (SELECT id_organizacion FROM organizaciones_politicas WHERE nombre = 'Movimiento Renovación Ciudadana');

SELECT nombres, apellidos FROM candidatos WHERE id_dignidad = (SELECT id_dignidad FROM dignidades WHERE nombre = 'Alcalde');

SELECT nombres, apellidos FROM candidatos WHERE id_circunscripcion IN (SELECT id_circunscripcion FROM circunscripciones
WHERE id_canton IN (SELECT id_canton FROM cantones WHERE id_provincia = (SELECT id_provincia FROM provincias WHERE nombre = 'Loja')));

SELECT c.nombres, c.apellidos, r.votos FROM candidatos c INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > (SELECT AVG(votos) FROM resultados);

SELECT nombre, siglas FROM organizaciones_politicas WHERE id_organizacion IN (SELECT id_organizacion FROM candidatos);

SELECT o.nombre, o.siglas FROM organizaciones_politicas o WHERE NOT EXISTS (SELECT 1 FROM candidatos c WHERE c.id_organizacion = o.id_organizacion);

SELECT c.nombres, c.apellidos, r.votos FROM candidatos c INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > ALL (SELECT r2.votos FROM resultados r2 INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato INNER JOIN circunscripciones ci ON c2.id_circunscripcion = ci.id_circunscripcion WHERE ci.id_canton = (SELECT id_canton FROM cantones WHERE nombre = 'Loja'));

SELECT c.nombres, c.apellidos, r.votos FROM candidatos c INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > ANY (SELECT r2.votos FROM resultados r2 INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato INNER JOIN circunscripciones ci ON c2.id_circunscripcion = ci.id_circunscripcion WHERE ci.id_canton = (SELECT id_canton FROM cantones WHERE nombre = 'Catamayo'));

SELECT c.nombres, c.apellidos, d.nombre AS dignidad, r.votos FROM candidatos c INNER JOIN resultados r ON c.id_candidato = r.id_candidato INNER JOIN dignidades d ON c.id_dignidad = d.id_dignidad
WHERE r.votos > (SELECT AVG(r2.votos) FROM resultados r2 INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato WHERE c2.id_dignidad = c.id_dignidad);

SELECT c.nombres, c.apellidos, ca.nombre AS canton, r.votos FROM candidatos c INNER JOIN resultados r ON c.id_candidato = r.id_candidato INNER JOIN circunscripciones ci ON c.id_circunscripcion = ci.id_circunscripcion INNER JOIN cantones ca ON ci.id_canton = ca.id_canton
WHERE r.votos = (SELECT MAX(r2.votos) FROM resultados r2 INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato INNER JOIN circunscripciones ci2 ON c2.id_circunscripcion = ci2.id_circunscripcion WHERE ci2.id_canton = ci.id_canton);

SELECT o.nombre, o.siglas, (SELECT COUNT(*) FROM candidatos c WHERE c.id_organizacion = o.id_organizacion) AS cantidad_candidatos FROM organizaciones_politicas o
WHERE (SELECT COUNT(*) FROM candidatos c WHERE c.id_organizacion = o.id_organizacion) > (SELECT COUNT(*) FROM candidatos) / (SELECT COUNT(*) FROM organizaciones_politicas);

SELECT c.nombres, c.apellidos FROM candidatos c WHERE NOT EXISTS (SELECT 1 FROM resultados r WHERE r.id_candidato = c.id_candidato);

CREATE VIEW vw_candidatos AS SELECT c.id_candidato, c.nombres, c.apellidos, o.nombre AS organizacion_politica, o.siglas, d.nombre AS dignidad, ca.nombre AS canton, p.nombre AS provincia
FROM candidatos c INNER JOIN organizaciones_politicas o ON c.id_organizacion = o.id_organizacion INNER JOIN dignidades d ON c.id_dignidad = d.id_dignidad
INNER JOIN circunscripciones ci ON c.id_circunscripcion = ci.id_circunscripcion LEFT JOIN cantones ca ON ci.id_canton = ca.id_canton INNER JOIN provincias p ON ci.id_provincia = p.id_provincia;

SELECT * FROM vw_candidatos;
