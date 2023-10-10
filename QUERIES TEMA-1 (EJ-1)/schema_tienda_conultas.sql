

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SHOW COLUMNS FROM producto;
SELECT nombre, precio AS euros, precio * 1.10 AS 'USD' FROM producto;
SELECT nombre AS "nombre de producto", precio AS euros, precio * 1.10 AS 'USD' FROM producto;
SELECT UPPER(nombre) AS 'Nombre en mayúscululas', precio FROM producto;
-- 7;
SELECT lower(nombre), precio FROM producto;
SELECT nombre, upper(substr(nombre, 1, 2)) FROM fabricante;
SELECT nombre, round(precio) FROM producto;
-- 10;
SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 20;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo; 
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo ORDER BY fabricante;
SELECT p.codigo AS Codigo_P, p.nombre AS producto, f.codigo AS Codigo_F, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo ORDER BY precio LIMIT 1;
-- 25;
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo ORDER BY precio DESC LIMIT 1;
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo';
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Crucial' AND precio > 200;
SELECT p.nombre AS producto, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE (f.nombre = 'Asus' OR f.nombre = 'Seagate'OR f.nombre = 'Hewlett-Packard');
SELECT p.nombre AS producto, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE(f.nombre IN('Asus','Seagate','Hewlett-Packard'));
-- 30;
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%';
SELECT p.nombre AS producto, precio, f.nombre AS fabricante FROM producto AS p INNER JOIN fabricante AS f ON p.codigo_fabricante = f.codigo WHERE precio >= 180 ORDER BY precio DESC, p.nombre ASC;
SELECT DISTINCT f.codigo, f.nombre FROM fabricante AS f INNER JOIN producto AS p ON f.codigo = p.codigo_fabricante;
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante AS f LEFT JOIN producto AS p ON f.codigo = p.codigo_fabricante;
-- 35;
SELECT f.nombre AS fabricante FROM fabricante AS f LEFT JOIN producto AS p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS null;
SELECT nombre, precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
SELECT * FROM producto p WHERE p.precio = (SELECT MAX(p.precio) FROM producto p WHERE p.codigo_fabricante = (SELECT  f.codigo FROM fabricante f WHERE f.nombre = 'Lenovo'));
SELECT * FROM producto INNER JOIN fabricante ON fabricante.codigo=producto.codigo_fabricante WHERE fabricante.nombre='Lenovo' ORDER BY producto.precio DESC LIMIT 1;
SELECT * FROM producto INNER JOIN fabricante ON fabricante.codigo=producto.codigo_fabricante WHERE fabricante.nombre='Hewlett-Packard' LIMIT 1;
SELECT * FROM producto WHERE precio >=(SELECT MAX(producto.precio) FROM producto WHERE producto.codigo_fabricante=(SELECT codigo FROM fabricante WHERE fabricante.nombre= 'Lenovo'));
SELECT p.nombre 'Productos caros de Asus', f.nombre 'Fabricante' FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio > (SELECT AVG(p.precio) FROM producto p 
JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus') AND f.nombre = 'Asus';



















