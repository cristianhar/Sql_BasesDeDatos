/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/11/09
@DESCRIPCION : BASE DE DATOS DE DEPORTES - EJERCICIOS DE PRACTICA Y CONSULTAS BASICAS CON PROCEDIMIENTOS ALMACENADOS Y VISTAS


 */
DROP DATABASE IF EXISTS deportes;
CREATE DATABASE deportes;
Use deportes;

create table socios(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  primary key (documento)
 );

 create table profesores(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  primary key (documento)
 );

 create table cursos(
  numero integer auto_increment,
  deporte varchar(20),
  dia varchar(15),
  documentoprofesor char(8),
  primary key (numero)
 );

 create table inscritos(
  documentosocio char(8) not null,
  numero integer not null,
  matricula char(1),
  primary key (documentosocio,numero)
 );


insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into profesores values('23333333','Carlos Caseres','Colon 245');
 insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into profesores values('25555555','Esteban Lopez','Sucre 1204');

 insert into cursos(deporte,dia,documentoprofesor) 
  values('tenis','lunes','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('tenis','martes','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','miercoles','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','jueves','23333333');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','viernes','23333333');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('futbol','sabado','24444444');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('futbol','lunes','24444444');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('basquet','martes','24444444');

 insert into inscritos values('30000000',1,'s');
 insert into inscritos values('30000000',3,'n');
 insert into inscritos values('30000000',6,null);
 insert into inscritos values('31111111',1,'s');
 insert into inscritos values('31111111',4,'s');
 insert into inscritos values('32222222',8,'s');
 
 -- CREA UNA VISTA EN LA QUE APAREZCA EL NOMBRE Y DOCUMENTO DEL SOCIO , EL DEPORTE ,EL DIA Y EL NOMBRE DEL PROFESOR (NO MOSTRAR DATOS DE LOS SOCIOS QUE NO ESTAN INSCRITOS EN DEPORTES)
 
 CREATE VIEW vista_club AS 
 SELECT s.nombre as socio ,
 s.documento as docsocio,
 s.domicilio as domsocio,
 c.deporte as deporte, 
 dia ,
 p.nombre as profesor, matricula
 from socios as s 
 join inscritos as i on s.documento = i.documentosocio
 join cursos as c on i.numero=c.numero 
 join profesores as p on c.documentoprofesor= p.documento;
 
 -- Realice una consulta a la vista donde muestre la cantidad de socios inscriptos en cada deporte ordenados por cantidad
 
 SELECT deporte , count(socio) as cantidad from vista_club group by deporte order by cantidad ;
 
 -- Muestre consultando la vista el nombre y documento de los socios que deben matriculas
 SELECT socio , docsocio FROM vista_club WHERE matricula != 's';
 -- Los profesores y los dias en que asisten al club para dictar sus clases
 SELECT DISTINCT profesor,dia from vista_club;
 
 
 -- Muestre todos los socios que son compañeros en tenis los lunes
 SELECT socio ,docsocio FROM vista_club WHERE dia = 'lunes' AND deporte = 'tenis';
 
 -- Consulte la vista vista_inscritos  que muestre la cantidad de inscritos por curso , incluyendo el nombre del deporte y el dia 
 
 CREATE VIEW vista_inscritos AS SELECT deporte , dia ,(SELECT count(*) FROM inscritos AS i WHERE i.numero = c.numero )as cantidad FROM cursos as c ;
 SELECT * FROM vista_inscritos;           


                        
