/* 

@AUTOR: CRISTIAN ARBOLEDA
@FECHA: 2024/12/02
@DESCRIPCION : BASE DE DATOS DE LIBRERIA 


 */
  
  DROP SCHEMA IF EXISTS libCJAHbd2795599;
 -- -----------------------------------------------------
-- Crear la libreria	
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS libCJAHbd2795599;
USE libCJAHbd2795599 ;

-- Crear la tabla tbl_clientes
CREATE TABLE tbl_clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    identificacion VARCHAR(11) NOT NULL,
    nombres VARCHAR(25) NOT NULL,
    apellidos VARCHAR(25) NOT NULL,
    telefono VARCHAR(12) NOT NULL,
    direccion VARCHAR(100),
    correo_electronico VARCHAR(100) NOT NULL
);

-- Insertar 6 clientes
INSERT INTO tbl_clientes (identificacion, nombres, apellidos, telefono, direccion, correo_electronico)
VALUES
    (1033486313, 'juan david', 'patiño medina', '3054345501', 'calle 35 # 56', 'juand_patino9@soy.sena.edu.co'),
    (32227273, 'Camila', 'Fuentes Carmona', 3173797662, 'Avenida las brisas', 'camila1@gemail.com'),
    (1454893546, 'Julio', 'Medina ruiz', 3508688865, 'Cabañas 5Ta etapa', 'juliom@gemail.com'),
    (91425576, 'Sofia', 'Martinez Osa', 3008500934, 'Avenida 34 A 24', 'osafia@gemail.com'),
    (1000546324, 'Melissa', 'Velez Cano', 3005929704, 'Calle 92 # 74b ', 'melissavel@gemail.com'),
    (1020563112, 'Oscar Andres', 'Medina Ruiz', 3154254538, 'Santa Rosa de Osos', 'oscarruiz@gemail.com');

-- Eliminar 3 clientes
DELETE FROM tbl_clientes WHERE id_cliente IN (4, 5, 6);

-- Crear la tabla tbl_autores
CREATE TABLE tbl_autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(25) NOT NULL,
    apellidos VARCHAR(25) NOT NULL
);

-- Insertar autores adicionales
INSERT INTO tbl_autores (nombres, apellidos)
VALUES
    ('Marc', 'Cerasini'),
    ('Miguel', 'Strogoff'),
    ('Edgar Allan', 'Poe'),
    ('Ben', 'Mezrich'),
    ('Mary', 'Wollstonecraft Shelley'),
    ('Bram', 'Stoker'),
    ('Bruno', 'Nievas'),
    ('César', 'García Muñoz'),
    ('Armando', 'Rodera'),
    ('Jane', 'Austen'),
    ('Emily', 'Bronte'),
    ('Alejandro', 'Dumas'),
    ('Gabriel', 'García Márquez'),
    ('Nikos', 'Kazantzakis'),
    ('Raymond', 'Carver'),
    ('Umberto', 'Eco'),
    ('J. G', 'Ballard'),
    ('Stephen', 'King'),
    ('Haruki', 'Murakami'),
    ('Micahel', 'Chabon'),
    ('Jonathan', 'Sanfran Foer'),
    ('Margaret', 'Atwood'),
    ('Javier', 'Marias'),
    ('Ngugi wa', 'Thiongo'),
    ('J.M', 'Coetzee'),
    ('J.K.', 'Rowling');


-- Crear la tabla tbl_categorias
CREATE TABLE tbl_categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(40) NOT NULL
);

-- Insertar las categorías de los libros
INSERT INTO tbl_categorias (categoria)
VALUES
    ('Acción y Aventura'),
    ('Terror'),
    ('Misterio'),
    ('Ciencia Ficción'),
    ('Drama'),
    ('Historia'),
    ('Fantasía'),
    ('Ficción Moderna'),
    ('Suspenso'),
    ('Romance'),
    ('narrativa'),
    ('novela');

-- Crear la tabla tbl_libros
CREATE TABLE tbl_libros (
    isbn INT,
    titulo VARCHAR(125) NOT NULL,
    fecha_pub DATE NOT NULL,
    categoria INT NOT NULL,
    precio INT NOT NULL,
    portada VARCHAR(255), -- Cambio en esta línea
    cantidad_stock INT NOT NULL CHECK (cantidad_stock >= 0),
    PRIMARY KEY(isbn),
    FOREIGN KEY (categoria) REFERENCES tbl_categorias (id_categoria)
);


-- Insertar los datos de los libros proporcionados
INSERT INTO tbl_libros (isbn, titulo, fecha_pub, categoria, precio, portada, cantidad_stock)
VALUES
    (3720, 'Operation Hell Gate', '2005-09-27', 1, 48000, NULL, 8),
    (3285, 'Miguel Strogoff', '2001-12-10', 1, 25000,NULL, 8),
    (4681, 'El gato Negro', '1997-10-12', 2, 44000,NULL, 8),
    (4982, 'Frankenstein', '1990-03-01', 2, 55500, NULL, 8),
    (3853, 'Sexo en la Luna', '2011-06-01', 8, 29500, NULL, 8),
    (4157, 'Drácula', '1999-04-10', 2, 46800, NULL, 8),
    (4289, 'Realidad Aumentada', '2001-03-13', 9, 35200,NULL, 8),
    (4422, 'Juicio Final, Sangre en el Cielo', '2009-05-30', 9, 40000, NULL, 8),
    (4665, 'El Enigma de los Vencidos', '2000-11-25', 9, 38500, NULL, 8),
    (5786, 'Orgullo y Prejuicio', '2003-09-25', 10, 36100, NULL, 8),
    (6034, 'Cumbres Borrascosas', '1998-11-25', 10, 60800, NULL, 8),
    (6180, 'La Dama de las Camelias', '1995-07-28', 10, 57600, NULL, 8),
    (7291, 'Cien Años de Soledad', '1990-04-27', 11, 39500, NULL, 8),
    (1282, 'Zorba, el Griego', '2010-11-25', 11, 38500, NULL, 8),
    (2835, 'Cathedral', '2004-08-15', 11, 25700, NULL, 8),
    (8807, 'El Nombre de la Rosa', '2011-05-24', 12, 68000, NULL, 8),
    (2437, 'Crónica de una Muerte Anunciada', '2016-07-15', 11, 48000, NULL, 8),
	(7092, 'CRASH', '1901-01-01', 1, 70749, NULL, 8),
    (7122, 'El Imperio del Sol', '1901-01-01', 5, 108058, NULL, 8),
    (9774, 'El Resplandor', '1977-01-28', 2, 49000, NULL, 8),
    (7466, 'La Torre Oscura', '1989-05-20', 7, 54000, NULL, 8),
    (5241, 'Kafka en la orilla', '2008-09-01', 8, 56000, NULL, 8),
    (6200, '1Q84', '2012-11-01', 4, 57000, NULL, 8),
    (6998, 'El misterio de los hermanos Kavalier', '2023-09-28', 8, 85000, NULL, 8),
    (8537, 'Los últimos días de disco', '1997-09-01', 5, 71700, NULL, 8),
    (9671, 'Todo Esta Iluminado', '2016-10-04', 8, 41700, NULL, 8),
    (9192, 'Comer Animasles', '2011-04-05', 5, 80700, NULL, 8),
    (3370, 'El cuento de la criada', '2021-03-04', 8, 52000, NULL, 8),
    (2630, 'La mujer comestible', '2003-06-26', 4, 39000, NULL, 8),
    (2660, 'Todas las almas', '2021-11-05', 8, 80700, NULL, 8),
    (8833, 'Los enamoramientos', '2016-07-15', 5, 48000, NULL, 8),
    (1455, 'Reforzando los Cimientos', '2017-04-29', 8, 85000, NULL, 8),
    (9231, 'sueños en tiempa de guerra', '2016-08-10', 5, 61600, NULL, 8),
    (8985, 'verano', '2020-12-01', 8, 75000, NULL, 8),
    (5609, 'Elizabeth Costello', '2005-03-04', 8, 52000, NULL, 8),
    (2662, 'HARRY POTTER Y LA PIEDRA FILOSOFAL', '2010-06-01', 7, 57000, NULL, 8),
    (6388, 'Animales fantasticos y donde ecncontrarlos', '2023-06-22', 7, 46000, NULL, 8),
    (1667, 'Punto de Fuga', '2008-04-01', 1, 39000, NULL, 8),
    (6095, 'La vuelta al mundo en 80 dias', '2018-02-22', 6, 56000, NULL, 8),
    (7701, 'cuentos de Edgar Allan Poe para niños y niñas', '2022-09-07', 7, 71000, NULL, 8),
    (1944, 'la noche de los monstruos', '2020-07-06', 2, 45000, NULL, 8),
    (1908, 'once upon a time in russia: the rise of the oligarchs--a true story of ambition, wealth, betrayal, and murder', '2016-06-14', 1, 90000, NULL, 8),
	(7902, 'la dama del sudario', '2022-03-21', 11, 80000, NULL, 8),
	(3921, 'Holocausto manhattan', '2013-07-06', 9, 26000, NULL, 8),
	(5973, 'Thirty Six Days', '2014-12-13', 1, 11500, NULL, 8),
	(6466, 'El Enigma De los Vencidos', '2012-05-16',3, 45000, NULL, 8),
    (5551, 'Sentido y Sensibilidad ', '2015-06-11', 10, 41500, NULL, 8),
    (3852, 'Poesía Completa ', '2021-02-17', 10, 90000, NULL, 8),
    (8264, 'El Conde de Montecristo', '2013-02-14', 9, 61000, NULL, 8),
    (5917, 'Odisea', '2018-09-17', 5, 190000, NULL, 8),
    (2523, 'Bajo la Luz Marina', '2005-10-12', 11, 41000, NULL, 8),
    (7993, 'Apocaliptico E integrado', '2023-05-25', 3, 94000, NULL, 8);

-- Crear la tabla tbl_libro_por_autor
CREATE TABLE tbl_libro_por_autor (
    id_autor INT NOT NULL,
    isbn INT NOT NULL,
    PRIMARY KEY (id_autor, isbn),
    FOREIGN KEY (id_autor) REFERENCES tbl_autores (id_autor),
    FOREIGN KEY (isbn) REFERENCES tbl_libros (isbn)
);

-- Insertar los libros por autor
INSERT INTO tbl_libro_por_autor (id_autor, isbn)
VALUES
    (1,3720),
    (1,1667),
    (2,3285),
	(2,6095),
    (3,4681),
    (3,7701),
    (4,4982),
    (4,1944),
    (5,3853),
    (5,1908),
    (6,4157),
    (6,7902),
    (7,4289),
    (7,3921),
    (8,4422),
    (8,5973),
    (9,4665),
    (9,6466),
    (10,5786),
    (10,5551),
    (11,6034),
    (11,3852),
    (12,6180),
    (12,8264),
    (13,7291), 
    (13,2437),
    (14,1282),
    (14,5917),
    (15,2835),
    (15,2523),
    (16,8807),
    (16,7993),
    (17,7092),
    (17,7122),
    (18,9774),
    (18,7466),
    (19,5241),
    (19,6200),
    (20,6998),
    (20,8537),
    (21,9671),
    (21,9192),
    (22,3370),
    (22,2630),
    (23,2660),
    (23,8833),
    (24,1455),
    (24,9231),
    (25,8985),
    (25,5609),
    (26,2662),
    (26,6388);

-- Crear la tabla tbl_pedido_cliente
CREATE TABLE tbl_pedido_cliente (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    nro_pedido INT NOT NULL,
    id_cliente INT NOT NULL,
    isbn INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    subtotal INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES tbl_clientes (id_cliente),
    FOREIGN KEY (isbn) REFERENCES tbl_libros (isbn)
);

-- Insertar mínimo 1 pedido por cada cliente con un mínimo de 2 libros por número de pedido
INSERT INTO tbl_pedido_cliente (nro_pedido, id_cliente, isbn, fecha_pedido, cantidad, subtotal)
VALUES
    (1, 1, 3720, '2023-09-07', 2, 96000),
    (2, 1, 7092, '2023-09-09', 1, 70749),
    (3, 2, 5973, '2023-09-13', 1, 94000),
    (4, 2, 5551, '2023-09-14', 1, 41500),
    (5, 3, 8833, '2023-09-01', 5, 240000),
    (6, 3, 9671, '2023-09-01', 3, 125100);
    
-- consultar la tabla clientes 
SELECT * FROM  tbl_clientes;
SELECT * FROM  tbl_autores;
SELECT * FROM  tbl_categorias;
SELECT * FROM  tbl_libros;
SELECT * FROM  tbl_pedido_cliente;
SELECT * FROM  tbl_libro_por_autor;



