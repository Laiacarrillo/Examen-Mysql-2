CREATE DATABASE sakilacampus;
USE sakilacampus;

1-- 
CREATE TABLE pais (
    id_pais SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

2--
CREATE TABLE ciudad (
    id_ciudad SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_pais SMALLINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

3--
CREATE TABLE direccion (
    id_direccion SMALLINT UNSIGNED PRIMARY KEY,
    direccion VARCHAR(50) NOT NULL,
    direccion2 VARCHAR(50),
    distrito VARCHAR(50),
    id_ciudad SMALLINT UNSIGNED NOT NULL,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

4--
CREATE TABLE cliente (
    id_cliente SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_almacen TINYINT UNSIGNED NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    email VARCHAR(50),
    id_direccion SMALLINT UNSIGNED NOT NULL,
    activo TINYINT(1) NOT NULL DEFAULT 1,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

5--
 CREATE TABLE empleado (
    id_empleado TINYINT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    id_direccion SMALLINT UNSIGNED NOT NULL,
    email VARCHAR(50),
    id_almacen TINYINT UNSIGNED NOT NULL,
    activo TINYINT(1) NOT NULL DEFAULT 1,
    username VARCHAR(16) NOT NULL,
    password VARCHAR(40) NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

6--
CREATE TABLE almacen (
    id_almacen TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_empleado_jefe TINYINT UNSIGNED NOT NULL,
    id_direccion SMALLINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

7--
CREATE TABLE pelicula (
    id_pelicula SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma TINYINT UNSIGNED NOT NULL,
    id_idioma_original TINYINT UNSIGNED,
    duracion_alquiler TINYINT UNSIGNED NOT NULL,
    rental_rate DECIMAL(4,2) NOT NULL,
    duracion SMALLINT UNSIGNED NOT NULL,
    replacement_cost DECIMAL(5,2) NOT NULL,
    clasificacion ENUM('G','PG','PG-13','R','NC-17') NOT NULL,
    caracteristicas_especiales SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

8--
CREATE TABLE inventario (
    id_inventario MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_pelicula SMALLINT UNSIGNED NOT NULL,
    id_almacen TINYINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

9--
CREATE TABLE alquiler(
    id_alquiler INT PRIMARY KEY AUTO_INCREMENT,
    fecha_alquiler DATETIME NOT NULL,
    id_inventario MEDIUMINT UNSIGNED NOT NULL,
    id_cliente SMALLINT UNSIGNED NOT NULL,
    fecha_devolucion DATETIME,
    id_empleado TINYINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

10--
CREATE TABLE pago (
    id_pago SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_cliente SMALLINT UNSIGNED NOT NULL,
    id_empleado TINYINT UNSIGNED NOT NULL,
    id_alquiler INT NOT NULL,
    total DECIMAL(5,2) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);

11--
CREATE TABLE idioma (
    id_idioma TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre CHAR(20) NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

12--
CREATE TABLE categoria (
    id_categoria TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

13--
CREATE TABLE pelicula_categoria (
    id_pelicula SMALLINT UNSIGNED NOT NULL,
    id_categoria TINYINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pelicula, id_categoria),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

14--
CREATE TABLE actor (
    id_actor SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

15--
CREATE TABLE pelicula_actor (
    id_pelicula SMALLINT UNSIGNED NOT NULL,
    id_actor SMALLINT UNSIGNED NOT NULL,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_pelicula, id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor)
);

16--
CREATE TABLE film_text (
    film_id SMALLINT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT
);





