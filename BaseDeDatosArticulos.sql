/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2023/10/03
@DESCRIPCION : BASE DE DATOS DE ARTICULOS


 */

-- -----------------------------------------------------
-- Borro la BD para volverla a crear
-- -----------------------------------------------------
 DROP SCHEMA IF EXISTS articulosbd;
 
 
 -- -----------------------------------------------------
-- Creo la bd de la libreria si no Existe
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS articulosbd;
USE articulosbd ;


-- -----------------------------------------------------
-- Creo la tabla clientes
-- -----------------------------------------------------
CREATE TABLE clientes (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(100) NOT NULL,
  saldo INT NOT NULL,
  limite_credito DATETIME NOT NULL,
  descuento INT NOT NULL,
  PRIMARY KEY (id_cliente)
  );
  
  -- -----------------------------------------------------
-- Creo la tabla pedidos
-- -----------------------------------------------------
  CREATE TABLE  pedidos (
  id_pedido INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(100) NOT NULL,
  fecha_pedido DATETIME NOT NULL,
  cantidad INT NOT NULL,
  id_cliente INT NOT NULL,
  PRIMARY KEY (id_pedido),
  FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
  );
  
-- -----------------------------------------------------
-- Creo la tabla articulos
-- -----------------------------------------------------
  CREATE TABLE IF NOT EXISTS articulos(
  id_articulo INT NOT NULL AUTO_INCREMENT,
  fabrica INT NOT NULL,
  total_articulos INT NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  id_pedido INT NOT NULL,
  PRIMARY KEY (id_articulo),
  FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido));
-- -----------------------------------------------------
-- Creo la tabla fabricas
-- -----------------------------------------------------
CREATE TABLE  fabricas (
 id_fabrica INT NOT NULL AUTO_INCREMENT,
 telefono INT NOT NULL,
 total_articulos  INT NOT NULL,
 id_articulo INT NOT NULL,
 PRIMARY KEY (id_fabrica, id_articulo),
 FOREIGN KEY (id_articulo) REFERENCES articulos(id_articulo)
 );
 
 CREATE TABLE fabricas_alternativas (
  id_fabrica_alternativa INT NOT NULL AUTO_INCREMENT,
  total_articulos INT NOT NULL,
  PRIMARY KEY (id_fabrica_alternativa));

 
 
