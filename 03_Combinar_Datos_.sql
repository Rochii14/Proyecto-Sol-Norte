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

<<<<<<< HEAD
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
=======
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
>>>>>>> recuperar-historial
END;
go
------------------------------------------------------------------------------------------
--INSERTAR ID DE CATEGORIA EN SOCIO

<<<<<<< HEAD
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
=======
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
>>>>>>> recuperar-historial
	WHERE DATEDIFF( YEAR, TRY_CONVERT (DATE, Fecha_De_Nacimiento, 103), GETDATE ()) >= 18;
END;
go
------------------------------------------------------------------------------------------
--INSERTO EN LA TABLA INSCRIPTO
<<<<<<< HEAD

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
=======
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
>>>>>>> recuperar-historial
AS
BEGIN
	SET LANGUAGE spanish

<<<<<<< HEAD
	UPDATE Clases.Clase
=======
	UPDATE ddbbaTP.Clase
>>>>>>> recuperar-historial
	SET Dia = DATENAME(WEEKDAY, CONVERT(DATE, Fecha, 103))

	SET LANGUAGE english;
END;
go
<<<<<<< HEAD
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

=======

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
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
        FROM Socios.GrupoFamiliar 
=======
        FROM ddbbaTP.GrupoFamiliar 
>>>>>>> recuperar-historial
        ORDER BY NEWID();

        -- Generar una fecha de nacimiento aleatoria entre 1950-01-01 y 2020-12-31
        DECLARE @DiasRandom INT = ABS(CHECKSUM(NEWID()) % 25836); -- días entre 1950-01-01 y 2020-12-31
        DECLARE @FechaNacimientoDate DATE = DATEADD(DAY, @DiasRandom, '19500101');
        SET @FechaNacimiento = FORMAT(@FechaNacimientoDate, 'dd/MM/yyyy');

<<<<<<< HEAD
        INSERT INTO Accesos.Invitado (Dni, Nombre, Nro_Socio, IdFactura, Fecha_De_Nacimiento)
=======
        INSERT INTO ddbbaTP.Invitado (Dni, Nombre, Nro_Socio, IdFactura, Fecha_De_Nacimiento)
>>>>>>> recuperar-historial
        VALUES (@Dni, @Nombre, @Nro_Socio, NULL, @FechaNacimiento);

        SET @i = @i + 1;
    END

    PRINT CAST(@CantInv AS VARCHAR(10)) + ' invitados aleatorios generados exitosamente.';
END;
go

EXEC CargaInvitadosRandom @CantInv = 10;
go
<<<<<<< HEAD
-------------------------------------------------------------------------------------------------
--INSERTAR JERARQUIA EN ACTIVIDADES EXTRA

CREATE OR ALTER PROCEDURE Accesos.InsertarActividadJerarquica
=======

-------------------------------------------------------------------------------------------------
--INSERTAR JERARQUIA EN ACTIVIDADES EXTRA
go
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividadJerarquica
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    INSERT INTO Accesos.ActividadExtra (Tipo)
=======
    INSERT INTO ddbbaTP.ActividadExtra (Tipo)
>>>>>>> recuperar-historial
    VALUES (@TipoActividad);

    -- Obtener el ID generado
    SET @IdActExtra = SCOPE_IDENTITY();

    -- 2. Insertar en la tabla correspondiente
    IF @SubTipo = 'Colonia'
    BEGIN
<<<<<<< HEAD
        INSERT INTO Accesos.Colonia (IdActividadExtra, FechaInicio, FechaFin, Precio)
=======
        INSERT INTO ddbbaTP.Colonia (IdActividadExtra, FechaInicio, FechaFin, Precio)
>>>>>>> recuperar-historial
        VALUES (@IdActExtra, @FechaInicio, @FechaFin, @Precio);
    END
    ELSE IF @SubTipo = 'Sum'
    BEGIN
<<<<<<< HEAD
        INSERT INTO Accesos.Sum_Recreativo (IdActividadExtra, Precio)
=======
        INSERT INTO ddbbaTP.Sum_Recreativo (IdActividadExtra, Precio)
>>>>>>> recuperar-historial
        VALUES (@IdActExtra, @Precio);
    END
    ELSE IF @SubTipo = 'Pileta'
    BEGIN
<<<<<<< HEAD
        INSERT INTO Accesos.Pileta (IdActividadExtra, Fec_Temporada)
=======
        INSERT INTO ddbbaTP.Pileta (IdActividadExtra, Fec_Temporada)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
EXEC Accesos.InsertarActividadJerarquica
=======
EXEC ddbbaTP.InsertarActividadJerarquica
>>>>>>> recuperar-historial
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Colonia',
    @FechaInicio = '2025-01-10',
    @FechaFin = '2025-02-20',
    @Precio = 25000;
go

-- Sum recreativo
<<<<<<< HEAD
EXEC Accesos.InsertarActividadJerarquica
=======
EXEC ddbbaTP.InsertarActividadJerarquica
>>>>>>> recuperar-historial
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Sum',
    @Precio = 18000;
go

-- Pileta
<<<<<<< HEAD
EXEC Accesos.InsertarActividadJerarquica
=======
EXEC ddbbaTP.InsertarActividadJerarquica
>>>>>>> recuperar-historial
    @TipoActividad = 'Recreativa',
    @SubTipo = 'Pileta',
    @Fec_Temporada = '2025-01-01';
go
<<<<<<< HEAD
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
=======

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
>>>>>>> recuperar-historial
AS
BEGIN
    IF @EdadS > 12 AND @EdadS < 18
    BEGIN
<<<<<<< HEAD
        SELECT @MontoBaseS = Costo FROM Socios.Categoria  
=======
        SELECT @MontoBaseS = Costo FROM ddbbaTP.Categoria  
>>>>>>> recuperar-historial
		WHERE Nombre = 'Cadete';
    END
    ELSE IF @EdadS >= 18
    BEGIN
<<<<<<< HEAD
        SELECT @MontoBaseS = Costo FROM Socios.Categoria 
=======
        SELECT @MontoBaseS = Costo FROM ddbbaTP.Categoria 
>>>>>>> recuperar-historial
        WHERE Nombre = 'Mayor';
    END
    ELSE
    BEGIN
<<<<<<< HEAD
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
=======
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
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    END;
=======
    END
>>>>>>> recuperar-historial

    -- Invitados solo pueden acceder a pase del día
    IF @EsSocio = 0 AND @TipoPase <> 'Día'
    BEGIN
        THROW 60002, 'Los invitados solo pueden acceder al pase del día.', 1;
<<<<<<< HEAD
    END;
=======
    END
>>>>>>> recuperar-historial

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
<<<<<<< HEAD
go
---------------------------------------------------------------------------------------------------------
--VALIDAR TIPO DE PERSONA (SOCIO O INVITADO)

CREATE OR ALTER PROCEDURE Socios.Validar_TipoPersona
=======
GO
---------------------------------------------------------------------------------------------------------
--VALIDAR TIPO DE PERSONA (SOCIO O INVITADO)
go
CREATE OR ALTER PROCEDURE ddbbaTP.Validar_TipoPersona
>>>>>>> recuperar-historial
    @Identificador VARCHAR(10),         -- Puede ser NroSocio o IdInvitado
    @EsSocio BIT OUTPUT,                -- 1 si es socio, 0 si es invitado
    @Existe BIT OUTPUT                  -- 1 si existe en alguna tabla, 0 si no
AS
BEGIN
    SET NOCOUNT ON;
    SET @EsSocio = NULL;
    SET @Existe = 0;

    IF EXISTS (
<<<<<<< HEAD
        SELECT 1 FROM Socios.Socio WHERE NroSocio = @Identificador
=======
        SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @Identificador
>>>>>>> recuperar-historial
    )
    BEGIN
        SET @EsSocio = 1;
        SET @Existe = 1;
        RETURN;
    END

    IF EXISTS (
<<<<<<< HEAD
        SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @Identificador
=======
        SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @Identificador
>>>>>>> recuperar-historial
    )
    BEGIN
        SET @EsSocio = 0;
        SET @Existe = 1;
        RETURN;
    END
END;
<<<<<<< HEAD
go

---------------------------------------------------------------------------------------------------------
-- ACTUALIZAR MORA FACTURAS

CREATE OR ALTER PROCEDURE Facturacion.Actualizar_Morosidad
=======
GO

---- ACTUALIZAR MORA FACTURAS
go
CREATE OR ALTER PROCEDURE ddbbaTP.Actualizar_Morosidad
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
            Facturacion.Factura AS F
=======
            ddbbaTP.Factura AS F
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
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
=======
>>>>>>> recuperar-historial
