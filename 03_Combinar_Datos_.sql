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

--INSERTAR ID DE GRUPO FAMILIAR EN SOCIO

CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Id_GruporFamiliar
AS
BEGIN
	UPDATE ddbbaTP.Socio
	SET IdGrupoFamiliar = gp.IdGrupoFamiliar
	FROM ddbbaTP.GrupoFamiliar AS gp
	WHERE ddbbaTP.Socio.NroSocio2 = gp.NroSocio

	UPDATE ddbbaTP.Socio
	SET IdGrupoFamiliar = gp.IdGrupoFamiliar
	FROM ddbbaTP.GrupoFamiliar AS gp
	WHERE ddbbaTP.Socio.NroSocio = gp.NroSocio
END;
go
------------------------------------------------------------------------------------------
--INSERTAR ID DE CATEGORIA EN SOCIO

CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Id_Categoria
AS
BEGIN
	UPDATE ddbbaTP.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM ddbbaTP.Categoria AS c WHERE c.Nombre = 'Menor' )
	WHERE DATEDIFF ( YEAR, (TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103)), GETDATE ()) <= 12;

	UPDATE ddbbaTP.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM ddbbaTP.Categoria AS c WHERE c.Nombre = 'Cadete' )
	WHERE DATEDIFF( YEAR, TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103), GETDATE ()) BETWEEN 13 AND 17;

	UPDATE ddbbaTP.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM ddbbaTP.Categoria AS c WHERE c.Nombre = 'Mayor' )
	WHERE DATEDIFF( YEAR, TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103), GETDATE ()) >= 18;
END;
go
------------------------------------------------------------------------------------------
--INSERTO EN LA TABLA INSCRIPTO
CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Inscripto
AS
BEGIN
	INSERT INTO ddbbaTP.Inscripto(NroSocio, IdActividad, FechaInscripcion)
	SELECT DISTINCT AE.NroSocio, C.IdActividad, ISNULL(AE.FechaInscripcion, '2024-01-01')  -- provisoria
	FROM ddbbaTP.Anotado_En AE 
	JOIN ddbbaTP.Clase C ON AE.IdClase= C.IdClase
	WHERE NOT EXISTS (SELECT 1 FROM  ddbbaTP.Inscripto I WHERE I.NroSocio=AE.NroSocio AND I.IdActividad =C.IdActividad)
 
END;
GO

--------------------------------------------------------------------------------------------

--INSERTAR DIA EN TABLA CLASE
go
CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Dia_Clase
AS
BEGIN
	SET LANGUAGE spanish

	UPDATE ddbbaTP.Clase
	SET Dia = DATENAME(WEEKDAY, CONVERT(DATE, Fecha, 103))

	SET LANGUAGE english;
END;
go

-------------------------------------------------------------------------------------------------
--INSERTAR DATOS EN CUENTA
go
CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Datos_Cuenta
AS
BEGIN
	INSERT INTO ddbbaTP.Cuenta ( NroSocio )
	SELECT s.NroSocio
	FROM ddbbaTP.Socio AS s
	WHERE NOT EXISTS ( SELECT 1 FROM ddbbaTP.Cuenta AS c WHERE c.NroSocio = s.NroSocio ) 
			AND ( s.NroSocio2 IS NULL OR S.NroSocio IN ( SELECT gp.NroSocio FROM ddbbaTP.GrupoFamiliar AS gp ) )
END;
go

-------------------------------------------------------------------------------------------------
--INSERTAR DATOS EN INVITADO
go
CREATE OR ALTER PROCEDURE CargaInvitadosRandom @CantInv INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Dni INT;
    DECLARE @Nombre VARCHAR(50);
    DECLARE @Nro_Socio VARCHAR(10);
    DECLARE @FechaNacimiento VARCHAR(10);

    DECLARE @i INT = 0;
    DECLARE @RandomNombres TABLE (Nombre VARCHAR(50));
    INSERT INTO @RandomNombres (Nombre) VALUES
        ('Juan'), ('Maria'), ('Carlos'), ('Laura'), ('Pedro'),
        ('Ana'), ('Luis'), ('Sofia'), ('Diego'), ('Valeria');

    -- Verificar que haya socios disponibles que sean responsables de un grupo familiar
    -- (aquellos que tienen un registro en la tabla GrupoFamiliar)
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar)
    BEGIN
        PRINT 'Advertencia: La tabla GrupoFamiliar está vacía. No hay socios responsables de grupo familiar para asociar invitados.';
        RETURN;
    END

    WHILE @i < @CantInv
    BEGIN 
        SET @Dni = ABS(CHECKSUM(NEWID()) % 900000000) + 100000000;

        SELECT TOP 1 @Nombre = Nombre FROM @RandomNombres ORDER BY NEWID();

        -- Seleccionar un socio aleatorio que sea responsable de un grupo familiar
        -- (un NroSocio que exista en la tabla GrupoFamiliar)
        SELECT TOP 1 @Nro_Socio = NroSocio 
        FROM ddbbaTP.GrupoFamiliar 
        ORDER BY NEWID();

        -- Generar una fecha de nacimiento aleatoria entre 1950-01-01 y 2020-12-31
        DECLARE @DiasRandom INT = ABS(CHECKSUM(NEWID()) % 25836); -- días entre 1950-01-01 y 2020-12-31
        DECLARE @FechaNacimientoDate DATE = DATEADD(DAY, @DiasRandom, '19500101');
        SET @FechaNacimiento = FORMAT(@FechaNacimientoDate, 'dd/MM/yyyy');

        INSERT INTO ddbbaTP.Invitado (Dni, Nombre, Nro_Socio, IdFactura, Fecha_De_Nacimiento)
        VALUES (@Dni, @Nombre, @Nro_Socio, NULL, @FechaNacimiento);

        SET @i = @i + 1;
    END

    PRINT CAST(@CantInv AS VARCHAR(10)) + ' invitados aleatorios generados exitosamente.';
END;
go

EXEC CargaInvitadosRandom @CantInv = 10;
go

-------------------------------------------------------------------------------------------------
--INSERTAR JERARQUIA EN ACTIVIDADES EXTRA
go
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividadJerarquica
    @TipoActividad VARCHAR(50),
    @SubTipo VARCHAR(20), -- 'Colonia', 'Sum', 'Pileta'
    @FechaInicio VARCHAR(10) = NULL,
    @FechaFin VARCHAR(10) = NULL,
    @Precio DECIMAL(10,2) = NULL,
    @Fec_Temporada DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdActExtra INT;

    -- 1. Insertar en ActividadExtra
    INSERT INTO ddbbaTP.ActividadExtra (Tipo)
    VALUES (@TipoActividad);

    -- Obtener el ID generado
    SET @IdActExtra = SCOPE_IDENTITY();

    -- 2. Insertar en la tabla correspondiente
    IF @SubTipo = 'Colonia'
    BEGIN
        INSERT INTO ddbbaTP.Colonia (IdActividadExtra, FechaInicio, FechaFin, Precio)
        VALUES (@IdActExtra, @FechaInicio, @FechaFin, @Precio);
    END
    ELSE IF @SubTipo = 'Sum'
    BEGIN
        INSERT INTO ddbbaTP.Sum_Recreativo (IdActividadExtra, Precio)
        VALUES (@IdActExtra, @Precio);
    END
    ELSE IF @SubTipo = 'Pileta'
    BEGIN
        INSERT INTO ddbbaTP.Pileta (IdActividadExtra, Fec_Temporada)
        VALUES (@IdActExtra, @Fec_Temporada);
    END
    ELSE
    BEGIN
        RAISERROR('SubTipo inválido. Debe ser "Colonia", "Sum" o "Pileta".', 16, 1);
        RETURN;
    END
END;
go

-- Colonia
EXEC ddbbaTP.InsertarActividadJerarquica
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Colonia',
    @FechaInicio = '2025-01-10',
    @FechaFin = '2025-02-20',
    @Precio = 25000;
go

-- Sum recreativo
EXEC ddbbaTP.InsertarActividadJerarquica
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Sum',
    @Precio = 18000;
go

-- Pileta
EXEC ddbbaTP.InsertarActividadJerarquica
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Pileta',
    @Fec_Temporada = '2025-01-01';
go

-------------------------------------------------------------------------------------------------

--INSERTAR MEDIOS DE PAGO
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Visa', @Tipo= 'Credito', @Modalidad= 'Tarjeta'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='MasterCard', @Tipo= 'Credito', @Modalidad= 'Tarjeta'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Tarjeta Naranja', @Tipo= 'Debito', @Modalidad= 'Tarjeta'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Pago Facil', @Tipo= 'Contado', @Modalidad= 'Presencial'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Rapipago', @Tipo= 'Contado', @Modalidad= 'Presencial'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Mercado Pago', @Tipo= 'Billetera', @Modalidad= 'Transferencia'
go
execute ddbbaTP.InsertarMedioDePago @Nombre='Efectivo', @Tipo= 'Contado', @Modalidad= 'Presencial'

---------------------------------------------------------------------------------------------------------------

--ASIGNAR MONTO A CATEGORIA
go
CREATE OR ALTER PROCEDURE ddbbaTP.Asignar_Monto_Categoria  @EdadS INT,  @MontoBaseS DECIMAL(10,2) OUTPUT
AS
BEGIN
    IF @EdadS > 12 AND @EdadS < 18
    BEGIN
        SELECT @MontoBaseS = Costo FROM ddbbaTP.Categoria  
		WHERE Nombre = 'Cadete';
    END
    ELSE IF @EdadS >= 18
    BEGIN
        SELECT @MontoBaseS = Costo FROM ddbbaTP.Categoria 
        WHERE Nombre = 'Mayor';
    END
    ELSE
    BEGIN
        SELECT @MontoBaseS = Costo  FROM ddbbaTP.Categoria 
        WHERE Nombre = 'Menor';
    END
END;

-----------------------------------------------------------------------------------------------------------------
--ASIGNAR MONTO A ACTIVIDAD
go
CREATE OR ALTER PROCEDURE ddbbaTP.Asignar_Monto_Actividad @NombreAct VARCHAR(100), @MontoBaseS DECIMAL(10,2) OUTPUT
AS
BEGIN
	select @MontoBaseS=a.Costo from ddbbaTP.Actividad a where a.Nombre like @NombreAct
END;
------------------------------------------------------------------------------------------------------------------------
--ASIGNAR MONTO A PILETA
go
CREATE OR ALTER PROCEDURE ddbbaTP.Asignar_Monto_Pileta
    @EdadPersona INT,
    @EsSocio BIT,                    -- 1 = socio, 0 = invitado
    @TipoPase VARCHAR(20) = 'Día',   -- 'Día', 'Mes' o 'Temporada' (opcional, default = 'Día')
    @MontoBaseS DECIMAL(10,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validación del tipo de pase
    IF @TipoPase NOT IN ('Día', 'Mes', 'Temporada')
    BEGIN
        THROW 60001, 'Tipo de pase inválido. Debe ser Día, Mes o Temporada.', 1;
    END

    -- Invitados solo pueden acceder a pase del día
    IF @EsSocio = 0 AND @TipoPase <> 'Día'
    BEGIN
        THROW 60002, 'Los invitados solo pueden acceder al pase del día.', 1;
    END

    -- Asignar monto según edad y tipo de persona
    IF @EsSocio = 1
    BEGIN
        -- SOCIOS
        IF @TipoPase = 'Día'
            SET @MontoBaseS = CASE WHEN @EdadPersona < 12 THEN 15000 ELSE 25000 END;
        ELSE IF @TipoPase = 'Mes'
            SET @MontoBaseS = CASE WHEN @EdadPersona < 12 THEN 375000 ELSE 625000 END;
        ELSE IF @TipoPase = 'Temporada'
            SET @MontoBaseS = CASE WHEN @EdadPersona < 12 THEN 1200000 ELSE 2000000 END;
    END
    ELSE
    BEGIN
        -- INVITADOS
        SET @MontoBaseS = CASE WHEN @EdadPersona < 12 THEN 2000 ELSE 30000 END;
    END
END;
GO
---------------------------------------------------------------------------------------------------------
--VALIDAR TIPO DE PERSONA (SOCIO O INVITADO)
go
CREATE OR ALTER PROCEDURE ddbbaTP.Validar_TipoPersona
    @Identificador VARCHAR(10),         -- Puede ser NroSocio o IdInvitado
    @EsSocio BIT OUTPUT,                -- 1 si es socio, 0 si es invitado
    @Existe BIT OUTPUT                  -- 1 si existe en alguna tabla, 0 si no
AS
BEGIN
    SET NOCOUNT ON;
    SET @EsSocio = NULL;
    SET @Existe = 0;

    IF EXISTS (
        SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @Identificador
    )
    BEGIN
        SET @EsSocio = 1;
        SET @Existe = 1;
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @Identificador
    )
    BEGIN
        SET @EsSocio = 0;
        SET @Existe = 1;
        RETURN;
    END
END;
GO

---- ACTUALIZAR MORA FACTURAS
go
CREATE OR ALTER PROCEDURE ddbbaTP.Actualizar_Morosidad
AS
BEGIN
    SET NOCOUNT ON; -- Evita que se devuelvan recuentos de filas afectados.

    DECLARE @FechaActual DATE;
    SET @FechaActual = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE F
        SET
            F.Monto_Total = F.Monto_Total + F.Monto_Total * 10/100,
            F.Estado = 'Vencido', -- Cambia el estado a 'Vencido' si aún no lo está
            F.Dias_Atrasados = DATEDIFF(DAY, TRY_CONVERT(DATE, F.Fecha_Vencimiento), @FechaActual)
        FROM
            ddbbaTP.Factura AS F
        WHERE
            TRIM(F.Estado) = 'Pendiente' -- Solo facturas pendientes
            AND TRY_CONVERT(DATE, F.Fecha_Vencimiento) IS NOT NULL -- Asegura que la fecha de vencimiento sea válida
            AND TRY_CONVERT(DATE, F.Fecha_Vencimiento) < @FechaActual; -- La fecha de vencimiento ya  pasó

        COMMIT TRANSACTION; -- Confirma los cambios.
        PRINT 'Proceso de Actualización de Morosidad completado. Se han actualizado ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' facturas.';

    END TRY
    BEGIN CATCH
        -- Si ocurre un error, revierte la transacción.
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @Msg NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'ERROR en Actualizar_Morosidad: ' + @Msg;
        RAISERROR(@Msg, 16, 1);
    END CATCH
END;
