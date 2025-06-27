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
Use Com5600G08
go

CREATE OR ALTER PROCEDURE ddbbaTP.Importar_Presentismo
    @Ruta_Archivo VARCHAR(200)
AS
BEGIN
    CREATE TABLE #PresentismoTemporal (
    NroSocio VARCHAR(10),
    Actividad VARCHAR(100),
    Fecha VARCHAR(10),
    Asistencia VARCHAR(2),
    Profesor VARCHAR(100),
    Basura CHAR(6)
    );

	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'ddbbaTP' AND TABLE_NAME = 'ProfesorActividad')
	BEGIN
		CREATE TABLE ddbbaTP.ProfesorActividad (
		IdProfesor INT,
		Actividad VARCHAR(100),
		CONSTRAINT PK_Profesor_Actividad PRIMARY KEY (IdProfesor, Actividad),
		CONSTRAINT FK_Profesor_Act FOREIGN KEY (IdProfesor) REFERENCES ddbbaTP.Profesor(IdProfesor) );
	END;

    DECLARE @SQL_Pres NVARCHAR(MAX)= ' BULK INSERT #PresentismoTemporal
                                       FROM ''' + @Ruta_Archivo + '''
                                       WITH
                                       (
                                           FIELDTERMINATOR = '';'',
                                           ROWTERMINATOR = ''\n'',
                                           CODEPAGE = ''ACP'',
                                           FIRSTROW = 2
                                       );';
    EXEC sp_executesql @SQL_Pres;

	WITH ProfesoresNuevos AS
	(
		SELECT DISTINCT pt.Profesor
		FROM #PresentismoTemporal AS pt
		WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.Profesor AS p WHERE p.Nombre_Completo = pt.Profesor )
	)
	INSERT INTO ddbbaTP.Profesor (Nombre_Completo)
	SELECT Profesor FROM ProfesoresNuevos


    INSERT INTO ddbbaTP.ProfesorActividad (IdProfesor, Actividad)
    SELECT DISTINCT p.IdProfesor, pt.Actividad
    FROM #PresentismoTemporal AS pt
		JOIN ddbbaTP.Profesor p ON p.Nombre_Completo = pt.Profesor
    WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.ProfesorActividad pa WHERE pa.IdProfesor = p.IdProfesor AND pa.Actividad = pt.Actividad )

    INSERT INTO ddbbaTP.Clase (Fecha, IdProfesor, IdActividad)
    SELECT DISTINCT pt.Fecha, pa.IdProfesor, a.IdActividad
    FROM #PresentismoTemporal AS pt
		JOIN ddbbaTP.Profesor AS p ON p.Nombre_Completo = pt.Profesor
		JOIN ddbbaTP.ProfesorActividad AS pa ON pa.IdProfesor = p.IdProfesor AND pa.Actividad = pt.Actividad
		JOIN ddbbaTP.Actividad AS a ON a.Nombre = pt.Actividad
    WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.Clase AS c WHERE pt.Fecha = c.Fecha AND c.IdProfesor = pa.IdProfesor AND c.IdActividad = a.IdActividad )


	INSERT INTO ddbbaTP.Asiste (NroSocio, IdClase)
	SELECT DISTINCT pt.NroSocio, c.IdClase
	FROM #PresentismoTemporal pt
		JOIN ddbbaTP.Profesor AS p ON p.Nombre_Completo = pt.Profesor
		JOIN ddbbaTP.Actividad AS a ON A.Nombre = pt.Actividad
		JOIN ddbbaTP.Clase AS c ON c.IdActividad = a.IdActividad AND c.IdProfesor = p.IdProfesor AND c.Fecha = pt.Fecha
	WHERE pt.Asistencia IN ('P', 'PP') 
			AND pt.NroSocio IN ( SELECT s.NroSocio FROM ddbbaTP.Socio AS s )
				AND NOT EXISTS ( SELECT 1 FROM ddbbaTP.Anotado_En AS ae WHERE ae.NroSocio = pt.NroSocio AND ae.IdClase = c.IdClase );
				

	INSERT INTO ddbbaTP.Anotado_En (NroSocio, IdClase)
	SELECT DISTINCT pt.NroSocio, c.IdClase
	FROM #PresentismoTemporal pt
		JOIN ddbbaTP.Profesor AS p ON p.Nombre_Completo = pt.Profesor
		JOIN ddbbaTP.Actividad AS a ON A.Nombre = pt.Actividad
		JOIN ddbbaTP.Clase AS c ON c.IdActividad = a.IdActividad AND c.IdProfesor = p.IdProfesor AND c.Fecha = pt.Fecha	
	WHERE pt.NroSocio IN ( SELECT s.NroSocio FROM ddbbaTP.Socio AS s )
		AND NOT EXISTS ( SELECT 1 FROM ddbbaTP.Anotado_En AS ae WHERE ae.NroSocio = pt.NroSocio AND ae.IdClase = c.IdClase );

	EXEC ddbbaTP.Insertar_Inscripto;
	EXEC ddbbaTP.Insertar_Dia_Clase;

    DROP TABLE #PresentismoTemporal;
END;
go

EXEC ddbbaTP.Importar_Presentismo 'C:\_temp\Presentismo 2.csv';
go

SELECT * FROM ddbbaTP.Profesor
go

SELECT * FROM ddbbaTP.ProfesorActividad
go

SELECT * FROM ddbbaTP.Clase
go

SELECT * FROM ddbbaTP.Anotado_En
go

SELECT * FROM ddbbaTP.Asiste 
go

SELECT * FROM ddbbaTP.Inscripto
go

