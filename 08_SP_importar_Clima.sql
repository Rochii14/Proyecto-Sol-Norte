/*ENTREGA 5
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

CREATE OR ALTER PROCEDURE Accesos.Importar_Clima  @RutaArchivo VARCHAR(200)
AS
BEGIN
    CREATE TABLE #carga_Clima_Temp (
        fechaYHora     VARCHAR(30),
        temperatura    VARCHAR(10),
        lluvia         VARCHAR(20),
        humedad        VARCHAR(10),
        viento         VARCHAR(20)
    );

    DECLARE @SQL_Clima NVARCHAR(MAX) = '
        BULK INSERT #carga_Clima_Temp
        FROM ''' + @RutaArchivo + '''
        WITH (
            FIELDTERMINATOR = '','',
            ROWTERMINATOR = ''\n'',
            FIRSTROW = 4,
            CODEPAGE = ''ACP''
        );';

    EXEC sp_executesql @SQL_Clima;
	--select * from #carga_Clima_Temp

	INSERT INTO Accesos.Dia_Lluvia (Fecha)
	SELECT DISTINCT 
		CAST(TRY_CAST(REPLACE(fechaYHora, 'T', ' ') AS DATETIME) AS DATE)
	FROM #carga_Clima_Temp
	WHERE TRY_CAST(REPLACE(lluvia, ',', '.') AS DECIMAL(8,2)) > 0
	  AND TRY_CAST(REPLACE(fechaYHora, 'T', ' ') AS DATETIME) IS NOT NULL
	  AND CAST(TRY_CAST(REPLACE(fechaYHora, 'T', ' ') AS DATETIME) AS DATE) NOT IN (
		  SELECT Fecha FROM Accesos.Dia_Lluvia
	  );

     DROP TABLE #carga_Clima_Temp;
END;
go

EXEC Accesos.Importar_Clima 'C:\open-meteo-buenosaires_2024.csv' --Guardamos el archivo en extensión .csv UTF-8
go

SELECT * FROM Accesos.Dia_LLuvia
go

---------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE Accesos.Importar_Clima2
    @RutaArchivo VARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabla temporal para líneas crudas ya algunas columnas tiene distintos formatos 
    CREATE TABLE #ArchivoCrudo (
        Linea NVARCHAR(MAX)
    );

    -- Cargar archivo CSV completo
    DECLARE @sql NVARCHAR(MAX) = N'
    BULK INSERT #ArchivoCrudo
    FROM ''' + REPLACE(@RutaArchivo, '''', '''''') + '''
    WITH (
        ROWTERMINATOR = ''0x0A'',
        CODEPAGE = ''65001''
    );';

    EXEC sp_executesql @sql;

    CREATE TABLE #DiasLluvia (
        Fecha DATE-- Tabla temporal para fechas parseadas
    );

    
    INSERT INTO #DiasLluvia (Fecha)-- Insertar solo líneas con datos, parsear fecha
    SELECT DISTINCT
        TRY_CAST(LEFT(Linea, 10) AS DATE) AS Fecha
    FROM #ArchivoCrudo
    WHERE Linea LIKE '2025-%'
      AND LTRIM(RTRIM(Linea)) <> ''
      AND TRY_CAST(LEFT(Linea, 10) AS DATE) IS NOT NULL;

    
    SELECT * FROM #DiasLluvia;-- Mostrar para validación

    -- Insertar en tabla final, evitando duplicados
    INSERT INTO Accesos.Dia_LLuvia (Fecha)
    SELECT Fecha
    FROM #DiasLluvia AS dne
    WHERE NOT EXISTS (
        SELECT 1
        FROM Accesos.Dia_LLuvia AS f
        WHERE f.Fecha = dne.Fecha
    );
   
    SELECT COUNT(*) AS TotalDiasInsertados FROM Accesos.Dia_LLuvia; -- Confirmar días
END;
go

EXEC Accesos.Importar_Clima2 'C:\open-meteo-buenosaires_2025.csv' --Guardamos el archivo en extensión .csv UTF-8
go

SELECT * FROM Accesos.Dia_LLuvia
go
