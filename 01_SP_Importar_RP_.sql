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
use Com5600G08
go
CREATE OR ALTER PROCEDURE ddbbaTP.Importar_Responsables_De_Pago
	@RutaArchivo VARCHAR (200)
AS
BEGIN
	CREATE TABLE #SocioTemporal (
	NroSocio VARCHAR(10) PRIMARY KEY,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Dni INT,
	Email_Personal VARCHAR(100),
	Fecha_Nac VARCHAR(10),
	Telefono_C VARCHAR(30),
	Telefono_E VARCHAR(30),
	Nombre_Obra_Social VARCHAR(100),
	Nro_Obra_Social VARCHAR(50),
	Telefono_C_E VARCHAR(30) );
	

	DECLARE @SQL_Socio NVARCHAR(MAX) = ' BULK INSERT #SocioTemporal
										 FROM ''' + @RutaArchivo + '''
										 WITH
										 (
											FIELDTERMINATOR = '';'',
											ROWTERMINATOR = ''\n'',
											CODEPAGE = ''ACP'',
											FIRSTROW = 2
										 );';
	EXEC sp_executesql @SQL_Socio;

	WITH FiltrarDatos AS
	(
		SELECT * 
		FROM #SocioTemporal AS st
		WHERE NOT EXISTS ( SELECT 1  FROM ddbbaTP.Socio AS s WHERE st.NroSocio = s.NroSocio )
				AND NOT EXISTS ( SELECT 1 FROM ddbbaTP.Socio AS s WHERE st.Dni = s.Dni )
					AND TRY_CONVERT(DATE, st.Fecha_Nac, 103) IS NOT NULL
	)

	INSERT INTO ddbbaTP.Socio ( NroSocio, Nombre, Apellido, Dni, Email_Personal, Fecha_De_Nacimiento, Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social, Nro_Obra_Social, Telefono_Emergencia_2 )
	SELECT * 
	FROM FiltrarDatos


	DROP TABLE #SocioTemporal;

END;
go

EXEC ddbbaTP.Importar_Responsables_De_Pago 'C:\_temp\Responsables de pago.csv'
go

SELECT * FROM ddbbaTP.Socio


