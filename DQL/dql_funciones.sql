-- 1. TotalIngresosCliente(ClienteID, Año)
-- Esta función calcula los ingresos generados por un cliente en un año específico.

DELIMITER $$
CREATE FUNCTION TotalIngresosCliente(cliente_id int, año int)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total_ingresos
DECIMAL(10,2)

SELECT COALESCE(SUM(amount),0)
INTO total_ingresos
FROM payment
WHERE customer_id = cliente_id
AND YEAR(payment_date) = Año;

RETURN total_ingresos
END $$
DELIMITER ;

-- 2. PromedioDuracionAlquiler(PeliculaID)
-- Esta función retorna la duración promedio de alquiler de una película específica.

DELIMITER $$
CREATE FUNCTION PromedioDuracionAlquiler(id_pelicula INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
DECLARE promedio_dias
DECIMAL(5,2)

SELECT COALESCE(AVG(DATEDIFF(return_date,rental_date)),0)
INTO promedio_dias
FROM rental r
JOIN inventario i ON r.id_inventario = i.id_inventario
WHERE i.id_pelicula = id_pelicula
RETURN promedio_dias
END $$
DELIMITER;

-- 3. IngresosPorCategoria(CategoriaID)
-- Esta función calcula los ingresos totales generados por una categoría específica de películas.

DELIMITER $$
CREATE FUNCTION IngresosPorCategoria(id_categoria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN 
DECLARE total_ingresos
DECIMAL (10,2)
SELECT COALESCE(SUM(p.amount),0)
INTO total_ingresos
FROM payment p
JOIN alquiler r ON p.id_alquiler = r.id_alquiler
JOIN inventario i ON r.id_inventario = i.id_inventario
JOIN categoria c ON i.id_pelicula = c.id_pelicula
WHERE c.id_categoria = id_categoria
RETURN total_ingresos
END $$
DELIMITER ;


-- 4. DescuentoFrecuenciaCliente(ClienteID)
-- Esta función calcula un descuento basado en la frecuencia de alquiler del cliente. Por ejemplo, si el cliente ha alquilado más de 10 veces, recibe un descuento del 10%.
DELIMITER $$
CREATE FUNCTION DescuentoFrecuenciaCliente(id_cliente INT)
RETURNS DECIMAL (5,2)
DETERMINISTIC
BEGIN
DECLARE total_alquileres INT;
DECLARE descuento DECIMAL (10,2);
SELECT COUNT(id_alquiler) INTO total_alquileres
FROM alquiler
WHERE id_cliente = id_cliente
AND alquiler_date >= NOW() INTERVAL 1 YEAR;

IF total_alquileres > 50 THEN
SET descuento = 0.20;

ELSE IF total_alquileres > 30 THEN
SET
descuento = 0.10;
ELSE 
SET descuento = 0.00;
END IF;

RETURN descuento;
END $$
DELIMITER ;

-- 5. EsClienteVIP(ClienteID)
-- Esta función verifica si un cliente es "VIP" basándose en la cantidad de alquileres realizados y los ingresos generados. Un cliente es considerado "VIP" si ha alquilado más de 20 veces o ha generado ingresos superiores a 5000.

DELIMITER $$
CREATE FUNCTION EsClienteVIP(id_cliente INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE total_gasto
DECIMAL (10,2);
DECLARE total_alquileres int;
SELECT SUM(amount),
COUNT(id_alquiler)
INTO total_gasto, total_alquileres
FROM pago
JOIN alquiler ON pago.id_alquiler = alquier.id_alquiler
WHERE pago.id_cliente = id_cliente
AND alquiler_date >= NOW() INTERVAL 1 YEAR;
RETURN (total_gasto>500 OR total_alquileres>40);
END $$
DELIMITER ;
