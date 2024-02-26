/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/10/25
@DESCRIPCION : BASE DE DATOS DE HOSPITAL


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
(22, 6, 8422, 'Bocina G.', 'Enfermero', 'N', 183800),
(45, 1, 8526, 'Franky H.', 'Enfermera', 'T', 252200),
(22, 2, 9901, 'Núñez C.', 'Interino', 'N', 221000);


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

-- PROCEDIMIENTOS ALMACENADOS

-- Procedimiento para consultar tabla empleado
DELIMITER $$

CREATE PROCEDURE consultar_emp()
BEGIN
    SELECT * FROM tabla_emp;

END $$

DELIMITER ;

-- Procedimiento para consultar el nombre y el telefono de la tabla hospital
DELIMITER $$

CREATE PROCEDURE nombretel_hospital()
BEGIN
    SELECT nom_hospital ,telefono FROM tabla_hospital; 

END $$