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

CREATE OR ALTER PROCEDURE ddbbaTP.Importar_Grupo_Familiar
	@RutaArchivo VARCHAR(200)
AS
BEGIN
	CREATE TABLE #GrupoFamiliarTemporal (
	NroSocio VARCHAR(10) PRIMARY KEY,
	NroSocio_RP VARCHAR(10),
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Dni INT,
	Email_Personal VARCHAR(100),
	Fecha_Nac VARCHAR(10),
	Telefono_C VARCHAR(30),
	Telefono_C_E VARCHAR(30),
	Nombre_Obra_Social VARCHAR(100),
	Nro_Obra_Social VARCHAR(50),
	Telefono_C_E_2 VARCHAR(30) );

	DECLARE @SQL_GF NVARCHAR(MAX) = ' BULK INSERT #GrupoFamiliarTemporal
												 FROM ''' + @RutaArchivo + '''
												 WITH
												 (
													FIELDTERMINATOR = '';'',
													ROWTERMINATOR = ''\n'',
													CODEPAGE = ''ACP'',
													FIRSTROW = 2
												 );';
	EXEC sp_executesql @SQL_GF;

	WITH FiltrarDatos AS
	(
		SELECT *
		FROM #GrupoFamiliarTemporal AS gft
		WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.GrupoFamiliar AS gf WHERE gf.NroSocio = gft.NroSocio_RP )
	)

	INSERT INTO ddbbaTP.GrupoFamiliar(NroSocio)
	SELECT NroSocio_RP
	FROM (
			SELECT NroSocio_RP, --Funcionaba también con un SELECT DISTINCT NroSocio_RP
				   ROW_NUMBER() OVER (PARTITION BY NroSocio_RP ORDER BY NroSocio) AS rn
			FROM FiltrarDatos
		 )	AS sub
	WHERE rn = 1;

	WITH FiltrarDatos AS
	(
		SELECT *
		FROM #GrupoFamiliarTemporal AS gft
		WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.Socio AS s WHERE s.NroSocio = gft.NroSocio )
				AND NOT EXISTS ( SELECT 1 FROM ddbbaTP.Socio AS s WHERE s.Dni = gft.Dni )
					AND TRY_CONVERT(DATE, gft.Fecha_Nac, 103) IS NOT NULL
	)

	INSERT INTO ddbbaTP.Socio( NroSocio, 
							   Dni, 
							   Nombre, 
							   Apellido, 
							   Email_Personal,
							   Fecha_De_Nacimiento, 
							   Telefono_Contacto, 
							   Telef_C_Emergencia, 
							   Nombre_Obra_Social,
							   Nro_Obra_Social,
							   NroSocio2,
							   Telefono_Emergencia_2 )
	SELECT NroSocio,
		   Dni,
		   Nombre,
		   Apellido,
		   Email_Personal,
		   Fecha_Nac,
		   Telefono_C,
		   Telefono_C_E,
		   Nombre_Obra_Social,
		   Nro_Obra_Social,
		   CASE	
				WHEN DATEDIFF( YEAR, TRY_CONVERT(DATE, Fecha_Nac, 103), GETDATE() ) < 18 THEN NroSocio_RP
				ELSE NULL
		   END AS NroSocio2,
		   Telefono_C_E_2

	FROM FiltrarDatos

	EXEC ddbbaTP.Insertar_Id_GruporFamiliar;
	EXEC ddbbaTP.Insertar_Datos_Cuenta;
	
	DROP TABLE #GrupoFamiliarTemporal;
END;
go
EXEC ddbbaTP.Importar_Grupo_Familiar 'C:\_temp\Grupo Familiar.csv'
go

SELECT * FROM ddbbaTP.GrupoFamiliar

SELECT * FROM ddbbaTP.Socio

SELECT * FROM ddbbaTP.Cuenta


