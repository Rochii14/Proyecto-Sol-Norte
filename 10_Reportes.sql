/*ENTREGA 6
*FECHA DE ENTREGA: 20/06/2025
*COMISION:5600
*NUMERO DE GRUPO: 08
*NOMBRE DE LA MATERIA: Base de Datos Aplicadas
*INTEGRANTES: 45318374 | Di Marco Jazmín
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Rocío Elizabeth
*/

USE Com5600G08
go
/*REPORTE 1:
Reporte de los socios morosos, que hayan incumplido en más de dos oportunidades dado un rango de fechas a ingresar. 
El reporte debe contener los siguientes datos: Nombre del reporte: Morosos Recurrentes Período: rango de fechas Nro de socio Nombre y apellido.
Mes incumplido Ordenados de Mayor a menor por ranking de morosidad El mismo debe ser desarrollado utilizando Windows Function. 

Cada factura debe contar con una fecha de Vencimiento (5 días corridos a partir de la generación de la factura)
El segundo vencimiento son hasta 5 días corridos luego del primer vencimiento y con un recargo del 10% del total Facturado.*/

/*    @NroSocio VARCHAR(10),   @Tipo VARCHAR(20), -- 'Categoria' | 'Actividad' @NombreActividad VARCHAR(100)*/

--Morosos Recurrentes	01/11/2024 - 01/06/2025	TEST-001	PRUEBA MOROSO	2024-12, 2025-01, 2025-03	3
 
CREATE OR ALTER PROCEDURE Facturacion.GenerarCasosPruebaMorosos

AS

BEGIN

    SET NOCOUNT ON;

    -- 1. Crear un socio ficticio de prueba si no existe

    IF NOT EXISTS (

        SELECT 1 FROM Socios.Socio WHERE NroSocio = 'TEST-001'

    )

    BEGIN

        INSERT INTO Socios.Socio (NroSocio, Nombre, Apellido)

        VALUES ('TEST-001', 'PRUEBA', 'MOROSO');

    END

    -- 2. Insertar 3 cuotas para ese socio

    DECLARE @IdCuota1 INT, @IdCuota2 INT, @IdCuota3 INT;

    INSERT INTO Facturacion.Cuota (NroSocio)

    VALUES ('TEST-001'); 

    SET @IdCuota1 = SCOPE_IDENTITY();

    INSERT INTO Facturacion.Cuota (NroSocio)

    VALUES ('TEST-001');

    SET @IdCuota2 = SCOPE_IDENTITY();

    INSERT INTO Facturacion.Cuota (NroSocio)

    VALUES ('TEST-001');

    SET @IdCuota3 = SCOPE_IDENTITY();

    -- 3. Insertar facturas vencidas en meses diferentes (dentro del rango)

    INSERT INTO Facturacion.Factura (IdCuota, Fecha_Vencimiento, Estado, Dias_Atrasados)

    VALUES 

        (@IdCuota1, '2024-12-10', 'Vencido', 15),

        (@IdCuota2, '2025-01-15', 'Vencido', 20),

        (@IdCuota3, '2025-03-20', 'Vencido', 30);

END;

go

EXEC Facturacion.GenerarCasosPruebaMorosos;

go

EXECUTE Facturacion.Actualizar_Morosidad

go
 
CREATE OR ALTER PROCEDURE Facturacion.Reporte_1

    @FechaInicio DATE, -- Fecha de inicio del rango para considerar la morosidad

    @FechaFin DATE     -- Fecha de fin del rango para considerar la morosidad

AS

BEGIN

    SET NOCOUNT ON;
 
    -- Validar que las fechas sean válidas

    IF @FechaInicio IS NULL OR @FechaFin IS NULL OR @FechaInicio > @FechaFin

    BEGIN

        THROW 50000, 'Las fechas de inicio y fin del período son inválidas o el rango es incorrecto.', 1;

    END;
 
    WITH SocioIncumplimientoDetalle AS (

        SELECT DISTINCT

            S.NroSocio,

            S.Nombre,

            S.Apellido,

            CAST(YEAR(TRY_CONVERT(DATE, F.Fecha_Vencimiento)) AS NVARCHAR(4)) + '-' +

            RIGHT('0' + CAST(MONTH(TRY_CONVERT(DATE, F.Fecha_Vencimiento)) AS NVARCHAR(2)), 2) AS MesIncumplidoAnio

        FROM

            Facturacion.Factura AS F

        INNER JOIN

            Facturacion.Cuota AS C ON F.IdCuota = C.IdCuota

        INNER JOIN

            Socios.Socio AS S ON C.NroSocio = S.NroSocio

        WHERE

            -- Condiciones para que una factura se considere 'morosa'

            (F.Estado = 'Vencido' OR F.Dias_Atrasados > 0)

            AND TRY_CONVERT(DATE, F.Fecha_Vencimiento) BETWEEN @FechaInicio AND @FechaFin

    ),

    -- CTE para calcular el ranking de morosidad para cada socio

    SocioRanking AS (

        SELECT

            NroSocio,

            Nombre,

            Apellido,

            MesIncumplidoAnio,

            -- Usamos una función de ventana COUNT para calcular el número de meses distintos de incumplimiento

            -- Esto se convierte en nuestro 'Ranking de Morosidad'

            COUNT(MesIncumplidoAnio) OVER (PARTITION BY NroSocio) AS RankingMorosidad

        FROM

            SocioIncumplimientoDetalle

    ),

    -- CTE final para agregar los meses incumplidos y filtrar por el requisito de recurrencia

    SocioMorososRecurrentes AS (

        SELECT

            NroSocio,

            Nombre,

            Apellido,

            -- Concatenar todos los meses incumplidos en una sola cadena para cada socio

            STRING_AGG(MesIncumplidoAnio, ', ') WITHIN GROUP (ORDER BY MesIncumplidoAnio) AS MesesIncumplidos,

            MAX(RankingMorosidad) AS RankingMorosidad -- Tomar el ranking calculado por la función de ventana

        FROM

            SocioRanking

        GROUP BY

            NroSocio,

            Nombre,

            Apellido

        HAVING MAX(RankingMorosidad) > 2-- Filtro principal: socios con más de dos oportunidades (meses) incumplidas

    )

    -- Selección final de los datos del reporte

    SELECT

        'Morosos Recurrentes' AS 'Reporte_1_:Morosos_Recurrentes',

        CONVERT(NVARCHAR(10), @FechaInicio, 103) + ' - ' + CONVERT(NVARCHAR(10), @FechaFin, 103) AS 'Período',

        FinalReport.NroSocio AS 'Nro de socio',

        FinalReport.Nombre + ' ' + FinalReport.Apellido AS 'Nombre y Apellido',

        FinalReport.MesesIncumplidos AS 'Meses Incumplidos',

        FinalReport.RankingMorosidad AS 'Ranking de Morosidad' -- Número total de meses incumplidos

    FROM

        SocioMorososRecurrentes AS FinalReport

    ORDER BY

        FinalReport.RankingMorosidad DESC, -- Ordenar de Mayor a menor por ranking de morosidad

        FinalReport.Nombre,

        FinalReport.Apellido,

        FinalReport.NroSocio;

END;

go
 
EXECUTE Facturacion.Reporte_1 @FechaInicio = '2024-11-01', @FechaFin ='2025-06-01'

go
 
---------------------------------------------------------------------------------------------------------------------------------------
/*REPORTE 2:
Reporte acumulado mensual de ingresos por actividad deportiva al momento en que se saca el reporte tomando como inicio enero.*/

CREATE OR ALTER PROCEDURE Facturacion.Reporte2
AS
BEGIN
    -- Fecha actual y fecha de inicio fija
    DECLARE @fechaActual DATE = CAST(GETDATE() AS DATE);
    DECLARE @fechaInicio DATE = '2025-01-01';

    -- Reporte acumulado total por actividad
    SELECT 
        a.Nombre AS Actividad,
        COUNT(*) AS CantidadInscriptos,
        SUM(a.Costo) AS IngresosTotales
    FROM Clases.Inscripto i
    INNER JOIN Clases.Actividad a ON a.IdActividad = i.IdActividad
    WHERE TRY_CAST(i.FechaInscripcion AS DATE) >= @fechaInicio
      AND TRY_CAST(i.FechaInscripcion AS DATE) <= @fechaActual
    GROUP BY a.Nombre
    ORDER BY a.Nombre;
END;
go

--Acualizaciones porque solo hay registros anteriores a 2025
UPDATE Clases.Inscripto set FechaInscripcion= '2025-03-12' where NroSocio='SN-4035' and IdActividad=6
go
UPDATE Clases.Inscripto set FechaInscripcion= '2025-02-12' where NroSocio='SN-4002' and IdActividad=6
go
UPDATE Clases.Inscripto set FechaInscripcion= '2025-01-12' where NroSocio='SN-4003' and IdActividad=5
go
UPDATE Clases.Inscripto set FechaInscripcion= '2025-01-12' where NroSocio='SN-4004' and IdActividad=5
go
UPDATE Clases.Inscripto set FechaInscripcion= '2025-03-12' where NroSocio='SN-4045' and IdActividad=6
go
UPDATE Clases.Inscripto set FechaInscripcion= '2025-03-12' where NroSocio='SN-4037' and IdActividad=6
go

EXECUTE Facturacion.Reporte2
go

------------------------------------------------------------------------------------------------------------------------------
/*REPORTE 3: 
Reporte de la cantidad de socios que han realizado alguna actividad de forma alternada (inasistencias) por categoría de socios y actividad, 
ordenado según cantidad de inasistencias ordenadas de mayor a menor.*/

CREATE OR ALTER PROCEDURE Clases.Reporte_3 
AS
BEGIN
	WITH Socios_Anotados_Sin_Asistencia AS (
		SELECT 
			ae.NroSocio,
			cat.Nombre,
			c.IdActividad,
			a.Nombre AS NombreActividad
		FROM Clases.Anotado_En ae
		JOIN Socios.Socio s ON s.NroSocio = ae.NroSocio
		JOIN Socios.Categoria AS cat ON cat.IdCategoria = s.IdCategoria
		JOIN Clases.Clase c ON c.IdClase = ae.IdClase
		JOIN Clases.Actividad a ON a.IdActividad = c.IdActividad
		WHERE NOT EXISTS (
							SELECT 1 
							FROM Clases.Asiste asi
							WHERE asi.NroSocio = ae.NroSocio AND asi.IdClase = ae.IdClase
						 )
	)
	SELECT  sa.Nombre,
			sa.NombreActividad,
			COUNT(*) AS CantidadInasistencias
	FROM Socios_Anotados_Sin_Asistencia sa
	GROUP BY sa.Nombre, sa.NombreActividad
	ORDER BY CantidadInasistencias DESC;
END;
go

EXECUTE Clases.Reporte_3
go

---------------------------------------------------------------------------------------------------------------------------------
/*Reporte 4 Reporte que contenga a los socios que no han asistido a alguna clase de la actividad que realizan. El reporte 
debe contener: Nombre, Apellido, edad, categoría y la actividad*/

CREATE OR ALTER PROCEDURE Clases.Reporte_4
AS
BEGIN
	SELECT 
		s.Nombre,
		s.NroSocio,
		s.Apellido,
		DATEDIFF(YEAR, TRY_CONVERT(DATE, s.Fecha_De_Nacimiento, 103), GETDATE()) AS Edad,
		c.Nombre AS Categoria,
		a.Nombre AS Actividad
	FROM 
		Socios.Socio s
	JOIN 
		Clases.Inscripto i ON s.NroSocio = i.NroSocio
	JOIN 
		Clases.Actividad a ON i.IdActividad = a.IdActividad
	JOIN 
		Socios.Categoria c ON s.IdCategoria = c.IdCategoria
	JOIN 
		Clases.Clase cl ON cl.IdActividad = a.IdActividad
	LEFT JOIN 
		Clases.Asiste asi ON asi.IdClase = cl.IdClase AND asi.NroSocio = s.NroSocio
	WHERE 
		asi.NroSocio IS NULL
	GROUP BY 
		s.Nombre, s.NroSocio, s.Apellido, s.Fecha_De_Nacimiento, c.Nombre, a.Nombre;
END;
go

EXEC Clases.Reporte_4
go

 