/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2024/12/02
@DESCRIPCION : BASE DE DATOS DE EMPRESA - EJERCICIOS DE PRACTICA Y CONSULTAS BASICAS.


 */

 -- Dropeo la base de datos para que no tener problemas.
DROP DATABASE IF EXISTS empresa;

-- Crea la base de datos "empresa"
CREATE DATABASE IF NOT EXISTS empresa;

-- Selecciona la base de datos "empresa"
USE empresa;

-- Crea la tabla "fabricantes"
CREATE TABLE IF NOT EXISTS fabricantes (
  codigo INT AUTO_INCREMENT,
  Nombre VARCHAR(100),
  PRIMARY KEY (codigo)
);

-- Crea la tabla "articulos"
CREATE TABLE IF NOT EXISTS articulos (
  codigo INT AUTO_INCREMENT,
  Nombre VARCHAR(100),
  Precio INT,
  Fabricante INT,
  PRIMARY KEY (codigo),
  FOREIGN KEY (Fabricante) REFERENCES fabricantes(codigo)
);
-- Inserto los 5 fabricantes
INSERT INTO fabricantes (Nombre)  VALUES('Arteche'),('Huawei'),('Samsung'),('Apple'),('Balteau');

-- Inserto los 12 articulos
INSERT INTO articulos  (Nombre,Precio,Fabricante) VALUES
('TC',1000,1),('TPs',1000,1),('TTs',1000,1),('SH20',2000,2),('SH30',2000,2),('SH40',2000,2),('A31',4000,3),('A70',4000,3),('Galaxy',4000,3),('Iphone 13',5000,4),('Iphone 14',6000,4),('Iphone 15',7000,4),('Altavoz',20000,2);

-- Hago las consultas para validar que si haya entrado el codigo 
SELECT * FROM articulos;
SELECT * FROM fabricantes;

-- Hago consulta solo por nombre y Precio
SELECT  Nombre,Precio FROM articulos;
-- Hago consulta solo por nombre y Precios mayores de 2000
SELECT  Nombre FROM articulos WHERE precio > 2000; 

-- Hago consultas por precio entre  2000 y 5000
SELECT * FROM articulos WHERE precio BETWEEN  2000  and 5000; 

-- Hago consultas por precio * 5  y le pongo una etiqueta 
SELECT Nombre ,precio*10 AS preciox5 FROM articulos;

-- Sacar el promedio con la funcion AVG 
SELECT 	AVG(precio) FROM articulos; 

-- Sacar la cantidad de articulos  con la funcion COUNT
SELECT COUNT(codigo) FROM articulos;

-- Sumar la cantidad de precios de la tabla articulos con la funcion SUM
SELECT SUM(precio) FROM articulos;

-- Maximo y minimo precio de todos 
SELECT MAX(Precio) AS Precio_Maximo FROM articulos;
SELECT MIN(Precio) AS Precio_Minimo FROM articulos;

-- Precio medio de los productos de fabricante 2 
SELECT AVG(Precio) From articulos WHERE codigo = 2 ;

-- Precio Ascendente y Descendente.
SELECT Nombre, Precio FROM articulos WHERE Precio >= 5000 ORDER BY Precio ;
SELECT Nombre, Precio FROM articulos WHERE Precio >= 5000 ORDER BY Precio DESC;

-- Nombre Ascendente 
SELECT Nombre, Precio FROM articulos WHERE Precio >= 2000 ORDER BY Nombre ;

-- Obtener un listado de todos los articulos incluyendo por cada articulo los datos del fabricante

-- Las dos tablas juntas
SELECT *  FROM articulos , fabricantes WHERE articulos.codigo = fabricantes.codigo; 

SELECT articulos.codigo, articulos.Nombre, Precio, fabricantes.codigo, fabricantes.Nombre FROM articulos , fabricantes WHERE articulos.Fabricante = fabricantes.codigo;

SELECT fabricantes.Nombre, AVG(articulos.Precio) AS precio_promedio FROM fabricantes, articulos WHERE articulos.codigo = fabricantes.codigo GROUP BY fabricantes.Nombre;

-- Para Cambiarle el nombre al codigo 8 
UPDATE  articulos SET Nombre = "Impresora Laser" WHERE codigo = 8;

-- Articulos con 10 % de descuento a todos los articulos
UPDATE articulos SET precio = precio*0.9 ;
-- Articulos un descuento del 10% a los articulos mayores de 50000
UPDATE articulos SET precio = precio-1000 WHERE  precio >= 5000 ;


