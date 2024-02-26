/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/11/09
@DESCRIPCION : BASE DE DATOS DE BIBLIOTECA - EJERCICIOS DE PRACTICA Y CONSULTAS BASICAS CON PROCEDIMIENTOS ALMACENADOS Y VISTAS


 */

-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS biblioteca;

-- Crear la base de datos
CREATE DATABASE biblioteca;

-- Usar la base de datos
USE biblioteca;

-- Crear la tabla "libros"
CREATE TABLE libros (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(40),
  autor VARCHAR(30),
  editorial VARCHAR(20),
  precio DECIMAL(5,2),
  stock INT
);

create table empleados(
  legajo int primary key auto_increment,
  documento char(8),
  sexo char(1),
  apellido varchar(40),
  nombre varchar(30),
  domicilio varchar(30),
  seccion int not null,
  cantidadhijos int,
  estadocivil char(10),
  fechaingreso date
 );

create table secciones(
  codigo int auto_increment primary key,
  nombre varchar(30),
  sueldo decimal(5,2)
 );
 
 insert into secciones(nombre,sueldo) values('Administracion', 300);
 insert into secciones(nombre,sueldo) values('Contaduría', 400);
 insert into secciones(nombre,sueldo) values('Sistemas', 500);


-- Insertar datos en la tabla "libros"
INSERT INTO libros (titulo, autor, editorial, precio, stock)
VALUES 
  ('Alicia en el país de las maravillas', 'Lewis Carroll', 'Emece', 20.00, 9),
  ('Alicia en el país de las maravillas', 'Lewis Carroll', 'Plaza', 35.00, 50),
  ('Aprenda PHP', 'Mario Molina', 'Siglo XXI', 40.00, 3),
  ('El aleph', 'Borges', 'Emece', 10.00, 18),
  ('Ilusiones', 'Richard Bach', 'Planeta', 15.00, 22),
  ('Java en 10 minutos', 'Mario Molina', 'Siglo XXI', 50.00, 7),
  ('Martin Fierro', 'José Hernández', 'Planeta', 20.00, 3),
  ('Martin Fierro', 'José Hernández', 'Emece', 30.00, 70),
  ('Uno', 'Richard Bach', 'Planeta', 10.00, 120);

insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values ('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)   
   values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
 insert into empleados (documento,sexo,apellido,nombre,domicilio,seccion,cantidadhijos,estadocivil,fechaingreso)
   values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');
   
DELIMITER $$
CREATE PROCEDURE producto_2_num(IN num1 INT, num2 INT,OUT producto INT)
BEGIN
SET producto = num1*num2;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE pa_Factorial(IN num1 INT,OUT resultado INT)
BEGIN
DECLARE num int;
SET resultado = 1;
set num = num1;
WHILE num >1 DO
CALL producto_2_num(resultado,num,resultado);
set num = num - 1 ;
END WHILE;
END $$
DELIMITER ;

CALL producto_2_num(2,5,@sumaproducto);
SELECT @sumaproducto;


CALL pa_Factorial(10,@resuu);
SELECT @resuu;

-- Generar dos numeros aleatorios
DELIMITER $$
CREATE PROCEDURE `generar_2_aleatorios`(OUT num1 INT, 
OUT num2 INT)
BEGIN
REPEAT
	SET num1 = RAND()*100;
	SET num2 = RAND()*100;
	UNTIL num1 <> num2
END REPEAT;
END $$
DELIMITER ;


call generar_2_aleatorios(@s,@a);
select @s as primer_aleatorio, @a as segundo_aleatorio;

DELIMITER $$
CREATE  PROCEDURE `repeat_aleatorio`(
OUT num1 INT,
OUT num2 INT)
BEGIN
etiqueta1: LOOP
	SET num1 = RAND()*100;
	SET num2 = RAND()*100;
    IF num1 <> num2 THEN 
		LEAVE etiqueta1;
	END IF; 
END LOOP;
END $$
DELIMITER ;


-- se ejecuta hasta que sea verdadera se acaba el ciclo
call repeat_aleatorio(@a,@b);
select @a as aleatorio, @b as aleatorio_2;

CREATE VIEW vista_empleados AS SELECT CONCAT(apellido,' ',e.nombre) AS nombre ,s.nombre as seccion ,cantidadhijos FROM empleados AS e join secciones AS s on s.codigo = seccion;




SELECT nombre , seccion , cantidadhijos FROM vista_empleados;

SELECT seccion, count(*) AS Cantidad FROM vista_empleados GROUP BY seccion;
-- Vista empleados ingreso


CREATE VIEW  vista_empleados_ingreso (fecingreso,cantidad) as select extract(year from fechaingreso) as fecingreso , count(*) as cantidad FROM empleados group by fecingreso;


-- VISTA BASADA EN UNA VISTA
CREATE VIEW vista_empleados_con_hijos AS select nombre ,seccion,cantidadhijos FROM vista_empleados  WHERE cantidadhijos >0;

SELECT * FROM vista_empleados;
SELECT * FROM vista_empleados_ingreso;
SELECT * FROM vista_empleados_con_hijos;
