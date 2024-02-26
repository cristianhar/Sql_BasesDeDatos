/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/10/17
@DESCRIPCION : BASE DE DATOS DE EMPRESA - EJERCICIOS DE PRACTICA Y CONSULTAS BASICAS.


 */

-- Dropeo la base de datos para que no tener problemas.
DROP DATABASE IF EXISTS empresa;

-- Crea la base de datos "empresa"
CREATE DATABASE IF NOT EXISTS empresa;

-- Selecciona la base de datos "empresa"
USE empresa;

-- Crea la tabla "departamentos"
CREATE TABLE IF NOT EXISTS departamentos (
  codigo INT AUTO_INCREMENT,
  nombre VARCHAR(100),
  presupuesto INT,
  PRIMARY KEY (codigo)
);

-- Crea la tabla "empleados"
CREATE TABLE IF NOT EXISTS empleados (
  DNI VARCHAR(11),
  nombre VARCHAR(100),
  apellidos VARCHAR(255),
  departamento INT,
  PRIMARY KEY (DNI),
  FOREIGN KEY (departamento) REFERENCES departamentos(codigo)
);


-- Inserto los 5 departamentos
INSERT INTO departamentos (nombre, presupuesto) VALUES
('Desarrollo', 50000),
('Marketing', 50000),
('Digitalizacion', 50000),
('Mercadeo', 50000),
('Mantenimiento',70000);

-- Inserto los 5 empleados
INSERT INTO empleados (DNI, nombre, apellidos, departamento) VALUES
('1214742451', 'Cristian', 'Arboleda Henao', 1),
('1214742452', 'Johao', 'Ramirez B', 2),
('1214742453', 'Andres', 'Hugo Gil', 3),
('1214742454', 'Pedro', 'Hugo Gil', 4),
('1214742455', 'Juan', 'Hugo Gil', 5),
('1214742456', 'Laura', 'González', 1),
('1214742457', 'María', 'López', 2),
('1214742458', 'Carlos', 'Rodríguez', 3),
('1214742459', 'Sofía', 'Martínez', 4),
('1214742460', 'Antonio', 'Pérez', 5),
('1214742461', 'Ana', 'Sánchez', 1),
('1214742462', 'David', 'Torres', 2),
('1214742463', 'Elena', 'Gómez', 3),
('1214742464', 'Fernando', 'Ruiz', 4),
('1214742465', 'Isabel', 'Fernández', 5);


-- Consulto el apellido de los empleados
SELECT apellidos FROM  empleados ;

-- Obtener los apellidos de los empleados sin repeticiones 
SELECT DISTINCT apellidos FROM empleados;

-- Obtener empleados con apellido Lopez
SELECT * FROM empleados WHERE apellidos = 'López';
-- Obtener empleados con apellido Lopez o Perez
SELECT * FROM empleados WHERE apellidos = 'López' or apellidos= 'Pérez';
-- Obtener empleados que pertenecen al derpartamento  5 
SELECT * FROM empleados WHERE departamento = 5 ;
-- Obtener empleados que pertenecen al 
SELECT * FROM empleados WHERE departamento = 3  or departamento = 4;
-- Los empleados con apellidos iniciado en P
SELECT * FROM empleados WHERE apellidos LIKE 'P%';
-- Suma de todo el presupuesto de los departamentos
SELECT SUM(presupuesto) FROM departamentos;
-- Cuenta los empleados totales
SELECT COUNT(DNI) FROM empleados;
-- Cantidad de empleados por departamento
SELECT departamento, COUNT(*) AS Cantidad FROM empleados GROUP BY departamento;
-- Listado de todos los empleados.
SELECT empleados.* ,  departamentos.nombre  AS nombre_departamento FROM empleados,departamentos WHERE empleados.departamento = departamentos.codigo ;
-- Otra forma
SELECT  * FROM empleados e ,  departamentos d  WHERE  e.departamento = d.codigo ;

-- Select empleados donde el presupuesto del departamento es mayor que 60000 
SELECT empleados.nombre, empleados.apellidos, departamentos.nombre AS nombre_departamento FROM empleados, departamentos WHERE empleados.departamento = departamentos.codigo AND departamentos.presupuesto >= 60000;

-- Obtener los departamentos cuyo presupuesto es mayor que el presupuesto medio
SELECT * FROM departamentos WHERE presupuesto >= (SELECT AVG(presupuesto) FROM departamentos);

-- Obtener solo los nombres de los departamentos que tienen mas de 2 empleados. 
SELECT departamentos.nombre
FROM departamentos
WHERE (SELECT COUNT(*) FROM empleados WHERE empleados.departamento = departamentos.codigo) > 2;

-- Agregar el empleado Esther Vazques al nuevo departamento Calidad
INSERT INTO departamentos (codigo, nombre, presupuesto) VALUES (11, 'Calidad', 40000);
INSERT INTO empleados (DNI, nombre, apellidos, departamento) VALUES ('89267109', 'Esther', 'Vázquez', 11);

-- Presupuesto recorte del 10% 
UPDATE departamentos SET presupuesto = presupuesto * 0.9;
-- Despido a los empleados de mercadeo 
DELETE FROM empleados WHERE departamento = 4;
-- Borro a todos los empleados que pertenecen a un departamento donde el presupuesto sea mayor que 60000
DELETE FROM empleados
WHERE departamento IN (SELECT codigo FROM departamentos WHERE presupuesto > 60000);
-- Despido a todos los empleados.
DELETE FROM empleados;
