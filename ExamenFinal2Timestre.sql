/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/11/21
@DESCRIPCION : Examen Final de Base De datos con procedimientos almacenados.


 */

-- Creacion de la base de datos  si no existe
drop database if exists gabineteAbogados;


-- Creo la base de datos
create database gabineteAbogados;

--Utilizo la base de datos
use gabineteAbogados;

-- Borro la tabla si existe 
drop table if exists cliente;

--Creacion de la tabla cliente
create table cliente(
codCliente int not null primary key,
nombreCliente varchar(50) not null,
apellidoCliente varchar(50) not null,
telefonoCliente varchar(20) not null,
direccionCliente varchar(50) not null,
correoCliente varchar(50) not null
);


--Creacion de la tabla procurador
drop table if exists procurador;
create table procurador(
codProcurador int not null primary key,
nombreProcurador varchar(50) not null,
apellidoProcurador varchar(50) not null,
telefonoProcurador varchar(20) not null,
direccionProcurador varchar(50) not null,
correoProcurador varchar(50) not null
);

--Creacion de la tabla asunto
drop table if exists asunto;
create table asunto(
codAsunto int not null auto_increment primary key,
fechaTramite varchar(50),
estadoTramite varchar(50),
codCliente int not null,
codProcurador int not null,
FOREIGN KEY (codCliente) REFERENCES cliente(codCliente),
FOREIGN KEY (codProcurador) REFERENCES procurador(codProcurador)
);

--Creacion de la tabla cambioestadotramite.

drop table if exists cambioEstadoTramite;
create table cambioEstadoTramite(
estadoTramite varchar(50),
fechaTramite varchar(50),
codAsunto int not null
);




--insert into para la tabla clientes
insert into cliente
values
(123,"Carlos","Perez","5555555","Medellín","carlosp@ya.com"),
(456,"Juan","Soto","4444444","Bello","juans@ya.com"),
(789,"Pedro","Paz","7777777","Medellín","pedrop@ya.com"),
(234,"Fredy","Duarte","7676767","Medellín","ferdyd@ya.com"),
(567,"Maribel","Soto","456689","Bello","maribels@ya.com"),
(890,"Hannah","Suarez","234213","Medellín","hannahs@ya.com");


--Insert into para la tabla procurador
insert into procurador
values
(987,"María","Bedoya","9998800","Medellín","mariab@ya.com"),
(654,"Ruben","Díaz","2225566","Itagüí","rubend@ya.com"),
(321,"Daniela","Hoyos","6664499","Medellín","dhoyos@ya.com");

--Insert into para la tabla asunto

insert into asunto(fechaTramite,estadoTramite,codCliente,codProcurador)
values
("10-11-2023","En Trámite",123,321),
("11-11-2023","En Trámite",789,654),
("11-11-2023","En Trámite",456,321),
("12-11-2023","En Trámite",567,987),
("13-11-2023","En Trámite",890,321),
("15-11-2023","En Trámite",234,321);



-- Ejercicio 1
CREATE VIEW todalainfor 
AS SELECT c.nombreCliente 
AS NombreCliente , c.apellidoCliente 
AS ApellidoCliente , a.fechaTramite 
AS Fecha_Tramite, a.estadoTramite 
AS Estado_Tramite FROM cliente as c JOIN asunto as a ON c.codCliente = a.codCliente;

DELIMITER $$
CREATE PROCEDURE mostrar_nom_apellido()
BEGIN 
SELECT * FROM todalainfor;

END $$
DELIMITER ;
/*
-- Ejercicio 2 
CREATE VIEW procurador_cliente AS SELECT p.nombreProcurador 
AS NombreProcurador  , a.codAsunto 
AS CodigoCaso, c.nombreCliente 
AS NombreCliente ,a.estadoTramite 
AS EstadoTramite FROM procurador as p JOIN cliente as c  JOIN asunto as a ON c.codCliente = a.codCliente  ;

-- 2. Usando Procedimiento Almacenado, mostrar el nombre del Procurador, el código  
-- de los casos que tiene asigados, en que estado se encuentran y el nombre del cliente,
-- ordenado por el nombre del cliente

DELIMITER $$
*/
-- DROP VIEW procurador_cliente;

DELIMITER $$
CREATE PROCEDURE mostrar_nompro_codigo_casos()
BEGIN 

SELECT p.nombreProcurador 
AS NombreProcurador  , a.codAsunto 
AS CodigoCaso, c.nombreCliente 
AS NombreCliente ,a.estadoTramite 
AS EstadoTramite FROM procurador as p  
JOIN asunto as a ON p.codProcurador = a.codProcurador JOIN cliente as c  ON c.codCliente = a.codCliente ;
END $$
DELIMITER ;


-- Ejercicio 3



DELIMITER $$
CREATE TRIGGER cambioEstadodeTramitesS
 AFTER UPDATE ON asunto
 FOR EACH ROW
 BEGIN 
 INSERT INTO  cambioEstadoTramite (estadoTramite,fechaTramite,codAsunto) VALUES (new.estadoTramite,new.fechaTramite,old.codAsunto);
 END $$
 DELIMITER ;

-- Ejercicio 4
CREATE VIEW mostrarDatosEstado AS SELECT estadoTramite ,fechaTramite , codAsunto FROM cambioEstadoTramite;


-- Ejercicio 5 



DELIMITER $$
CREATE TRIGGER borrarestados
 BEFORE DELETE
 ON asunto
 FOR EACH ROW
 BEGIN 
 DELETE FROM cambioEstadoTramite WHERE codAsunto = old.codAsunto ;
 END $$
 DELIMITER ;
 


-- --------------------------------------------------------------------
-- Final de Bases de Datos II ----- Ficha: 2795599
-- Nombres y Apellidos Completos: Cristian Johao Arboleda Henao
-- Número de Documento: 1214742451
-- ___________________________________________________________________________________________________________
-- 1. Usando Procedimiento Almacenado, mostar el nombre y apellido de los clientes 
-- en un solo campo, con el estado de su trámite y la fecha del trámite
CALL mostrar_nom_apellido();



-- ___________________________________________________________________________________________________________
-- 2. Usando Procedimiento Almacenado, mostrar el nombre del Procurador, el código  
-- de los casos que tiene asigados, en que estado se encuentran y el nombre del cliente,
-- ordenado por el nombre del cliente

CALL mostrar_nompro_codigo_casos();

-- ___________________________________________________________________________________________________________
-- 3. En una tabla llamada "cambioEstadoTramite", almacenar TODOS LOS DATOS cuando se haga una 
-- actualización de estado y fecha en la tabla "asunto" (Trigger)
UPDATE asunto SET fechaTramite = "21-11-2023", estadoTramite = "Cerrado" WHERE codAsunto = 1;
SELECT * FROM cambioEstadoTramite;
SELECT * FROM asunto;


-- ___________________________________________________________________________________________________________
-- 4. Genere una vista con los todos losdatos de la tabla "cambioEstadoTramite" 
-- ordenado por la fecha

SELECT * FROM mostrarDatosEstado ;



-- ___________________________________________________________________________________________________________
-- 5. Si se elimina un caso en la tabla asunto, se deben eliminar todos sus 
-- registros de la tabla cambioEstadoTramite (Trigger)

DELETE FROM asunto  WHERE codAsunto = 1 LIMIT 1;
