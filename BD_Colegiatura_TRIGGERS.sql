/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/11/21
@DESCRIPCION : BASE DE DATOS DE COLEGIATURA - CREACION DE TRIGGERS


 */
 drop database if exists colegiatura;
CREATE DATABASE colegiatura;
USE colegiatura;
-- drop database if exists profesores;

create table profesores(
codigoprofesor INT auto_increment,
nombre varchar(30),
primary key (codigoprofesor)
);

create table alumnos(
documento char (8),
nombre varchar(10),
nota decimal(4,2),
codigoprofesor INT, 
primary key (documento),
foreign key (codigoprofesor) references profesores (codigoprofesor)
);

INSERT INTO profesores (codigoprofesor, nombre) VALUES
(1,'Professor Smith'),
(2,'Professor Johnson'),
(3,'Professor Davis');

INSERT INTO alumnos (documento, nombre, nota, codigoprofesor) VALUES
('12345678', 'Alice', 4.75, 1),
('23456789', 'Bob', 2.95, 2),
('34567890', 'Carol', 4.12, 1),
('45678901', 'David', 4.88, 3),
('56789012', 'Emily', 3.45, 2),
('67890123', 'Frank', 1.32, 3);

-- -- crear una vista con los datos de todos los alumnos que tienen una nota mayor o igual a 3,5 junto con el nombre del profesor que lo calificó

CREATE VIEW vista_alumno as select a.documento, a.nombre as nombrealumno, a.nota, p.nombre as nombreprofesor, a.codigoprofesor as codigoprofesor 
from alumnos as a join profesores as p on a.codigoprofesor=p.codigoprofesor 
WHERE nota>=3.5;

select * from vista_alumno;
	
Insert into vista_alumno (documento, nombrealumno, nota, codigoprofesor)
VALUES ('5123467','John Doe', 4.75, 2);

select * from alumnos;

-- modificamos la nota de un alumno aprobado mediante la vista
update vista_alumno set nota=4.5 where documento='23456789';
select * from vista_alumno;

CREATE TABLE usuarios(
nombre VARCHAR(30),
clave VARCHAR(30),
primary key(nombre)
);

CREATE TABLE clavesanteriores(
numero INT AUTO_INCREMENT,
nombre VARCHAR(30),
clave VARCHAR(30),
primary key (numero)
);

DELIMITER //
CREATE TRIGGER before_usuarios_update
before update
on usuarios
for each row 
begin 
insert into clavesanteriores (nombre,clave) values (old.nombre, old.clave);
end //
DELIMITER ;

insert into usuarios (nombre, clave) values ('marcos', '123abc');

update usuarios set clave='999zzz' where nombre= 'marcos';

select * from clavesanteriores;


-- JSAFKJAHF

CREATE TABLE libros ( 
codigo int auto_increment,
titulo varchar(50),
autor varchar (50),
editorial varchar(10),
precio float,
stock int,
primary key (codigo)
);

CREATE TABLE ventas (
numero int auto_increment,
codigolibro int,
precio float,
cantidad int,
primary key (numero)
);

insert into libros(titulo, autor, editorial, precio, stock)
  values('Uno','Richard Bach','Planeta',15,100);   
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Ilusiones','Richard Bach','Planeta',18,50);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('El aleph','Borges','Emece',25,200);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Aprenda PHP','Mario Molina','Emece',45,200);
  
  
-- Cuando compran libros
  DELIMITER //
  CREATE TRIGGER before_ventas_insert
  BEFORE insert 
  on ventas for each row 
  begin 
  update libros set stock=libros.stock-new.cantidad
  where new.codigolibro=libros.codigo;
  end //
  DELIMITER ;
  
INSERT INTO ventas(codigolibro,precio,cantidad) VALUES (1,15,1);

-- Cuando el cliente devolvio un libro
 DELIMITER //
CREATE TRIGGER before_libros_update
 BEFORE UPDATE 
  on ventas for each row 
  begin 
  update libros set stock=libros.stock+1
  where old.codigolibro=libros.codigo;
  end //
  DELIMITER ;
  
UPDATE ventas SET cantidad = cantidad - 1 where numero =3 ;  


-- Creamos un nuevo disparador para actualizar el campo stock de la tabla libros cuando se elimina un registro de la tabla ventas
 DELIMITER //
CREATE TRIGGER before_ventas_delete
 BEFORE DELETE 
  on ventas for each row 
  begin 
  update libros set stock=libros.stock+old.cantidad
  where old.codigolibro=libros.codigo;
  end //
  DELIMITER ;
  
DELETE from ventas WHERE numero = 2;
SELECT * FROM libros;
SELECT * FROM ventas;


SHOW triggers;
