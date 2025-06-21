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
-----------------------------------------------------------IMPORTAR CATEGORÍA
CREATE OR ALTER PROCEDURE ddbbaTP.ImportarCategoria
    @RutaArchivo VARCHAR(200)
AS
BEGIN
    CREATE TABLE #CategoriaTemporal (
        Nombre VARCHAR(50),
        Costo VARCHAR(50),
        Vigente_Hasta VARCHAR(50),
		CampoExtra VARCHAR(50)
    );

DECLARE @SQL_Categoria NVARCHAR(MAX) = '
        BULK INSERT #CategoriaTemporal
        FROM ''' + @RutaArchivo + '''
        WITH (
            FIELDTERMINATOR = '';'',
            ROWTERMINATOR = ''\n'',
            CODEPAGE = ''ACP'',
            FIRSTROW = 2
        );';

    EXEC sp_executesql @SQL_Categoria ;

INSERT INTO ddbbaTP.Categoria (Nombre, Costo, Vigente_Hasta)
SELECT 
    Nombre,
    TRY_CAST(Costo AS DECIMAL(10,2)),
    Vigente_Hasta
FROM #CategoriaTemporal
WHERE 
    TRY_CAST(Costo AS DECIMAL(10,2)) IS NOT NULL AND
    Nombre IN ('Mayor', 'Cadete', 'Menor') AND Nombre NOT IN ( SELECT cat.Nombre FROM ddbbaTP.Categoria AS cat );

	EXEC ddbbaTP.Insertar_Id_Categoria

	DROP TABLE #CategoriaTemporal
END;

go
EXECUTE ddbbaTP.ImportarCategoria 'C:\_temp\Tarifas.csv';
go

SELECT * FROM ddbbaTP.Categoria
go
SELECT * FROM ddbbaTP.Socio

-----------------------------------------------------------IMPORTAR ACTIVIDAD
go
CREATE OR ALTER PROCEDURE ddbbaTP.ImportarActividad 
    @RutaArchivo VARCHAR(200)
AS
BEGIN
    CREATE TABLE #ActividadTemporal (
        Nombre VARCHAR(50),
        Costo VARCHAR(50),
        Vigente_Hasta VARCHAR(50),
        CampoExtra VARCHAR(50)
    );

    DECLARE @SQL_Actividad NVARCHAR(MAX) = '
        BULK INSERT #ActividadTemporal
        FROM ''' + @RutaArchivo + '''
        WITH (
            FIELDTERMINATOR = '';'',
            ROWTERMINATOR = ''\n'',
            CODEPAGE = ''ACP'',
            FIRSTROW = 2
        );';

    EXEC sp_executesql @SQL_Actividad;

    -- Normalizar nombres primero
    WITH ActividadNormalizada AS (
        SELECT 
            CASE 
                WHEN Nombre COLLATE Latin1_General_CI_AI = 'Ajederez' THEN 'Ajedrez'
                ELSE Nombre
            END AS NombreNormalizado,
            TRY_CAST(Costo AS DECIMAL(10,2)) AS Costo,
            Vigente_Hasta
        FROM #ActividadTemporal
        WHERE TRY_CAST(Costo AS DECIMAL(10,2)) IS NOT NULL
    )

    -- Insertar evitando duplicados
    INSERT INTO ddbbaTP.Actividad(Nombre, Costo, Vigente_Hasta)
    SELECT 
        AN.NombreNormalizado,
        AN.Costo,
        AN.Vigente_Hasta
    FROM ActividadNormalizada AN
    WHERE AN.NombreNormalizado COLLATE Latin1_General_CI_AI IN (
            'Futsal', 'Voley', 'Taekwondo', 'Baile artistico', 'Natación', 'Ajedrez'
        )
      AND NOT EXISTS (
            SELECT 1 FROM ddbbaTP.Actividad A
            WHERE A.Nombre COLLATE Latin1_General_CI_AI = AN.NombreNormalizado
        );

    DROP TABLE #ActividadTemporal;
END;
go
EXECUTE ddbbaTP.ImportarActividad 'C:\_temp\Tarifas.csv';
go
SELECT * FROM ddbbaTP.Actividad

-----------------------------------------------------------IMPORTAR ACTIVIDAD EXTRA
go
CREATE OR ALTER PROCEDURE ddbbaTP.ImportarTarifasActExtras @RutaArchivo VARCHAR(200)
    AS
    BEGIN 
        CREATE TABLE #ArchivoCompleto (
            Col1 VARCHAR(100), -- Para 'Valor del dia', 'Valor de temporada', 'Valor del Mes'
            Col2 VARCHAR(100), -- Para 'Adultos', 'Menores de 12 años'
            Col3 VARCHAR(100), -- Para 'MontoSocio'
            Col4 VARCHAR(100), -- Para 'MontoInvitado' (puede estar vacío)
            Col5 VARCHAR(100)  -- Para 'Vigente hasta'
        );
        DECLARE @SQL NVARCHAR(MAX) = '
            BULK INSERT #ArchivoCompleto
            FROM ''' + @RutaArchivo + '''
            WITH (
                FIELDTERMINATOR = '';'',   -- ¡CAMBIO AQUÍ! Asume que las columnas están separadas por tabulaciones.
                ROWTERMINATOR = ''\n'',   -- Asume saltos de línea de estilo Windows (Retorno de carro + Salto de línea).
                CODEPAGE = ''ACP'',         -- Utiliza la página de códigos ANSI del sistema para el archivo.
                FIRSTROW = 2                
            );';
        EXEC sp_executesql @SQL;
        WITH SeccionFiltrada AS (
            SELECT *,
                ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum FROM #ArchivoCompleto
        ),
		Seccion AS (
			SELECT *,   --identificacion de cada seccion con su id
				SeccionId = COUNT(CASE WHEN LTRIM(RTRIM(Col1)) LIKE 'Valor %' THEN 1 END)
						   OVER (ORDER BY RowNum ROWS UNBOUNDED PRECEDING)
			FROM SeccionFiltrada
		),
        TarifaCTE AS (
            SELECT 
				SeccionId,
				TipoTarifa = MAX(NULLIF(LTRIM(RTRIM(Col1)), '')) OVER (PARTITION BY SeccionId),
                TipoPersona = LTRIM(RTRIM(Col2)), -- Elimina espacios en blanco del TipoPersona.
                SocioTarifa = Col3,            -- Valor de la tarifa para socios (como texto).
                InvitadoTarifa = Col4,         -- Valor de la tarifa para invitados (como texto, puede estar vacío).
                VigenteHasta = Col5            -- Fecha de vigencia (como texto).
            FROM Seccion 
			WHERE LTRIM(RTRIM(Col2)) IN ('Adultos', 'Menores de 12 años') -- Filtra solo las filas que contienen los tipos de persona relevantes para evitar procesar filas vacías o no deseadas.
        )

	INSERT INTO ddbbaTP.TarifaPileta (TipoTarifa, TipoPersona, MontoSocio, MontoInvitado, VigenteHasta)
	SELECT 
		CASE
			WHEN TipoTarifa LIKE '%del dia%' THEN 'Día'
			WHEN TipoTarifa LIKE '%temporada%' THEN 'Temporada'
			WHEN TipoTarifa LIKE '%del Mes%' THEN 'Mes'
			ELSE TipoTarifa
		END,
		CASE
			WHEN TipoPersona = 'Adultos' THEN 'Adulto'
			WHEN TipoPersona = 'Menores de 12 años' THEN 'Menor de 12 años'
			ELSE TipoPersona
		END,
		TRY_CAST(REPLACE(REPLACE(REPLACE(SocioTarifa, '$', ''), '.', ''), ',', '.') AS DECIMAL(12,2)),
		TRY_CAST(REPLACE(REPLACE(REPLACE(InvitadoTarifa, '$', ''), '.', ''), ',', '.') AS DECIMAL(12,2)),
		TRY_CAST(FORMAT(TRY_CONVERT(DATE, VigenteHasta, 103), 'yyyy-MM-dd') AS DATE)
	FROM TarifaCTE
	WHERE TipoPersona IS NOT NULL AND LTRIM(RTRIM(TipoPersona)) <> ''
	AND NOT EXISTS (
        SELECT 1 FROM ddbbaTP.TarifaPileta t
        WHERE
            t.TipoTarifa = CASE
                WHEN TipoTarifa LIKE '%del dia%' THEN 'Día'
                WHEN TipoTarifa LIKE '%temporada%' THEN 'Temporada'
                WHEN TipoTarifa LIKE '%del mes%' THEN 'Mes'
                ELSE TipoTarifa
            END
            AND t.TipoPersona = CASE
                WHEN TipoPersona = 'Adultos' THEN 'Adulto'
                WHEN TipoPersona = 'Menores de 12 años' THEN 'Menor de 12 años'
                ELSE TipoPersona
            END
            AND t.VigenteHasta = TRY_CONVERT(DATE, VigenteHasta, 103)
    );
    DROP TABLE #ArchivoCompleto;
END;
go
EXECUTE ddbbaTP.ImportarTarifasActExtras 'C:\_temp\Tarifas.csv'
go
SELECT * FROM ddbbaTP.TarifaPileta