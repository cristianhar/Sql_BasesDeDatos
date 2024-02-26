/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2024/12/02
@DESCRIPCION : BASE DE DATOS DE CLIENTES


 */


-- Borro la base de datos si existe
DROP DATABASE IF EXISTS VentasApplicativo;

-- Creo la base de datos si no existe
CREATE DATABASE IF NOT EXISTS VentasApplicativo;

-- Utilizo la tabla 
USE VentasApplicativo;

-- Creo la tabla usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    id_usu INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(11),
    contrasena_usu VARCHAR(32),
    correo VARCHAR(32),
    direccion VARCHAR(100),
    telefono VARCHAR(100),
    PRIMARY KEY (id_usu)
    
);

-- Creo la tabla clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id_cl INT AUTO_INCREMENT,
    identificacion VARCHAR(11),
    nombre_cl VARCHAR(32),
    apellido_cl VARCHAR(32),
    direccion VARCHAR(100),
    PRIMARY KEY (id_cl)
);

-- Creo la tabla productos
CREATE TABLE IF NOT EXISTS Productos (
    id_pr INT AUTO_INCREMENT,
    codigo_pr VARCHAR(11),
    nombre_pr VARCHAR(32),
    stock_pr INT,
    descripcion_pr VARCHAR(100),
    precio_pr INT,
    id_cliente INT,
    PRIMARY KEY (id_pr),
    FOREIGN KEY(id_cliente) REFERENCES Clientes(id_cl)
);

