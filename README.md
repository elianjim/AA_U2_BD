# Base de Datos: Proceso Electoral Ficticio en Ecuador

**Universidad Nacional de Loja — Carrera de Computación**

| Información | Detalle |
|---|---|
| **Asignatura** | Base de Datos |
| **Estudiantes** | Axel Jiménez y Elian Jiménez |
| **Docente** | Ing. René Guamán |
| **Ciclo** | 3.º «A» |
| **Periodo académico** | Septiembre 2026 – Febrero 2027 |

## Contenido

1. [Planteamiento del problema](#1-planteamiento-del-problema)
2. [Modelo relacional](#2-modelo-relacional)
3. [Creación de tablas (DDL)](#3-creación-de-tablas-ddl)
4. [Inserción de datos (DML)](#4-inserción-de-datos-dml)
5. [Actividad A: subconsultas](#5-actividad-a-subconsultas)
   - [Nivel 1: subconsultas básicas](#nivel-1-subconsultas-básicas)
   - [Nivel 2: subconsultas con operadores](#nivel-2-subconsultas-con-operadores)
   - [Nivel 3: subconsultas correlacionadas](#nivel-3-subconsultas-correlacionadas)
6. [Actividad B: creación de vistas](#6-actividad-b-creación-de-vistas-views)
7. [Observaciones](#7-observaciones)

---

## 1. Planteamiento del problema

En Ecuador, durante las elecciones seccionales se eligen autoridades de los Gobiernos Autónomos Descentralizados (GAD), como prefectos, alcaldes, concejales y vocales de juntas parroquiales.

Se requiere desarrollar una base de datos que permita almacenar y consultar información relacionada con un **proceso electoral ficticio**. El sistema debe gestionar las organizaciones políticas participantes, sus candidatos, las dignidades a elegir, las circunscripciones electorales, los votantes y los resultados obtenidos.

La base de datos debe permitir responder preguntas como:

- ¿Qué candidatos participan para la alcaldía de un cantón?
- ¿Qué organización política tiene más candidatos inscritos?
- ¿Qué candidatos obtuvieron más votos que el promedio de su dignidad?
- ¿Qué candidato obtuvo la mayor cantidad de votos en cada cantón?
- ¿Qué organizaciones políticas no inscribieron candidatos?
- ¿Qué porcentaje de votos obtuvo cada candidato?
- ¿Cuáles son los resultados consolidados por dignidad y circunscripción?

> **Importante:** Este ejercicio es un modelo académico simplificado, no una reproducción del sistema oficial del Consejo Nacional Electoral (CNE). Los candidatos y resultados son ficticios.

## 2. Modelo relacional

<img width="631" height="572" alt="Captura de pantalla 2026-11-23 082811" src="https://github.com/user-attachments/assets/ee49b978-2bf0-4307-88f6-a7d3159600ee" />


## 3. Creación de tablas (DDL)

### Tabla `provincias`

```sql
CREATE TABLE provincias (
    id_provincia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);
```

### Tabla `cantones`

```sql
CREATE TABLE cantones (
    id_canton INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
);
```

### Tabla `candidatos`

```sql
CREATE TABLE candidatos (
    id_candidato INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    id_organizacion INT NOT NULL,
    id_dignidad INT NOT NULL,
    id_circunscripcion INT NOT NULL,
    FOREIGN KEY (id_organizacion)
        REFERENCES organizaciones_politicas(id_organizacion),
    FOREIGN KEY (id_dignidad)
        REFERENCES dignidades(id_dignidad),
    FOREIGN KEY (id_circunscripcion)
        REFERENCES circunscripciones(id_circunscripcion)
);
```<img width="257" height="207" alt="Captura de pantalla 2026-11-23 083118" src="https://github.com/user-attachments/assets/31c958fb-fa00-4fd2-b6c9-abfb879cb571" />


## 4. Inserción de datos (DML)

### Datos de provincias

```sql
INSERT INTO provincias (id_provincia, nombre) VALUES
(1, 'Loja'),
(2, 'Azuay'),
(3, 'Guayas'),
(4, 'Pichincha'),
(5, 'El Oro');
```

### Datos de cantones

```sql
INSERT INTO cantones (id_canton, nombre, id_provincia) VALUES
(1, 'Loja', 1),
(2, 'Catamayo', 1),
(3, 'Macará', 1),
(4, 'Cuenca', 2),
(5, 'Guayaquil', 3),
(6, 'Quito', 4),
(7, 'Machala', 5);
```

### Datos de candidatos

```sql
INSERT INTO candidatos (
    id_candidato, nombres, apellidos,
    id_organizacion, id_dignidad, id_circunscripcion
) VALUES
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
```

## 5. Actividad A: subconsultas

### Nivel 1: subconsultas básicas

#### 1. Candidatos de una organización política

Mostrar los nombres y apellidos de los candidatos que pertenecen al **Movimiento Renovación Ciudadana**, obteniendo su identificador mediante una subconsulta.

```sql
SELECT nombres, apellidos
FROM candidatos
WHERE id_organizacion = (
    SELECT id_organizacion
    FROM organizaciones_politicas
    WHERE nombre = 'Movimiento Renovación Ciudadana'
);
```
<img width="257" height="207" alt="Captura de pantalla 2026-11-23 083118" src="https://github.com/user-attachments/assets/49cf9862-cd09-4ac4-8e84-49510722a9cb" />


#### 2. Candidatos de la dignidad de alcalde

Mostrar los candidatos inscritos para la dignidad de **alcalde**, identificándola mediante una subconsulta.

```sql
SELECT nombres, apellidos
FROM candidatos
WHERE id_dignidad = (
    SELECT id_dignidad
    FROM dignidades
    WHERE nombre = 'Alcalde'
);
```

<img width="815" height="297" alt="Captura de pantalla 2026-11-23 083341" src="https://github.com/user-attachments/assets/f9e8df79-fa26-4059-b8be-23431f7cb956" />



#### 3. Candidatos de la provincia de Loja

Mostrar los candidatos que participan en cantones de la provincia de **Loja**, utilizando subconsultas para identificar los cantones.

```sql
SELECT nombres, apellidos
FROM candidatos
WHERE id_circunscripcion IN (
    SELECT id_circunscripcion
    FROM circunscripciones
    WHERE id_canton IN (
        SELECT id_canton
        FROM cantones
        WHERE id_provincia = (
            SELECT id_provincia
            FROM provincias
            WHERE nombre = 'Loja'
        )
    )
);
```

<img width="817" height="262" alt="Captura de pantalla 2026-11-23 083414" src="https://github.com/user-attachments/assets/f4c1768d-118e-4bca-8d15-cc269997340e" />


#### 4. Candidatos con votación superior al promedio general

Mostrar los candidatos que obtuvieron más votos que el promedio general de votación.

```sql
SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > (
    SELECT AVG(votos)
    FROM resultados
);
```

<img width="818" height="235" alt="Captura de pantalla 2026-11-23 083700" src="https://github.com/user-attachments/assets/c58f7b62-cd75-4361-800f-863b67c21d4d" />



### Nivel 2: subconsultas con operadores

#### 5. Organizaciones con candidatos inscritos — `IN`

Mostrar las organizaciones políticas que cuentan con al menos un candidato registrado.

```sql
SELECT nombre, siglas
FROM organizaciones_politicas
WHERE id_organizacion IN (
    SELECT id_organizacion
    FROM candidatos
);
```


<img width="818" height="156" alt="Captura de pantalla 2026-11-23 083746" src="https://github.com/user-attachments/assets/b88b424f-0f6b-46ac-8e99-4aa0be9de89e" />


#### 6. Organizaciones sin candidatos — `NOT EXISTS`

Mostrar las organizaciones políticas sin candidatos inscritos.

```sql
SELECT o.nombre, o.siglas
FROM organizaciones_politicas o
WHERE NOT EXISTS (
    SELECT 1
    FROM candidatos c
    WHERE c.id_organizacion = o.id_organizacion
);
```


<img width="821" height="92" alt="Captura de pantalla 2026-11-23 083810" src="https://github.com/user-attachments/assets/9f65bc3f-4690-4541-b78f-50702457f3dd" />


#### 7. Candidatos con votación superior a todos los candidatos de Loja — `ALL`

Mostrar los candidatos cuya votación supera a **todas** las votaciones de los candidatos del cantón Loja.

```sql
SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > ALL (
    SELECT r2.votos
    FROM resultados r2
    INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato
    INNER JOIN circunscripciones ci
        ON c2.id_circunscripcion = ci.id_circunscripcion
    WHERE ci.id_canton = (
        SELECT id_canton
        FROM cantones
        WHERE nombre = 'Loja'
    )
);
```


<img width="740" height="165" alt="Captura de pantalla 2026-11-23 083842" src="https://github.com/user-attachments/assets/13360d0a-6a20-404d-8539-fd60cfaa287f" />


#### 8. Candidatos con votación superior a algún candidato de Catamayo — `ANY`

Mostrar los candidatos cuya votación supera al menos una de las votaciones registradas en el cantón Catamayo.

```sql
SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
INNER JOIN resultados r ON c.id_candidato = r.id_candidato
WHERE r.votos > ANY (
    SELECT r2.votos
    FROM resultados r2
    INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato
    INNER JOIN circunscripciones ci
        ON c2.id_circunscripcion = ci.id_circunscripcion
    WHERE ci.id_canton = (
        SELECT id_canton
        FROM cantones
        WHERE nombre = 'Catamayo'
    )
);
```



<img width="817" height="270" alt="Captura de pantalla 2026-11-23 084033" src="https://github.com/user-attachments/assets/d2e3b83e-3377-4f3f-a8de-0ae5ee20599c" />


### Nivel 3: subconsultas correlacionadas

#### 9. Candidatos con votación superior al promedio de su dignidad

Mostrar los candidatos cuya votación supera el promedio obtenido por los candidatos de la **misma dignidad**.

```sql
SELECT c.nombres, c.apellidos, d.nombre AS dignidad, r.votos
FROM candidatos c
INNER JOIN resultados r ON c.id_candidato = r.id_candidato
INNER JOIN dignidades d ON c.id_dignidad = d.id_dignidad
WHERE r.votos > (
    SELECT AVG(r2.votos)
    FROM resultados r2
    INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato
    WHERE c2.id_dignidad = c.id_dignidad
);
```



<img width="820" height="160" alt="Captura de pantalla 2026-11-23 091953" src="https://github.com/user-attachments/assets/a41e831a-016e-4e14-aff6-a5de0318b09a" />


#### 10. Candidato con mayor votación por cantón

Identificar los candidatos que obtuvieron más votos en su respectivo cantón. **Si hay empates, se muestran todos.**

```sql
SELECT c.nombres, c.apellidos, ca.nombre AS canton, r.votos
FROM candidatos c
INNER JOIN resultados r ON c.id_candidato = r.id_candidato
INNER JOIN circunscripciones ci
    ON c.id_circunscripcion = ci.id_circunscripcion
INNER JOIN cantones ca ON ci.id_canton = ca.id_canton
WHERE r.votos = (
    SELECT MAX(r2.votos)
    FROM resultados r2
    INNER JOIN candidatos c2 ON r2.id_candidato = c2.id_candidato
    INNER JOIN circunscripciones ci2
        ON c2.id_circunscripcion = ci2.id_circunscripcion
    WHERE ci2.id_canton = ci.id_canton
);
```




<img width="817" height="165" alt="Captura de pantalla 2026-11-23 092020" src="https://github.com/user-attachments/assets/db28e16d-2a5a-4922-897d-6f143bf1064a" />


#### 11. Organizaciones con más candidatos que el promedio

Mostrar las organizaciones políticas cuya cantidad de candidatos inscritos supera el promedio por organización.

```sql
SELECT
    o.nombre,
    o.siglas,
    (
        SELECT COUNT(*)
        FROM candidatos c
        WHERE c.id_organizacion = o.id_organizacion
    ) AS cantidad_candidatos
FROM organizaciones_politicas o
WHERE (
    SELECT COUNT(*)
    FROM candidatos c
    WHERE c.id_organizacion = o.id_organizacion
) > (
    SELECT COUNT(*) FROM candidatos
) / (
    SELECT COUNT(*) FROM organizaciones_politicas
);
```

<img width="817" height="102" alt="Captura de pantalla 2026-11-23 092049" src="https://github.com/user-attachments/assets/aeeb15cd-ad78-4d9e-910b-f511426f2e42" />


#### 12. Candidatos sin resultados electorales

Mostrar los candidatos que no tienen registros en la tabla `resultados`.

```sql
SELECT c.nombres, c.apellidos
FROM candidatos c
WHERE NOT EXISTS (
    SELECT 1
    FROM resultados r
    WHERE r.id_candidato = c.id_candidato
);
```


<img width="816" height="92" alt="Captura de pantalla 2026-11-23 092128" src="https://github.com/user-attachments/assets/b56c2d17-e6da-479f-a970-dc74323efc42" />



## 6. Actividad B: creación de vistas (VIEWS)

### Vista 1. Información general de candidatos

Crear una vista llamada `vw_candidatos` que muestre el identificador del candidato, nombres, apellidos, organización política, siglas, dignidad, cantón y provincia.


<img width="820" height="336" alt="Captura de pantalla 2026-11-23 092621" src="https://github.com/user-attachments/assets/f2fbeb93-22b6-4b7f-90d0-84991fcecf5e" />


```sql
CREATE VIEW vw_candidatos AS
SELECT
    c.id_candidato,
    c.nombres,
    c.apellidos,
    o.nombre AS organizacion_politica,
    o.siglas,
    d.nombre AS dignidad,
    ca.nombre AS canton,
    p.nombre AS provincia
FROM candidatos c
INNER JOIN organizaciones_politicas o
    ON c.id_organizacion = o.id_organizacion
INNER JOIN dignidades d
    ON c.id_dignidad = d.id_dignidad
INNER JOIN circunscripciones ci
    ON c.id_circunscripcion = ci.id_circunscripcion
LEFT JOIN cantones ca
    ON ci.id_canton = ca.id_canton
INNER JOIN provincias p
    ON ci.id_provincia = p.id_provincia;
```

Consulta de la vista:

```sql
SELECT * FROM vw_candidatos;
```
