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

CREATE OR ALTER PROCEDURE Socios.Importar_Responsables_De_Pago
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
		WHERE NOT EXISTS ( SELECT 1  FROM Socios.Socio AS s WHERE st.NroSocio = s.NroSocio )
				AND NOT EXISTS ( SELECT 1 FROM Socios.Socio AS s WHERE st.Dni = s.Dni )
					AND TRY_CONVERT(DATE, st.Fecha_Nac, 103) IS NOT NULL
	)

	INSERT INTO Socios.Socio ( NroSocio, Nombre, Apellido, Dni, Email_Personal, Fecha_De_Nacimiento, Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social, Nro_Obra_Social, Telefono_Emergencia_2 )
	SELECT * 
	FROM FiltrarDatos


	DROP TABLE #SocioTemporal;

END;
go

EXEC Socios.Importar_Responsables_De_Pago 'C:\_temp\Responsables de pago.csv'
go

go
SELECT * FROM Socios.Socio
go

CREATE OR ALTER PROCEDURE Socios.AgregarSocioGrupoFamiliar   @NroSocioTitular VARCHAR(10),  @NroSocioIntegrante VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    -- Validar que ambos socios existan
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocioTitular)
    BEGIN
        THROW 50001, 'El socio titular no existe.', 1;
    END
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocioIntegrante)
    BEGIN
        THROW 50002, 'El socio integrante no existe.', 1;
    END
    -- Verificar que el titular tenga un grupo familiar asociado
    DECLARE @IdGrupoFamiliar INT;
 
    SELECT @IdGrupoFamiliar = S.IdGrupoFamiliar
    FROM Socios.Socio AS S
    WHERE S.NroSocio = @NroSocioTitular;
 
    IF @IdGrupoFamiliar IS NULL
    BEGIN
        -- Si no lo tiene asignado, buscarlo en la tabla GrupoFamiliar
        SELECT @IdGrupoFamiliar = GF.IdGrupoFamiliar
        FROM Socios.GrupoFamiliar GF
        WHERE GF.NroSocio = @NroSocioTitular;
 
        -- Si aún no existe, crear el grupo
        IF @IdGrupoFamiliar IS NULL
        BEGIN
            INSERT INTO Socios.GrupoFamiliar (NroSocio)
            VALUES (@NroSocioTitular);
 
            SET @IdGrupoFamiliar = SCOPE_IDENTITY();
 
            -- Actualizar el socio titular para reflejar su grupo
            UPDATE Socios.Socio
            SET IdGrupoFamiliar = @IdGrupoFamiliar
            WHERE NroSocio = @NroSocioTitular;
        END
    END
 
    -- Asignar el grupo y el responsable al integrante
    UPDATE Socios.Socio
    SET IdGrupoFamiliar = @IdGrupoFamiliar,
        NroSocio2 = @NroSocioTitular
    WHERE NroSocio = @NroSocioIntegrante;
 
    PRINT 'Integrante agregado al grupo familiar correctamente.';
END;
 
go

CREATE OR ALTER PROCEDURE Socios.EliminarSocioGrupoFamiliar @NroSocio VARCHAR(10)

AS

BEGIN

    SET NOCOUNT ON;

    -- Validar que exista el socio

    IF NOT EXISTS (

        SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio

    )

    BEGIN

        THROW 50001, 'El socio no existe.', 1;

    END;

    -- Verificar si es titular del grupo

    IF EXISTS (

        SELECT 1 FROM Socios.GrupoFamiliar WHERE NroSocio = @NroSocio

    )

    BEGIN

        THROW 50002, 'No se puede eliminar al socio porque es titular del grupo familiar.', 1;

    END;

    -- Eliminar la relación con el grupo familiar

    UPDATE Socios.Socio

    SET IdGrupoFamiliar = NULL,

        NroSocio2 = NULL

    WHERE NroSocio = @NroSocio;
 
    PRINT 'El socio fue eliminado del grupo familiar correctamente.';

END;



