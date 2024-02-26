/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/7/11
@DESCRIPCION : BASE DE DATOS DE BIBLIOTECA - EJERCICIOS DE PRACTICA Y CONSULTAS BASICAS.


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

CREATE TABLE empleados(
documento CHAR(8),
nombre VARCHAR(20),
apellido VARCHAR(20),
sueldo DECIMAL(6,2),
cantidadhijos INT,
seccion VARCHAR(20),
PRIMARY KEY(documento)
);


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


insert into empleados (documento,nombre,apellido,sueldo,cantidadhijos,seccion)
values('22222222','Juan','Perez',300,2,'Contaduria'),('22333333','Luis','Lopez',700,0,'Contaduria'),
('22444444','Marta','Perez',500,1,'Sistemas'),('22555555','Susana','Garcia',400,2,'Secretaria'),('22666666','Jose Maria','Morales',1200,3,'Secretaria');


DELIMITER $$

CREATE PROCEDURE pa_prom (IN num1 INT, num2 INT ,OUT resultado FLOAT)
BEGIN
SELECT (num1+num2)/2 INTO resultado;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE pa_autor_sumaypromedio (IN p_autor VARCHAR(30), OUT suma DECIMAL(6,2) ,OUT promedio DECIMAL(6,2))
BEGIN
SELECT titulo,editorial,precio FROM libros WHERE autor = p_autor;
SELECT SUM(precio) INTO suma FROM libros WHERE autor = p_autor;
SELECT AVG(precio) INTO promedio FROM libros WHERE autor = p_autor;                                                            
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE pa_incrementar (INOUT contador INT)
BEGIN
SET contador = contador+1 ;                                                       
END $$
DELIMITER ;


-- Creamos un procedimiento que  recibe un numero de documento y un entero como parametro cantidad de entrada y salida

DELIMITER $$
CREATE PROCEDURE pa_cantidaddhijos (IN p_documento VARCHAR(8),INOUT cantidad INT)
BEGIN
SELECT cantidadhijos + cantidad INTO cantidad FROM empleados WHERE documento = p_documento;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE pa_sumar(IN v1 INT, v2 INT)
BEGIN
DECLARE suma int;
set suma = v1 + v2;
SELECT suma;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE mayor(IN a INT, b INT)
BEGIN
if a  > b then
	select a;
else 
	select b;
end if;    
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE mayor_de_edad(IN a INT)
BEGIN

if a > 18 then 
	select 'Eres mayor de edad';
else 
	select "Jovencito";
    
end if; 

END $$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE promedio_notas(IN a FLOAT, b FLOAT, c FLOAT)
BEGIN
  DECLARE suma FLOAT;
  DECLARE promedio FLOAT;
  
  SET suma = a + b + c;
  SET promedio = suma / 3;

  IF promedio > 3.5 THEN 
    SELECT CONCAT("Pasaste manito (Promedio: ", promedio, ")");
  ELSE 
    SELECT CONCAT("No pasaste manito (Promedio: ", promedio, ")");
  END IF;
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE verificarcontraseña(IN contraseñaEntrante VARCHAR(255))
BEGIN
  DECLARE contrasena VARCHAR(255);
  SET contrasena = "123456";
 
  IF contraseñaEntrante = contrasena THEN
    SELECT "La contraseña es correcta";
  ELSE
    SELECT "La contraseña es incorrecta";
  END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE dividir_numeros(IN a DECIMAL(6,1) ,b DECIMAL(6,1))
BEGIN
  
 
  IF b = 0 THEN
    SELECT "Recuerda que no puedes dividir por 0";  
  ELSE
    SELECT a/b AS DIVISION;
  END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE medalla(IN valor INT ,OUT tipo VARCHAR(20))
BEGIN
  
CASE valor 
	when 1 THEN
    SET tipo = "Medalla de Oro";
    when 2 THEN
    SET tipo = "Medalla de Plata";
    when 3 THEN
    SET tipo = "Medalla de Bronce";     
    ELSE
    SET tipo = "Sin Medalla";  
    
   	END CASE;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE contar_car(IN valor INT, OUT valorout VARCHAR(30))
BEGIN
  CASE
    WHEN valor < 9 THEN SET valorout = '1';
    WHEN valor >= 9 AND valor < 99 THEN SET valorout = '2';
    WHEN valor >= 99 AND valor < 999 THEN SET valorout = '3';
    WHEN valor >= 999 AND valor < 9999 THEN SET valorout = '4';
    ELSE SET valorout = 'El numero es mayor a 9999';
  END CASE;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE generar_aleatorio(OUT num1 INT, OUT num2  INT)
BEGIN
 SET num1 = 0;
 SET num2 = 0;
 WHILE num1= num2 DO
     SET num1 = rand()*10;
     SET num2 = rand()*10;
 END WHILE;   
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE generar_repeat(OUT numero1 INT, OUT numero2 INT)
BEGIN
  REPEAT 
    SET numero1 = RAND() * 11;
    SET numero2 = RAND() * 11;
  UNTIL numero1 = numero2 END REPEAT;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE generar_loop(OUT numero1 INT, OUT numero2 INT)
BEGIN
  etiqueta:LOOP 
    SET numero1 = RAND() * 11;
    SET numero2 = RAND() * 11;
  IF numero1 != numero then LEAVE etiqueta|;
  END IF;
  END LOOP;
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE generar_forloop(OUT suma INT)
BEGIN
  DECLARE i INT;
  SET suma = 0;

  FOR i FROM 1 TO 100 DO
    SET suma = suma + i;
  END FOR;

END $$

DELIMITER ;

CALL pa_prom(42,6,@result);
SELECT @result as Resultado;
CALL pa_autor_sumaypromedio("Lewis Carroll",@sum,@prom);
SELECT @sum ,@prom SumaPromedio;

SET @conta = 1;
SELECT @conta;
CALL pa_incrementar(@conta);


SET @cant = 0;
-- Calcular la cantidad de hijos que tiene 22666666
CALL pa_cantidaddhijos("22666666", @cant);
SELECT @cant AS "22666666";

CALL pa_sumar(2,5);
CALL mayor(7,52);

-- Creamos un procedimiento almacenado que muestre el mayor de 2 enteros que le pasamos como parametro:
CALL mayor_de_edad(19);
-- Crear un procedimiento almacenado que recibas tres notas y calcule su promedio ademas digitasi gano o perdio sabiendo que la nota minima para ganar es 3.5
CALL promedio_notas(3,4,5);

-- CREAR UN PROCEDIMIENTO ALMACENADO QUE RECIBA UNA CADENA DE CARACTERES CONTRASEÑA en una variable y verifique si es la misma que esta almacenada
CALL verificarcontraseña("12455");

-- Procedimiento para dividir 2 numeros 
CALL dividir_numeros(10,2);
-- PROCEDIMIENTO CON CASE
CALL medalla(1,@ti);
SELECT @ti as Medalla;


-- Procedimiento almacenado que le enviemos un entero comprendido entre 1 y 999 el segundo parametro debe retonar la cantidad de digitos que tiene dicho numero
CALL contar_car(99999,@cantidadnumeros);
SELECT @cantidadnumeros AS CANTIDAD;

CALL generar_aleatorio(@N,@M);
SELECT @N AS NumeroUno , @M AS NumeroDos;

CALL generar_repeat(@ABC,@BCD);
SELECT @ABC AS NumeroUnoRepeat , @BCD AS NumeroDosRepeat;

CALL generar_loop(@AB,@BC);
SELECT @AB AS NumeroUnoLoop , @BC AS NumeroDosLoop;

CALL generar_forloop(@SUMAFOR);
SELECT @SUMAFOR AS SUMAFOOR ;
