-- 1. Trigger: ActualizarTotalAlquileresEmpleado
-- Este trigger actualiza el total de alquileres gestionados por un empleado cada vez que se registre un alquiler.

CREATE TRIGGER ActualizarTotalAlquileresEmpleado
AFTER INSERT ON alquiler
FOR EACH ROW
BEGIN
    UPDATE Empleados
    SET TotalAlquileres = TotalAlquileres + 1
    WHERE id_empleado = NEW.id_empleado;
END;

-- 2. Trigger: AuditarActualizacionCliente
-- Este trigger registra cualquier cambio en la información de un cliente en una tabla de auditoría.

CREATE TRIGGER AuditarActualizacionCliente
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaClientes (id_cliente, CampoModificado, ValorAnterior, ValorNuevo, FechaModificacion)
    VALUES (NEW.id_cliente, 
            'Nombre', OLD.Nombre, NEW.Nombre, NOW());
END;

-- 3. Trigger: RegistrarHistorialDeCosto
-- Este trigger guarda los cambios en los costos de alquiler de las películas en una tabla de historial de costos.

CREATE TRIGGER RegistrarHistorialDeCosto
AFTER UPDATE ON pelicula
FOR EACH ROW
BEGIN
    IF OLD.CostoAlquiler <> NEW.CostoAlquiler THEN
        INSERT INTO HistorialCostos (PeliculaID, CostoAnterior, CostoNuevo, FechaCambio)
        VALUES (NEW.id_pelicula, OLD.CostoAlquiler, NEW.CostoAlquiler, NOW());
    END IF;
END;

-- 4. Trigger: NotificarEliminacionAlquiler
-- Este trigger registra una notificación cuando un alquiler es eliminado.

CREATE TRIGGER NotificarEliminacionAlquiler
AFTER DELETE ON alquileres
FOR EACH ROW
BEGIN
    INSERT INTO Notificaciones (TipoNotificacion, Detalle, Fecha)
    VALUES ('Eliminación de alquiler', CONCAT('Se ha eliminado el alquiler con ID ', OLD.id_alquiler), NOW());
END;

-- 5. Trigger: RestringirAlquilerConSaldoPendiente
-- Este trigger evita que un cliente con saldo pendiente pueda realizar nuevos alquileres.

CREATE TRIGGER RestringirAlquilerConSaldoPendiente
BEFORE INSERT ON alquileres
FOR EACH ROW
BEGIN
    DECLARE saldoPendiente DECIMAL(10, 2);

    SELECT SUM(Saldo) INTO saldoPendiente
    FROM Alquileres
    WHERE id_cliente = NEW.id_cliente AND Estado = 'Pendiente';

    IF saldoPendiente > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cliente tiene saldo pendiente y no puede realizar un nuevo alquiler.';
    END IF;
END;