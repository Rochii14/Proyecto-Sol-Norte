/*Entrega 4- Documento de instalación y configuración
Luego de decidirse por un motor de base de datos relacional, llegó el momento de generar la base de datos. En esta oportunidad utilizarán
SQL Server. Deberá instalar el DMBS y documentar el proceso. No incluya capturas de pantalla. Detalle las configuraciones aplicadas 
(ubicación de archivos, memoria asignada, seguridad, puertos, etc.) en un documento como el que le entregaría al DBA. Cree la base de datos, 
entidades y relaciones. Incluya restricciones y claves. Deberá entregar un archivo .sql con el scriptcompleto de creación (debe funcionar 
si se lo ejecuta “tal cual” es entregado en una sola ejecución). Incluya comentarios para indicar qué hace cada módulo de código.  Genere 
store procedures para manejar la inserción, modificado, borrado (si corresponde, también debe decidir si determinadas entidades solo admitirán
borrado lógico) de cada tabla. Los nombres de los store procedures NO deben comenzar con “SP”.  Algunas operaciones implicarán store procedures 
que involucran varias tablas, uso de transacciones, etc. Puede que incluso realicen ciertas operaciones mediante varios SPs. Asegúrense de que 
los comentarios que acompañen al código lo expliquen. Genere esquemas para organizar de forma lógica los componentes del sistema y aplique esto 
en la creación de objetos. NO use el esquema “dbo”.  Todos los SP creados deben estar acompañados de juegos de prueba. Se espera que realicen 
validaciones básicas en los SP (p/e cantidad mayor a cero, CUIT válido, etc.) y que en los juegos de prueba demuestren la correcta aplicación 
de las validaciones. Las pruebas deben realizarse en un script separado, donde con comentarios se indique en cada caso el resultado esperado
El archivo .sql con el script debe incluir comentarios donde consten este enunciado, la fecha de entrega, número de grupo, nombre de la materia, 
nombres y DNI de los alumnos.  Entregar todo en un zip (observar las pautas para nomenclatura antes expuestas) mediante la sección de prácticas de 
MIEL. Solo uno de los miembros del grupo debe hacer la entrega. 

*FECHA DE ENTREGA: 23/05/2025
*NUMERO DE GRUPO: 08
*NOMBRE DE LA MATERIA: Base de Datos Aplicadas
*INTEGRANTES: 		  45318374 | Di Marco Jazmín
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Rocío Elizabeth
*/

-------------------------------------CREACIÓN DE OBJETOS-------------------------------
CREATE DATABASE Com5600G08
GO 
USE Com5600G08

go
CREATE SCHEMA ddbbaTP
go
-- Tabla SOCIO
CREATE TABLE ddbbaTP.Socio (
    Nro_Socio INT IDENTITY(1,1) PRIMARY KEY,
    Dni INT CHECK (Dni BETWEEN 10000000 AND 99999999), --CHEQUEO QUE EL DNI SEA VÁLIDO
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email_Personal VARCHAR(100),
    Fecha_De_Nacimiento DATE CHECK (Fecha_De_Nacimiento <= GETDATE()), --VALIDACIÓN DE FECHA VÁLIDA
    Telefono_Contacto VARCHAR(20),
    Telef_C_Emergencia VARCHAR(20),
    Nombre_Obra_Social VARCHAR(100),
    Nro_Obra_Social VARCHAR(50),
    IdGrupoFamiliar INT,
    IdCategoria INT,
    NroSocio2 INT, --RELACIÓN UNARIA
	---LAS AGREGO A LO ULTIMO PARA QUE NO TUVIERA CONFLICTO REFERENCIAL
    --CONSTRAINT FK_Socio_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES GrupoFamiliar(Id),
    --CONSTRAINT FK_Socio_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
    --CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES Socio(Nro_Socio)
);	--1
go
-- Tabla GRUPO FAMILIAR
CREATE TABLE ddbbaTP.GrupoFamiliar (
    IdGrupoFamiliar INT IDENTITY(1,1) PRIMARY KEY,
    NroSocio INT,
    CONSTRAINT FK_GrupoFamiliar_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio)
);   --2
go
-- Tabla CATEGORIA
CREATE TABLE ddbbaTP.Categoria (
    IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Costo DECIMAL(10,2) CHECK (Costo >= 0),		--validacion costo positivo
    Vigente_Hasta DATE
);  --3
go
-- Tabla ACTIVIDAD
CREATE TABLE ddbbaTP.Actividad (
    IdActividad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    Costo DECIMAL(10,2) CHECK (Costo >= 0), --validacion costo positivo
    Vigente_Hasta DATE
);   --4
go

-- Tabla PROFESOR
CREATE TABLE ddbbaTP.Profesor (
    IdProfesor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email_Personal VARCHAR(100)
);  --5
go
-- Tabla CLASE
CREATE TABLE ddbbaTP.Clase (
    IdClase INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE CHECK (Fecha >= '2000-01-01'), --VALIDACIÓN DE FECHA VÁLIDA
    Hora TIME,
    Dia VARCHAR(15),
    IdProfesor INT,
    IdActividad INT,
    CONSTRAINT FK_Clase_Profesor FOREIGN KEY (IdProfesor) REFERENCES ddbbaTP.Profesor(IdProfesor),
    CONSTRAINT FK_Clase_Actividad FOREIGN KEY (IdActividad) REFERENCES ddbbaTP.Actividad(IdActividad)
);  --6
go
-- Tabla CUOTA
CREATE TABLE ddbbaTP.Cuota (
    IdCuota INT IDENTITY(1,1) PRIMARY KEY,
    Estado VARCHAR(20),
    NroSocio INT,
    CONSTRAINT FK_Cuota_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio)
); --7
go
-- Tabla DESCUENTO
CREATE TABLE ddbbaTP.Descuento (
    IdDescuento INT IDENTITY(1,1) PRIMARY KEY,
    Tipo VARCHAR(50),
    IdGrupoFamiliar INT,
    NroSocio INT,
    CONSTRAINT FK_Descuento_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES ddbbaTP.GrupoFamiliar(IdGrupoFamiliar),
    CONSTRAINT FK_Descuento_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio)
);  --8
go
-- Tabla FACTURA
CREATE TABLE ddbbaTP.Factura (
    IdFactura INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Vencimiento DATE,
    Dias_Atrasados INT,
    Estado VARCHAR(20),
    IdDescuento INT,
    IdCuota INT,
    CONSTRAINT FK_Factura_Descuento FOREIGN KEY (IdDescuento) REFERENCES ddbbaTP.Descuento(IdDescuento),
    CONSTRAINT FK_Factura_Cuota FOREIGN KEY (IdCuota) REFERENCES ddbbaTP.Cuota(IdCuota)
);  --9 
go
-- Tabla CUENTA
CREATE TABLE ddbbaTP.Cuenta (
    IdCuenta INT IDENTITY(1,1) PRIMARY KEY,
    Saldo_Favor DECIMAL(10,2) CHECK (Saldo_Favor >= 0),
    NroSocio INT,
    CONSTRAINT FK_Cuenta_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio)
);  --10
go
-- Tabla MEDIO DE PAGO
CREATE TABLE ddbbaTP.MedioDePago (
    IdMedioPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Tipo VARCHAR(30),
    Modalidad VARCHAR(30)
); --11
go
-- Tabla PAGO
CREATE TABLE ddbbaTP.Pago (
    IdPago INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_de_Pago DATE CHECK (Fecha_de_Pago >= '2000-01-01'),
    IdCuenta INT,
    IdFactura INT,
    IdMedioDePago INT,
    CONSTRAINT FK_Pago_Cuenta FOREIGN KEY (IdCuenta) REFERENCES ddbbaTP.Cuenta(IdCuenta),
    CONSTRAINT FK_Pago_Factura FOREIGN KEY (IdFactura) REFERENCES ddbbaTP.Factura(IdFactura),
    CONSTRAINT FK_Pago_MedioDePago FOREIGN KEY (IdMedioDePago) REFERENCES ddbbaTP.MedioDePago(IdMedioPago)
); --12
go
-- Tabla REEMBOLSO
CREATE TABLE ddbbaTP.Reembolso (
    IdReembolso INT IDENTITY(1,1) PRIMARY KEY,
    Modalidad VARCHAR(30),
    IdMedioDePago INT,
    IdPago INT,
    CONSTRAINT FK_Reembolso_MedioDePago FOREIGN KEY (IdMedioDePago) REFERENCES ddbbaTP.MedioDePago(IdMedioPago),
    CONSTRAINT FK_Reembolso_Pago FOREIGN KEY (IdPago) REFERENCES ddbbaTP.Pago(IdPago)
); --13
go
-- Tabla INVITADO (entidad débil)
CREATE TABLE ddbbaTP.Invitado (
    IdInvitado INT IDENTITY(1,1),
    Nombre VARCHAR(50),
    Nro_Socio INT,
    IdFactura INT,
    CONSTRAINT PK_Invitado_Socio PRIMARY KEY (IdInvitado,Nro_Socio),
	CONSTRAINT FK_Invitado_Socio FOREIGN KEY (Nro_Socio) REFERENCES ddbbaTP.Socio(Nro_Socio),
    CONSTRAINT FK_Invitado_Factura FOREIGN KEY (IdFactura) REFERENCES ddbbaTP.Factura(IdFactura)
); --14
go
-- Tabla PASE PILETA
CREATE TABLE ddbbaTP.PasePileta (
    IdPasePileta INT IDENTITY(1,1) PRIMARY KEY,
    Tarifa_Socio DECIMAL(10,2) CHECK (Tarifa_Socio >= 0), --valido que sea positivo
    Tarifa_Invitado DECIMAL(10,2) CHECK (Tarifa_Invitado >= 0), --valido que sea positivo
    NroSocio INT,
    IdInvitado INT,
    CONSTRAINT FK_PasePileta_Invitado FOREIGN KEY (IdInvitado,NroSocio) REFERENCES ddbbaTP.Invitado(IdInvitado,Nro_Socio)
); --15
go
-- Tabla ACTIVIDAD EXTRA (jerarquía)
CREATE TABLE ddbbaTP.ActividadExtra (
    IdActExtra INT IDENTITY(1,1) PRIMARY KEY,
    Tipo VARCHAR(50)
); --16
go
CREATE TABLE ddbbaTP.Colonia (
    IdActividadExtra INT PRIMARY KEY,
    Precio DECIMAL(10,2) CHECK (Precio >= 0), --VALIDACIÓN DE costo positivo
    CONSTRAINT FK_Colonia_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES ddbbaTP.ActividadExtra(IdActExtra)
); --17
go
CREATE TABLE ddbbaTP.Sum_Recreativo (
    IdActividadExtra INT PRIMARY KEY,
    Precio DECIMAL(10,2) CHECK (Precio >= 0), --valido que sea positivo
    CONSTRAINT FK_Sum_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES ddbbaTP.ActividadExtra(IdActExtra)
); --18
go
CREATE TABLE ddbbaTP.Pileta (
    IdActividadExtra INT,
    IdPasePileta INT,
    Fec_Temporada DATE,
    CONSTRAINT PK_Pileta PRIMARY KEY (IdActividadExtra, Fec_Temporada),
    CONSTRAINT FK_Pileta_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES ddbbaTP.ActividadExtra(IdActExtra),
    CONSTRAINT FK_Pileta_PasePileta FOREIGN KEY (IdPasePileta) REFERENCES ddbbaTP.PasePileta(IdPasePileta)
); --19
go
-- Tablas intermedias (relaciones N:N)
CREATE TABLE ddbbaTP.Asiste (
    NroSocio INT,
    IdClase INT,
    CONSTRAINT PK_Asiste PRIMARY KEY (NroSocio, IdClase),
    CONSTRAINT FK_Asiste_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio),
    CONSTRAINT FK_Asiste_Clase FOREIGN KEY (IdClase) REFERENCES ddbbaTP.Clase(IdClase)
); --20
go
CREATE TABLE ddbbaTP.Anotado_En (
    NroSocio INT,
    IdClase INT,
     CONSTRAINT PK_Anotado_En PRIMARY KEY (NroSocio, IdClase),
    CONSTRAINT FK_Anotado_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio),
    CONSTRAINT FK_Anotado_Clase FOREIGN KEY (IdClase) REFERENCES ddbbaTP.Clase(IdClase)
); --21
go
CREATE TABLE ddbbaTP.Inscripto (
    NroSocio INT,
    IdActividad INT,
    CONSTRAINT PK_Inscripto PRIMARY KEY (NroSocio, IdActividad),
    CONSTRAINT FK_Inscripto_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP. Socio(Nro_Socio),
    CONSTRAINT FK_Inscripto_Actividad FOREIGN KEY (IdActividad) REFERENCES ddbbaTP.Actividad(IdActividad)
); --22
go
CREATE TABLE ddbbaTP.Realiza(
	NroSocio INT,
	IdActividadExtra INT,
	Fecha DATE CHECK (Fecha >= '2000-01-01'), --valido fecha
	CONSTRAINT PK_Realiza PRIMARY KEY (NroSocio, IdActividadExtra),
	CONSTRAINT FK_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP. Socio(Nro_Socio),
    CONSTRAINT FK_Inscripto_Actividad_Extra FOREIGN KEY (IdActividadExtra) REFERENCES ddbbaTP.ActividadExtra(IdActExtra)
) --23
go
----SOLUCIONO PROBLEMA DE INTEGRIDAD CON LAS CONSTRAINTS
-- Solo si no existe ya esta constraint
IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_GrupoFamiliar_Socio'
)
BEGIN
    ALTER TABLE ddbbaTP.GrupoFamiliar
    ADD CONSTRAINT FK_GrupoFamiliar_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(Nro_Socio);
END;
GO
-- Agregar constraints en Socio
IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_GrupoFamiliar'
)
BEGIN
	ALTER TABLE ddbbaTP.Socio
	ADD CONSTRAINT FK_Socio_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES ddbbaTP.GrupoFamiliar(IdGrupoFamiliar);
END;
go
IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_Categoria'
)
BEGIN
	ALTER TABLE ddbbaTP.Socio
	ADD CONSTRAINT FK_Socio_Categoria FOREIGN KEY (IdCategoria) REFERENCES ddbbaTP.Categoria(IdCategoria);
END;
go
IF NOT EXISTS (
    SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_A_Cargo'
)
ALTER TABLE ddbbaTP.Socio
ADD CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES ddbbaTP.Socio(Nro_Socio);
GO
ALTER TABLE ddbbaTP.Categoria ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Actividad ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Clase ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Profesor ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Descuento ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Socio ADD Estado VARCHAR(10) DEFAULT 'Activo';
GO
ALTER TABLE ddbbaTP.Pago ADD Monto  DECIMAL(10,2);
GO
ALTER TABLE ddbbaTP.Reembolso ADD Monto  DECIMAL(10,2);
GO
ALTER TABLE ddbbaTP.Invitado ADD Dni INT CHECK (Dni BETWEEN 10000000 AND 99999999); --CHEQUEO QUE EL DNI SEA VÁLIDO
GO
ALTER TABLE ddbbaTP.Inscripto ADD Fecha_Inscripcion DATE  DEFAULT GETDATE();
GO
ALTER TABLE ddbbaTP.Anotado_En ADD FechaInscripcionA DATE  DEFAULT GETDATE();
GO

ALTER TABLE ddbbaTP.Colonia ADD Fecha_Fin DATE  DEFAULT GETDATE();
GO
ALTER TABLE ddbbaTP.Colonia ADD Fecha_Inicio DATE  DEFAULT GETDATE();
GO
ALTER TABLE ddbbaTP.Descuento ADD Porcentaje INT CHECK (Porcentaje >= 0);
go
---------------------------------------------STORE PROCEDURES ------------------------------------------------------------
------------------------------------------------------------------------------------------>INSERCIÓN
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarCategoria
	@Nombre VARCHAR (50),
	@Costo DECIMAL (10,2),
	@Vigencia DATE,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO ddbbaTP.Categoria (Nombre, Costo, Vigente_Hasta, Estado)
	VALUES (@Nombre, @Costo, @Vigencia, @Estado)
END;
go

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarSocio
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
	@NroSocio2 INT,
	@Estado VARCHAR (20)
AS
BEGIN
	INSERT INTO ddbbaTP.Socio (Dni, Nombre, Apellido, Email_Personal, Fecha_De_Nacimiento,
							   Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social,
							   Nro_Obra_Social, IdGrupoFamiliar, IdCategoria, NroSocio2, Estado )
	
	VALUES (@Dni, @Nombre, @Apellido, @Email, @Fecha_Nac, @Telf_Contacto, @Telf_Contacto_Emergencia,
			@Nombre_O_Social, @Nro_Obra_Social, @IdGrupoFamiliar, @IdCategoria, @NroSocio2, @Estado)
END;

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
go
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarGrupoFamiliar 
	@ID_Socio INT
AS
BEGIN
	INSERT INTO ddbbaTP.GrupoFamiliar (NroSocio)
	VALUES (@Id_Socio)
END;		
GO


--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividad
	@Nombre VARCHAR (100),
	@Costo DECIMAL (10,2),
	@Vigencia DATE,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO ddbbaTP.Actividad (Nombre, Costo, Vigente_Hasta, Estado)
	VALUES (@Nombre, @Costo, @Vigencia, @Estado)
END;
GO


--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarProfesor
	@Nombre VARCHAR (50),
	@Apellido VARCHAR (50),
	@Email VARCHAR (100),
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO ddbbaTP.Profesor (Nombre, Apellido, Email_Personal, Estado)
	VALUES (@Nombre, @Apellido, @Email, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarClase
	@Fecha DATE,
	@Hora TIME,
	@Dia VARCHAR (15),
	@Id_Profesor INT,
	@Id_Actividad INT,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO ddbbaTP.Clase (Fecha, Hora, Dia, IdProfesor, IdActividad, Estado)
	VALUES (@Fecha, @Hora, @Dia, @Id_Profesor, @Id_Actividad, @Estado)
END;
GO

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarCuota
    @Estado VARCHAR(20),
    @NroSocio INT
AS
BEGIN
    INSERT INTO ddbbaTP.Cuota (Estado, NroSocio)
    VALUES (@Estado, @NroSocio);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarDescuento
	@Tipo VARCHAR (50),
	@Id_GrupoFamiliar INT,
	@NroSocio INT,
	@Estado VARCHAR (10) = 'Activo'
AS
BEGIN
	INSERT INTO ddbbaTP.Descuento (Tipo, IdGrupoFamiliar, NroSocio, Estado)
	VALUES (@Tipo, @Id_GrupoFamiliar, @NroSocio, @Estado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarFactura
    @Fecha_Vencimiento DATE,
    @Dias_Atrasados INT,
    @Estado VARCHAR(20),
    @IdDescuento INT,
    @IdCuota INT
AS
BEGIN
    INSERT INTO ddbbaTP.Factura (Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
    VALUES (@Fecha_Vencimiento, @Dias_Atrasados, @Estado, @IdDescuento, @IdCuota);
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarCuenta
	@SaldoFavor DECIMAL (10,2),
	@NroSocio INT
AS
BEGIN
	INSERT INTO ddbbaTP.Cuenta (Saldo_Favor, NroSocio)
	VALUES (@SaldoFavor, @NroSocio)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarMedioDePago
	@Nombre VARCHAR (50),
	@Tipo VARCHAR (30),
	@Modalidad VARCHAR (30)
AS
BEGIN
	INSERT INTO ddbbaTP.MedioDePago (Nombre, Tipo, Modalidad)
	VALUES (@Nombre, @Tipo, @Modalidad)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPago
	@Fecha_de_pago DATE,
	@IdCuenta INT,
	@IdFactura INT,
	@IdMedio INT
AS
BEGIN
	INSERT INTO ddbbaTP.Pago (Fecha_de_pago, IdCuenta, IdFactura, IdMedioDePago)
	VALUES (@Fecha_de_pago, @IdCuenta, @IdFactura, @IdMedio)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarReembolso
	@Modalidad VARCHAR (30),
	@IdMedioDePago INT,
	@IdPago INT
AS
BEGIN
	INSERT INTO ddbbaTP.Reembolso (Modalidad, IdMedioDePago, IdPago)
	VALUES (@Modalidad, @IdMedioDePago, @IdPAGO)
END;
GO
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarInvitado
	@Nombre VARCHAR (20),
	@Nro_Socio INT,
	@Id_Factura INT
AS
BEGIN
	INSERT INTO ddbbaTP.Invitado (Nombre, Nro_Socio, IdFactura)
	VALUES (@Nombre, @Nro_Socio, @Id_Factura)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPasePileta
	@TarifaSocio DECIMAL (10,2),
	@TarifaInvitado DECIMAL (10,2),
	@NroSocio INT,
	@IdInvitado INT
AS
BEGIN
	INSERT INTO ddbbaTP.PasePileta (Tarifa_Socio, Tarifa_Invitado, NroSocio, IdInvitado)
	VALUES (@TarifaSocio, @TarifaInvitado, @NroSocio, @IdInvitado)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarActividadExtra
	@Tipo VARCHAR (50)
AS
BEGIN
	INSERT INTO ddbbaTP.ActividadExtra (Tipo)
	VALUES (@Tipo)
END;
GO

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarColonia
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
	INSERT INTO ddbbaTP.Colonia (IdActividadExtra, Precio)
	VALUES (@idAct_extra, @Precio)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarSum
	@IdAct_extra INT,
	@Precio DECIMAL (10,2)
AS
BEGIN
	INSERT INTO ddbbaTP.Sum_Recreativo (IdActividadExtra, Precio)
	VALUES (@idAct_extra, @Precio)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR ALTER PROCEDURE ddbbaTP.InsertarPileta
	@IdActExtra INT,
	@IdPasePileta INT,
	@Fec_Temporada DATE
AS
BEGIN
	INSERT INTO ddbbaTP.Pileta (IdActividadExtra, IdPasePileta, Fec_Temporada)
	VALUES (@IdActExtra, @IdPasePileta, @Fec_Temporada)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarAsiste
	@NroSocio INT,
	@IdClase INT
AS
BEGIN
	INSERT INTO ddbbaTP.Asiste (NroSocio, IdClase)
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarAnotadoEn
	@NroSocio INT,
	@IdClase INT
AS
BEGIN
	INSERT INTO ddbbaTP.Anotado_En (NroSocio, IdClase)
	VALUES (@NroSocio, @IdClase)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarInscripto
	@NroSocio INT,
	@IdActividad INT
AS
BEGIN
	INSERT INTO ddbbaTP.Inscripto (NroSocio, IdActiviDad)
	VALUES (@NroSocio, @IdActividad)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE OR ALTER PROCEDURE ddbbaTP.InsertarRealiza
	@NroSocio INT,
	@IdActividadExtra INT,
	@Fecha DATE
AS
BEGIN
	INSERT INTO ddbbaTP.Realiza (NroSocio, IdActividadExtra, Fecha)
	VALUES (@NroSocio, @IdActividadExtra, @Fecha)
END;
GO

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--Sp Para registrar una clase completa

CREATE OR ALTER PROCEDURE ddbbaTP.AltaClaseCompleta
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


------------------------------------------------------------------------------------------>MODIFICACION
-- =============================================
-- STORED PROCEDURES PARA MODIFICACIÓN DE DATOS
-- =============================================

-- Procedimiento para modificar un Socio
CREATE PROCEDURE ddbbaTP.ModificarSocio
    @NroSocio INT,
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
    @NroSocio2 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
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
    IF @NroSocio2 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio2)
    BEGIN
        RAISERROR('El socio a cargo con número %d no existe', 16, 1, @NroSocio2);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE ddbbaTP.Socio
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
            NroSocio2 = ISNULL(@NroSocio2, NroSocio2)
        WHERE Nro_Socio = @NroSocio;
        
        PRINT 'Socio modificado correctamente';
    END TRY
    BEGIN CATCH    
        throw;
    END CATCH
END;
GO

--//////////////////////////////////////////////////////////MODIFICAR//////////////////////////////////////////////////////
-- Procedimiento para modificar un Grupo Familiar
CREATE PROCEDURE ddbbaTP.ModificarGrupoFamiliar
    @IdGrupoFamiliar INT,
    @NroSocio INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el grupo familiar exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE ddbbaTP.GrupoFamiliar
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
CREATE PROCEDURE ddbbaTP.ModificarCategoria
    @IdCategoria INT,
    @Nombre VARCHAR(50) = NULL,
    @Costo DECIMAL(10,2) = NULL,
    @Vigente_Hasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la categoría exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Categoria WHERE IdCategoria = @IdCategoria)
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
        UPDATE ddbbaTP.Categoria
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
CREATE PROCEDURE ddbbaTP.ModificarActividad
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
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
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
    IF @IdCategoria IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Categoria WHERE IdCategoria = @IdCategoria)
    BEGIN
        RAISERROR('La categoría con ID %d no existe', 16, 1, @IdCategoria);
        RETURN;
    END
    -- Validar que la actividad padre exista si se proporciona
    IF @IdAct IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdAct)
    BEGIN
        RAISERROR('La actividad padre con ID %d no existe', 16, 1, @IdAct);
        RETURN;
    END
    BEGIN TRY
        UPDATE ddbbaTP.Actividad
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
CREATE PROCEDURE ddbbaTP.ModificarProfesor
    @IdProfesor INT,
    @Nombre VARCHAR(50) = NULL,
    @Apellido VARCHAR(50) = NULL,
    @Email_Personal VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el profesor exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Profesor WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Profesor
        SET Nombre = ISNULL(@Nombre, Nombre),
            Apellido = ISNULL(@Apellido, Apellido),
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
CREATE PROCEDURE ddbbaTP.ModificarClase
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
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
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
    IF @IdProfesor IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Profesor WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('El profesor con ID %d no existe', 16, 1, @IdProfesor);
        RETURN;
    END
    
    -- Validar que la actividad exista si se proporciona
    IF @IdActividad IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad con ID %d no existe', 16, 1, @IdActividad);
        RETURN;
    END
    
    BEGIN TRY        
        UPDATE ddbbaTP.Clase
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
CREATE PROCEDURE ddbbaTP.ModificarCuota
    @IdCuota INT,
    @Estado VARCHAR(20) = NULL,
    @NroSocio INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la cuota exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota)
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
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Cuota
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
CREATE PROCEDURE ddbbaTP.ModificarDescuento
    @IdDescuento INT,
    @Tipo VARCHAR(50) = NULL,
    @Porcentaje DECIMAL(5,2) = NULL,
    @IdGrupoFamiliar INT = NULL,
    @NroSocio INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el descuento exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento)
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
       ((SELECT IdGrupoFamiliar FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento) IS NULL AND
        (SELECT NroSocio FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento) IS NULL)
    BEGIN
        RAISERROR('Debe especificar al menos un grupo familiar o un socio', 16, 1);
        RETURN;
    END
    
    -- Validar que el grupo familiar exista si se proporciona
    IF @IdGrupoFamiliar IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar con ID %d no existe', 16, 1, @IdGrupoFamiliar);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Descuento
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
CREATE PROCEDURE ddbbaTP.ModificarActividadExtra
	@IdActExtra INT,
	@Tipo VARCHAR(50)=NULL
AS
BEGIN
	SET NOCOUNT ON;

	-- Validar que la actividad extra exista
	IF NOT EXISTS (SELECT 1 FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActExtra)
    BEGIN
        RAISERROR('La Actividad Extra con ID %d no existe', 16, 1, @IdActExtra);
        RETURN;
    END

	BEGIN TRY
		UPDATE ddbbaTP.ActividadExtra
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
CREATE PROCEDURE ddbbaTP.ModificarColonia
	@IdActExtra INT,
	@Precio DECIMAL(10,2),
	@FechaInicio DATE,
	@FechaFin DATE
AS
BEGIN
	SET NOCOUNT ON;

	-- Verificar que la actividad exista
	IF NOT EXISTS (SELECT 1 FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActExtra)
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
		UPDATE ddbbaTP.Colonia
		SET Precio = ISNULL(@Precio, Precio),
			Fecha_Fin = ISNULL(@FechaFin, Fecha_Fin),
			Fecha_Inicio = ISNULL(@FechaInicio, Fecha_Inicio)
		WHERE @IdActExtra = IdActividadExtra;
		PRINT 'Colonia modificada correctamente';
	END TRY
	BEGIN CATCH
		THROW
	END CATCH
END;
GO
-- Procedimiento para modificar una Factura
CREATE PROCEDURE ddbbaTP.ModificarFactura
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
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
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
    IF @IdCuota IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota)
    BEGIN
        RAISERROR('La cuota con ID %d no existe.', 16, 1, @IdCuota);
        RETURN;
    END

    -- Validar que el descuento exista si se proporciona
    IF @IdDescuento IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Descuento WHERE IdDescuento = @IdDescuento)
    BEGIN
        RAISERROR('El descuento con ID %d no existe.', 16, 1, @IdDescuento);
        RETURN;
    END

    BEGIN TRY
        -- Actualizar la factura
        UPDATE ddbbaTP.Factura
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
CREATE PROCEDURE ddbbaTP.ModificarAnotadoEn
    @NroSocio INT,
    @IdClase INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que la inscripción exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase)
    BEGIN
        RAISERROR('No existe una inscripción del socio %d en la clase %d', 16, 1, @NroSocio, @IdClase);
        RETURN;
    END
    
    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que la clase exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
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
        UPDATE ddbbaTP.Anotado_En
        SET FechaInscripcionA = ISNULL(@FechaInscripcion, FechaInscripcionA) 
        WHERE NroSocio = @NroSocio AND IdClase = @IdClase;
        
        PRINT 'Inscripción modificada correctamente';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Inscripto
CREATE PROCEDURE ddbbaTP.ModificarInscripto
    @NroSocio INT,
    @IdActividad INT,
    @FechaInscripcion DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la actividad exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Actividad WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad con ID %d no existe.', 16, 1, @IdActividad);
        RETURN;
    END

    -- Validar que exista la inscripción (suponiendo tabla Inscripcion con esa relación)
    IF NOT EXISTS (
        SELECT 1 FROM ddbbaTP.Inscripto
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
        UPDATE ddbbaTP.Inscripto
        SET Fecha_Inscripcion = ISNULL(@FechaInscripcion, Fecha_Inscripcion)
        WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad;

        PRINT 'Inscripción modificada correctamente.';
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO
-- Procedimiento para modificar un Invitado
CREATE PROCEDURE ddbbaTP.ModificarInvitado
    @IdInvitado INT,
    @Nombre VARCHAR(50),
    @Dni INT = NULL,
    @NroSocio INT,
    @IdFactura INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el invitado exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado)
    BEGIN
        RAISERROR('El invitado con ID %d no existe.', 16, 1, @IdInvitado);
        RETURN;
    END

    -- Validar que el socio exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe.', 16, 1, @NroSocio);
        RETURN;
    END

    -- Validar que la factura exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
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
        UPDATE ddbbaTP.Invitado
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
CREATE PROCEDURE ddbbaTP.ModificarMedioDePago
    @IdMedioPago INT,
    @Nombre VARCHAR(50),
    @Tipo VARCHAR(30),
    @Modalidad VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que el medio de pago exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioPago)
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
        UPDATE ddbbaTP.MedioDePago
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
CREATE PROCEDURE ddbbaTP.ModificarPago
    @IdPago INT,
    @FechaPago DATE = NULL,
    @Monto DECIMAL(10,2) = NULL,
    @IdCuenta INT = NULL,
    @IdFactura INT = NULL,
    @IdMedioDePago INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el pago exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdPago = @IdPago)
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
    IF @IdCuenta IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Cuenta WHERE IdCuenta = @IdCuenta)
    BEGIN
        RAISERROR('La cuenta con ID %d no existe', 16, 1, @IdCuenta);
        RETURN;
    END
    
    -- Validar que la factura exista si se proporciona
    IF @IdFactura IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdFactura = @IdFactura)
    BEGIN
        RAISERROR('La factura con ID %d no existe', 16, 1, @IdFactura);
        RETURN;
    END
    
    -- Validar que el medio de pago exista si se proporciona
    IF @IdMedioDePago IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioDePago)
    BEGIN
        RAISERROR('El medio de pago con ID %d no existe', 16, 1, @IdMedioDePago);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.Pago
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
CREATE PROCEDURE ddbbaTP.ModificarPasePileta
    @IdPasePileta INT,
    @TarifaSocio DECIMAL(10,2) = NULL,
    @TarifaInvitado DECIMAL(10,2) = NULL,
    @NroSocio INT = NULL,
    @IdInvitado INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validar que el pase de pileta exista
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta)
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
       ((SELECT NroSocio FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL AND
        (SELECT IdInvitado FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta) IS NULL)
    BEGIN
        RAISERROR('Debe especificar al menos un socio o un invitado', 16, 1);
        RETURN;
    END
    
    -- Validar que el socio exista si se proporciona
    IF @NroSocio IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE Nro_Socio = @NroSocio)
    BEGIN
        RAISERROR('El socio con número %d no existe', 16, 1, @NroSocio);
        RETURN;
    END
    
    -- Validar que el invitado exista si se proporciona
    IF @IdInvitado IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado)
    BEGIN
        RAISERROR('El invitado con ID %d no existe', 16, 1, @IdInvitado);
        RETURN;
    END
    
    BEGIN TRY
        UPDATE ddbbaTP.PasePileta
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
    @IdPago INT = NULL
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
GO
------------------------------------------------------------------------------------>BORRADO
CREATE PROCEDURE ddbbaTP.BorrarSocio 
    @Nro_Socio INT
AS
BEGIN
    IF NOT EXISTS (select 1 from ddbbaTP.Socio where Nro_Socio=@Nro_Socio)
    BEGIN 
        RAISERROR('El socio %d no existe',16,1, @Nro_Socio);
        RETURN;
    END
    UPDATE ddbbaTP.Socio SET Estado='Inactivo' where Nro_Socio=@Nro_Socio;
END
GO

-- Borrar Grupo Familiar si no tiene socios activos asociados
CREATE PROCEDURE ddbbaTP.BorrarGrupoFamiliar
    @IdGrupoFamiliar INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.GrupoFamiliar WHERE IdGrupoFamiliar = @IdGrupoFamiliar)
    BEGIN
        RAISERROR('El grupo familiar no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE IdGrupoFamiliar = @IdGrupoFamiliar AND Estado = 'Activo')
    BEGIN
        RAISERROR('El grupo familiar tiene socios activos.', 16, 1);
        RETURN;
    END

    DELETE ddbbaTP.GrupoFamiliar where IdGrupoFamiliar= @IdGrupoFamiliar
END
GO

-- Borrar ActividadExtra
CREATE PROCEDURE ddbbaTP.BorrarActividadExtra
    @IdActividadExtra INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Realiza where IdActividadExtra = @IdActividadExtra)
    BEGIN
        RAISERROR('No se puede eliminar la actividad extra. Está asociada a registros.', 16, 1)
        RETURN
    END
    DELETE FROM ddbbaTP.Colonia WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.Sum_Recreativo WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.Pileta WHERE IdActividadExtra = @IdActividadExtra
    DELETE FROM ddbbaTP.ActividadExtra WHERE IdActExtra = @IdActividadExtra
END
GO

-- Borrar Factura (Borrado lógico)
CREATE PROCEDURE ddbbaTP.BorrarFactura
    @IdFactura INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Factura where IdFactura = @IdFactura)
    BEGIN
        RAISERROR('Factura no encontrada.', 16, 1)
        RETURN
    END
    UPDATE ddbbaTP.Factura 
    SET Estado = 'Inactivo' where IdFactura = @IdFactura
END
GO

-- Borrar Invitado
CREATE PROCEDURE ddbbaTP.BorrarInvitado
    @IdInvitado INT
AS
BEGIN
    DELETE FROM ddbbaTP.Invitado WHERE IdInvitado = @IdInvitado
END
GO

-- Borrar Categoria
CREATE PROCEDURE ddbbaTP.BorrarCategoria
    @IdCategoria INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Socio WHERE IdCategoria = @IdCategoria)
    BEGIN
        RAISERROR('La categoría está asociada a socios.', 16, 1)
        RETURN
    END
     UPDATE ddbbaTP.Categoria 
    SET Estado = 'Inactivo' where IdCategoria = @IdCategoria
END
GO

-- Borrado lógico en Actividad
CREATE PROCEDURE ddbbaTP.BorrarActividad
    @IdActividad INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Inscripto WHERE IdActividad = @IdActividad)
    BEGIN
        RAISERROR('La actividad tiene socios inscriptos.', 16, 1)
        RETURN
    END
    UPDATE ddbbaTP.Actividad
    SET Estado = 'Inactivo' where IdActividad = @IdActividad
END
GO

-- Borrado lógico en clase si no tiene socios anotados ni que asistan
CREATE PROCEDURE ddbbaTP.BorrarClase
    @IdClase INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase no existe.', 16, 1)
        RETURN
    END

    IF EXISTS (SELECT 1 FROM ddbbaTP.Anotado_En where IdClase = @IdClase) OR
       EXISTS (SELECT 1 FROM ddbbaTP.Asiste where IdClase = @IdClase)
    BEGIN
        RAISERROR('La clase tiene socios anotados o asistentes.', 16, 1)
        RETURN
    END
    UPDATE ddbbaTP.Clase
    SET Estado = 'Inactivo' where IdClase = @IdClase
END
GO

-- Borrado lógico profesor si no dicta clases 
CREATE PROCEDURE ddbbaTP.BorrarProfesor
    @IdProfesor INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Clase WHERE IdProfesor = @IdProfesor)
    BEGIN
        RAISERROR('No se puede eliminar el profesor porque dicta clases.', 16, 1)
        RETURN
    END
    UPDATE ddbbaTP.Profesor
    SET Estado = 'Inactivo' where IdProfesor = @IdProfesor
END
GO

-- Borrar Cuota 
CREATE PROCEDURE ddbbaTP.BorrarCuota
    @IdCuota INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdCuota = @IdCuota)
    BEGIN
        RAISERROR('La cuota está asociada a una factura.', 16, 1)
        RETURN
    END
    DELETE FROM ddbbaTP.Cuota WHERE IdCuota = @IdCuota
END
GO

-- Borrado lógico en Descuento
CREATE PROCEDURE ddbbaTP.BorrarDescuento
    @IdDescuento INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Factura WHERE IdDescuento = @IdDescuento)
    BEGIN
        RAISERROR('El descuento está asociado a una factura.', 16, 1)
        RETURN
    END
    UPDATE ddbbaTP.Descuento
    SET Estado = 'Inactivo' where IdDescuento = @IdDescuento
END
GO

-- Borrar Pago solo si no tiene un reembolso
CREATE PROCEDURE ddbbaTP.BorrarPago
    @IdPago INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Reembolso where IdPago = @IdPago)
    BEGIN
        RAISERROR('El pago tiene un reembolso asociado.', 16, 1)
        RETURN
    END
    DELETE FROM ddbbaTP.Pago where IdPago = @IdPago
END
GO

-- Borrar Cuenta si no tiene ningun pago
CREATE PROCEDURE ddbbaTP.BorrarCuenta
    @IdCuenta INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdCuenta = @IdCuenta)
    BEGIN
        RAISERROR('La cuenta tiene pagos registrados.', 16, 1)
        RETURN
    END
    DELETE FROM ddbbaTP.Cuenta WHERE IdCuenta = @IdCuenta
END
GO

-- Borrar Medio de Pago si no tiene pagos ni reembolsos
CREATE PROCEDURE ddbbaTP.BorrarMedioDePago
    @IdMedioDePago INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ddbbaTP.Pago WHERE IdMedioDePago = @IdMedioDePago)
        OR EXISTS (SELECT 1 FROM ddbbaTP.Reembolso WHERE IdMedioDePago = @IdMedioDePago)
    BEGIN
        RAISERROR('El medio de pago está en uso.', 16, 1)
        RETURN
    END
    DELETE FROM ddbbaTP.MedioDePago WHERE IdMedioPago = @IdMedioDePago
END
GO

-- Borrar Reembolso
CREATE PROCEDURE ddbbaTP.BorrarReembolso
    @IdReembolso INT
AS
BEGIN
    DELETE FROM ddbbaTP.Reembolso WHERE IdReembolso = @IdReembolso
END
GO

-- Borrar Pase Pileta
CREATE PROCEDURE ddbbaTP.BorrarPasePileta
    @IdPasePileta INT
AS
BEGIN
    DELETE FROM ddbbaTP.PasePileta WHERE IdPasePileta = @IdPasePileta
END
GO

-- Borrar Asiste
CREATE PROCEDURE ddbbaTP.BorrarAsiste
    @NroSocio INT,
    @IdClase INT
AS
BEGIN
    DELETE FROM ddbbaTP.Asiste WHERE NroSocio = @NroSocio AND IdClase = @IdClase
END
GO
 
-- Borrar Anotado_En
CREATE PROCEDURE ddbbaTP.BorrarAnotado
    @NroSocio INT,
    @IdClase INT
AS
BEGIN
    DELETE FROM ddbbaTP.Anotado_En WHERE NroSocio = @NroSocio AND IdClase = @IdClase
END
GO

-- Borrar Inscripto
CREATE PROCEDURE ddbbaTP.BorrarInscripto
    @NroSocio INT,
    @IdActividad INT
AS
BEGIN
    DELETE FROM ddbbaTP.Inscripto WHERE NroSocio = @NroSocio AND IdActividad = @IdActividad
END
GO

-- Borrar Realiza
CREATE PROCEDURE ddbbaTP.BorrarRealiza
    @NroSocio INT,
    @IdActividadExtra INT
AS
BEGIN
    DELETE FROM ddbbaTP.Realiza WHERE NroSocio = @NroSocio AND IdActividadExtra = @IdActividadExtra
END
GO



 

