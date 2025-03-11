-- 1. Evento: InformeAlquileresMensual
-- Genera un informe mensual de alquileres y lo almacena automáticamente en una tabla de informes.

CREATE EVENT InformeAlquileresMensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-04-01 00:00:00'
DO
BEGIN
    INSERT INTO InformeAlquileres (Fecha, TotalAlquileres, TotalIngresos)
    SELECT 
        CURDATE(),
        COUNT(*),
        SUM(CASE WHEN Estado = 'Finalizado' THEN CostoAlquiler ELSE 0 END)
    FROM Alquileres
    WHERE FechaAlquiler BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE();
END;

-- 2. Evento: ActualizarSaldoPendienteCliente
-- Actualiza los saldos pendientes de los clientes al final de cada mes.

CREATE EVENT ActualizarSaldoPendienteCliente
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-31 23:59:59'
DO
BEGIN
    UPDATE Clientes
    SET SaldoPendiente = (
        SELECT SUM(Saldo) FROM Alquileres WHERE ClienteID = Clientes.ClienteID AND Estado = 'Pendiente'
    );
END;

-- 3. Evento: AlertaPeliculasNoAlquiladas
-- Envía una alerta cuando una película no ha sido alquilada en el último año.

CREATE EVENT AlertaPeliculasNoAlquiladas
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DECLARE finished INT DEFAULT 0;

    DECLARE movie_cursor CURSOR FOR
        SELECT PeliculaID
        FROM Peliculas
        WHERE NOT EXISTS (
            SELECT 1 FROM Alquileres
            WHERE Alquileres.PeliculaID = Peliculas.PeliculaID 
            AND Alquileres.FechaAlquiler > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
        );

    OPEN movie_cursor;

    read_loop: LOOP
        FETCH movie_cursor INTO @PeliculaID;
        IF finished = 1 THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO Alertas (TipoAlerta, Descripcion, Fecha)
        VALUES ('Alerta', CONCAT('La película con ID ', @PeliculaID, ' no ha sido alquilada en el último año.'), CURDATE());

    END LOOP;

    CLOSE movie_cursor;
END;

-- 4. Evento: LimpiarAuditoriaCada6Meses
-- Borra los registros antiguos de auditoría cada seis meses.

CREATE EVENT LimpiarAuditoriaCada6Meses
ON SCHEDULE EVERY 6 MONTH
STARTS '2025-03-11 00:00:00'
DO
BEGIN
    DELETE FROM AuditoriaClientes
    WHERE FechaModificacion < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END;

-- 5. Evento: ActualizarCategoriasPopulares
-- Actualiza la lista de categorías más alquiladas al final de cada mes.

sql
Copiar
CREATE EVENT ActualizarCategoriasPopulares
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-03-31 23:59:59'
DO
BEGIN
    TRUNCATE TABLE CategoriasPopulares; 

    INSERT INTO CategoriasPopulares (CategoriaID, TotalAlquileres)
    SELECT p.CategoriaID, COUNT(a.AlquilerID) AS TotalAlquileres
    FROM Alquileres a
    JOIN Peliculas p ON a.PeliculaID = p.PeliculaID
    WHERE a.FechaAlquiler BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
    GROUP BY p.CategoriaID
    ORDER BY TotalAlquileres DESC
    LIMIT 10; 
END;
