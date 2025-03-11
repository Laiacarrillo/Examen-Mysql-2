## Sistema de Alquiler de Películas

### Descripción del Proyecto

Este proyecto tiene como objetivo la implementación de consultas SQL, funciones, triggers y eventos en una base de datos de alquiler de películas. Se utilizará el sistema Sakila como base para las tareas y consultas. Las actividades incluyen el análisis de datos de alquileres, la implementación de funcionalidades para gestionar clientes y películas, y la automatización de tareas periódicas.

## Estructura del Repositorio

- `/Consultas_SQL`: Contiene las consultas SQL requeridas.
- `/Funciones_SQL`: Contiene las funciones SQL.
- `/Triggers`: Contiene los triggers SQL.
- `/Eventos`: Contiene los eventos SQL.
- `/Documentación`: Contiene este archivo y otros documentos relacionados.

## Instalación y Configuración
Para implementar la base de datos, sigue estos pasos:
1. Clona el repositorio desde GitHub:
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```
2. Abre MySQL Workbench o tu herramienta preferida.
3. Ejecuta el script `ddl.sql` para crear la estructura de la base de datos:
   ```sql
   SOURCE ddl.sql;
   ```
4. Carga los datos iniciales ejecutando `dml.sql`:
   ```sql
   SOURCE dml.sql;
   ```
5. Ejecuta los diferentes scripts SQL según sea necesario:
   - Consultas: `dql_select.sql`
   - Procedimientos almacenados: `dql_procedimientos.sql`
   - Funciones: `dql_funciones.sql`
   - Triggers: `dql_triggers.sql`
   - Eventos: `dql_eventos.sql`


### Requerimientos
- Base de Datos: El sistema debe utilizar la base de datos Sakila.
- Entorno de Ejecución: Se debe ejecutar sobre un servidor SQL compatible con la sintaxis estándar de MySQL (o similar).

### Objetivos:
- Consultas para obtener información sobre clientes, películas, alquileres y categorías.
- Funciones para calcular ingresos, duraciones y descuentos.
- Triggers para automatizar actualizaciones y auditorías.
- Eventos programados para generar informes y mantener la base de datos.
- Consultas SQL
-- El objetivo es realizar diversas consultas sobre la base de datos de alquiler de películas para obtener información clave, como:

- Cliente con más alquileres en los últimos 6 meses.
- Las películas más alquiladas durante el último año.
-Ingresos y cantidad de alquileres por cada categoría de película.
- Número total de clientes que han realizado alquileres por idioma en un mes específico.
- Clientes que han alquilado todas las películas de una categoría.
- Ciudades con más clientes activos en el último trimestre.
- Categorías con menos alquileres registrados en el último año.
- Promedio de días que un cliente tarda en devolver las películas alquiladas.
- Empleados que gestionaron más alquileres en la categoría de acción.
- Informe de clientes con alquileres recurrentes.
- Costo promedio de alquiler por idioma de las películas.
- Películas con mayor duración alquilada en el último año.
- Clientes que más alquilaron películas de comedia.
- Total de días alquilados por cada cliente en el último mes.
- Número de alquileres diarios por cada almacén en el último trimestre.
- Ingresos totales generados por cada almacén en el último semestre.
- Cliente que ha realizado el alquiler más caro en el último año.
- Categorías con más ingresos generados en los últimos tres meses.
- Cantidad de películas alquiladas por cada idioma en el último mes.
- Clientes que no han realizado ningún alquiler en el último año.

## Funciones SQL
Se deben desarrollar las siguientes funciones para realizar cálculos específicos sobre los datos:

- TotalIngresosCliente: Calcula los ingresos generados por un cliente en un año específico.
- PromedioDuracionAlquiler: Retorna la duración promedio de alquiler de una película específica.
- IngresosPorCategoria: Calcula los ingresos totales generados por una categoría específica de películas.
- DescuentoFrecuenciaCliente: Calcula un descuento basado en la frecuencia de alquiler de un cliente.
- EsClienteVIP: Verifica si un cliente es "VIP" basado en la cantidad de alquileres realizados y los ingresos generados.

## Triggers
Se deben implementar los siguientes triggers para automatizar acciones dentro de la base de datos:

- ActualizarTotalAlquileresEmpleado: Al registrar un alquiler, se actualiza el total de alquileres gestionados por el empleado correspondiente.
- AuditarActualizacionCliente: Cada vez que se modifica un cliente, se registra el cambio en una tabla de auditoría.
- RegistrarHistorialDeCosto: Guarda el historial de cambios en los costos de alquiler de las películas.
- NotificarEliminacionAlquiler: Registra una notificación cuando se elimina un registro de alquiler.
- RestringirAlquilerConSaldoPendiente: Evita que un cliente con saldo pendiente pueda realizar nuevos alquileres.

## Eventos SQL
Se deben crear los siguientes eventos para automatizar tareas periódicas:

- InformeAlquileresMensual: Genera un informe mensual de alquileres y lo almacena automáticamente.
- ActualizarSaldoPendienteCliente: Actualiza los saldos pendientes de los clientes al final de cada mes.
- AlertaPeliculasNoAlquiladas: Envía una alerta cuando una película no ha sido alquilada en el último año.
- LimpiarAuditoriaCada6Meses: Borra los registros antiguos de auditoría cada seis meses.
- ActualizarCategoriasPopulares: Actualiza la lista de categorías más alquiladas al final de cada mes.

## Estructura del Repositorio
El repositorio sigue una organización clara y estructurada:
```
Los_Ambientales/
│-- ddl.sql              # Creación de la base de datos y tablas
│-- dml.sql              # Inserción de datos 
│-- dql_select.sql       # Consultas SQL
│-- dql_funciones.sql    # Funciones definidas en SQL
│-- dql_triggers.sql     # Triggers
│-- dql_eventos.sql      # Eventos programados
│-- README.md            # Documentación del proyecto
│-- Diagrama.jpg         # Modelo de datos
```
## Autor

Laia Carrillo

Este README describe el objetivo y las tareas del proyecto. Asegúrate de cumplir con todos los requisitos y realizar las tareas de acuerdo a las especificaciones de la base de datos Sakila.



