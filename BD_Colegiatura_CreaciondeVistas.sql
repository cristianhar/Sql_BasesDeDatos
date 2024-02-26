/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/11/09
@DESCRIPCION : BASE DE DATOS DE COLEGIATURA - CREACION DE VISTAS Y VISUALIZACION.


 */
 -- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS colegiatura;

-- Crear la base de datos
CREATE DATABASE colegiatura;

-- Usar la base de datos
USE colegiatura;


-- Crear la tabla "profesores"
CREATE TABLE profesores (
  codigoprofesor INT,
  nombre VARCHAR(40),
  PRIMARY KEY (codigoprofesor)
);


-- Crear la tabla "alumnos"
CREATE TABLE alumnos (
  documento CHAR(8),
  nombre VARCHAR(40),
  nota DECIMAL(3, 2),
  codigoprofesor INT,
  PRIMARY KEY (documento),
  FOREIGN KEY (codigoprofesor) REFERENCES profesores (codigoprofesor)
);



-- Insertar datos de profesores
INSERT INTO profesores (codigoprofesor, nombre) VALUES
(1, 'Profesor Alejandro'),
(2, 'Profesora Beatriz'),
(3, 'Profesor Carlos');

-- Insertar datos de alumnos
INSERT INTO alumnos (documento, nombre, nota, codigoprofesor) VALUES
('11111111', 'Ana García', 4.2, 1),
('22222222', 'Beto Martínez', 3.5, 2),
('33333333', 'Carmen Rodríguez', 2.8, 3),
('44444444', 'David López', 1.9, 1),
('55555555', 'Elena Sánchez', 4.7, 2),
('66666666', 'Fernando Pérez', 3.4, 3);


-- Creamos una vista con los datos de tdos los alumnos que tienen una nota mayor o igual a 3,9 junto con el nombre del profesor que lo califico.

-- Creamos una vista con los datos de todos los alumnos que tienen una nota mayor o igual a 3,9 junto con el nombre del profesor que lo calificó.
CREATE VIEW vista_nota AS SELECT a.documento, a.nombre AS nombre_alumno, a.nota, p.nombre AS nombre_profesor , a.codigoprofesor FROM alumnos AS a
JOIN profesores AS p ON a.codigoprofesor = p.codigoprofesor WHERE nota >3.5 with check option;



-- Mediante la vista insertamos un nuevo alumno calificador por el profesor con codigo 1

INSERT INTO vista_nota (documento, nombre_alumno, nota, codigoprofesor) VALUES
('11111131', 'Cristian Johao', 5.0, 3);


-- Modifcamos la nota de un alumno aprobado mediante la vista 

UPDATE vista_nota SET nota =5.0 WHERE documento = '44444444';
SELECT * FROM vista_nota;
