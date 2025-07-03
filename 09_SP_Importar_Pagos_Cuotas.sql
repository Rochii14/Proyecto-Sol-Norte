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
----------importo los datos que están en archivo de los pagos
CREATE OR ALTER PROCEDURE Facturacion.Importar_Pagos  @rutaArchivo VARCHAR(200)
AS
BEGIN
    -- Borra si ya existe la tabla temporal global
    IF OBJECT_ID('tempdb..##Carga_Pago_Temp') IS NOT NULL 
        DROP TABLE ##Carga_Pago_Temp;

    -- Crea la tabla temporal con colId como BIGINT
    CREATE TABLE ##Carga_Pago_Temp
    (
        colId BIGINT,
        colFecha VARCHAR(30),
        colResp VARCHAR(10),
        colValor DECIMAL(10,2),
        colMedioPago VARCHAR(30)
    );

    -- Arma el comando BULK INSERT
    DECLARE @SQL_Pago NVARCHAR(MAX) = '
        BULK INSERT ##Carga_Pago_Temp
        FROM ''' + @rutaArchivo + '''
        WITH (
            FIELDTERMINATOR = '';'',
            ROWTERMINATOR = ''\n'',
            FIRSTROW = 2,
            CODEPAGE = ''ACP''
        );';

    EXEC sp_executesql @SQL_Pago;
END;
go

CREATE OR ALTER PROCEDURE Facturacion.ActualizarTablasSegunPagosArchivo
AS
BEGIN
    SET NOCOUNT ON;
   
    DECLARE 
        @IdCuota INT,@IdFactura INT,@IdCuenta INT, @IdMedioPago INT,
        @colId BIGINT,@colFecha VARCHAR(30),@colResp VARCHAR(10),
        @colValor DECIMAL(10,2),@colMedioPago VARCHAR(30),@FechaConvertida DATE;
    -- Cursor para recorrer pagos únicos
    DECLARE pagos_cursor CURSOR FOR
    SELECT DISTINCT colId, colFecha, colResp, colValor, colMedioPago
    FROM ##Carga_Pago_Temp;

    OPEN pagos_cursor;

    FETCH NEXT FROM pagos_cursor 
    INTO @colId, @colFecha, @colResp, @colValor, @colMedioPago;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Convertir fecha
            SET @FechaConvertida = COALESCE(TRY_CAST(@colFecha AS DATE), GETDATE());

            -- Validar existencia del socio
            IF EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @colResp)
            BEGIN
                -- 1. Insertar cuota
                INSERT INTO Facturacion.Cuota (Estado, NroSocio)
                VALUES ('Pendiente', @colResp);

                SET @IdCuota = SCOPE_IDENTITY();

                -- 2. Insertar factura
                INSERT INTO Facturacion.Factura (Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
                VALUES (@FechaConvertida, 0, 'Pagada', NULL, @IdCuota);

                SET @IdFactura = SCOPE_IDENTITY();

                -- 3. Buscar o crear medio de pago
                SELECT @IdMedioPago = IdMedioPago
                FROM Facturacion.MedioDePago
                WHERE Nombre = @colMedioPago;

                IF @IdMedioPago IS NULL
                BEGIN
                    INSERT INTO Facturacion.MedioDePago (Nombre, Tipo, Modalidad)
                    VALUES (@colMedioPago, 'Desconocido', 'Importado');

                    SET @IdMedioPago = SCOPE_IDENTITY();
                END

                -- 4. Buscar o crear cuenta
                SELECT @IdCuenta = IdCuenta
                FROM Socios.Cuenta
                WHERE NroSocio = @colResp;

                IF @IdCuenta IS NULL
                BEGIN
                    INSERT INTO Socios.Cuenta (Saldo_Favor, NroSocio)
                    VALUES (0, @colResp);

                    SET @IdCuenta = SCOPE_IDENTITY();
                END

                -- 5. Insertar pago si no existe
                IF NOT EXISTS (
                    SELECT 1 FROM Facturacion.Pago WHERE IdPago = @colId
                )
                BEGIN
                    INSERT INTO Facturacion.Pago (IdPago, Fecha_de_Pago, IdCuenta, IdFactura, IdMedioDePago, Monto)
                    VALUES (@colId, @FechaConvertida, @IdCuenta, @IdFactura, @IdMedioPago, @colValor);

                    PRINT 'Pago insertado: IdPago=' + CAST(@colId AS VARCHAR);
                END
                ELSE
                BEGIN
                    PRINT 'Pago duplicado detectado. No insertado: IdPago=' + CAST(@colId AS VARCHAR);
                END
            END
            ELSE
            BEGIN
                PRINT 'NroSocio no existe. Pago omitido: IdPago=' + CAST(@colId AS VARCHAR);
            END

            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error en colId: ' + CAST(@colId AS VARCHAR) + ' - ' + ERROR_MESSAGE();
        END CATCH;

        FETCH NEXT FROM pagos_cursor 
        INTO @colId, @colFecha, @colResp, @colValor, @colMedioPago;
    END;

    CLOSE pagos_cursor;
    DEALLOCATE pagos_cursor;

END;
GO
GO
execute Facturacion.Importar_Pagos 'C:\_temp\Pago cuotas.csv'
go

execute Facturacion.ActualizarTablasSegunPagosArchivo
go

----------NUEVAS CUOTAS Y FACTURAS
CREATE OR ALTER PROCEDURE Facturacion.GenerarCuotaYFacturaMembresiaYActividades 
    @NroSocio VARCHAR(10),
    @Tipo VARCHAR(20), -- 'Categoria' | 'Actividad'
    @NombreActividad VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE 
            @IdCuota INT,
            @IdDescuento INT = NULL,
            @PorcentajeDescuento INT = 0,
            @MontoFinal DECIMAL(10,2),
            @IdFactura INT,
            @FechaEmision DATE,
            @FechaVencimiento DATE,
            @FechaVencimiento2 DATE,
            @MontoBase DECIMAL(10,2),
            @FechaNacimientoSocio VARCHAR(10),
            @FechaNacimientoSocioDATE DATE,
            @EdadSocio INT,
            @IdGrupoFamiliarSocio INT,
            @NroSocioResponsable VARCHAR(10),
            @CantAct INT,
            @EsSocio BIT = 1;

        -- 1) Grupo familiar
        SELECT @IdGrupoFamiliarSocio = s.IdGrupoFamiliar
        FROM Socios.Socio s
        WHERE s.NroSocio = @NroSocio;

        IF @IdGrupoFamiliarSocio IS NOT NULL
            SELECT @NroSocioResponsable = gf.NroSocio
            FROM Socios.GrupoFamiliar gf
            WHERE gf.IdGrupoFamiliar = @IdGrupoFamiliarSocio;
        ELSE
            SET @NroSocioResponsable = @NroSocio;

        -- 2) Insertar cuota
        INSERT INTO Facturacion.Cuota (Estado, NroSocio, Socio_Cuota)
        VALUES ('Pendiente', @NroSocioResponsable, @NroSocio);
        SET @IdCuota = SCOPE_IDENTITY();

        -- 3) Fecha nacimiento y edad
        SELECT @FechaNacimientoSocio = Fecha_De_Nacimiento
        FROM Socios.Socio WHERE NroSocio = @NroSocio;

        SET @FechaNacimientoSocioDATE = TRY_CONVERT(DATE, @FechaNacimientoSocio, 103);
        IF @FechaNacimientoSocioDATE IS NULL
            THROW 50000, 'La fecha de nacimiento del socio es inválida.', 1;

        SET @EdadSocio = DATEDIFF(YEAR, @FechaNacimientoSocioDATE, GETDATE())
                         - CASE WHEN MONTH(@FechaNacimientoSocioDATE) > MONTH(GETDATE())
                              OR (MONTH(@FechaNacimientoSocioDATE) = MONTH(GETDATE()) AND DAY(@FechaNacimientoSocioDATE) > DAY(GETDATE()))
                              THEN 1 ELSE 0 END;

        -- 4) Monto base y descuentos
        IF @Tipo = 'Categoria'
        BEGIN
            EXEC Socios.Asignar_Monto_Categoria @EdadS = @EdadSocio, @MontoBaseS = @MontoBase OUTPUT;

            IF @IdGrupoFamiliarSocio IS NOT NULL
                SET @PorcentajeDescuento = 15;
        END
        ELSE IF @Tipo = 'Actividad'
        BEGIN
            IF @NombreActividad IS NULL OR @NombreActividad = ''
                SELECT TOP 1 @NombreActividad = a.Nombre
                FROM Clases.Inscripto i
                JOIN Clases.Actividad a ON i.IdActividad = a.IdActividad
                WHERE i.NroSocio = @NroSocio
                  AND TRY_CONVERT(DATE, i.FechaInscripcion, 103) IS NOT NULL
                ORDER BY TRY_CONVERT(DATE, i.FechaInscripcion, 103) DESC;

            IF @NombreActividad IS NULL OR @NombreActividad = ''
                THROW 50001, 'No se especificó actividad válida.', 1;

            EXEC Clases.Asignar_Monto_Actividad @NombreAct = @NombreActividad, @MontoBaseS = @MontoBase OUTPUT;

            SELECT @CantAct = COUNT(*) FROM Clases.Inscripto WHERE NroSocio = @NroSocio;
            IF @CantAct > 1
                SET @PorcentajeDescuento = 10;
        END
        ELSE
            THROW 50000, 'Tipo inválido.', 1;

        SET @MontoFinal = ISNULL(@MontoBase, 0) - (ISNULL(@MontoBase, 0) * @PorcentajeDescuento / 100.0);

        -- 5) Fechas
        SET @FechaEmision = GETDATE();
        SET @FechaVencimiento = DATEADD(DAY, 5, @FechaEmision);
        SET @FechaVencimiento2 = DATEADD(DAY, 5, @FechaVencimiento);

        -- 6) Descuento
        IF @PorcentajeDescuento > 0
        BEGIN
            SELECT @IdDescuento = IdDescuento
            FROM Facturacion.Descuento
            WHERE Porcentaje = @PorcentajeDescuento AND NroSocio = @NroSocio;

            IF @IdDescuento IS NULL
            BEGIN
                INSERT INTO Facturacion.Descuento (Porcentaje, NroSocio)
                VALUES (@PorcentajeDescuento, @NroSocio);

                SET @IdDescuento = SCOPE_IDENTITY();
            END
        END

        -- 7) Insertar factura con fecha de emisión y ambos vencimientos
        INSERT INTO Facturacion.Factura 
            (Fecha_Emision, Fecha_Vencimiento, Fecha_Vencimiento2, Monto_Total, Dias_Atrasados, Estado, IdDescuento, IdCuota, Detalle)
        VALUES 
            (
                CONVERT(VARCHAR(10), @FechaEmision, 120),      -- yyyy-MM-dd
                CONVERT(VARCHAR(10), @FechaVencimiento, 120),  -- yyyy-MM-dd
                CONVERT(VARCHAR(10), @FechaVencimiento2, 120), -- yyyy-MM-dd
                @MontoFinal, 0, 'Pendiente', @IdDescuento, @IdCuota, @NombreActividad
            );

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
---------->comprobación de que se inserta y modifica la factura
select * from Facturacion.Factura
go
execute Facturacion.GenerarCuotaYFacturaMembresiaYActividades @NroSocio ='SN-4139', @Tipo ='Actividad' , @NombreActividad='Futsal'
go
select * from Facturacion.Factura
go
--------------------------------------------------------------------------------------------------------------------------------
---------HACER GENERAR FACTURA ACTIVIDAD EXTRA
CREATE OR ALTER PROCEDURE Facturacion.GenerarFacturaActividadExtraSocio  @NroSocio VARCHAR(10), @IdActExtra INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE  @TipoActividad VARCHAR(50),  @Monto DECIMAL(10,2), @IdCuota INT,  @IdFactura INT,
            @FechaEmision DATE = GETDATE(),  @FechaVencimiento DATE = DATEADD(DAY, 5, GETDATE()),  @FechaVencimiento2 DATE = DATEADD(DAY, 10, GETDATE());

        -- 1. Obtener tipo de actividad
        SELECT @TipoActividad = Tipo
        FROM Accesos.ActividadExtra
        WHERE IdActExtra = @IdActExtra;

        IF @TipoActividad IS NULL
            THROW 50000, 'Actividad no encontrada.', 1;

        -- 2. Obtener monto según el tipo de actividad
        IF @TipoActividad = 'Colonia'
        BEGIN
            SELECT @Monto = Precio
            FROM Accesos.Colonia
            WHERE IdActividadExtra = @IdActExtra;
        END
        ELSE IF @TipoActividad = 'Pileta'
        BEGIN
            -- Suponemos que hay una sola temporada actual (última por fecha)
            SELECT TOP 1 @Monto = 0 -- no hay campo precio directo en Pileta
            FROM Accesos.Pileta
            WHERE IdActividadExtra = @IdActExtra
            ORDER BY Fec_Temporada DESC;
        END
        ELSE IF @TipoActividad = 'Sum' OR @TipoActividad = 'Sum_Recreativo'
        BEGIN
            SELECT @Monto = Precio
            FROM Accesos.Sum_Recreativo
            WHERE IdActividadExtra = @IdActExtra;
        END
        ELSE
            THROW 50001, 'Tipo de actividad no reconocido.', 1;

        IF @Monto IS NULL OR @Monto <= 0
            THROW 50002, 'Monto no válido para la actividad.', 1;

        -- 3. Insertar cuota
        INSERT INTO Facturacion.Cuota (Estado, NroSocio)
        VALUES ('Pendiente', @NroSocio);
        SET @IdCuota = SCOPE_IDENTITY();

        -- 4. Insertar factura
        INSERT INTO Facturacion.Factura (
            Fecha_Emision, Fecha_Vencimiento, Fecha_Vencimiento2,
            Monto_Total, Dias_Atrasados, Estado, IdDescuento, IdCuota, Detalle)
        VALUES (
            @FechaEmision, @FechaVencimiento, @FechaVencimiento2,
            @Monto, 0, 'Pendiente', NULL, @IdCuota, @TipoActividad);

        SET @IdFactura = SCOPE_IDENTITY();

        PRINT 'Factura generada exitosamente. IdFactura = ' + CAST(@IdFactura AS VARCHAR);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO
CREATE OR ALTER PROCEDURE Facturacion.GenerarFacturaPiletaInvitado  @IdInvitado INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE 
            @MontoFactura DECIMAL(12,2),
            @FechaEmision DATE = GETDATE(),
            @FechaVencimiento DATE,
            @FechaVencimiento2 DATE,
            @IdFactura INT;

        -- Validar que exista el invitado
        IF NOT EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado)
        BEGIN
            THROW 50000, 'El invitado no existe.', 1;
        END

        -- Validar que no tenga ya una factura asignada
        IF EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado AND IdFactura IS NOT NULL)
        BEGIN
            THROW 50001, 'Este invitado ya tiene una factura asociada.', 1;
        END

        -- Obtener monto para invitado según tarifa vigente
        SELECT TOP 1 @MontoFactura = MontoInvitado
        FROM Accesos.TarifaPileta
        WHERE (VigenteHasta IS NULL OR VigenteHasta >= @FechaEmision)
        ORDER BY VigenteHasta ASC;

        IF @MontoFactura IS NULL
        BEGIN
            THROW 50002, 'No se encontró una tarifa vigente para invitados.', 1;
        END

        -- Calcular fechas
        SET @FechaVencimiento = DATEADD(DAY, 5, @FechaEmision);
        SET @FechaVencimiento2 = DATEADD(DAY, 5, @FechaVencimiento);

        -- Insertar factura
        INSERT INTO Facturacion.Factura (
            Fecha_Emision, Fecha_Vencimiento, Fecha_Vencimiento2, 
            Monto_Total, Dias_Atrasados, Estado, IdDescuento, IdCuota, Detalle
        )
        VALUES (
            CONVERT(VARCHAR(10), @FechaEmision, 120),
            CONVERT(VARCHAR(10), @FechaVencimiento, 120),
            CONVERT(VARCHAR(10), @FechaVencimiento2, 120),
            @MontoFactura, 0, 'Pendiente', NULL, NULL, 'Pileta - Invitado'
        );

        SET @IdFactura = SCOPE_IDENTITY();

        -- Asociar factura al invitado
        UPDATE Accesos.Invitado
        SET IdFactura = @IdFactura
        WHERE IdInvitado = @IdInvitado;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;

----elupdate es para ver si se genera una factura con una fecha vigente, de otro modo no la genera
----update Accesos.TarifaPileta set VigenteHasta = '20251212' where IdTarifa= 2 or IdTarifa=1


---------- ------------------------------------ ANULAR última FACTURA  de un socio que se dio de baja
CREATE OR ALTER PROCEDURE Facturacion.AnularFacturasPorBajaSocio @NroSocio VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRY
        DECLARE @IdFacturaUltima INT;

        -- Encuentra el IdFactura de la última factura generada para el socio dado
        SELECT TOP 1 @IdFacturaUltima = f.IdFactura
        FROM Facturacion.Factura AS f
        INNER JOIN Facturacion.Cuota AS c ON f.IdCuota = c.IdCuota
        WHERE c.NroSocio = @NroSocio
        ORDER BY f.IdFactura DESC; -- Asume que un IdFactura más alto significa que fue generada más recientemente

        -- Verifica si se encontró una factura antes de intentar anularla
        IF @IdFacturaUltima IS NOT NULL
        BEGIN
            -- Actualiza el estado de la última factura encontrada a 'Anulada'
            UPDATE f
            SET f.Estado = 'Anulada'
            FROM Facturacion.Factura AS f
            WHERE f.IdFactura = @IdFacturaUltima;

            -- Mensaje de confirmación (solo para fines de desarrollo/depuración)
            SELECT 'Última factura (' + CAST(@IdFacturaUltima AS VARCHAR(10)) + ') anulada exitosamente para el socio: ' + @NroSocio AS Mensaje;
        END
        ELSE
        BEGIN
            -- Mensaje si no se encontraron facturas para el socio
             SELECT 'No se encontraron facturas para el socio: ' + @NroSocio AS Mensaje;
        END

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT;
        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
go

CREATE OR ALTER PROCEDURE Socios.Dar_Baja_Socio @NroSocio VARCHAR(10)
AS
BEGIN
	UPDATE Socios.Socio SET Estado= 'Inactivo' where NroSocio= @NroSocio
	PRINT 'Socio ' + @NroSocio + ' dado de baja'
END;
go
EXECUTE Socios.Dar_Baja_Socio @NroSocio= 'SN-4003'
go
EXECUTE Facturacion.AnularFacturasPorBajaSocio @NroSocio='SN-4003'
go

--NOTA: No se actualizan las clases a las que está anotado el socio ni su grupo familiar por el momento
-------------------------------------------------- PAGAR CUOTA/factura
CREATE OR ALTER PROCEDURE Facturacion.PagarFactura @IdFactura INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar existencia de la factura
        IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
        BEGIN
            THROW 60000, 'La factura no existe.', 1;
        END

        -- Validar que no esté ya pagada
        IF EXISTS (
            SELECT 1 FROM Facturacion.Factura 
            WHERE IdFactura = @IdFactura AND Estado = 'Pagada'
        )
        BEGIN
            THROW 60001, 'La factura ya fue pagada.', 1;
        END

        -- Actualizar factura a estado "Pagada"
        UPDATE Facturacion.Factura
        SET Estado = 'Pagada',
            Fecha_Pago = GETDATE()  -- Solo si tenés esta columna
        WHERE IdFactura = @IdFactura;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;

------------------------------Actalizar factura

CREATE OR ALTER PROCEDURE Facturacion.ModificarFactura
    @IdFactura INT,
    @FechaVencimiento VARCHAR(10) = NULL, -- Nueva fecha de vencimiento (opcional)
    @DiasAtrasados INT = NULL,            -- Nuevos días de atraso (opcional)
    @Estado VARCHAR(20) = NULL,           -- Nuevo estado de la factura (opcional)
    @IdDescuento INT = NULL,              -- Nuevo IdDescuento (opcional)
    @IdCuota INT = NULL,                  -- Nuevo IdCuota (opcional)
    @MontoTotal DECIMAL(10,2) = NULL,     -- Nuevo Monto_Total (opcional)
    @Detalle VARCHAR(255) = NULL,         -- Nuevo Detalle de la factura (opcional)
    @FechaEmision VARCHAR(10) = NULL      -- Nueva Fecha_Emision (opcional)
AS
BEGIN
    --SET NOCOUNT ON;  Evita que se devuelvan recuentos de filas afectados por cada sentencia.
 
    -- Declarar variable para verificar la existencia de la factura
    DECLARE @FacturaExiste BIT;
    DECLARE @MensajeError NVARCHAR(4000);
 
    BEGIN TRY
        -- 1. Verificar si la factura existe
        SELECT @FacturaExiste = 1
        FROM Facturacion.Factura
        WHERE IdFactura = @IdFactura;
 
        IF @FacturaExiste IS NULL
        BEGIN
            THROW 50000, 'Error: La factura con el IdFactura especificado no existe.', 1;
        END;
 
        -- 2. Validar FKs si se proporcionan nuevos valores
        IF @IdDescuento IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento)
        BEGIN
            SET @MensajeError = 'Error: El IdDescuento proporcionado (' + CAST(@IdDescuento AS NVARCHAR(10)) + ') no existe.';
            THROW 50000, @MensajeError, 1;
        END;
 
        IF @IdCuota IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Cuota WHERE IdCuota = @IdCuota)
        BEGIN
            SET @MensajeError = 'Error: El IdCuota proporcionado (' + CAST(@IdCuota AS NVARCHAR(10)) + ') no existe.';
            THROW 50000, @MensajeError, 1;
        END;
 
        -- Iniciar transacción para asegurar atomicidad de la actualización
        BEGIN TRANSACTION;
 
        -- 3. Realizar la actualización de la factura
        UPDATE Facturacion.Factura
        SET
            Fecha_Vencimiento = ISNULL(@FechaVencimiento, Fecha_Vencimiento),
            Dias_Atrasados = ISNULL(@DiasAtrasados, Dias_Atrasados),
            Estado = ISNULL(@Estado, Estado),
            IdDescuento = ISNULL(@IdDescuento, IdDescuento),
            IdCuota = ISNULL(@IdCuota, IdCuota),
            Monto_Total = ISNULL(@MontoTotal, Monto_Total),
            Detalle = ISNULL(@Detalle, Detalle),
            Fecha_Emision = ISNULL(@FechaEmision, Fecha_Emision) -- Se agregó el campo Fecha_Emision
        WHERE
            IdFactura = @IdFactura;
 
        COMMIT TRANSACTION; -- Confirmar los cambios si todo fue bien
 
        PRINT 'Factura con IdFactura ' + CAST(@IdFactura AS NVARCHAR(10)) + ' modificada exitosamente.';
 
    END TRY
    BEGIN CATCH
        -- En caso de error, revertir la transacción si está activa
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
 
        -- Capturar y relanzar el error para que la aplicación llamante lo maneje
        SET @MensajeError = ERROR_MESSAGE();
        RAISERROR(@MensajeError, 16, 1);
    END CATCH
END;

go

CREATE or alter PROCEDURE Facturacion.ReembolsoPorLluvia
AS
BEGIN
    SET NOCOUNT ON;
    -- Cargar una tabla temporal
		SELECT 
			p.IdPago,
			p.Monto,
			p.IdMedioDePago,
			p.IdCuenta,
			TRY_CAST(p.Fecha_de_Pago AS DATE) AS FechaConvertida
		INTO #PagosValidos
		FROM Facturacion.Pago p
		WHERE TRY_CAST(p.Fecha_de_Pago AS DATE) IS NOT NULL;
 
    -- Insertar reembolsos por lluvia
    INSERT INTO Facturacion.Reembolso (Modalidad, IdMedioDePago, IdPago, Monto, FechaLLuvia)
    SELECT 
        'Lluvia',  p.IdMedioDePago,  p.IdPago,  CAST(p.Monto * 0.6 AS decimal(10,2)), p.FechaConvertida
    FROM #PagosValidos p
    INNER JOIN Accesos.Dia_Lluvia dl ON p.FechaConvertida = dl.Fecha
    WHERE NOT EXISTS (
        SELECT 1
        FROM Facturacion.Reembolso r
        WHERE r.IdPago = p.IdPago
          AND r.Modalidad = 'Lluvia'
    );
 
    -- Acreditar el saldo a favor SOLO para los pagos que ya tienen reembolso de lluvia
		UPDATE c
		SET c.Saldo_Favor = ISNULL(c.Saldo_Favor, 0) + CAST(p.Monto * 0.6 AS decimal(10,2))
		FROM Socios.Cuenta c
		INNER JOIN #PagosValidos p ON c.IdCuenta = p.IdCuenta
		INNER JOIN Accesos.Dia_Lluvia dl ON p.FechaConvertida = dl.Fecha
		INNER JOIN Facturacion.Reembolso r ON r.IdPago = p.IdPago AND r.Modalidad = 'Lluvia';

	DROP TABLE #PagosValidos;
END;
 
 
CREATE OR ALTER PROCEDURE Facturacion.ReembolsoPorCobro @IdPago BIGINT,  @Monto DECIMAL(10,2),  @Modalidad VARCHAR(30), @FechaLluvia DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdMedioDePago INT;
    DECLARE @IdCuenta INT;

    -- Obtener datos del pago
    SELECT  @IdMedioDePago = IdMedioDePago,  @IdCuenta = IdCuenta
    FROM Facturacion.Pago WHERE IdPago = @IdPago;

    IF @IdMedioDePago IS NOT NULL AND @IdCuenta IS NOT NULL
    BEGIN
        -- Validar que no exista un reembolso previo con la misma modalidad para este pago
        IF NOT EXISTS (
            SELECT 1 FROM Facturacion.Reembolso  WHERE IdPago = @IdPago AND Modalidad = @Modalidad
        )
        BEGIN
            -- Insertar el reembolso
            INSERT INTO Facturacion.Reembolso (Modalidad, IdMedioDePago, IdPago, Monto, FechaLluvia)
            VALUES (@Modalidad, @IdMedioDePago, @IdPago, @Monto, @FechaLluvia);

            -- Acreditar el monto como saldo a favor
            UPDATE Socios.Cuenta  SET Saldo_Favor = ISNULL(Saldo_Favor, 0) + @Monto
            WHERE IdCuenta = @IdCuenta;
        END
        ELSE
        BEGIN
            PRINT 'Ya existe un reembolso con esta modalidad para este pago. No se acreditó nuevamente.';
        END
    END
    ELSE
    BEGIN
        RAISERROR('No se encontró el pago o la cuenta asociada.', 16, 1);
    END
END;
GO
