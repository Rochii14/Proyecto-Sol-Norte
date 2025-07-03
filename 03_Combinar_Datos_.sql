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

CREATE OR ALTER PROCEDURE Socios.Insertar_Id_GruporFamiliar
AS
BEGIN
	UPDATE Socios.Socio
	SET IdGrupoFamiliar = gp.IdGrupoFamiliar
	FROM Socios.GrupoFamiliar AS gp
	WHERE Socios.Socio.NroSocio2 = gp.NroSocio

	UPDATE Socios.Socio
	SET IdGrupoFamiliar = gp.IdGrupoFamiliar
	FROM Socios.GrupoFamiliar AS gp
	WHERE Socios.Socio.NroSocio = gp.NroSocio
END;
go
------------------------------------------------------------------------------------------
--INSERTAR ID DE CATEGORIA EN SOCIO

CREATE OR ALTER PROCEDURE Socios.Insertar_Id_Categoria
AS
BEGIN
	UPDATE Socios.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM Socios.Categoria AS c WHERE c.Nombre = 'Menor' )
	WHERE DATEDIFF ( YEAR, (TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103)), GETDATE ()) <= 12;

	UPDATE Socios.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM Socios.Categoria AS c WHERE c.Nombre = 'Cadete' )
	WHERE DATEDIFF( YEAR, TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103), GETDATE ()) BETWEEN 13 AND 17;

	UPDATE Socios.Socio
	SET IdCategoria = ( SELECT c.IdCategoria FROM Socios.Categoria AS c WHERE c.Nombre = 'Mayor' )
	WHERE DATEDIFF( YEAR, TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103), GETDATE ()) >= 18;
END;
go
------------------------------------------------------------------------------------------
--INSERTO EN LA TABLA INSCRIPTO

CREATE OR ALTER PROCEDURE Clases.Insertar_Inscripto
AS
BEGIN
	INSERT INTO Clases.Inscripto(NroSocio, IdActividad, FechaInscripcion)
	SELECT DISTINCT AE.NroSocio, C.IdActividad, ISNULL(AE.FechaInscripcion, '2024-01-01')  -- provisoria
	FROM Clases.Anotado_En AE 
	JOIN Clases.Clase C ON AE.IdClase= C.IdClase
	WHERE NOT EXISTS (SELECT 1 FROM  Clases.Inscripto I WHERE I.NroSocio=AE.NroSocio AND I.IdActividad =C.IdActividad)
 
END;
go
--------------------------------------------------------------------------------------------
--INSERTAR DIA EN TABLA CLASE

CREATE OR ALTER PROCEDURE Clases.Insertar_Dia_Clase
AS
BEGIN
	SET LANGUAGE spanish

	UPDATE Clases.Clase
	SET Dia = DATENAME(WEEKDAY, CONVERT(DATE, Fecha, 103))

	SET LANGUAGE english;
END;
go
-------------------------------------------------------------------------------------------------
--INSERTAR DATOS EN CUENTA

CREATE OR ALTER PROCEDURE Socios.Insertar_Datos_Cuenta
AS
BEGIN
	INSERT INTO Socios.Cuenta ( NroSocio )
	SELECT s.NroSocio
	FROM Socios.Socio AS s
	WHERE NOT EXISTS ( SELECT 1 FROM Socios.Cuenta AS c WHERE c.NroSocio = s.NroSocio ) 
			AND ( s.NroSocio2 IS NULL OR S.NroSocio IN ( SELECT gp.NroSocio FROM Socios.GrupoFamiliar AS gp ) )
END;
go
-------------------------------------------------------------------------------------------------
--INSERTAR DATOS EN INVITADO

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
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar)
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
        FROM Socios.GrupoFamiliar 
        ORDER BY NEWID();

        -- Generar una fecha de nacimiento aleatoria entre 1950-01-01 y 2020-12-31
        DECLARE @DiasRandom INT = ABS(CHECKSUM(NEWID()) % 25836); -- días entre 1950-01-01 y 2020-12-31
        DECLARE @FechaNacimientoDate DATE = DATEADD(DAY, @DiasRandom, '19500101');
        SET @FechaNacimiento = FORMAT(@FechaNacimientoDate, 'dd/MM/yyyy');

        INSERT INTO Accesos.Invitado (Dni, Nombre, Nro_Socio, IdFactura, Fecha_De_Nacimiento)
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

CREATE OR ALTER PROCEDURE Accesos.InsertarActividadJerarquica
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
    INSERT INTO Accesos.ActividadExtra (Tipo)
    VALUES (@TipoActividad);

    -- Obtener el ID generado
    SET @IdActExtra = SCOPE_IDENTITY();

    -- 2. Insertar en la tabla correspondiente
    IF @SubTipo = 'Colonia'
    BEGIN
        INSERT INTO Accesos.Colonia (IdActividadExtra, FechaInicio, FechaFin, Precio)
        VALUES (@IdActExtra, @FechaInicio, @FechaFin, @Precio);
    END
    ELSE IF @SubTipo = 'Sum'
    BEGIN
        INSERT INTO Accesos.Sum_Recreativo (IdActividadExtra, Precio)
        VALUES (@IdActExtra, @Precio);
    END
    ELSE IF @SubTipo = 'Pileta'
    BEGIN
        INSERT INTO Accesos.Pileta (IdActividadExtra, Fec_Temporada)
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
EXEC Accesos.InsertarActividadJerarquica
    @TipoActividad = 'Colonia',
    @SubTipo = 'Colonia',
    @FechaInicio = '2025-01-10',
    @FechaFin = '2025-02-20',
    @Precio = 25000;
go

-- Sum recreativo
EXEC Accesos.InsertarActividadJerarquica
    @TipoActividad = 'Sum',
    @SubTipo = 'Sum',
    @Precio = 18000;
go

-- Pileta
EXEC Accesos.InsertarActividadJerarquica
    @TipoActividad = 'Pileta',
    @SubTipo = 'Pileta',
    @Fec_Temporada = '2025-01-01';
go
-------------------------------------------------------------------------------------------------
--INSERTAR MEDIOS DE PAGO

EXEC Facturacion.InsertarMedioDePago @Nombre='Visa', @Tipo= 'Credito', @Modalidad= 'Tarjeta'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='MasterCard', @Tipo= 'Credito', @Modalidad= 'Tarjeta'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='Tarjeta Naranja', @Tipo= 'Debito', @Modalidad= 'Tarjeta'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='Pago Facil', @Tipo= 'Contado', @Modalidad= 'Presencial'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='Rapipago', @Tipo= 'Contado', @Modalidad= 'Presencial'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='Mercado Pago', @Tipo= 'Billetera', @Modalidad= 'Transferencia'
go
EXEC Facturacion.InsertarMedioDePago @Nombre='Efectivo', @Tipo= 'Contado', @Modalidad= 'Presencial'
go

---------------------------------------------------------------------------------------------------------------
--ASIGNAR MONTO A CATEGORIA

CREATE OR ALTER PROCEDURE Socios.Asignar_Monto_Categoria  @EdadS INT,  @MontoBaseS DECIMAL(10,2) OUTPUT
AS
BEGIN
    IF @EdadS > 12 AND @EdadS < 18
    BEGIN
        SELECT @MontoBaseS = Costo FROM Socios.Categoria  
		WHERE Nombre = 'Cadete';
    END
    ELSE IF @EdadS >= 18
    BEGIN
        SELECT @MontoBaseS = Costo FROM Socios.Categoria 
        WHERE Nombre = 'Mayor';
    END
    ELSE
    BEGIN
        SELECT @MontoBaseS = Costo  FROM Socios.Categoria 
        WHERE Nombre = 'Menor';
    END
END;
go

-----------------------------------------------------------------------------------------------------------------
--ASIGNAR MONTO A ACTIVIDAD

CREATE OR ALTER PROCEDURE Clases.Asignar_Monto_Actividad @NombreAct VARCHAR(100), @MontoBaseS DECIMAL(10,2) OUTPUT
AS
BEGIN
	select @MontoBaseS=a.Costo from Clases.Actividad a where a.Nombre like @NombreAct
END;
go

------------------------------------------------------------------------------------------------------------------------
--ASIGNAR MONTO A PILETA

CREATE OR ALTER PROCEDURE Accesos.Asignar_Monto_Pileta
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
    END;

    -- Invitados solo pueden acceder a pase del día
    IF @EsSocio = 0 AND @TipoPase <> 'Día'
    BEGIN
        THROW 60002, 'Los invitados solo pueden acceder al pase del día.', 1;
    END;

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
go
---------------------------------------------------------------------------------------------------------
--VALIDAR TIPO DE PERSONA (SOCIO O INVITADO)

CREATE OR ALTER PROCEDURE Socios.Validar_TipoPersona
    @Identificador VARCHAR(10),         -- Puede ser NroSocio o IdInvitado
    @EsSocio BIT OUTPUT,                -- 1 si es socio, 0 si es invitado
    @Existe BIT OUTPUT                  -- 1 si existe en alguna tabla, 0 si no
AS
BEGIN
    SET NOCOUNT ON;
    SET @EsSocio = NULL;
    SET @Existe = 0;

    IF EXISTS (
        SELECT 1 FROM Socios.Socio WHERE NroSocio = @Identificador
    )
    BEGIN
        SET @EsSocio = 1;
        SET @Existe = 1;
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @Identificador
    )
    BEGIN
        SET @EsSocio = 0;
        SET @Existe = 1;
        RETURN;
    END
END;
go

---------------------------------------------------------------------------------------------------------
-- ACTUALIZAR MORA FACTURAS

CREATE OR ALTER PROCEDURE Facturacion.Actualizar_Morosidad
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
            Facturacion.Factura AS F
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
go

CREATE OR ALTER PROCEDURE Facturacion.Actualizar_Fecha_Vencimiento
AS
BEGIN
	UPDATE Facturacion.Factura
	SET Fecha_Vencimiento = CONVERT(VARCHAR(10), TRY_CONVERT(DATE, Fecha_Vencimiento, 103), 120)
	WHERE Fecha_Vencimiento IS NOT NULL
END;
go


------------------ HabilitarPasePileta  ------------------

CREATE OR ALTER PROCEDURE Facturacion.HabilitarPasePileta  @TarifaSocio DECIMAL(10,2),@TarifaInvitado DECIMAL(10,2),@NroSocio VARCHAR(10),@IdInvitado INT = NULL,@Fec_Temporada DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdActividadExtra INT;
    DECLARE @PasePiletaExistente INT;
    DECLARE @FacturaId INT;
    -- Validar tarifas
    IF @TarifaSocio < 0 OR @TarifaInvitado < 0
    BEGIN
        PRINT 'Error: Tarifa no puede ser negativa.';
        RETURN -1;
    END;
    -- Validar socio e invitado
    IF @IdInvitado IS NOT NULL 
    BEGIN
        IF NOT EXISTS (
            SELECT 1 
            FROM Accesos.Invitado 
            WHERE Nro_Socio = @NroSocio AND IdInvitado = @IdInvitado
        )
        BEGIN
            PRINT 'Error: Socio e invitado no coinciden.';
            RETURN -2;
        END;
    END
    ELSE IF NOT EXISTS (
        SELECT 1 
        FROM Socios.Socio 
        WHERE NroSocio = @NroSocio
    )
    BEGIN
        PRINT 'Error: Socio no existe.';
        RETURN -4;
    END;
    -- Obtener la actividad pileta correspondiente a la temporada
    SELECT @IdActividadExtra = IdActividadExtra
    FROM Accesos.Pileta
    WHERE Fec_Temporada = @Fec_Temporada;
    IF @IdActividadExtra IS NULL
    BEGIN
        PRINT 'Error: No hay pileta para la temporada.';
        RETURN -3;
    END;
    -- Verificar si existe factura pagada correspondiente
    IF @IdInvitado IS NOT NULL
		BEGIN
			SELECT TOP 1 @FacturaId = IdFactura
			FROM Accesos.Invitado
			WHERE IdInvitado = @IdInvitado
			  AND Nro_Socio = @NroSocio;
		END
    ELSE
    BEGIN
        SELECT TOP 1 @FacturaId = F.IdFactura
        FROM Facturacion.Factura F
        INNER JOIN Facturacion.Cuota C ON F.IdCuota = C.IdCuota
        WHERE C.NroSocio = @NroSocio
          AND C.IdActividadExtra = @IdActividadExtra
          AND F.Estado = 'Pagada';
    END;
    IF @FacturaId IS NULL
		BEGIN
			PRINT 'Error: No hay factura pagada correspondiente a pileta.';
			RETURN -5;
		END;
    -- Verificar si ya existe un pase
    SELECT @PasePiletaExistente = IdPasePileta
    FROM Accesos.PasePileta
    WHERE NroSocio = @NroSocio AND (IdInvitado = @IdInvitado OR (IdInvitado IS NULL AND @IdInvitado IS NULL))
      AND IdActividadExtra = @IdActividadExtra AND Fec_Temporada = @Fec_Temporada;
    IF @PasePiletaExistente IS NOT NULL
		BEGIN
			UPDATE Accesos.PasePileta SET Tarifa_Socio = @TarifaSocio,  Tarifa_Invitado = @TarifaInvitado
			WHERE IdPasePileta = @PasePiletaExistente; 
			PRINT 'Pase pileta actualizado.';
		END
    ELSE
    BEGIN
        INSERT INTO Accesos.PasePileta (  Tarifa_Socio,  Tarifa_Invitado,  NroSocio,  IdInvitado,   IdActividadExtra,  Fec_Temporada  )
        VALUES (  @TarifaSocio, @TarifaInvitado, @NroSocio, @IdInvitado, @IdActividadExtra, @Fec_Temporada );
        PRINT 'Pase pileta insertado.';
    END;
END;
GO
