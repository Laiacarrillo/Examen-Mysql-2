-- 1. Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 
SELECT cliente_id, COUNT(*) AS cantidad_alquileres
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH
GROUP BY cliente_id
ORDER BY cantidad_alquileres DESC
LIMIT 1;

-- 2. Lista las cinco películas más alquiladas durante el último año
SELECT pelicula_id, COUNT(*) AS cantidad_alquileres
FROM alquileres
WHERE fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY pelicula_id
ORDER BY cantidad_alquileres DESC
LIMIT 5;