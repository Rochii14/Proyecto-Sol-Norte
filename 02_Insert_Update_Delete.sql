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
/**/
<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Socios.InsertarSocio
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarSocio
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
	INSERT INTO Socios.Socio (NroSocio,Dni, Nombre, Apellido, Email_Personal, Fecha_De_Nacimiento,
=======
	INSERT INTO ddbbaTP.Socio (NroSocio,Dni, Nombre, Apellido, Email_Personal, Fecha_De_Nacimiento,
>>>>>>> recuperar-historial
							   Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social,
							   Nro_Obra_Social, IdGrupoFamiliar, IdCategoria, NroSocio2, Estado, Telefono_Emergencia_2 )
	
	VALUES (@NroSocio, @Dni, @Nombre, @Apellido, @Email, @Fecha_Nac, @Telf_Contacto, @Telf_Contacto_Emergencia,
			@Nombre_O_Social, @Nro_Obra_Social, @IdGrupoFamiliar, @IdCategoria, @NroSocio2, @Estado, @Telefono_Emergencia_2)
END;
<<<<<<< HEAD
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE Socios.InsertarGrupoFamiliar 
	@ID_Socio Varchar(10)
AS
BEGIN
	INSERT INTO Socios.GrupoFamiliar (NroSocio)
=======

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
go
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarGrupoFamiliar 
	@ID_Socio Varchar(10)
AS
BEGIN
	INSERT INTO ddbbaTP.GrupoFamiliar (NroSocio)
>>>>>>> recuperar-historial
	VALUES (@Id_Socio)
END;		
GO


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
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
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividad
>>>>>>> recuperar-historial
	@Nombre VARCHAR (100),
	@Costo DECIMAL (10,2),
	@Vigencia DATE,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Actividad (Nombre, Costo, Vigente_Hasta, Estado)
=======
	INSERT INTO ddbbaTP.Actividad (Nombre, Costo, Vigente_Hasta, Estado)
>>>>>>> recuperar-historial
	VALUES (@Nombre, @Costo, @Vigencia, @Estado)
END;
GO


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.InsertarProfesor
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarProfesor
>>>>>>> recuperar-historial
	@NombreCompleto VARCHAR (100),
	@Email VARCHAR (100),
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Profesor (Nombre_Completo, Email_Personal, Estado)
=======
	INSERT INTO ddbbaTP.Profesor (Nombre_Completo, Email_Personal, Estado)
>>>>>>> recuperar-historial
	VALUES (@NombreCompleto, @Email, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.InsertarClase
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarClase
>>>>>>> recuperar-historial
	@Fecha DATE,
	@Hora TIME,
	@Dia VARCHAR (15),
	@Id_Profesor INT,
	@Id_Actividad INT,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Clase (Fecha, Hora, Dia, IdProfesor, IdActividad, Estado)
=======
	INSERT INTO ddbbaTP.Clase (Fecha, Hora, Dia, IdProfesor, IdActividad, Estado)
>>>>>>> recuperar-historial
	VALUES (@Fecha, @Hora, @Dia, @Id_Profesor, @Id_Actividad, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarCuota
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarCuota
>>>>>>> recuperar-historial
    @Estado VARCHAR(20),
    @NroSocio VARCHAR(10)
AS
BEGIN
<<<<<<< HEAD
    INSERT INTO Facturacion.Cuota (Estado, NroSocio)
=======
    INSERT INTO ddbbaTP.Cuota (Estado, NroSocio)
>>>>>>> recuperar-historial
    VALUES (@Estado, @NroSocio);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarDescuento
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarDescuento
>>>>>>> recuperar-historial
	@Tipo VARCHAR (50),
	@Id_GrupoFamiliar INT,
	@NroSocio VARCHAR(10),
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Facturacion.Descuento (Tipo, IdGrupoFamiliar, NroSocio, Estado)
=======
	INSERT INTO ddbbaTP.Descuento (Tipo, IdGrupoFamiliar, NroSocio, Estado)
>>>>>>> recuperar-historial
	VALUES (@Tipo, @Id_GrupoFamiliar, @NroSocio, @Estado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarFactura
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarFactura
>>>>>>> recuperar-historial
    @Fecha_Vencimiento DATE,
    @Dias_Atrasados INT,
    @Estado VARCHAR(20),
    @IdDescuento INT,
    @IdCuota INT
AS
BEGIN
<<<<<<< HEAD
    INSERT INTO Facturacion.Factura (Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
=======
    INSERT INTO ddbbaTP.Factura (Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
>>>>>>> recuperar-historial
    VALUES (@Fecha_Vencimiento, @Dias_Atrasados, @Estado, @IdDescuento, @IdCuota);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Socios.InsertarCuenta
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarCuenta
>>>>>>> recuperar-historial
	@SaldoFavor DECIMAL (10,2),
	@NroSocio VARCHAR(10)
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Socios.Cuenta (Saldo_Favor, NroSocio)
=======
	INSERT INTO ddbbaTP.Cuenta (Saldo_Favor, NroSocio)
>>>>>>> recuperar-historial
	VALUES (@SaldoFavor, @NroSocio)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarMedioDePago
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarMedioDePago
>>>>>>> recuperar-historial
	@Nombre VARCHAR (50),
	@Tipo VARCHAR (30),
	@Modalidad VARCHAR (30)
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Facturacion.MedioDePago (Nombre, Tipo, Modalidad)
=======
	INSERT INTO ddbbaTP.MedioDePago (Nombre, Tipo, Modalidad)
>>>>>>> recuperar-historial
	VALUES (@Nombre, @Tipo, @Modalidad)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarPago
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPago
>>>>>>> recuperar-historial
	@Fecha_de_pago VARCHAR(10),
	@IdCuenta INT,
	@IdFactura INT,
	@IdMedio INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Facturacion.Pago (Fecha_de_pago, IdCuenta, IdFactura, IdMedioDePago)
=======
	INSERT INTO ddbbaTP.Pago (Fecha_de_pago, IdCuenta, IdFactura, IdMedioDePago)
>>>>>>> recuperar-historial
	VALUES (@Fecha_de_pago, @IdCuenta, @IdFactura, @IdMedio)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Facturacion.InsertarReembolso
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarReembolso
>>>>>>> recuperar-historial
	@Modalidad VARCHAR (30),
	@IdMedioDePago INT,
	@IdPago BIGINT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Facturacion.Reembolso (Modalidad, IdMedioDePago, IdPago)
=======
	INSERT INTO ddbbaTP.Reembolso (Modalidad, IdMedioDePago, IdPago)
>>>>>>> recuperar-historial
	VALUES (@Modalidad, @IdMedioDePago, @IdPAGO)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarInvitado
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarInvitado
>>>>>>> recuperar-historial
	@Nombre VARCHAR (20),
	@Nro_Socio VARCHAR(10),
	@Id_Factura INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Accesos.Invitado (Nombre, Nro_Socio, IdFactura)
=======
	INSERT INTO ddbbaTP.Invitado (Nombre, Nro_Socio, IdFactura)
>>>>>>> recuperar-historial
	VALUES (@Nombre, @Nro_Socio, @Id_Factura)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarPasePileta
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPasePileta
>>>>>>> recuperar-historial
	@TarifaSocio DECIMAL (10,2),
	@TarifaInvitado DECIMAL (10,2),
	@NroSocio VARCHAR(10),
	@IdInvitado INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Accesos.PasePileta (Tarifa_Socio, Tarifa_Invitado, NroSocio, IdInvitado)
=======
	INSERT INTO ddbbaTP.PasePileta (Tarifa_Socio, Tarifa_Invitado, NroSocio, IdInvitado)
>>>>>>> recuperar-historial
	VALUES (@TarifaSocio, @TarifaInvitado, @NroSocio, @IdInvitado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarActividadExtra
	@Tipo VARCHAR (50)
AS
BEGIN
	INSERT INTO Accesos.ActividadExtra (Tipo)
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividadExtra
	@Tipo VARCHAR (50)
AS
BEGIN
	INSERT INTO ddbbaTP.ActividadExtra (Tipo)
>>>>>>> recuperar-historial
	VALUES (@Tipo)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarColonia
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarColonia
>>>>>>> recuperar-historial
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Accesos.Colonia (IdActividadExtra, Precio)
=======
	INSERT INTO ddbbaTP.Colonia (IdActividadExtra, Precio)
>>>>>>> recuperar-historial
	VALUES (@idAct_extra, @Precio)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarSum
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarSum
>>>>>>> recuperar-historial
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Accesos.Sum_Recreativo (IdActividadExtra, Precio)
=======
	INSERT INTO ddbbaTP.Sum_Recreativo (IdActividadExtra, Precio)
>>>>>>> recuperar-historial
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

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.InsertarAsiste
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarAsiste
>>>>>>> recuperar-historial
	@NroSocio VARCHAR(10),
	@IdClase INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Asiste (NroSocio, IdClase)
=======
	INSERT INTO ddbbaTP.Asiste (NroSocio, IdClase)
>>>>>>> recuperar-historial
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.InsertarAnotadoEn
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarAnotadoEn
>>>>>>> recuperar-historial
	@NroSocio VARCHAR(10),
	@IdClase INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Anotado_En (NroSocio, IdClase)
=======
	INSERT INTO ddbbaTP.Anotado_En (NroSocio, IdClase)
>>>>>>> recuperar-historial
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.InsertarInscripto
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarInscripto
>>>>>>> recuperar-historial
	@NroSocio VARCHAR(10),
	@IdActividad INT
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Clases.Inscripto (NroSocio, IdActiviDad)
=======
	INSERT INTO ddbbaTP.Inscripto (NroSocio, IdActiviDad)
>>>>>>> recuperar-historial
	VALUES (@NroSocio, @IdActividad)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Accesos.InsertarRealiza
=======
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarRealiza
>>>>>>> recuperar-historial
	@NroSocio VARCHAR(10),
	@IdActividadExtra INT,
	@Fecha DATE
AS
BEGIN
<<<<<<< HEAD
	INSERT INTO Accesos.Realiza (NroSocio, IdActividadExtra, Fecha)
=======
	INSERT INTO ddbbaTP.Realiza (NroSocio, IdActividadExtra, Fecha)
>>>>>>> recuperar-historial
	VALUES (@NroSocio, @IdActividadExtra, @Fecha)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--Sp Para registrar una clase completa

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.AltaClaseCompleta
=======
CREATE OR ALTER PROCEDURE ddbbaTP.AltaClaseCompleta
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
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
=======
	EXEC ddbbaTP.InsertarProfesor @NombreProfesor, @ApellidoProfesor, @EmailProfesor;

	--Id Maximo, ya que el hacer la insercion el id de profesor aumenta progresivamente
	DECLARE @IdProfesor INT = (SELECT MAX(IdProfesor) FROM ddbbaTP.Profesor);

	--Insertar actividad
	EXEC ddbbaTP.InsertarActividad @NombreActividad, @CostoActividad, @VigenciaActividad;

	--Id Maximo, ya que el hacer la insercion el id de actividad aumenta progresivamente
	DECLARE @IdActividad INT = (SELECT MAX(IdActividad) FROM ddbbaTP.Actividad);

	-- 3. Insertar clase
	EXEC ddbbaTP.InsertarClase @FechaClase, @HoraClase, @DiaClase, @IdProfesor, @IdActividad;
END;

EXEC ddbbaTP.AltaClaseCompleta  'Mario',
								'Giménez',
								'mario.gimenez@deporte.com',
								'Futbol',
								40000,
								'2025-12-31',
								'2025-06-15',
								'18:30:00',
								'Jueves';

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE ddbbaTP.Nombre
(	Id SMALLINT IDENTITY (1,1),
	Nombre VARCHAR (20)
);

CREATE TABLE ddbbaTP.Apellido
(	Id SMALLINT IDENTITY (1,1),
	Apellido VARCHAR (20)
)

--drop table ddbbaTP.Apellido

INSERT INTO ddbbaTP.Nombre (Nombre) VALUES
('Matias Ezequiel'), ('Luciano Romeo'), ('Gonzalo Pablo'), ('Jose Ramon'), ('Thomas Uriel'),
('Carmen Lucia'), ('Sofia Daniela'), ('Bahia Valentina'), ('Lorena Camila'), ('Candela Victoria')

INSERT INTO ddbbaTP.Apellido (Apellido) VALUES
('Mendez'), ('Baez'), ('Gimenez'), ('Maidana'), ('Ramirez'), ('Carro'), ('Ovejero'), ('Perez'), ('Miguez'), ('Coronel'), ('Lastra')
GO


>>>>>>> recuperar-historial
------------------------------------------------------------------------------------------>MODIFICACION
-- =============================================
-- STORED PROCEDURES PARA MODIFICACIÓN DE DATOS
-- =============================================

-- Procedimiento para modificar un Socio
<<<<<<< HEAD
CREATE PROCEDURE Socios.ModificarSocio
=======
CREATE PROCEDURE ddbbaTP.ModificarSocio
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar DNI si se proporciona
    IF @Dni IS NOT NULL AND (@Dni < 10000000 OR @Dni > 99999999)
    BEGIN
        RAISERROR('El DNI debe ser un número de 8 dígitos', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio a cargo exista si se proporciona
<<<<<<< HEAD
    IF @NroSocio2 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio2)
=======
    IF @NroSocio2 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio2)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio a cargo con número %d no existe', 16, 1, @NroSocio2);
        RETURN;
    END
    
    BEGIN TRY        
<<<<<<< HEAD
        UPDATE Socios.Socio
=======
        UPDATE ddbbaTP.Socio
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Socios.ModificarGrupoFamiliar
=======
CREATE PROCEDURE ddbbaTP.ModificarGrupoFamiliar
>>>>>>> recuperar-historial
    @IdGrupoFamiliar INT,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el grupo familiar exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
<<<<<<< HEAD
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY        
<<<<<<< HEAD
        UPDATE Socios.GrupoFamiliar
=======
        UPDATE ddbbaTP.GrupoFamiliar
>>>>>>> recuperar-historial
        SET NroSocio = ISNULL(@NroSocio, NroSocio)
        WHERE IdGrupoFamiliar = @IdGrupoFamiliar;
        
        PRINT 'Grupo familiar modificado correctamente';
    END TRY
    BEGIN CATCH
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Categoría
<<<<<<< HEAD
CREATE PROCEDURE Socios.ModificarCategoria
=======
CREATE PROCEDURE ddbbaTP.ModificarCategoria
>>>>>>> recuperar-historial
    @IdCategoria INT,
    @Nombre VARCHAR(50) = NULL,
    @Costo DECIMAL(10,2) = NULL,
    @Vigente_Hasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la categoría exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Categoria WHERE IdCategoria = @IdCategoria)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Categoria WHERE IdCategoria = @IdCategoria)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La categoría con ID %d no existe', 16, 1, @IdCategoria);
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
<<<<<<< HEAD
        UPDATE Socios.Categoria
=======
        UPDATE ddbbaTP.Categoria
>>>>>>> recuperar-historial
        SET Nombre = ISNULL(@Nombre, Nombre),
            Costo = ISNULL(@Costo, Costo),
            Vigente_Hasta = ISNULL(@Vigente_Hasta, Vigente_Hasta)
        WHERE IdCategoria = @IdCategoria;
        
        PRINT 'Categoría modificada correctamente';
    END TRY
    BEGIN CATCH    
        throw;
    END CATCH
END;
GO

-- Procedimiento para modificar una Actividad
<<<<<<< HEAD
CREATE PROCEDURE Clases.ModificarActividad
=======
CREATE PROCEDURE ddbbaTP.ModificarActividad
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
>>>>>>> recuperar-historial
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
    -- Validar que la categoría exista si se proporciona
<<<<<<< HEAD
    IF @IdCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Categoria WHERE IdCategoria = @IdCategoria)
=======
    IF @IdCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Categoria WHERE IdCategoria = @IdCategoria)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La categoría con ID %d no existe', 16, 1, @IdCategoria);
        RETURN;
    END
    -- Validar que la actividad padre exista si se proporciona
<<<<<<< HEAD
    IF @IdAct IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdAct)
=======
    IF @IdAct IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdAct)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La actividad padre con ID %d no existe', 16, 1, @IdAct);
        RETURN;
    END
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Clases.Actividad
=======
        UPDATE ddbbaTP.Actividad
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Clases.ModificarProfesor
=======
CREATE PROCEDURE ddbbaTP.ModificarProfesor
>>>>>>> recuperar-historial
    @IdProfesor INT,
    @Nombre VARCHAR(50) = NULL,
    @Apellido VARCHAR(50) = NULL,
    @Email_Personal VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el profesor exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Profesor WHERE IdProfesor = @IdProfesor)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Profesor WHERE IdProfesor = @IdProfesor)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Clases.Profesor
=======
        UPDATE ddbbaTP.Profesor
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Clases.ModificarClase
=======
CREATE PROCEDURE ddbbaTP.ModificarClase
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF @IdProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Profesor WHERE IdProfesor = @IdProfesor)
=======
    IF @IdProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Profesor WHERE IdProfesor = @IdProfesor)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    -- Validar que la actividad exista si se proporciona
<<<<<<< HEAD
    IF @IdActividad IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
=======
    IF @IdActividad IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La actividad con ID %d no existe', 16, 1, @IdActividad);
        RETURN;
    END
    
    BEGIN TRY        
<<<<<<< HEAD
        UPDATE Clases.Clase
=======
        UPDATE ddbbaTP.Clase
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Socios.ModificarCuota
=======
CREATE PROCEDURE ddbbaTP.ModificarCuota
>>>>>>> recuperar-historial
    @IdCuota INT,
    @Estado VARCHAR(20) = NULL,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la cuota exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Cuota WHERE IdCuota = @IdCuota)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Socios.Cuota
=======
        UPDATE ddbbaTP.Cuota
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.ModificarDescuento
=======
CREATE PROCEDURE ddbbaTP.ModificarDescuento
>>>>>>> recuperar-historial
    @IdDescuento INT,
    @Tipo VARCHAR(50) = NULL,
    @Porcentaje DECIMAL(5,2) = NULL,
    @IdGrupoFamiliar INT = NULL,
    @NroSocio VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el descuento exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
       ((SELECT IdGrupoFamiliar FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento) IS NULL AND
        (SELECT NroSocio FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento) IS NULL)
=======
       ((SELECT IdGrupoFamiliar FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento) IS NULL AND
        (SELECT NroSocio FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento) IS NULL)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('Debe especificar al menos un grupo familiar o un socio', 16, 1);
        RETURN;
    END
    
    -- Validar que el grupo familiar exista si se proporciona
<<<<<<< HEAD
    IF @IdGrupoFamiliar IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
=======
    IF @IdGrupoFamiliar IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
<<<<<<< HEAD
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Facturacion.Descuento
=======
        UPDATE ddbbaTP.Descuento
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Accesos.ModificarActividadExtra
=======
CREATE PROCEDURE ddbbaTP.ModificarActividadExtra
>>>>>>> recuperar-historial
	@IdActExtra INT,
	@Tipo VARCHAR(50)=NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Validar que la actividad extra exista
<<<<<<< HEAD
	IF NOT EXISTS (SELECT 1 FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActExtra)
=======
	IF NOT EXISTS (SELECT 1 FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActExtra)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La Actividad Extra con ID %d no existe', 16, 1, @IdActExtra);
        RETURN;
    END

	BEGIN TRY
<<<<<<< HEAD
		UPDATE Accesos.ActividadExtra
=======
		UPDATE ddbbaTP.ActividadExtra
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Accesos.ModificarColonia
=======
CREATE PROCEDURE ddbbaTP.ModificarColonia
>>>>>>> recuperar-historial
	@IdActExtra INT,
	@Precio DECIMAL(10,2),
	@FechaInicio DATE,
	@FechaFin DATE
AS
BEGIN
	SET NOCOUNT ON;

	-- Verificar que la actividad exista
<<<<<<< HEAD
	IF NOT EXISTS (SELECT 1 FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActExtra)
=======
	IF NOT EXISTS (SELECT 1 FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActExtra)
>>>>>>> recuperar-historial
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

	-- Verificar que las fechas sean válidas
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
<<<<<<< HEAD
		UPDATE Accesos.Colonia
=======
		UPDATE ddbbaTP.Colonia
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.ModificarFactura
=======
CREATE PROCEDURE ddbbaTP.ModificarFactura
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
>>>>>>> recuperar-historial
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

    -- Validar que los días atrasados no sean negativos
    IF @DiasAtrasados < 0
    BEGIN
        RAISERROR('Los días atrasados no pueden ser negativos.', 16, 1);
        RETURN;
    END

    -- Validar estado si se proporciona (ejemplo: solo valores permitidos)
    IF @Estado IS NOT NULL AND @Estado NOT IN ('Pendiente', 'Pagada', 'Anulada')
    BEGIN
        RAISERROR('Estado inválido. Debe ser Pendiente, Pagada o Anulada.', 16, 1);
        RETURN;
    END

    -- Validar que la cuota exista si se proporciona
<<<<<<< HEAD
    IF @IdCuota IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Cuota WHERE IdCuota = @IdCuota)
=======
    IF @IdCuota IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La cuota con ID %d no existe.', 16, 1, @IdCuota);
        RETURN;
    END

    -- Validar que el descuento exista si se proporciona
<<<<<<< HEAD
    IF @IdDescuento IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Descuento WHERE IdDescuento = @IdDescuento)
=======
    IF @IdDescuento IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El descuento con ID %d no existe.', 16, 1, @IdDescuento);
        RETURN;
    END

    BEGIN TRY
        -- Actualizar la factura
<<<<<<< HEAD
        UPDATE Facturacion.Factura
=======
        UPDATE ddbbaTP.Factura
>>>>>>> recuperar-historial
        SET Fecha_Vencimiento = @FechaVencimiento,
            Dias_Atrasados = @DiasAtrasados,
            Estado = ISNULL(@Estado, Estado),
            IdCuota = ISNULL(@IdCuota, IdCuota),
            IdDescuento = ISNULL(@IdDescuento, IdDescuento)
        WHERE IdFactura = @IdFactura;

        PRINT 'Factura modificada correctamente.';
    END TRY
    BEGIN CATCH
        -- Manejo básico del error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al modificar la factura: %s', 16, 1, @ErrorMessage);
    END CATCH
END;
GO
-- Procedimiento para modificar un Anotado en
<<<<<<< HEAD
CREATE PROCEDURE Clases.ModificarAnotadoEn
=======
CREATE PROCEDURE ddbbaTP.ModificarAnotadoEn
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdClase INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la inscripción exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('No existe una inscripción del socio %d en la clase %d', 16, 1, @NroSocio, @IdClase);
        RETURN;
    END
    
    -- Validar que el socio exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que la clase exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La clase con ID %d no existe', 16, 1, @IdClase);
        RETURN;
    END
    
    -- Validar fecha de inscripción si se proporciona
    IF @FechaInscripcion IS NOT NULL AND @FechaInscripcion > GETDATE()
    BEGIN
        RAISERROR('La fecha de inscripción no puede ser futura', 16, 1);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Clases.Anotado_En
=======
        UPDATE ddbbaTP.Anotado_En
>>>>>>> recuperar-historial
        SET FechaInscripcion = ISNULL(@FechaInscripcion, FechaInscripcion) 
        WHERE NroSocio = @NroSocio AND IdClase = @IdClase;
        
        PRINT 'Inscripción modificada correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Inscripto
<<<<<<< HEAD
CREATE PROCEDURE Clases.ModificarInscripto
=======
CREATE PROCEDURE ddbbaTP.ModificarInscripto
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdActividad INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el socio exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la actividad exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Clases.Actividad WHERE IdActividad = @IdActividad)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La actividad con ID %d no existe.', 16, 1, @IdActividad);
        RETURN;
    END

    -- Validar que exista la inscripción (suponiendo tabla Inscripcion con esa relación)
    IF NOT EXISTS (
<<<<<<< HEAD
        SELECT 1 FROM Clases.Inscripto
=======
        SELECT 1 FROM ddbbaTP.Inscripto
>>>>>>> recuperar-historial
        WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
    )
    BEGIN
        RAISERROR('La inscripción para el socio %d en la actividad %d no existe.', 16, 1, @NroSocio, @IdActividad);
        RETURN;
    END

    -- Validar FechaInscripcion si se pasa, que no sea futura
    IF @FechaInscripcion IS NOT NULL AND @FechaInscripcion > GETDATE()
    BEGIN
        RAISERROR('La fecha de inscripción no puede ser futura.', 16, 1);
        RETURN;
    END

    BEGIN TRY
<<<<<<< HEAD
        UPDATE Clases.Inscripto
=======
        UPDATE ddbbaTP.Inscripto
>>>>>>> recuperar-historial
        SET FechaInscripcion = ISNULL(@FechaInscripcion, FechaInscripcion)
        WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad;

        PRINT 'Inscripción modificada correctamente.';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Invitado
<<<<<<< HEAD
CREATE PROCEDURE Accesos.ModificarInvitado
=======
CREATE PROCEDURE ddbbaTP.ModificarInvitado
>>>>>>> recuperar-historial
    @IdInvitado INT,
    @Nombre VARCHAR(50),
    @Dni INT = NULL,
    @NroSocio VARCHAR(10),
    @IdFactura INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el invitado exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El invitado con ID %d no existe.', 16, 1, @IdInvitado);
        RETURN;
    END

    -- Validar que el socio exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la factura exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La factura con ID %d no existe.', 16, 1, @IdFactura);
        RETURN;
    END

    -- Validar DNI si se proporciona (8 dígitos)
    IF @Dni IS NOT NULL AND (@Dni < 10000000 OR @Dni > 99999999)
    BEGIN
        RAISERROR('El DNI debe ser un número de 8 dígitos.', 16, 1);
        RETURN;
    END

    BEGIN TRY
<<<<<<< HEAD
        UPDATE Accesos.Invitado
=======
        UPDATE ddbbaTP.Invitado
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.ModificarMedioDePago
=======
CREATE PROCEDURE ddbbaTP.ModificarMedioDePago
>>>>>>> recuperar-historial
    @IdMedioPago INT,
    @Nombre VARCHAR(50),
    @Tipo VARCHAR(30),
    @Modalidad VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el medio de pago exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioPago)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioPago)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe.', 16, 1, @IdMedioPago);
        RETURN;
    END

    -- Validar que no estén vacíos los parámetros obligatorios (error típico que a veces no se valida)
    IF (@Nombre IS NULL OR LTRIM(RTRIM(@Nombre)) = '')
    BEGIN
        RAISERROR('El nombre no puede estar vacío.', 16, 1);
        RETURN;
    END
    IF (@Tipo IS NULL OR LTRIM(RTRIM(@Tipo)) = '')
    BEGIN
        RAISERROR('El tipo no puede estar vacío.', 16, 1);
        RETURN;
    END
    IF (@Modalidad IS NULL OR LTRIM(RTRIM(@Modalidad)) = '')
    BEGIN
        RAISERROR('La modalidad no puede estar vacía.', 16, 1);
        RETURN;
    END

    BEGIN TRY
<<<<<<< HEAD
        UPDATE Facturacion.MedioDePago
=======
        UPDATE ddbbaTP.MedioDePago
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.ModificarPago
=======
CREATE PROCEDURE ddbbaTP.ModificarPago
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdPago = @IdPago)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdPago = @IdPago)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
    IF @IdCuenta IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Cuenta WHERE IdCuenta = @IdCuenta)
=======
    IF @IdCuenta IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuenta WHERE IdCuenta = @IdCuenta)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La cuenta con ID %d no existe', 16, 1, @IdCuenta);
        RETURN;
    END
    
    -- Validar que la factura exista si se proporciona
<<<<<<< HEAD
    IF @IdFactura IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdFactura = @IdFactura)
=======
    IF @IdFactura IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La factura con ID %d no existe', 16, 1, @IdFactura);
        RETURN;
    END
    
    -- Validar que el medio de pago exista si se proporciona
<<<<<<< HEAD
    IF @IdMedioDePago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioDePago)
=======
    IF @IdMedioDePago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioDePago)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe', 16, 1, @IdMedioDePago);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Facturacion.Pago
=======
        UPDATE ddbbaTP.Pago
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Accesos.ModificarPasePileta
=======
CREATE PROCEDURE ddbbaTP.ModificarPasePileta
>>>>>>> recuperar-historial
    @IdPasePileta INT,
    @TarifaSocio DECIMAL(10,2) = NULL,
    @TarifaInvitado DECIMAL(10,2) = NULL,
    @NroSocio VARCHAR(10) = NULL,
    @IdInvitado INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el pase de pileta exista
<<<<<<< HEAD
    IF NOT EXISTS (SELECT 1 FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta)
=======
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta)
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
       ((SELECT NroSocio FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL AND
        (SELECT IdInvitado FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL)
=======
       ((SELECT NroSocio FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL AND
        (SELECT IdInvitado FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('Debe especificar al menos un socio o un invitado', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
<<<<<<< HEAD
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Socios.Socio WHERE NroSocio = @NroSocio)
=======
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE NroSocio = @NroSocio)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que el invitado exista si se proporciona
<<<<<<< HEAD
    IF @IdInvitado IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado)
=======
    IF @IdInvitado IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El invitado con ID %d no existe', 16, 1, @IdInvitado);
        RETURN;
    END
    
    BEGIN TRY
<<<<<<< HEAD
        UPDATE Accesos.PasePileta
=======
        UPDATE ddbbaTP.PasePileta
>>>>>>> recuperar-historial
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
<<<<<<< HEAD


=======
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Socios.BorrarSocio 
=======
CREATE PROCEDURE ddbbaTP.BorrarSocio 
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
CREATE PROCEDURE Socios.BorrarGrupoFamiliar
    @IdGrupoFamiliar INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Socios.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
=======
CREATE PROCEDURE ddbbaTP.BorrarGrupoFamiliar
    @IdGrupoFamiliar INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El grupo familiar no existe.', 16, 1);
        RETURN;
    END

<<<<<<< HEAD
    IF EXISTS (SELECT 1 FROM Socios.Socio WHERE IdGrupoFamiliar = @IdGrupoFamiliar AND Estado = 'Activo')
=======
    IF EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE IdGrupoFamiliar = @IdGrupoFamiliar AND Estado = 'Activo')
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El grupo familiar tiene socios activos.', 16, 1);
        RETURN;
    END

<<<<<<< HEAD
    DELETE Socios.GrupoFamiliar where IdGrupoFamiliar= @IdGrupoFamiliar
=======
    DELETE ddbbaTP.GrupoFamiliar where IdGrupoFamiliar= @IdGrupoFamiliar
>>>>>>> recuperar-historial
END
GO

-- Borrar ActividadExtra
<<<<<<< HEAD
CREATE PROCEDURE Accesos.BorrarActividadExtra
    @IdActividadExtra INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Accesos.Realiza where IdActividadExtra = @IdActividadExtra)
=======
CREATE PROCEDURE ddbbaTP.BorrarActividadExtra
    @IdActividadExtra INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Realiza where IdActividadExtra = @IdActividadExtra)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('No se puede eliminar la actividad extra. Está asociada a registros.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    DELETE FROM Accesos.Colonia WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.Sum_Recreativo WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.Pileta WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM Accesos.ActividadExtra WHERE IdActExtra = @IdActividadExtra
=======
    DELETE FROM ddbbaTP.Colonia WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.Sum_Recreativo WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.Pileta WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActividadExtra
>>>>>>> recuperar-historial
END
GO

-- Borrar Factura (Borrado lógico)
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarFactura
    @IdFactura INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Facturacion.Factura where IdFactura = @IdFactura)
=======
CREATE PROCEDURE ddbbaTP.BorrarFactura
    @IdFactura INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura where IdFactura = @IdFactura)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('Factura no encontrada.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    UPDATE Facturacion.Factura 
=======
    UPDATE ddbbaTP.Factura 
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdFactura = @IdFactura
END
GO

-- Borrar Invitado
<<<<<<< HEAD
CREATE PROCEDURE Accesos.BorrarInvitado
    @IdInvitado INT
AS
BEGIN
    DELETE FROM Accesos.Invitado WHERE IdInvitado = @IdInvitado
=======
CREATE PROCEDURE ddbbaTP.BorrarInvitado
    @IdInvitado INT
AS
BEGIN
    DELETE FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado
>>>>>>> recuperar-historial
END
GO

-- Borrar Categoria
<<<<<<< HEAD
CREATE PROCEDURE Socios.BorrarCategoria
    @IdCategoria INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Socios.Socio WHERE IdCategoria = @IdCategoria)
=======
CREATE PROCEDURE ddbbaTP.BorrarCategoria
    @IdCategoria INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE IdCategoria = @IdCategoria)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La categoría está asociada a socios.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
     UPDATE Socios.Categoria 
=======
     UPDATE ddbbaTP.Categoria 
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdCategoria = @IdCategoria
END
GO

-- Borrado lógico en Actividad
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarActividad
    @IdActividad INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clases.Inscripto WHERE IdActividad = @IdActividad)
=======
CREATE PROCEDURE ddbbaTP.BorrarActividad
    @IdActividad INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Inscripto WHERE IdActividad = @IdActividad)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La actividad tiene socios inscriptos.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    UPDATE Clases.Actividad
=======
    UPDATE ddbbaTP.Actividad
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdActividad = @IdActividad
END
GO

-- Borrado lógico en clase si no tiene socios anotados ni que asistan
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarClase
    @IdClase INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clases.Clase WHERE IdClase = @IdClase)
=======
CREATE PROCEDURE ddbbaTP.BorrarClase
    @IdClase INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La clase no existe.', 16, 1)
        RETURN
    END

<<<<<<< HEAD
    IF EXISTS (SELECT 1 FROM Clases.Anotado_En where IdClase = @IdClase) OR
       EXISTS (SELECT 1 FROM Clases.Asiste where IdClase = @IdClase)
=======
    IF EXISTS (SELECT 1 FROM ddbbaTP.Anotado_En where IdClase = @IdClase) OR
       EXISTS (SELECT 1 FROM ddbbaTP.Asiste where IdClase = @IdClase)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La clase tiene socios anotados o asistentes.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    UPDATE Clases.Clase
=======
    UPDATE ddbbaTP.Clase
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdClase = @IdClase
END
GO

-- Borrado lógico profesor si no dicta clases 
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarProfesor
    @IdProfesor INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clases.Clase WHERE IdProfesor = @IdProfesor)
=======
CREATE PROCEDURE ddbbaTP.BorrarProfesor
    @IdProfesor INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdProfesor = @IdProfesor)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('No se puede eliminar el profesor porque dicta clases.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    UPDATE Clases.Profesor
=======
    UPDATE ddbbaTP.Profesor
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdProfesor = @IdProfesor
END
GO

-- Borrar Cuota 
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarCuota
    @IdCuota INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdCuota = @IdCuota)
=======
CREATE PROCEDURE ddbbaTP.BorrarCuota
    @IdCuota INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdCuota = @IdCuota)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La cuota está asociada a una factura.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    DELETE FROM Facturacion.Cuota WHERE IdCuota = @IdCuota
=======
    DELETE FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota
>>>>>>> recuperar-historial
END
GO

-- Borrado lógico en Descuento
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarDescuento
    @IdDescuento INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Factura WHERE IdDescuento = @IdDescuento)
=======
CREATE PROCEDURE ddbbaTP.BorrarDescuento
    @IdDescuento INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdDescuento = @IdDescuento)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El descuento está asociado a una factura.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    UPDATE Facturacion.Descuento
=======
    UPDATE ddbbaTP.Descuento
>>>>>>> recuperar-historial
    SET Estado = 'Inactivo' where IdDescuento = @IdDescuento
END
GO

-- Borrar Pago solo si no tiene un reembolso
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarPago
    @IdPago BIGINT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Reembolso where IdPago = @IdPago)
=======
CREATE PROCEDURE ddbbaTP.BorrarPago
    @IdPago BIGINT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Reembolso where IdPago = @IdPago)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El pago tiene un reembolso asociado.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    DELETE FROM Facturacion.Pago where IdPago = @IdPago
=======
    DELETE FROM ddbbaTP.Pago where IdPago = @IdPago
>>>>>>> recuperar-historial
END
GO

-- Borrar Cuenta si no tiene ningun pago
<<<<<<< HEAD
CREATE PROCEDURE Socios.BorrarCuenta
    @IdCuenta INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdCuenta = @IdCuenta)
=======
CREATE PROCEDURE ddbbaTP.BorrarCuenta
    @IdCuenta INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdCuenta = @IdCuenta)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('La cuenta tiene pagos registrados.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    DELETE FROM Socios.Cuenta WHERE IdCuenta = @IdCuenta
=======
    DELETE FROM ddbbaTP.Cuenta WHERE IdCuenta = @IdCuenta
>>>>>>> recuperar-historial
END
GO

-- Borrar Medio de Pago si no tiene pagos ni reembolsos
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarMedioDePago
    @IdMedioDePago INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Facturacion.Pago WHERE IdMedioDePago = @IdMedioDePago)
        OR EXISTS (SELECT 1 FROM Facturacion.Reembolso WHERE IdMedioDePago = @IdMedioDePago)
=======
CREATE PROCEDURE ddbbaTP.BorrarMedioDePago
    @IdMedioDePago INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdMedioDePago = @IdMedioDePago)
        OR EXISTS (SELECT 1 FROM ddbbaTP.Reembolso WHERE IdMedioDePago = @IdMedioDePago)
>>>>>>> recuperar-historial
    BEGIN
        RAISERROR('El medio de pago está en uso.', 16, 1)
        RETURN
    END
<<<<<<< HEAD
    DELETE FROM Facturacion.MedioDePago WHERE IdMedioPago = @IdMedioDePago
=======
    DELETE FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioDePago
>>>>>>> recuperar-historial
END
GO

-- Borrar Reembolso
<<<<<<< HEAD
CREATE PROCEDURE Facturacion.BorrarReembolso
    @IdReembolso INT
AS
BEGIN
    DELETE FROM Facturacion.Reembolso WHERE IdReembolso = @IdReembolso
=======
CREATE PROCEDURE ddbbaTP.BorrarReembolso
    @IdReembolso INT
AS
BEGIN
    DELETE FROM ddbbaTP.Reembolso WHERE IdReembolso = @IdReembolso
>>>>>>> recuperar-historial
END
GO

-- Borrar Pase Pileta
<<<<<<< HEAD
CREATE PROCEDURE Accesos.BorrarPasePileta
    @IdPasePileta INT
AS
BEGIN
    DELETE FROM Accesos.PasePileta WHERE IdPasePileta = @IdPasePileta
=======
CREATE PROCEDURE ddbbaTP.BorrarPasePileta
    @IdPasePileta INT
AS
BEGIN
    DELETE FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta
>>>>>>> recuperar-historial
END
GO

-- Borrar Asiste
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarAsiste
=======
CREATE PROCEDURE ddbbaTP.BorrarAsiste
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdClase INT
AS
BEGIN
<<<<<<< HEAD
    DELETE FROM Clases.Asiste WHERE NroSocio = @NroSocio AND IdClase = @IdClase
=======
    DELETE FROM ddbbaTP.Asiste WHERE NroSocio = @NroSocio AND IdClase = @IdClase
>>>>>>> recuperar-historial
END
GO
 
-- Borrar Anotado_En
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarAnotado
=======
CREATE PROCEDURE ddbbaTP.BorrarAnotado
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdClase INT
AS
BEGIN
<<<<<<< HEAD
    DELETE FROM Clases.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase
=======
    DELETE FROM ddbbaTP.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase
>>>>>>> recuperar-historial
END
GO

-- Borrar Inscripto
<<<<<<< HEAD
CREATE PROCEDURE Clases.BorrarInscripto
=======
CREATE PROCEDURE ddbbaTP.BorrarInscripto
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdActividad INT
AS
BEGIN
<<<<<<< HEAD
    DELETE FROM Clases.Inscripto WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
=======
    DELETE FROM ddbbaTP.Inscripto WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
>>>>>>> recuperar-historial
END
GO

-- Borrar Realiza
<<<<<<< HEAD
CREATE PROCEDURE Accesos.BorrarRealiza
=======
CREATE PROCEDURE ddbbaTP.BorrarRealiza
>>>>>>> recuperar-historial
    @NroSocio VARCHAR(10),
    @IdActividadExtra INT
AS
BEGIN
<<<<<<< HEAD
    DELETE FROM Accesos.Realiza WHERE NroSocio = @NroSocio AND IdActividadExtra = @IdActividadExtra
=======
    DELETE FROM ddbbaTP.Realiza WHERE NroSocio = @NroSocio AND IdActividadExtra = @IdActividadExtra
>>>>>>> recuperar-historial
END
GO

--INSERTAR DIA EN TABLA CLASE

<<<<<<< HEAD
CREATE OR ALTER PROCEDURE Clases.Insertar_Dia_Clase
AS
BEGIN
	SET LANGUAGE spanish
	UPDATE Clases.Clase
=======
CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Dia_Clase
AS
BEGIN
	SET LANGUAGE spanish
	UPDATE ddbbaTP.Clase
>>>>>>> recuperar-historial
	SET Dia = DATENAME(WEEKDAY, CONVERT(DATE, Fecha, 103))
	SET LANGUAGE english;
END;
go