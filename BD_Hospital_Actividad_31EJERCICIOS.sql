/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/10/24
@DESCRIPCION : BASE DE DATOS DE UN HOSPITAL


 */

-- Elimino la base de datos si ya existe.
DROP DATABASE IF EXISTS hospital;

-- Creo la base de datos Hospital
CREATE DATABASE hospital;

-- Llamo la base de datos que voy a usar.
USE hospital;

-- Creo la tabla departamentos
CREATE TABLE tabla_dept(
cod_depar INT NOT NULL AUTO_INCREMENT,
nom_depar VARCHAR(50) NOT NULL,
ciudad_depar VARCHAR(50) NOT NULL,
PRIMARY KEY(cod_depar)
);
-- Creo la tabla empleados
CREATE TABLE tabla_emp(
doc_emp INT NOT NULL AUTO_INCREMENT,
nom_emp VARCHAR(50) NOT NULL,
oficio VARCHAR(50) NOT NULL,
fecha_nac DATE NOT NULL,
salario NUMERIC(9,2) NOT NULL,
comision NUMERIC(9,2) NOT NULL,   
cod_depar INT NOT NULL ,
PRIMARY KEY(doc_emp),
FOREIGN KEY(cod_depar) REFERENCES tabla_dept(cod_depar)
);
-- Creo la tabla hospital
CREATE TABLE tabla_hospital(
cod_hospital INT NOT NULL AUTO_INCREMENT,
nom_hospital VARCHAR(50) NOT NULL,
direccion VARCHAR(50) NOT NULL,
telefono VARCHAR(50) NOT NULL,
num_Cama INT NOT NULL,
PRIMARY KEY(cod_hospital)
);
-- Creo la tabla doctor
CREATE TABLE tabla_doctor(
doc_doctor INT NOT NULL AUTO_INCREMENT,
cod_hospital INT NOT NULL,
nom_doctor VARCHAR(50) NOT NULL,
especialidad VARCHAR(50) NOT NULL,
PRIMARY KEY(doc_doctor),
FOREIGN KEY(cod_hospital) REFERENCES tabla_hospital(cod_hospital)    
);
-- Creo la tabla sala
CREATE TABLE tabla_sala(
cod_sala INT NOT NULL AUTO_INCREMENT,
cod_hospital INT NOT NULL,
nom_sala VARCHAR(50) NOT NULL,    
num_cama INT NOT NULL,    
PRIMARY KEY(cod_sala),
FOREIGN KEY(cod_hospital) REFERENCES tabla_hospital(cod_hospital)
);
-- Creo la tabla plantilla
CREATE TABLE tabla_plantilla(
cod_empleado INT NOT NULL, 
cod_sala INT NOT NULL,
cod_hospital INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
funcion VARCHAR(50) NOT NULL,
jornada VARCHAR(50) NOT NULL,
salario NUMERIC(9,2) NOT NULL,
FOREIGN KEY(cod_sala) REFERENCES tabla_sala(cod_sala),
FOREIGN KEY(cod_hospital) REFERENCES tabla_hospital(cod_hospital)
);
-- Creo la tabla enfermo
CREATE TABLE tabla_enfermo(
cod_ingreso INT NOT NULL AUTO_INCREMENT,
nom_enfermo VARCHAR(50)NOT NULL,
direccion VARCHAR(50)NOT NULL,
fecha_nac VARCHAR(50)NOT NULL,
sexo VARCHAR(2) NOT NULL,
doc_enfermo INT NOT NULL,
PRIMARY KEY(cod_ingreso)
);




-- Ingreso los departamentos
INSERT INTO tabla_dept (cod_depar,nom_depar,ciudad_depar) VALUES (10,'Contabilidad','Bogotá'),
(20,'Investigación','Medellín'),
(30,'Ventas','Cali'),
(40,'Producción','Medellín');


-- Ingreso los empleados
INSERT INTO tabla_emp (doc_emp, nom_emp, oficio, fecha_nac, salario, comision, cod_depar) VALUES
(7369, 'Jorge', 'EMPLEADO', '1980-12-17', 10400, 0, 20),
(7499, 'Maria', 'VENDEDOR', '1982-02-22', 208000, 39000, 30),
(7521, 'Yeison', 'VENDEDOR', '1981-02-22', 162500, 65000, 30),
(7566, 'Daniela', 'DIRECTOR', '1982-04-02', 386750, 0, 20),
(7654, 'Santiago', 'VENDEDOR', '1981-09-28', 182000, 182000, 30),
(7698, 'Manuel', 'DIRECTOR', '1981-01-05', 370500, 0, 30),
(7782, 'Sandra', 'DIRECTOR', '1981-09-06', 318500, 0, 10),
(7788, 'Maribel', 'ANALISTA', '1987-03-30', 390000, 0, 20),
(7839, 'Edison', 'PRESIDENTE', '1982-11-17', 650000, 0, 10),
(7844, 'Luis', 'VENDEDOR', '1981-08-09', 195000, 0, 30),
(7876, 'Edilia', 'EMPLEADO', '1987-03-05', 143000, 0, 20),
(7900, 'Hannah', 'EMPLEADO', '1981-12-03', 123500, 0, 30),
(7902, 'Noah', 'ANALISTA', '1981-03-12', 390000, 0, 20),
(7934, 'Juan', 'EMPLEADO', '1982-06-23', 169000, 0, 10),
(7119, 'Pablo', 'DIRECTOR', '1983-11-19', 225000, 39000, 40),
(7322, 'Leticia', 'EMPLEADO', '1982-12-10', 129000, 0, 20);

-- Ingreso los hospitales
INSERT INTO tabla_hospital (cod_hospital, nom_hospital, direccion, telefono, num_Cama) VALUES
(19, 'Provincial', 'O Donell', '555-5555', 502),
(18, 'General', 'Atocha', '333-3333', 987),
(22, 'La Paz', 'Castellana 1000', '888-8888', 412),
(45, 'San Carlos', 'Ciudad Universitaria', '222-2222', 845);


-- Ingreso los doctores
INSERT INTO tabla_doctor (doc_doctor, cod_hospital, nom_doctor, especialidad) VALUES
(386, 22, 'Cabeza D.', 'Psiquiatría'),
(398, 22, 'Best D.', 'Urología'),
(435, 19, 'López A.', 'Cardiología'),
(453, 22, 'Galo D.', 'Pediatría'),
(522, 45, 'Adams C.', 'Neurología'),
(585, 18, 'Miller G.', 'Ginecología'),
(607, 45, 'Chuki P.', 'Pediatría'),
(982, 18, 'Cajal R.', 'Cardiología');


-- Ingreso las salas
INSERT INTO tabla_sala (cod_sala, cod_hospital, nom_sala, num_cama) VALUES
(1, 22, 'Recuperación', 10),
(2, 45, 'Recuperación', 15),
(3, 22, 'Maternidad', 34),
(4, 45, 'Maternidad', 24),
(5, 19, 'Cuidados Intensivos', 21),
(6, 18, 'Cuidados Intensivos', 10),
(7, 18, 'Cardiología', 53),
(8, 45, 'Cardiología', 55),
(9, 19, 'Psiquiátricos', 67),
(10, 22, 'Psiquiátricos', 118);


-- Ingreso los valores de la plantilla
INSERT INTO tabla_plantilla (cod_hospital, cod_sala, cod_empleado, nombre, funcion, jornada, salario) VALUES
(22, 6, 1009, 'Higueras D.', 'Enfermera', 'T', 200500),
(45, 4, 1280, 'Amigo R.', 'Interino', 'N', 221000),
(19, 6, 3106, 'Hernández', 'Enfermero', 'T', 275000),
(19, 6, 3754, 'Díaz B.', 'Enfermera', 'T', 226200),
(22, 1, 6065, 'Rivera G.', 'Enfermera', 'N', 162600),
(18, 4, 6357, 'Karplus W.', 'Interino', 'T', 337900),
(22, 1, 7379, 'Carlota R.', 'Enfermera', 'T', 211900),
(22, 6, 8422, 'Bocina G.', 'Enfermero', 'M', 183800),
(45, 1, 8526, 'Franky H.', 'Enfermera', 'T', 252200),
(22, 2, 9901, 'Núñez C.', 'Interino', 'M', 221000);


-- Ingreso los valores para la tabla enfermo
INSERT INTO tabla_enfermo (cod_ingreso, nom_enfermo, direccion, fecha_nac, sexo, doc_enfermo) VALUES
(10995, 'Laguía M.', 'Goya 20', '16-may-56', 'M', 280862422),
(14024, 'Fernández M.', 'Recoletos 50', '21-may-60', 'F', 284991452),
(18004, 'Serrano V.', 'Alcalá 12', '23-jun-67', 'F', 321790059),
(36658, 'Domin S.', 'Mayor 71', '01-ene-42', 'M', 160654471),
(38702, 'Neal R.', 'Orense 11', '18-jun-40', 'F', 380010217),
(39217, 'Cervantes M.', 'Perón 38', '29-feb-52', 'M', 440294390),
(59076, 'Miller B.', 'López de Hoyos 2', '16-sep-45', 'F', 311969044),
(63827, 'Ruiz P.', 'Ezquerdo 103', '26-dic-80', 'M', 100973253),
(64823, 'Fraiser A.', 'Soto 3', '10-jul-80', 'F', 285201776),
(74835, 'Benítez E.', 'Argentina', '05-oct-57', 'M', 154811767);

-- PROCEDIMIENTOS ALMACENADOS DE AQUI HACIA ABAJO


DELIMITER $$

CREATE PROCEDURE consultar_emp()
BEGIN
    SELECT * FROM tabla_emp;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE nombretel_hospital()
BEGIN
    SELECT nom_hospital ,telefono FROM tabla_hospital; 

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE cantidad_camas(IN valor INT(10))
BEGIN
SELECT * FROM tabla_hospital  WHERE num_Cama >= valor;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE consultar_doctores()
BEGIN
  SELECT nom_doctor, especialidad FROM tabla_doctor;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE consultar_hospital_lapaz()
BEGIN
  SELECT * FROM tabla_doctor WHERE cod_hospital = 22;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE consultar_vendedores_comision()
BEGIN
  SELECT * FROM tabla_emp WHERE oficio = 'VENDEDOR' ORDER BY comision DESC;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE consultar_departamentos()
BEGIN
  SELECT * FROM tabla_dept;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE salario_promedio_departamento()
BEGIN
  SELECT cod_depar, ROUND(AVG(salario), 2) AS salario_promedio FROM tabla_emp GROUP BY cod_depar;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE contar_empleados_departamento()
BEGIN
  SELECT cod_depar, COUNT(cod_depar) AS cantidad_empleados FROM tabla_emp GROUP BY cod_depar;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE datos_enfermos_porsexo(IN p_sexo CHAR(1))
BEGIN
  SELECT * FROM tabla_enfermo WHERE sexo = p_sexo;
END $$

DELIMITER ;



DELIMITER $$

CREATE PROCEDURE cantidadenfermos()
BEGIN
  SELECT COUNT(cod_ingreso) AS Cantidad FROM tabla_enfermo;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sumar_salario_oficio()
BEGIN
  SELECT oficio, SUM(salario) AS total_salario FROM tabla_emp GROUP BY oficio;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE empleados_sin_comision()
BEGIN
  SELECT * FROM tabla_emp WHERE comision = 0;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE empleados_fecha_nacimiento()
BEGIN
  SELECT nom_emp FROM tabla_emp WHERE fecha_nac BETWEEN '1981-02-01' AND '1981-12-31';
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE vendedor_mayor_comision()
BEGIN
  SELECT * FROM tabla_emp WHERE comision = (SELECT MAX(comision) FROM tabla_emp);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE nuevo_depto(IN p_cod INT, IN p_nombre VARCHAR(255), IN p_ciudad VARCHAR(255))
BEGIN
  INSERT INTO tabla_dept (cod_depar, nom_depar, ciudad_depar) VALUES (p_cod, p_nombre, p_ciudad);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE actualizar_empleado_a_dpto(IN p_doc_emp INT,IN p_cod_depar INT)
BEGIN
  UPDATE tabla_emp SET cod_depar = p_cod_depar
  WHERE doc_emp = p_doc_emp;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE insertar_empleado(IN id INT,
  IN p_nom_emp VARCHAR(50),
  IN p_oficio VARCHAR(50),
  IN p_fecha_nac DATE,
  IN p_salario NUMERIC(9,2),
  IN p_comision NUMERIC(9,2),
  IN p_departamento INT
)
BEGIN
  INSERT INTO tabla_emp (doc_emp, nom_emp, oficio, fecha_nac, salario, comision, cod_depar)
  VALUES
    (id, p_nom_emp, p_oficio, p_fecha_nac, p_salario, p_comision, p_departamento);
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE actualizar_numero_camas(IN p_cod_hospital INT, IN p_cantidad_camas INT)
BEGIN
  UPDATE tabla_hospital SET num_Cama = num_Cama + p_cantidad_camas WHERE cod_hospital = p_cod_hospital;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE ingresar_doctor(
  IN p_nombre_doctor VARCHAR(50),
  IN p_especialidad VARCHAR(50),
  IN p_cod_hospital INT
)
BEGIN
  INSERT INTO tabla_doctor (nom_doctor, especialidad, cod_hospital)
  VALUES (p_nombre_doctor, p_especialidad, p_cod_hospital);
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE mostrar_nombre_funcion_jornada()
BEGIN
SELECT nombre, funcion, jornada FROM tabla_plantilla;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE empleados_por_jornada(IN p_funcion VARCHAR(50), IN p_jornada VARCHAR(50))
BEGIN
    SELECT nombre , cod_empleado
    FROM tabla_plantilla
    WHERE funcion = p_funcion AND jornada = p_jornada;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE contar_funcion(IN p_funcion VARCHAR(50))
BEGIN
    SELECT COUNT(*) AS Cantidad
    FROM tabla_plantilla
    WHERE funcion = p_funcion;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE ingresar_enfermo(
  IN p_nom_enfermo VARCHAR(50),
  IN p_direccion VARCHAR(50),
  IN p_fecha_nac VARCHAR(50),
  IN p_sexo VARCHAR(2),
  IN p_doc_enfermo INT
)
BEGIN

  INSERT INTO tabla_enfermo (nom_enfermo, direccion, fecha_nac, sexo, doc_enfermo)
  VALUES (p_nom_enfermo, p_direccion, p_fecha_nac, p_sexo, p_doc_enfermo);
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE dar_baja_enfermo(IN p_cod_ingreso INT)
BEGIN
  
  DELETE FROM tabla_enfermo
  WHERE cod_ingreso = p_cod_ingreso;
END $$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE eliminar_doctor(IN p_nombre_doctor VARCHAR(50))
BEGIN
  DELETE FROM tabla_doctor WHERE nom_doctor = p_nombre_doctor LIMIT 1; 
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE despedir_por_oficio(IN p_oficio VARCHAR(50), IN p_cod_depar INT)
BEGIN
  DELETE FROM tabla_emp WHERE oficio = p_oficio AND cod_depar = p_cod_depar;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE reubicar_empleados(IN p_nuevo_departamento INT,IN p_cod_departamento INT)
BEGIN
  UPDATE tabla_emp
  SET cod_depar = p_nuevo_departamento
  WHERE cod_depar = p_cod_departamento;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE eliminar_departamento(IN p_departamento_a_eliminar INT)
BEGIN
  DELETE FROM tabla_emp
  WHERE cod_depar = p_departamento_a_eliminar;
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE contar_por_jornada(IN p_jornada CHAR(1))
BEGIN
    SELECT COUNT(*) AS cantidad_empleados
    FROM tabla_plantilla
    WHERE jornada = p_jornada;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE actualizar_plantilla_jornada()
BEGIN

UPDATE tabla_plantilla SET jornada ='T' WHERE cod_sala = 6 ;
UPDATE tabla_plantilla SET jornada ='M' WHERE cod_sala = 4 OR cod_sala= 2 ;
UPDATE tabla_plantilla SET jornada ='N' WHERE cod_sala = 1 ;
END $$
DELIMITER ;
-- FIN PROCEDIMIENTOS ALMACENADOS

-- Inicio de ejercicios
-- Consultas para darle solucion a los ejercicios.--
-- -------------------------------------------------


-- 1.Muestre todos los datos de los empleados 
CALL consultar_emp();


-- 2.Muestre el nombre del hospital y teléfono de la tabla hospital
CALL nombretel_hospital();


-- 3.Muestre todos los datos de hospital que tengan más de 600 camaS
CALL cantidad_camas (600);

-- 4.Muestre el nombre y la especialidad de todos los doctores
CALL consultar_doctores();

-- 5.Muestre todos los datos del (los) doctor(es) del hospital 'La Paz'
CALL consultar_hospital_lapaz();

-- 6.Muestre todos los datos de empleados cuyo oficio sea 'VENDEDOR', ordenado de mayor a menor por su comisión 
CALL consultar_vendedores_comision();

-- 7.Muestre todos los datos de los departamentos
CALL consultar_departamentos();

-- 8.	Consultar el salario medio, con dos decimales, de los empleados por departamento
CALL salario_promedio_departamento();
-- 9.	Contar los empleados por departamento
CALL contar_empleados_departamento();

-- 10.	Muestre los datos de los hombres enfermos 
CALL datos_enfermos_porsexo('M');
-- 11.	Muestre los datos de las mujeres enfermas 
CALL datos_enfermos_porsexo('F');

-- 12.	Contar, con el alias de Cantidad, los hombre y mujeres que hay enfermos
CALL cantidadenfermos();

-- 13.	Sumar el salario de los empleados por oficio
CALL sumar_salario_oficio();

-- 14.	Muestre los datos de los empleados que no tengan comisión
CALL empleados_sin_comision();



-- 15.	Muestre los empleados con fecha de nacimiento entre 1981-02-01 y 1981-12-31
CALL empleados_fecha_nacimiento();

-- 16.	Muestre los datos del vendedor que más gana comisión  
CALL vendedor_mayor_comision();


-- 17.	Ingrese un nuevo departamento de 'Ventas' en Barranquilla
-- Insertar un nuevo departamento con cod_depar = 50
CALL nuevo_depto(50, 'Ventas', 'Barranquilla');

-- 18.	Actualice el vendedor que más gana comisión ya que se va para Barranquilla
CALL actualizar_empleado_a_dpto(7654, 50);


-- 19.	Ingrese 3 nuevos empleados con oficio de 'VENDEDOR' en Barranquilla = 50
CALL insertar_empleado(7895,'Juan Pérez', 'VENDEDOR', '1985-03-15', 25000, 5000,50);
CALL insertar_empleado(7896,'María González', 'VENDEDOR', '1990-07-20', 28000, 6000,50);
CALL insertar_empleado(7897,'Carlos Rodríguez', 'VENDEDOR', '1988-11-10', 26000, 5500,50);
  
-- 20.	Actualice las camas de hospital 'Provincial', ya que le ingresaron 184 camas nuevas
CALL actualizar_numero_camas(19, 184);


-- 21.	Ingrese dos doctores nuevos, uno para 'Cardiología' al hospital 22; el otro para 'Pediatría' al hospital 18

-- Llamar al procedimiento para ingresar el primer doctor
CALL ingresar_doctor('Dr. López', 'Cardiología', 22);
CALL ingresar_doctor('Dr. Martínez', 'Pediatría', 18);

-- 22.	Muestre los nombres, función y jornada de la plantilla
CALL mostrar_nombre_funcion_jornada();


-- 23.	Muestre todos los datos de las 'Enfermera' de la jornada de la tarde
CALL empleados_por_jornada('Enfermera', 'T');

-- 24.	Cuantos de la plantilla con 'Interino'
-- Para contar los empleados con función 'Interino'
CALL contar_funcion('Interino');


-- 25.	Ingresar 3 nuevos enfermos
CALL ingresar_enfermo('Berto', 'Direccion Jotape', '1990-05-20', 'M', 10005);
CALL ingresar_enfermo('Ana', 'Direccion Pelope', '1990-03-20', 'F', 10006);
CALL ingresar_enfermo('Raul', 'Direccion Dahir', '1990-01-20', 'M', 10007);

-- 26.	Se dan de alta a los enfermos cuyo registro fueron 63827, 18004 y 74835
CALL dar_baja_enfermo(63827); 
CALL dar_baja_enfermo(18004); 
CALL dar_baja_enfermo(74835); 

-- 27.	El doctor 'Galo D.' ya no trabaja más en nuestro hospital
CALL eliminar_doctor('Galo D.');

-- 28.	Por disposición de la junta directiva todos los vendedores de Cali, fueron despedidos del hospital

CALL despedir_por_oficio('VENDEDOR', 30);

-- 29.	Los otros empleados de Cali fueron ubicados en Barranquilla 
-- 50 Seria el nuevo departamento y 30 el anterior 
CALL reubicar_empleados(50, 30);

-- 30.	El departamento de Ventas de Cali, fue cerrado definitivamente
CALL eliminar_departamento(30);

-- 31.	Cuantos hay en la plantilla por jornada
CALL contar_por_jornada('T'); 
CALL contar_por_jornada('N'); 

-- 32.	Actualice la plantilla de manera que queden repartidos, en lo posible, en la misma cantidad por jornada
CALL actualizar_plantilla_jornada();

