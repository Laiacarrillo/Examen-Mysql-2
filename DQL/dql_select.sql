-- 1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 
SELECT id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH
GROUP BY id_cliente
ORDER BY cantidad_alquileres DESC
LIMIT 1;

-- 2. Lista las cinco películas más alquiladas durante el último año
SELECT  p.id_pelicula, p.titulo, COUNT(a.id_alquiler) AS cantidad_alquileres
FROM alquiler a
JOIN inventario i on a.id_inventario = i.id_inventario 
JOIN pelicula p on i.id_pelicula = p.id_pelicula 
WHERE a.fecha_alquiler >= DATE_SUB(), INTERVAL 1 YEAR
GROUP BY p.id_pelicula 
GROUP BY cantidad_alquileres DESC 
LIMIT 5;

-- 3. Obtén el total de ingresos y la cantidad de alquileres realizados por cada categoría de película
SELECT p.clasificacion  AS categoria, COUNT(a.id_alquiler) AS total_alquileres, SUM(p.rental_rate) AS ingresos_totales
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario 
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
GROUP BY p.clasificacion 
GROUP BY ingresos_totales DESC;

-- 4. Calcula el número total de clientes que han realizado alquileres por cada idioma disponible en un mes específico
SELECT idioma.nombre AS idioma, COUNT(DISTINCT cliente.id_cliente) AS total_clientes
FROM alquiler a
JOIN cliente cliente ON a.id_cliente = cliente.id_cliente 
JOIN inventario i ON a.id_inventario = i.id_inventario 
JOIN pelicula p ON i.id_pelicula = p.id_pelicula 
JOIN idioma idioma ON p.id_idioma = idioma.id_idioma 
WHERE MONTH(a.fecha_alquiler) = MONTH(CURDATE())
GROUP BY idioma.nombre;

-- 5. Encuentra a los clientes que han alquilado todas las películas de una misma categoría
SELECT c.id_cliente, c.nombre, c.apellidos , p.clasificacion
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente 
JOIN  inventario i ON a.id_inventario = i.id_inventario 
JOIN pelicula p ON i.id_pelicula = p.id_pelicula 
GROUP BY c.id_cliente, p.clasificacion 
HAVING COUNT(DISTINCT p.id_pelicula)=
		(SELECT COUNT(*) FROM pelicula WHERE clasificacion = p.clasificacion); 
-- 6. Lista las tres ciudades con más clientes activos en el último trimestre
SELECT id_ciudad, COUNT(DISTINCT id_cliente) AS total_clientes
FROM cliente
JOIN alquiler ON cliente.id_cliente = alquiler.id_cliente 
WHERE fecha_alquiler >= CURDATE() - INTERVAL 3 MONTH
GROUP BY id_ciudad
ORDER BY total_clientes DESC
LIMIT 3;

-- 7. Muestra las cinco categorías con menos alquileres registrados en el último año
SELECT p.clasificacion AS categoria, COUNT(a.id_alquiler) AS total_alquileres
FROM alquiler a 
JOIN inventario i ON a.id_inventario = i.id_inventario 
JOIN pelicula p ON i.id_pelicula = p.id_pelicula 
WHERE a.fecha_alquiler >= DATE_SUB(NOW(), INTERVAL 1 YEAR) 
GROUP BY p.clasificacion
GROUP BY total_alquileres ASC 
LIMIT 5;


-- 8. Calcula el promedio de días que un cliente tarda en devolver las películas alquiladas
SELECT cliente_id, AVG(DATEDIFF(fecha_devolucion, fecha_alquiler)) AS promedio_dias
FROM alquileres
GROUP BY cliente_id;


-- 9. Encuentra los cinco empleados que gestionaron más alquileres en la categoría de Acción
SELECT id_empleado, COUNT(*) AS cantidad_alquileres
FROM alquiler
JOIN empleado ON alquiler.id_empleado = empleado.id_empleado
JOIN pelicula ON alquiler.id_pelicula = pelicula.id_pelicula
JOIN categoria ON pelicula.id_categoria = categoria.id_categoria 
WHERE categoria.nombre = 'Acción'
GROUP BY id_empleado 
ORDER BY cantidad_alquileres DESC
LIMIT 5;

-- 10. Genera un informe de los clientes con alquileres más recurrentes
SELECT id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquiler
GROUP BY id_cliente 
ORDER BY cantidad_alquileres DESC;


-- 11. Calcula el costo promedio de alquiler por idioma de las películas
SELECT id_idioma, AVG(costo) AS costo_promedio
FROM pelicula
JOIN alquiler ON pelicula.id_pelicula = alquiler.id_pelicula
GROUP BY idioma;

-- 12. Lista las cinco películas con mayor duración alquiladas en el último año
SELECT id_pelicula, DURACION, COUNT(*) AS cantidad_alquileres
FROM alquiler
JOIN pelicula ON alquiler.id_pelicula = pelicula.id_pelicula 
WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY pelicula_id
ORDER BY DURACION DESC
LIMIT 5;

-- 13. Muestra los clientes que más alquilaron películas de Comedia
SELECT id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquiler
JOIN pelicula ON alquiler.id_pelicula= pelicula.id_pelicula 
JOIN categoria ON pelicula.id_categoria = categoria.id_categoria 
WHERE categoria.nombre = 'Comedia'
GROUP BY cliente_id
ORDER BY cantidad_alquileres DESC
LIMIT 5;

-- 14. Encuentra la cantidad total de días alquilados por cada cliente en el último mes
SELECT id_cliente, SUM(DATEDIFF(fecha_devolucion, fecha_alquiler)) AS total_dias
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 MONTH
GROUP BY id_cliente;

-- 15. Muestra el número de alquileres diarios en cada almacén durante el último trimestre
SELECT almacen_id, DATE(fecha_alquiler) AS fecha, COUNT(*) AS cantidad_alquileres
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 3 MONTH
GROUP BY almacen_id, fecha
ORDER BY fecha;

-- 16. Calcula los ingresos totales generados por cada almacén en el último semestre
SELECT almacen_id, SUM(ingresos) AS total_ingresos
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH
GROUP BY almacen_id;

-- 17. Encuentra el cliente que ha realizado el alquiler más caro en el último año
SELECT cliente_id, MAX(ingresos) AS alquiler_mas_caro
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY cliente_id
ORDER BY alquiler_mas_caro DESC
LIMIT 1;

-- 18. Lista las cinco categorías con más ingresos generados durante los últimos tres meses
SELECT p.clasificacion AS categoria,
	SUM(p.rental_rate) AS ingresos_totales
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario 
JOIN pelicula p ON i.id_pelicula  = p.id_pelicula 
WHERE a.fecha_alquiler >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
GROUP BY p.clasificacion 
GROUP BY ingresos_totales DESC 
LIMIT 5;

-- 19. Obtén la cantidad de películas alquiladas por cada idioma en el último mes
SELECT idioma, COUNT(*) AS cantidad_alquileres
FROM alquileres
JOIN peliculas ON alquileres.pelicula_id = peliculas.pelicula_id
WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 MONTH
GROUP BY idioma;

-- 20. Lista los clientes que no han realizado ningún alquiler en el último año
SELECT id_cliente
FROM cliente
WHERE id_cliente NOT IN (
  SELECT DISTINCT id_cliente
  FROM alquiler
  WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
);







