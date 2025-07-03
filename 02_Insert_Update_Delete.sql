/*ENTREGA 5

*FECHA DE ENTREGA: 20/06/2025
*COMISION:5600
*NUMERO DE GRUPO: 08
*NOMBRE DE LA MATERIA: Base de Datos Aplicadas
*INTEGRANTES: 45318374 | Di Marco Jazm�n
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Roc�o Elizabeth
*/
USE Com5600G08
go 
/**/
CREATE OR ALTER PROCEDURE Socios.InsertarSocio
	@NroSocio VARCHAR(10),
	@Dni INT,
	@Nombre VARCHAR (50),
	@Apellido VARCHAR (50),
	@Email VARCHAR (100),
	@Fecha_Nac DATE,
	@Telf_Contacto VARCHAR (20),
	@Telf_Contacto_Emergencia VARCHAR (20),
	@Nombre_O_Social VARCHAR (50),
	@Nro_Obra_Social VARCHAR (50),
	@IdGrupoFamiliar INT,
	@IdCategoria INT,
	@NroSocio2 VARCHAR(10),
	@Estado VARCHAR (20),
	@Telefono_Emergencia_2 VARCHAR(30)
AS
BEGIN
	INSERT INTO Socios.Socio (NroSocio,Dni, Nombre, Apellido, Email_Personal, Fecha_De_Nacimiento,
							   Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social,
							   Nro_Obra_Social, IdGrupoFamiliar, IdCategoria, NroSocio2, Estado, Telefono_Emergencia_2 )
	
	VALUES (@NroSocio, @Dni, @Nombre, @Apellido, @Email, @Fecha_Nac, @Telf_Contacto, @Telf_Contacto_Emergencia,
			@Nombre_O_Social, @Nro_Obra_Social, @IdGrupoFamiliar, @IdCategoria, @NroSocio2, @Estado, @Telefono_Emergencia_2)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Socios.InsertarGrupoFamiliar 
	@ID_Socio Varchar(10)
AS
BEGIN
	INSERT INTO Socios.GrupoFamiliar (NroSocio)
	VALUES (@Id_Socio)
END;		
GO


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Socios.InsertarCategoria
	@Nombre VARCHAR (50),
	@Costo DECIMAL (10,2),
	@Vigente_Hasta VARCHAR (10),
	@Estado VARCHAR (10)
AS
BEGIN
	INSERT INTO Socios.Categoria(Nombre, Costo, Vigente_Hasta, Estado)
	VALUES (@Nombre, @Costo, @Vigente_Hasta, @Estado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarActividad
	@Nombre VARCHAR (100),
	@Costo DECIMAL (10,2),
	@Vigencia DATE,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO Clases.Actividad (Nombre, Costo, Vigente_Hasta, Estado)
	VALUES (@Nombre, @Costo, @Vigencia, @Estado)
END;
GO


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarProfesor
	@NombreCompleto VARCHAR (100),
	@Email VARCHAR (100),
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO Clases.Profesor (Nombre_Completo, Email_Personal, Estado)
	VALUES (@NombreCompleto, @Email, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarClase
	@Fecha DATE,
	@Hora TIME,
	@Dia VARCHAR (15),
	@Id_Profesor INT,
	@Id_Actividad INT,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO Clases.Clase (Fecha, Hora, Dia, IdProfesor, IdActividad, Estado)
	VALUES (@Fecha, @Hora, @Dia, @Id_Profesor, @Id_Actividad, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarCuota
    @Estado VARCHAR(20),
    @NroSocio VARCHAR(10)
AS
BEGIN
    INSERT INTO Facturacion.Cuota (Estado, NroSocio)
    VALUES (@Estado, @NroSocio);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarDescuento
	@Tipo VARCHAR (50),
	@Id_GrupoFamiliar INT,
	@NroSocio VARCHAR(10),
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO Facturacion.Descuento (Tipo, IdGrupoFamiliar, NroSocio, Estado)
	VALUES (@Tipo, @Id_GrupoFamiliar, @NroSocio, @Estado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarFactura
    @Fecha_Vencimiento DATE,
    @Dias_Atrasados INT,
    @Estado VARCHAR(20),
    @IdDescuento INT,
    @IdCuota INT
AS
BEGIN
    INSERT INTO Facturacion.Factura (Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
    VALUES (@Fecha_Vencimiento, @Dias_Atrasados, @Estado, @IdDescuento, @IdCuota);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Socios.InsertarCuenta
	@SaldoFavor DECIMAL (10,2),
	@NroSocio VARCHAR(10)
AS
BEGIN
	INSERT INTO Socios.Cuenta (Saldo_Favor, NroSocio)
	VALUES (@SaldoFavor, @NroSocio)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarMedioDePago
	@Nombre VARCHAR (50),
	@Tipo VARCHAR (30),
	@Modalidad VARCHAR (30)
AS
BEGIN
	INSERT INTO Facturacion.MedioDePago (Nombre, Tipo, Modalidad)
	VALUES (@Nombre, @Tipo, @Modalidad)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarPago
	@Fecha_de_pago VARCHAR(10),
	@IdCuenta INT,
	@IdFactura INT,
	@IdMedio INT
AS
BEGIN
	INSERT INTO Facturacion.Pago (Fecha_de_pago, IdCuenta, IdFactura, IdMedioDePago)
	VALUES (@Fecha_de_pago, @IdCuenta, @IdFactura, @IdMedio)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Facturacion.InsertarReembolso
	@Modalidad VARCHAR (30),
	@IdMedioDePago INT,
	@IdPago BIGINT
AS
BEGIN
	INSERT INTO Facturacion.Reembolso (Modalidad, IdMedioDePago, IdPago)
	VALUES (@Modalidad, @IdMedioDePago, @IdPAGO)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Accesos.InsertarInvitado
	@Nombre VARCHAR (20),
	@Nro_Socio VARCHAR(10),
	@Id_Factura INT
AS
BEGIN
	INSERT INTO Accesos.Invitado (Nombre, Nro_Socio, IdFactura)
	VALUES (@Nombre, @Nro_Socio, @Id_Factura)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE Accesos.InsertarPasePileta
	@TarifaSocio DECIMAL (10,2),
	@TarifaInvitado DECIMAL (10,2),
	@NroSocio VARCHAR(10),
	@IdInvitado INT
AS
BEGIN
	INSERT INTO Accesos.PasePileta (Tarifa_Socio, Tarifa_Invitado, NroSocio, IdInvitado)
	VALUES (@TarifaSocio, @TarifaInvitado, @NroSocio, @IdInvitado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE Accesos.InsertarActividadExtra
	@Tipo VARCHAR (50)
AS
BEGIN
	INSERT INTO Accesos.ActividadExtra (Tipo)
	VALUES (@Tipo)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE Accesos.InsertarColonia
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
	INSERT INTO Accesos.Colonia (IdActividadExtra, Precio)
	VALUES (@idAct_extra, @Precio)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Accesos.InsertarSum
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
	INSERT INTO Accesos.Sum_Recreativo (IdActividadExtra, Precio)
	VALUES (@idAct_extra, @Precio)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPileta
	@IdActExtra INT,
	@IdPasePileta INT,
	@Fec_Temporada DATE
AS
BEGIN
	INSERT INTO ddbbaTP.Pileta (IdActividadExtra, IdPasePileta, Fec_Temporada)
	VALUES (@IdActExtra, @IdPasePileta, @Fec_Temporada)
END;
GO*/

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarAsiste
	@NroSocio VARCHAR(10),
	@IdClase INT
AS
BEGIN
	INSERT INTO Clases.Asiste (NroSocio, IdClase)
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarAnotadoEn
	@NroSocio VARCHAR(10),
	@IdClase INT
AS
BEGIN
	INSERT INTO Clases.Anotado_En (NroSocio, IdClase)
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Clases.InsertarInscripto
	@NroSocio VARCHAR(10),
	@IdActividad INT
AS
BEGIN
	INSERT INTO Clases.Inscripto (NroSocio, IdActiviDad)
	VALUES (@NroSocio, @IdActividad)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Accesos.InsertarRealiza
	@NroSocio VARCHAR(10),
	@IdActividadExtra INT,
	@Fecha DATE
AS
BEGIN
	INSERT INTO Accesos.Realiza (NroSocio, IdActividadExtra, Fecha)
	VALUES (@NroSocio, @IdActividadExtra, @Fecha)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--Sp Para registrar una clase completa

CREATE OR ALTER PROCEDURE Clases.AltaClaseCompleta
	@NombreProfesor VARCHAR(50),
	@ApellidoProfesor VARCHAR(50),
	@EmailProfesor VARCHAR(100),

	@NombreActividad VARCHAR(100),
	@CostoActividad DECIMAL(10,2),
	@VigenciaActividad DATE,

	@FechaClase DATE,
	@HoraClase TIME,
	@DiaClase VARCHAR(15)
AS
BEGIN
	--Insertar profesor
	EXEC Clases.InsertarProfesor @NombreProfesor, @ApellidoProfesor, @EmailProfesor;

	--Id Maximo, ya que el hacer la insercion el id de profesor aumenta progresivamente
	DECLARE @IdProfesor INT = (SELECT MAX(IdProfesor) FROM Clases.Profesor);

	--Insertar actividad
	EXEC Clases.InsertarActividad @NombreActividad, @CostoActividad, @VigenciaActividad;

	--Id Maximo, ya que el hacer la insercion el id de actividad aumenta progresivamente
	DECLARE @IdActividad INT = (SELECT MAX(IdActividad) FROM Clases.Actividad);

	-- 3. Insertar clase
	EXEC Clases.InsertarClase @FechaClase, @HoraClase, @DiaClase, @IdProfesor, @IdActividad;
END;
GO
------------------------------------------------------------------------------------------>MODIFICACION
-- =============================================
-- STORED PROCEDURES PARA MODIFICACI�N DE DATOS
-- =============================================

-- Procedimiento para modificar un Socio
CREATE PROCEDURE Socios.ModificarSocio
    @NroSocio VARCHAR(10),
    @Dni INT = NULL,
    @Nombre VARCHAR(50) = NULL,
    @Apellido VARCHAR(50) = NULL,
    @Email_Personal VARCHAR(100) = NULL,
    @Telefono_Contacto VARCHAR(20) = NULL,
    @Telef_C_Emergencia VARCHAR(20) = NULL,
    @Nombre_Obra_Social VARCHAR(100) = NULL,
    @Nro_Obra_Social VARCHAR(50) = NULL,
    @IdGrupoFamiliar INT = NULL,
    @IdCategoria INT = NULL,
    @NroSocio2 VARCHAR(10) = NULL,
	@Telefono_Emergencia_2 VARCHAR(30) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar DNI si se proporciona
    IF @Dni IS NOT NULL AND (@Dni < 10000000 OR @Dni > 99999999)
    BEGIN
        RAISERROR('El DNI debe ser un n�mero de 8 d�gitos', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio a cargo exista si se proporciona
    IF @NroSocio2 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio2)
    BEGIN
        RAISERROR('El socio a cargo con n�mero %d no existe', 16, 1, @NroSocio2);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE Socios.Socio
        SET Dni = ISNULL(@Dni, Dni),
            Nombre = ISNULL(@Nombre, Nombre),
            Apellido = ISNULL(@Apellido, Apellido),
            Email_Personal = ISNULL(@Email_Personal, Email_Personal),
            Telefono_Contacto = ISNULL(@Telefono_Contacto, Telefono_Contacto),
            Telef_C_Emergencia = ISNULL(@Telef_C_Emergencia, Telef_C_Emergencia),
            Nombre_Obra_Social = ISNULL(@Nombre_Obra_Social, Nombre_Obra_Social),
            Nro_Obra_Social = ISNULL(@Nro_Obra_Social, Nro_Obra_Social),
            IdGrupoFamiliar = ISNULL(@IdGrupoFamiliar, IdGrupoFamiliar),
            IdCategoria = ISNULL(@IdCategoria, IdCategoria),
            NroSocio2 = ISNULL(@NroSocio2, NroSocio2),
			Telefono_Emergencia_2 = ISNULL(@Telefono_Emergencia_2, Telefono_Emergencia_2)
        WHERE NroSocio = @NroSocio;
        
        PRINT 'Socio modificado correctamente';
    END TRY
    BEGIN CATCH    
        throw;
    END CATCH
END;
GO

--//////////////////////////////////////////////////////////MODIFICAR//////////////////////////////////////////////////////
-- Procedimiento para modificar un Grupo Familiar
CREATE PROCEDURE Socios.ModificarGrupoFamiliar
    @IdGrupoFamiliar INT,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el grupo familiar exista
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE Socios.GrupoFamiliar
        SET NroSocio = ISNULL(@NroSocio, NroSocio)
        WHERE IdGrupoFamiliar = @IdGrupoFamiliar;
        
        PRINT 'Grupo familiar modificado correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Categor�a
CREATE PROCEDURE Socios.ModificarCategoria
    @IdCategoria INT,
    @Nombre VARCHAR(50) = NULL,
    @Costo DECIMAL(10,2) = NULL,
    @Vigente_Hasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la categor�a exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Categoria WHERE IdCategoria = @IdCategoria)
    BEGIN
        RAISERROR('La categor�a con ID %d no existe', 16, 1, @IdCategoria);
        RETURN;
    END
    
    -- Validar costo positivo si se proporciona
    IF @Costo IS NOT NULL AND @Costo < 0
    BEGIN
        RAISERROR('El costo debe ser un valor positivo', 16, 1);
        RETURN;
    END
    -- Set de Valores, verificando si son nulos
    BEGIN TRY        
        UPDATE Socios.Categoria
        SET Nombre = ISNULL(@Nombre, Nombre),
            Costo = ISNULL(@Costo, Costo),
            Vigente_Hasta = ISNULL(@Vigente_Hasta, Vigente_Hasta)
        WHERE IdCategoria = @IdCategoria;
        
        PRINT 'Categor�a modificada correctamente';
    END TRY
    BEGIN CATCH    
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Actividad
CREATE PROCEDURE Clases.ModificarActividad
    @IdActividad INT,
    @Nombre VARCHAR(100) = NULL,
    @Costo DECIMAL(10,2) = NULL,
    @Vigente_Hasta DATE = NULL,
    @IdAct INT = NULL,
    @IdCategoria INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    -- Validar que la actividad exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad con ID %d no existe', 16, 1, @IdActividad);
        RETURN;
    END
    -- Validar costo positivo si se proporciona
    IF @Costo IS NOT NULL AND @Costo < 0
    BEGIN
        RAISERROR('El costo debe ser un valor positivo', 16, 1);
        RETURN;
    END
    -- Validar que la categor�a exista si se proporciona
    IF @IdCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Categoria WHERE IdCategoria = @IdCategoria)
    BEGIN
        RAISERROR('La categor�a con ID %d no existe', 16, 1, @IdCategoria);
        RETURN;
    END
    -- Validar que la actividad padre exista si se proporciona
    IF @IdAct IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdAct)
    BEGIN
        RAISERROR('La actividad padre con ID %d no existe', 16, 1, @IdAct);
        RETURN;
    END
    BEGIN TRY
        UPDATE Clases.Actividad
        SET Nombre = ISNULL(@Nombre, Nombre),
            Costo = ISNULL(@Costo, Costo),
            Vigente_Hasta = ISNULL(@Vigente_Hasta, Vigente_Hasta)
        WHERE IdActividad = @IdActividad;
        
        PRINT 'Actividad modificada correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar un Profesor
CREATE PROCEDURE Clases.ModificarProfesor
    @IdProfesor INT,
    @Nombre VARCHAR(50) = NULL,
    @Apellido VARCHAR(50) = NULL,
    @Email_Personal VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el profesor exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Profesor WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Clases.Profesor
        SET Nombre_Completo = ISNULL(@Nombre, Nombre_Completo),
            Email_Personal = ISNULL(@Email_Personal, Email_Personal)
        WHERE IdProfesor = @IdProfesor;
        
        PRINT 'Profesor modificado correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Clase
CREATE PROCEDURE Clases.ModificarClase
    @IdClase INT,
    @Fecha DATE = NULL,
    @Hora TIME = NULL,
    @Dia VARCHAR(15) = NULL,
    @IdProfesor INT = NULL,
    @IdActividad INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la clase exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase con ID %d no existe', 16, 1, @IdClase);
        RETURN;
    END
    
    -- Validar fecha si se proporciona
    IF @Fecha IS NOT NULL AND @Fecha < '2000-01-01'
    BEGIN
        RAISERROR('La fecha debe ser posterior al 01/01/2000', 16, 1);
        RETURN;
    END
    
    -- Validar que el profesor exista si se proporciona
    IF @IdProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Profesor WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    -- Validar que la actividad exista si se proporciona
    IF @IdActividad IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad con ID %d no existe', 16, 1, @IdActividad);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE Clases.Clase
        SET Fecha = ISNULL(@Fecha, Fecha),
            Hora = ISNULL(@Hora, Hora),
            Dia = ISNULL(@Dia, Dia),
            IdProfesor = ISNULL(@IdProfesor, IdProfesor),
            IdActividad = ISNULL(@IdActividad, IdActividad)
        WHERE IdClase = @IdClase;
      
        PRINT 'Clase modificada correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Cuota
CREATE PROCEDURE Socios.ModificarCuota
    @IdCuota INT,
    @Estado VARCHAR(20) = NULL,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la cuota exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Cuota WHERE IdCuota = @IdCuota)
    BEGIN
        RAISERROR('La cuota con ID %d no existe', 16, 1, @IdCuota);
        RETURN;
    END
    
    -- Validar estado si se proporciona
    IF @Estado IS NOT NULL AND @Estado NOT IN ('Pendiente', 'Pagada', 'Vencida')
    BEGIN
        RAISERROR('El estado debe ser: Pendiente, Pagada o Vencida', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Socios.Cuota
        SET Estado = ISNULL(@Estado, Estado),
            NroSocio = ISNULL(@NroSocio, NroSocio)
        WHERE IdCuota = @IdCuota;
        
        PRINT 'Cuota modificada correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar un Descuento
CREATE PROCEDURE Facturacion.ModificarDescuento
    @IdDescuento INT,
    @Tipo VARCHAR(50) = NULL,
    @Porcentaje DECIMAL(5,2) = NULL,
    @IdGrupoFamiliar INT = NULL,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el descuento exista
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento)
    BEGIN
        RAISERROR('El descuento con ID %d no existe', 16, 1, @IdDescuento);
        RETURN;
    END
    
    -- Validar porcentaje si se proporciona
    IF @Porcentaje IS NOT NULL AND (@Porcentaje < 0 OR @Porcentaje > 100)
    BEGIN
        RAISERROR('El porcentaje debe estar entre 0 y 100', 16, 1);
        RETURN;
    END
    
    -- Validar que al menos uno (grupo familiar o socio) tenga valor
    IF (@IdGrupoFamiliar IS NULL AND @NroSocio IS NULL) AND
       ((SELECT IdGrupoFamiliar FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento) IS NULL AND
        (SELECT NroSocio FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento) IS NULL)
    BEGIN
        RAISERROR('Debe especificar al menos un grupo familiar o un socio', 16, 1);
        RETURN;
    END
    
    -- Validar que el grupo familiar exista si se proporciona
    IF @IdGrupoFamiliar IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Facturacion.Descuento
        SET Tipo = ISNULL(@Tipo, Tipo),
            Porcentaje = ISNULL(@Porcentaje, Porcentaje),
            IdGrupoFamiliar = ISNULL(@IdGrupoFamiliar, IdGrupoFamiliar),
            NroSocio = ISNULL(@NroSocio, NroSocio)
        WHERE IdDescuento = @IdDescuento;
        PRINT 'Descuento modificado correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO
-- Procedimiento para modificar una Actividad Extra
CREATE PROCEDURE Accesos.ModificarActividadExtra
	@IdActExtra INT,
	@Tipo VARCHAR(50)=NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Validar que la actividad extra exista
	IF NOT EXISTS (SELECT 1 FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActExtra)
    BEGIN
        RAISERROR('La Actividad Extra con ID %d no existe', 16, 1, @IdActExtra);
        RETURN;
    END

	BEGIN TRY
		UPDATE Accesos.ActividadExtra
		SET	Tipo = ISNULL(@Tipo, Tipo)
		WHERE IdActExtra = @IdActExtra;
		PRINT 'Actividad Extra modificada correctamente';
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH
END;
GO
-- Procedimiento para modificar una Colonia
CREATE PROCEDURE Accesos.ModificarColonia
	@IdActExtra INT,
	@Precio DECIMAL(10,2),
	@FechaInicio DATE,
	@FechaFin DATE
AS
BEGIN
	SET NOCOUNT ON;

	-- Verificar que la actividad exista
	IF NOT EXISTS (SELECT 1 FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActExtra)
	BEGIN
		RAISERROR('La actividad con ID %d no existe.', 16, 1, @IdActExtra);
		RETURN;
	END;

	-- Verificar que el precio no sea negativo
	IF @Precio < 0
	BEGIN
		RAISERROR('El precio no puede ser negativo.', 16, 1);
		RETURN;
	END;

	-- Verificar que las fechas sean v�lidas
	IF @FechaInicio IS NULL OR @FechaFin IS NULL
	BEGIN
		RAISERROR('La fecha de inicio y fin no pueden ser nulas.', 16, 1);
		RETURN;
	END;

	-- Verificar que la fecha de fin no sea anterior a la de inicio
	IF @FechaFin < @FechaInicio
	BEGIN
		RAISERROR('La fecha de fin no puede ser anterior a la de inicio.', 16, 1);
		RETURN;
	END
	BEGIN TRY
		UPDATE Accesos.Colonia
		SET Precio = ISNULL(@Precio, Precio),
			FechaFin = ISNULL(@FechaFin, FechaFin),
			FechaInicio = ISNULL(@FechaInicio, FechaInicio)
		WHERE @IdActExtra = IdActividadExtra;
		PRINT 'Colonia modificada correctamente';
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END;
GO
-- Procedimiento para modificar una Factura
CREATE PROCEDURE Facturacion.ModificarFactura
    @IdFactura INT,
    @FechaVencimiento DATE,
    @DiasAtrasados INT,
    @Estado VARCHAR(20) = NULL,
    @IdCuota INT = NULL,
    @IdDescuento INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que la factura exista
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
    BEGIN
        RAISERROR('La factura con ID %d no existe.', 16, 1, @IdFactura);
        RETURN;
    END

    -- Validar que la fecha de vencimiento no sea nula
    IF @FechaVencimiento IS NULL
    BEGIN
        RAISERROR('La fecha de vencimiento no puede ser nula.', 16, 1);
        RETURN;
    END

    -- Validar que los d�as atrasados no sean negativos
    IF @DiasAtrasados < 0
    BEGIN
        RAISERROR('Los d�as atrasados no pueden ser negativos.', 16, 1);
        RETURN;
    END

    -- Validar estado si se proporciona (ejemplo: solo valores permitidos)
    IF @Estado IS NOT NULL AND @Estado NOT IN ('Pendiente', 'Pagada', 'Anulada')
    BEGIN
        RAISERROR('Estado inv�lido. Debe ser Pendiente, Pagada o Anulada.', 16, 1);
        RETURN;
    END

    -- Validar que la cuota exista si se proporciona
    IF @IdCuota IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Cuota WHERE IdCuota = @IdCuota)
    BEGIN
        RAISERROR('La cuota con ID %d no existe.', 16, 1, @IdCuota);
        RETURN;
    END

    -- Validar que el descuento exista si se proporciona
    IF @IdDescuento IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento)
    BEGIN
        RAISERROR('El descuento con ID %d no existe.', 16, 1, @IdDescuento);
        RETURN;
    END

    BEGIN TRY
        -- Actualizar la factura
        UPDATE Facturacion.Factura
        SET Fecha_Vencimiento = @FechaVencimiento,
            Dias_Atrasados = @DiasAtrasados,
            Estado = ISNULL(@Estado, Estado),
            IdCuota = ISNULL(@IdCuota, IdCuota),
            IdDescuento = ISNULL(@IdDescuento, IdDescuento)
        WHERE IdFactura = @IdFactura;

        PRINT 'Factura modificada correctamente.';
    END TRY
    BEGIN CATCH
        -- Manejo b�sico del error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al modificar la factura: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
-- Procedimiento para modificar un Anotado en
CREATE PROCEDURE Clases.ModificarAnotadoEn
    @NroSocio VARCHAR(10),
    @IdClase INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la inscripci�n exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase)
    BEGIN
        RAISERROR('No existe una inscripci�n del socio %d en la clase %d', 16, 1, @NroSocio, @IdClase);
        RETURN;
    END
    
    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que la clase exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase con ID %d no existe', 16, 1, @IdClase);
        RETURN;
    END
    
    -- Validar fecha de inscripci�n si se proporciona
    IF @FechaInscripcion IS NOT NULL AND @FechaInscripcion > GETDATE()
    BEGIN
        RAISERROR('La fecha de inscripci�n no puede ser futura', 16, 1);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Clases.Anotado_En
        SET FechaInscripcion = ISNULL(@FechaInscripcion, FechaInscripcion) 
        WHERE NroSocio = @NroSocio AND IdClase = @IdClase;
        
        PRINT 'Inscripci�n modificada correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Inscripto
CREATE PROCEDURE Clases.ModificarInscripto
    @NroSocio VARCHAR(10),
    @IdActividad INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la actividad exista
    IF NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad con ID %d no existe.', 16, 1, @IdActividad);
        RETURN;
    END

    -- Validar que exista la inscripci�n (suponiendo tabla Inscripcion con esa relaci�n)
    IF NOT EXISTS (
        SELECT 1 FROM Clases.Inscripto
        WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
    )
    BEGIN
        RAISERROR('La inscripci�n para el socio %d en la actividad %d no existe.', 16, 1, @NroSocio, @IdActividad);
        RETURN;
    END

    -- Validar FechaInscripcion si se pasa, que no sea futura
    IF @FechaInscripcion IS NOT NULL AND @FechaInscripcion > GETDATE()
    BEGIN
        RAISERROR('La fecha de inscripci�n no puede ser futura.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE Clases.Inscripto
        SET FechaInscripcion = ISNULL(@FechaInscripcion, FechaInscripcion)
        WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad;

        PRINT 'Inscripci�n modificada correctamente.';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Invitado
CREATE PROCEDURE Accesos.ModificarInvitado
    @IdInvitado INT,
    @Nombre VARCHAR(50),
    @Dni INT = NULL,
    @NroSocio VARCHAR(10),
    @IdFactura INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el invitado exista
    IF NOT EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado)
    BEGIN
        RAISERROR('El invitado con ID %d no existe.', 16, 1, @IdInvitado);
        RETURN;
    END

    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la factura exista
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
    BEGIN
        RAISERROR('La factura con ID %d no existe.', 16, 1, @IdFactura);
        RETURN;
    END

    -- Validar DNI si se proporciona (8 d�gitos)
    IF @Dni IS NOT NULL AND (@Dni < 10000000 OR @Dni > 99999999)
    BEGIN
        RAISERROR('El DNI debe ser un n�mero de 8 d�gitos.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE Accesos.Invitado
        SET Nombre = @Nombre,
            Dni = ISNULL(@Dni, Dni),
            Nro_Socio = @NroSocio,
            IdFactura = @IdFactura
        WHERE IdInvitado = @IdInvitado;

        PRINT 'Invitado modificado correctamente.';
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END;
GO
-- Procedimiento para modificar un Medio de Pago
CREATE PROCEDURE Facturacion.ModificarMedioDePago
    @IdMedioPago INT,
    @Nombre VARCHAR(50),
    @Tipo VARCHAR(30),
    @Modalidad VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el medio de pago exista
    IF NOT EXISTS (SELECT 1 FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioPago)
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe.', 16, 1, @IdMedioPago);
        RETURN;
    END

    -- Validar que no est�n vac�os los par�metros obligatorios (error t�pico que a veces no se valida)
    IF (@Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = '')
    BEGIN
        RAISERROR('El nombre no puede estar vac�o.', 16, 1);
        RETURN;
    END
    IF (@Tipo IS NULL OR LTRIM(RTRIM(@Tipo)) = '')
    BEGIN
        RAISERROR('El tipo no puede estar vac�o.', 16, 1);
        RETURN;
    END
    IF (@Modalidad IS NULL OR LTRIM(RTRIM(@Modalidad)) = '')
    BEGIN
        RAISERROR('La modalidad no puede estar vac�a.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE Facturacion.MedioDePago
        SET Nombre = @Nombre,
            Tipo = @Tipo,
            Modalidad = @Modalidad
        WHERE IdMedioPago = @IdMedioPago;

        PRINT 'Medio de pago modificado correctamente.';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Pago
CREATE PROCEDURE Facturacion.ModificarPago
    @IdPago BIGINT,
    @FechaPago VARCHAR(10) = NULL,
    @Monto DECIMAL(10,2) = NULL,
    @IdCuenta INT = NULL,
    @IdFactura INT = NULL,
    @IdMedioDePago INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el pago exista
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdPago = @IdPago)
    BEGIN
        RAISERROR('El pago con ID %d no existe', 16, 1, @IdPago);
        RETURN;
    END
    
    -- Validar fecha si se proporciona
    IF @FechaPago IS NOT NULL AND @FechaPago < '2000-01-01'
    BEGIN
        RAISERROR('La fecha debe ser posterior al 01/01/2000', 16, 1);
        RETURN;
    END
    
    -- Validar monto positivo si se proporciona
    IF @Monto IS NOT NULL AND @Monto <= 0
    BEGIN
        RAISERROR('El monto debe ser un valor positivo', 16, 1);
        RETURN;
    END
    
    -- Validar que la cuenta exista si se proporciona
    IF @IdCuenta IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Cuenta WHERE IdCuenta = @IdCuenta)
    BEGIN
        RAISERROR('La cuenta con ID %d no existe', 16, 1, @IdCuenta);
        RETURN;
    END
    
    -- Validar que la factura exista si se proporciona
    IF @IdFactura IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
    BEGIN
        RAISERROR('La factura con ID %d no existe', 16, 1, @IdFactura);
        RETURN;
    END
    
    -- Validar que el medio de pago exista si se proporciona
    IF @IdMedioDePago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioDePago)
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe', 16, 1, @IdMedioDePago);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Facturacion.Pago
        SET Fecha_de_Pago = ISNULL(@FechaPago, Fecha_de_Pago),
            Monto = ISNULL(@Monto, Monto),
            IdCuenta = ISNULL(@IdCuenta, IdCuenta),
            IdFactura = ISNULL(@IdFactura, IdFactura),
            IdMedioDePago = ISNULL(@IdMedioDePago, IdMedioDePago)
        WHERE IdPago = @IdPago;
        
        PRINT 'Pago modificado correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Pase a Pileta
CREATE PROCEDURE Accesos.ModificarPasePileta
    @IdPasePileta INT,
    @TarifaSocio DECIMAL(10,2) = NULL,
    @TarifaInvitado DECIMAL(10,2) = NULL,
    @NroSocio VARCHAR(10) = NULL,
    @IdInvitado INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el pase de pileta exista
    IF NOT EXISTS (SELECT 1 FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta)
    BEGIN
        RAISERROR('El pase de pileta con ID %d no existe', 16, 1, @IdPasePileta);
        RETURN;
    END
    
    -- Validar tarifas positivas si se proporcionan
    IF @TarifaSocio IS NOT NULL AND @TarifaSocio < 0
    BEGIN
        RAISERROR('La tarifa para socio debe ser un valor positivo', 16, 1);
        RETURN;
    END
    
    IF @TarifaInvitado IS NOT NULL AND @TarifaInvitado < 0
    BEGIN
        RAISERROR('La tarifa para invitado debe ser un valor positivo', 16, 1);
        RETURN;
    END
    
    -- Validar que al menos uno (socio o invitado) tenga valor
    IF (@NroSocio IS NULL AND @IdInvitado IS NULL) AND
       ((SELECT NroSocio FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL AND
        (SELECT IdInvitado FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL)
    BEGIN
        RAISERROR('Debe especificar al menos un socio o un invitado', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
    BEGIN
        RAISERROR('El socio con n�mero %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que el invitado exista si se proporciona
    IF @IdInvitado IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado)
    BEGIN
        RAISERROR('El invitado con ID %d no existe', 16, 1, @IdInvitado);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE Accesos.PasePileta
        SET Tarifa_Socio = ISNULL(@TarifaSocio, Tarifa_Socio),
            Tarifa_Invitado = ISNULL(@TarifaInvitado, Tarifa_Invitado),
            NroSocio = ISNULL(@NroSocio, NroSocio),
            IdInvitado = ISNULL(@IdInvitado, IdInvitado)
        WHERE IdPasePileta = @IdPasePileta;
        
        PRINT 'Pase de pileta modificado correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO


-- Procedimiento para modificar una Pileta
/*
CREATE PROCEDURE ddbbaTP.ModificarPileta
    @IdActividadExtra INT,
    @IdPasePileta INT = NULL,
    @FechaTemporada DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la entrada de pileta exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Pileta WHERE IdActividadExtra = @IdActividadExtra)
    BEGIN
        RAISERROR('La entrada de pileta con ID de actividad extra %d no existe', 16, 1, @IdActividadExtra);
        RETURN;
    END
    
    -- Validar que el pase de pileta exista si se proporciona
    IF @IdPasePileta IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta)
    BEGIN
        RAISERROR('El pase de pileta con ID %d no existe', 16, 1, @IdPasePileta);
        RETURN;
    END
    
    -- Validar fecha de temporada si se proporciona
    IF @FechaTemporada IS NOT NULL AND @FechaTemporada < '2000-01-01'
    BEGIN
        RAISERROR('La fecha de temporada debe ser posterior al 01/01/2000', 16, 1);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Pileta
        SET IdPasePileta = ISNULL(@IdPasePileta, IdPasePileta),
            Fec_Temporada = ISNULL(@FechaTemporada, Fec_Temporada)
        WHERE IdActividadExtra = @IdActividadExtra;
        
        PRINT 'Datos de pileta modificados correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Reembolso
CREATE PROCEDURE ddbbaTP.ModificarReembolso
    @IdReembolso INT,
    @Modalidad VARCHAR(30) = NULL,
    @Monto DECIMAL(10,2) = NULL,
    @IdMedioDePago INT = NULL,
    @IdPago BIGINT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el reembolso exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Reembolso WHERE IdReembolso = @IdReembolso)
    BEGIN
        RAISERROR('El reembolso con ID %d no existe', 16, 1, @IdReembolso);
        RETURN;
    END
    
    -- Validar monto positivo si se proporciona
    IF @Monto IS NOT NULL AND @Monto <= 0
    BEGIN
        RAISERROR('El monto debe ser un valor positivo mayor que cero', 16, 1);
        RETURN;
    END
    
    -- Validar que el medio de pago exista si se proporciona
    IF @IdMedioDePago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioDePago)
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe', 16, 1, @IdMedioDePago);
        RETURN;
    END
    
    -- Validar que el pago exista si se proporciona
    IF @IdPago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdPago = @IdPago)
    BEGIN
        RAISERROR('El pago con ID %d no existe', 16, 1, @IdPago);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Reembolso
        SET Modalidad = ISNULL(@Modalidad, Modalidad),
            Monto = ISNULL(@Monto, Monto),
            IdMedioDePago = ISNULL(@IdMedioDePago, IdMedioDePago),
            IdPago = ISNULL(@IdPago, IdPago)
        WHERE IdReembolso = @IdReembolso;
        
        PRINT 'Reembolso modificado correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO*/
------------------------------------------------------------------------------------>BORRADO
CREATE PROCEDURE Socios.BorrarSocio 
    @Nro_Socio VARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (select 1 from ddbbaTP.Socio where NroSocio=@Nro_Socio)
    BEGIN 
        RAISERROR('El socio %d no existe',16,1, @Nro_Socio);
        RETURN;
    END
    UPDATE ddbbaTP.Socio SET Estado='Inactivo' where NroSocio=@Nro_Socio;
END
GO

-- Borrar Grupo Familiar si no tiene socios activos asociados
CREATE PROCEDURE Socios.BorrarGrupoFamiliar
    @IdGrupoFamiliar INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Socios.Socio WHERE IdGrupoFamiliar = @IdGrupoFamiliar AND Estado = 'Activo')
    BEGIN
        RAISERROR('El grupo familiar tiene socios activos.', 16, 1);
        RETURN;
    END

    DELETE Socios.GrupoFamiliar where IdGrupoFamiliar= @IdGrupoFamiliar
END
GO

-- Borrar ActividadExtra
CREATE PROCEDURE Accesos.BorrarActividadExtra
    @IdActividadExtra INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Accesos.Realiza where IdActividadExtra = @IdActividadExtra)
    BEGIN
        RAISERROR('No se puede eliminar la actividad extra. Est� asociada a registros.', 16, 1)
        RETURN
    END
    DELETE FROM Accesos.Colonia WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.Sum_Recreativo WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.Pileta WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActividadExtra
END
GO

-- Borrar Factura (Borrado l�gico)
CREATE PROCEDURE Facturacion.BorrarFactura
    @IdFactura INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura where IdFactura = @IdFactura)
    BEGIN
        RAISERROR('Factura no encontrada.', 16, 1)
        RETURN
    END
    UPDATE Facturacion.Factura 
    SET Estado = 'Inactivo' where IdFactura = @IdFactura
END
GO

-- Borrar Invitado
CREATE PROCEDURE Accesos.BorrarInvitado
    @IdInvitado INT
AS
BEGIN
    DELETE FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado
END
GO

-- Borrar Categoria
CREATE PROCEDURE Socios.BorrarCategoria
    @IdCategoria INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Socios.Socio WHERE IdCategoria = @IdCategoria)
    BEGIN
        RAISERROR('La categor�a est� asociada a socios.', 16, 1)
        RETURN
    END
     UPDATE Socios.Categoria 
    SET Estado = 'Inactivo' where IdCategoria = @IdCategoria
END
GO

-- Borrado l�gico en Actividad
CREATE PROCEDURE Clases.BorrarActividad
    @IdActividad INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clases.Inscripto WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad tiene socios inscriptos.', 16, 1)
        RETURN
    END
    UPDATE Clases.Actividad
    SET Estado = 'Inactivo' where IdActividad = @IdActividad
END
GO

-- Borrado l�gico en clase si no tiene socios anotados ni que asistan
CREATE PROCEDURE Clases.BorrarClase
    @IdClase INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase no existe.', 16, 1)
        RETURN
    END

    IF EXISTS (SELECT 1 FROM Clases.Anotado_En where IdClase = @IdClase) OR
       EXISTS (SELECT 1 FROM Clases.Asiste where IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase tiene socios anotados o asistentes.', 16, 1)
        RETURN
    END
    UPDATE Clases.Clase
    SET Estado = 'Inactivo' where IdClase = @IdClase
END
GO

-- Borrado l�gico profesor si no dicta clases 
CREATE PROCEDURE Clases.BorrarProfesor
    @IdProfesor INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clases.Clase WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('No se puede eliminar el profesor porque dicta clases.', 16, 1)
        RETURN
    END
    UPDATE Clases.Profesor
    SET Estado = 'Inactivo' where IdProfesor = @IdProfesor
END
GO

-- Borrar Cuota 
CREATE PROCEDURE Facturacion.BorrarCuota
    @IdCuota INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdCuota = @IdCuota)
    BEGIN
        RAISERROR('La cuota est� asociada a una factura.', 16, 1)
        RETURN
    END
    DELETE FROM Facturacion.Cuota WHERE IdCuota = @IdCuota
END
GO

-- Borrado l�gico en Descuento
CREATE PROCEDURE Facturacion.BorrarDescuento
    @IdDescuento INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdDescuento = @IdDescuento)
    BEGIN
        RAISERROR('El descuento est� asociado a una factura.', 16, 1)
        RETURN
    END
    UPDATE Facturacion.Descuento
    SET Estado = 'Inactivo' where IdDescuento = @IdDescuento
END
GO

-- Borrar Pago solo si no tiene un reembolso
CREATE PROCEDURE Facturacion.BorrarPago
    @IdPago BIGINT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Reembolso where IdPago = @IdPago)
    BEGIN
        RAISERROR('El pago tiene un reembolso asociado.', 16, 1)
        RETURN
    END
    DELETE FROM Facturacion.Pago where IdPago = @IdPago
END
GO

-- Borrar Cuenta si no tiene ningun pago
CREATE PROCEDURE Socios.BorrarCuenta
    @IdCuenta INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdCuenta = @IdCuenta)
    BEGIN
        RAISERROR('La cuenta tiene pagos registrados.', 16, 1)
        RETURN
    END
    DELETE FROM Socios.Cuenta WHERE IdCuenta = @IdCuenta
END
GO

-- Borrar Medio de Pago si no tiene pagos ni reembolsos
CREATE PROCEDURE Facturacion.BorrarMedioDePago
    @IdMedioDePago INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdMedioDePago = @IdMedioDePago)
        OR EXISTS (SELECT 1 FROM Facturacion.Reembolso WHERE IdMedioDePago = @IdMedioDePago)
    BEGIN
        RAISERROR('El medio de pago est� en uso.', 16, 1)
        RETURN
    END
    DELETE FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioDePago
END
GO

-- Borrar Reembolso
CREATE PROCEDURE Facturacion.BorrarReembolso
    @IdReembolso INT
AS
BEGIN
    DELETE FROM Facturacion.Reembolso WHERE IdReembolso = @IdReembolso
END
GO

-- Borrar Pase Pileta
CREATE PROCEDURE Accesos.BorrarPasePileta
    @IdPasePileta INT
AS
BEGIN
    DELETE FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta
END
GO

-- Borrar Asiste
CREATE PROCEDURE Clases.BorrarAsiste
    @NroSocio VARCHAR(10),
    @IdClase INT
AS
BEGIN
    DELETE FROM Clases.Asiste WHERE NroSocio = @NroSocio AND IdClase = @IdClase
END
GO
 
-- Borrar Anotado_En
CREATE PROCEDURE Clases.BorrarAnotado
    @NroSocio VARCHAR(10),
    @IdClase INT
AS
BEGIN
    DELETE FROM Clases.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase
END
GO

-- Borrar Inscripto
CREATE PROCEDURE Clases.BorrarInscripto
    @NroSocio VARCHAR(10),
    @IdActividad INT
AS
BEGIN
    DELETE FROM Clases.Inscripto WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
END
GO

-- Borrar Realiza
CREATE PROCEDURE Accesos.BorrarRealiza
    @NroSocio VARCHAR(10),
    @IdActividadExtra INT
AS
BEGIN
    DELETE FROM Accesos.Realiza WHERE NroSocio = @NroSocio AND IdActividadExtra = @IdActividadExtra
END
GO

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