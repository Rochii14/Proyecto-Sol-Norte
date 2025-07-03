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
*INTEGRANTES: 45318374 | Di Marco Jazmín
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Rocío Elizabeth
*/

-------------------------------------CREACIÓN DE OBJETOS-------------------------------
<<<<<<< HEAD

-----------CREACIÓN DE LA BASE DE DATOS

USE master
go

IF NOT EXISTS ( SELECT name FROM master.dbo.sysdatabases WHERE name = 'Com5600G08' )
BEGIN
	CREATE DATABASE Com5600G08
	COLLATE Modern_Spanish_CI_AS
END;
go

USE Com5600G08
go

-----------CREACIÓN DE LOS SCHEMAS

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Socios')
BEGIN
	EXEC ('CREATE SCHEMA Socios')
END;
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Clases')
BEGIN
	EXEC ('CREATE SCHEMA Clases')
END;
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Facturacion')
BEGIN
	EXEC ('CREATE SCHEMA Facturacion')
END;
go

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Accesos')
BEGIN
	EXEC ('CREATE SCHEMA Accesos')
END;
go

-----------CREACIÓN DE TABLAS

-- Tabla SOCIO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Socios' AND TABLE_NAME = 'Socio')
BEGIN
	CREATE TABLE Socios.Socio (
		NroSocio VARCHAR(10) PRIMARY KEY,
		Dni INT CHECK (Dni BETWEEN 10000000 AND 999999999), --CHEQUEO QUE EL DNI SEA VÁLIDO
		Nombre VARCHAR(50),
		Apellido VARCHAR(50),
		Email_Personal VARCHAR(100),
		Fecha_De_Nacimiento VARCHAR(10),
		Telefono_Contacto VARCHAR(20),
		Telef_C_Emergencia VARCHAR(20),
		Nombre_Obra_Social VARCHAR(100),
		Nro_Obra_Social VARCHAR(50),
		IdGrupoFamiliar INT,
		IdCategoria INT,
		Estado VARCHAR(10) DEFAULT 'Activo',
		NroSocio2 VARCHAR(10), --RELACIÓN UNARIA
		---LAS AGREGO A LO ULTIMO PARA QUE NO TUVIERA CONFLICTO REFERENCIAL
		--CONSTRAINT FK_Socio_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES GrupoFamiliar(Id),
		--CONSTRAINT FK_Socio_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
		--CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES Socio(Nro_Socio)
	);	
END;   --1
go

-- Tabla GRUPO FAMILIAR

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Socios' AND TABLE_NAME = 'GrupoFamiliar')
BEGIN
	CREATE TABLE Socios.GrupoFamiliar (
		IdGrupoFamiliar INT IDENTITY(1,1) PRIMARY KEY,
		NroSocio VARCHAR(10),
		CONSTRAINT FK_GrupoFamiliar_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio) 
	);
END;   --2
go

-- Tabla CATEGORIA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Socios' AND TABLE_NAME = 'Categoria')
BEGIN
    CREATE TABLE Socios.Categoria (
        IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(50),
        Costo DECIMAL(10,2) CHECK (Costo >= 0),  --validacion costo positivo
        Vigente_Hasta VARCHAR(10),
        Estado VARCHAR(10) DEFAULT 'Activo'
    );
END;   --3
go

-- Tabla CUENTA



-- Tabla ACTIVIDAD

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Actividad')
BEGIN
	CREATE TABLE Clases.Actividad (
		IdActividad INT IDENTITY(1,1) PRIMARY KEY,
		Nombre VARCHAR(100),
		Costo DECIMAL(10,2) CHECK (Costo >= 0), --validacion costo positivo
		Vigente_Hasta VARCHAR(10),
		Estado VARCHAR(10) DEFAULT 'Activo'
	);
END;   --4
go

-- Tabla PROFESOR

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Profesor')
BEGIN
	CREATE TABLE Clases.Profesor (
		IdProfesor INT IDENTITY(1,1) PRIMARY KEY,
		Nombre VARCHAR(50),
		Apellido VARCHAR(50),
		Email_Personal VARCHAR(100),
		Estado VARCHAR(10) DEFAULT 'Activo'
	);  
END;   --5
go

-- Tabla CLASE

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Clase')
BEGIN
	CREATE TABLE Clases.Clase (
		IdClase INT IDENTITY(1,1) PRIMARY KEY,
		Fecha VARCHAR(10),
		Hora TIME,
		Dia VARCHAR(15),
		IdProfesor INT,
		IdActividad INT,
		Estado VARCHAR(10) DEFAULT 'Activo',
		CONSTRAINT FK_Clase_Profesor FOREIGN KEY (IdProfesor) REFERENCES Clases.Profesor(IdProfesor),
		CONSTRAINT FK_Clase_Actividad FOREIGN KEY (IdActividad) REFERENCES Clases.Actividad(IdActividad)
	);
END;   --6
go

-- Tabla CUOTA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'Cuota')
BEGIN
	CREATE TABLE Facturacion.Cuota (
		IdCuota INT IDENTITY(1,1) PRIMARY KEY,
		Estado VARCHAR(20),
		NroSocio VARCHAR(10),
		CONSTRAINT FK_Cuota_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio)
	);
END;   --7
go

-- Tabla DESCUENTO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'Descuento')
BEGIN
	CREATE TABLE Facturacion.Descuento (
		IdDescuento INT IDENTITY(1,1) PRIMARY KEY,
		Tipo VARCHAR(50),
		IdGrupoFamiliar INT,
		NroSocio VARCHAR(10),
		Estado VARCHAR(10) DEFAULT 'Activo',
		Porcentaje INT CHECK (Porcentaje >= 0),
		CONSTRAINT FK_Descuento_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES Socios.GrupoFamiliar(IdGrupoFamiliar),
		CONSTRAINT FK_Descuento_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio)
	);
END;   --8
go

-- Tabla FACTURA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'Factura')
BEGIN
	CREATE TABLE Facturacion.Factura (
		IdFactura INT IDENTITY(1,1) PRIMARY KEY,
		Fecha_Vencimiento VARCHAR(10),
		Dias_Atrasados INT,
		Estado VARCHAR(20),
		IdDescuento INT,
		IdCuota INT,
		CONSTRAINT FK_Factura_Descuento FOREIGN KEY (IdDescuento) REFERENCES Facturacion.Descuento(IdDescuento),
		CONSTRAINT FK_Factura_Cuota FOREIGN KEY (IdCuota) REFERENCES Facturacion.Cuota(IdCuota)
	);
END;   --9 
go

--Tabla CUENTA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Socios' AND TABLE_NAME = 'Cuenta')
BEGIN
	CREATE TABLE Socios.Cuenta (
		IdCuenta INT IDENTITY(1,1) PRIMARY KEY,
		Saldo_Favor DECIMAL(10,2) DEFAULT(0) CHECK (Saldo_Favor >= 0) ,
		NroSocio VARCHAR(10),
		CONSTRAINT FK_Cuenta_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio)
	);
END;   --10
go

-- Tabla MEDIO DE PAGO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'MedioDePago')
BEGIN
	CREATE TABLE Facturacion.MedioDePago (
		IdMedioPago INT IDENTITY(1,1) PRIMARY KEY,
		Nombre VARCHAR(50),
		Tipo VARCHAR(30),
		Modalidad VARCHAR(30)
	);
END;   --11
go

-- Tabla PAGO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'Pago')
BEGIN
	CREATE TABLE Facturacion.Pago (
		IdPago BIGINT PRIMARY KEY,
		Fecha_de_Pago VARCHAR(10),
		IdCuenta INT,
		IdFactura INT,
		IdMedioDePago INT,
		Monto  DECIMAL(10,2),
		CONSTRAINT FK_Pago_Cuenta FOREIGN KEY (IdCuenta) REFERENCES Socios.Cuenta(IdCuenta),
		CONSTRAINT FK_Pago_Factura FOREIGN KEY (IdFactura) REFERENCES Facturacion.Factura(IdFactura),
		CONSTRAINT FK_Pago_MedioDePago FOREIGN KEY (IdMedioDePago) REFERENCES Facturacion.MedioDePago(IdMedioPago)
	);
END;   --12
go

-- Tabla REEMBOLSO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Facturacion' AND TABLE_NAME = 'Reembolso')
BEGIN
	CREATE TABLE Facturacion.Reembolso (
		IdReembolso INT IDENTITY(1,1) PRIMARY KEY,
		Modalidad VARCHAR(30),
		IdMedioDePago INT,
		IdPago BIGINT,
		Monto  DECIMAL(10,2),
		CONSTRAINT FK_Reembolso_MedioDePago FOREIGN KEY (IdMedioDePago) REFERENCES Facturacion.MedioDePago(IdMedioPago),
		CONSTRAINT FK_Reembolso_Pago FOREIGN KEY (IdPago) REFERENCES Facturacion.Pago(IdPago)
	);
END;   --13
go

-- Tabla INVITADO (entidad débil)

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Invitado')
BEGIN
	CREATE TABLE Accesos.Invitado (
		Dni INT CHECK (Dni BETWEEN 100000000 AND 999999999),
		IdInvitado INT IDENTITY(1,1),
		Nombre VARCHAR(50),
		Nro_Socio VARCHAR(10),
		IdFactura INT,
		CONSTRAINT PK_Invitado_Socio PRIMARY KEY (IdInvitado,Nro_Socio),
		CONSTRAINT FK_Invitado_Socio FOREIGN KEY (Nro_Socio) REFERENCES Socios.Socio(NroSocio),
		CONSTRAINT FK_Invitado_Factura FOREIGN KEY (IdFactura) REFERENCES Facturacion.Factura(IdFactura)
	);
END;   --14
go

-- Tabla PASE PILETA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'PasePileta')
BEGIN
	CREATE TABLE Accesos.PasePileta (
		IdPasePileta INT IDENTITY(1,1) PRIMARY KEY,
		Tarifa_Socio DECIMAL(10,2) CHECK (Tarifa_Socio >= 0), --valido que sea positivo
		Tarifa_Invitado DECIMAL(10,2) CHECK (Tarifa_Invitado >= 0), --valido que sea positivo
		NroSocio VARCHAR(10),
		IdInvitado INT,
		CONSTRAINT FK_PasePileta_Invitado FOREIGN KEY (IdInvitado,NroSocio) REFERENCES Accesos.Invitado(IdInvitado,Nro_Socio)
	);
END;   --15
go

-- Tabla ACTIVIDAD EXTRA (jerarquía)

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'ActividadExtra')
BEGIN
	CREATE TABLE Accesos.ActividadExtra (
		IdActExtra INT IDENTITY(1,1) PRIMARY KEY,
		Tipo VARCHAR(50)
	);
END;   --16
go

-- Tabla COLONIA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Colonia')
BEGIN
	CREATE TABLE Accesos.Colonia (
		IdActividadExtra INT PRIMARY KEY,
		FechaFin VARCHAR(10),
		FechaInicio VARCHAR(10),
		Precio DECIMAL(10,2) CHECK (Precio >= 0), --VALIDACIÓN DE costo positivo
		CONSTRAINT FK_Colonia_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES Accesos.ActividadExtra(IdActExtra)
	);
END;   --17
go

-- Tabla SUM_RECREATIVO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Sum_Recreativo')
BEGIN
	CREATE TABLE Accesos.Sum_Recreativo (
		IdActividadExtra INT PRIMARY KEY,
		Precio DECIMAL(10,2) CHECK (Precio >= 0), --valido que sea positivo
		CONSTRAINT FK_Sum_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES Accesos.ActividadExtra(IdActExtra)
	);
END;   --18
go

-- Tabla PILETA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Pileta')
BEGIN
	CREATE TABLE Accesos.Pileta (
		IdActividadExtra INT,
		IdPasePileta INT,
		Fec_Temporada DATE,
		CONSTRAINT PK_Pileta PRIMARY KEY (IdActividadExtra, Fec_Temporada),
		CONSTRAINT FK_Pileta_ActividadExtra FOREIGN KEY (IdActividadExtra) REFERENCES Accesos.ActividadExtra(IdActExtra),
		CONSTRAINT FK_Pileta_PasePileta FOREIGN KEY (IdPasePileta) REFERENCES Accesos.PasePileta(IdPasePileta)
	);
END;   --19
go

-- Tabla ASISTE

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Asiste')
BEGIN
	CREATE TABLE Clases.Asiste (
		NroSocio VARCHAR(10),
		IdClase INT,
		CONSTRAINT PK_Asiste PRIMARY KEY (NroSocio, IdClase),
		CONSTRAINT FK_Asiste_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio),
		CONSTRAINT FK_Asiste_Clase FOREIGN KEY (IdClase) REFERENCES Clases.Clase(IdClase)
	);
END;   --20
go

-- Tabla ANOTADO_EN

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Anotado_En')
BEGIN
	CREATE TABLE Clases.Anotado_En (
		NroSocio VARCHAR(10),
		IdClase INT,
		FechaInscripcion VARCHAR(20),
		CONSTRAINT PK_Anotado_En PRIMARY KEY (NroSocio, IdClase),
		CONSTRAINT FK_Anotado_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio),
		CONSTRAINT FK_Anotado_Clase FOREIGN KEY (IdClase) REFERENCES Clases.Clase(IdClase)
	);
END;   --21
go

-- Tabla INSCRIPTO
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Clases' AND TABLE_NAME = 'Inscripto')
BEGIN
	CREATE TABLE Clases.Inscripto (
		NroSocio VARCHAR(10),
		IdActividad INT,
		FechaInscripcion VARCHAR(10),
		CONSTRAINT PK_Inscripto PRIMARY KEY (NroSocio, IdActividad),
		CONSTRAINT FK_Inscripto_Socio FOREIGN KEY (NroSocio) REFERENCES Socios. Socio(NroSocio),
		CONSTRAINT FK_Inscripto_Actividad FOREIGN KEY (IdActividad) REFERENCES Clases.Actividad(IdActividad)
	);
END;   --22
go

-- Tabla REALIZA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Realiza')
BEGIN
	CREATE TABLE Accesos.Realiza(
		NroSocio VARCHAR(10),
		IdActividadExtra INT,
		Fecha VARCHAR(10),
		CONSTRAINT PK_Realiza PRIMARY KEY (NroSocio, IdActividadExtra),
		CONSTRAINT FK_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(NroSocio),
		CONSTRAINT FK_Inscripto_Actividad_Extra FOREIGN KEY (IdActividadExtra) REFERENCES Accesos.ActividadExtra(IdActExtra)
	);
END;   --23
go

-- Tabla DIA_LLUVIA

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'Dia_Lluvia')
BEGIN
	CREATE TABLE Accesos.Dia_LLuvia( --relación 1:1 con reembolso
			Fecha DATE,
			CONSTRAINT PK_dia_lluvia PRIMARY KEY (fecha),
	);
END;   --24
go

----SOLUCIONO PROBLEMA DE INTEGRIDAD CON LAS CONSTRAINTS

-- Solo si no existe ya esta constraint

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_GrupoFamiliar_Socio')
BEGIN
    ALTER TABLE Socios.GrupoFamiliar
    ADD CONSTRAINT FK_GrupoFamiliar_Socio FOREIGN KEY (NroSocio) REFERENCES Socios.Socio(Nro_Socio);
END;
go

-- Agregar constraints en Socio
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_GrupoFamiliar')
BEGIN
	ALTER TABLE Socios.Socio
	ADD CONSTRAINT FK_Socio_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES Socios.GrupoFamiliar(IdGrupoFamiliar);
END;
go

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_Categoria')
BEGIN
	ALTER TABLE Socios.Socio
	ADD CONSTRAINT FK_Socio_Categoria FOREIGN KEY (IdCategoria) REFERENCES Socios.Categoria(IdCategoria);
END;
go

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Socio_A_Cargo')
BEGIN
	ALTER TABLE Socios.Socio
	ADD CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES Socios.Socio(NroSocio);
END;
go


----CAMBIOS REALIZADOS DESPUÉS DE LA CREACIÓN DE LAS TABLAS


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Accesos' AND TABLE_NAME = 'TarifaPileta')
BEGIN
	CREATE TABLE Accesos.TarifaPileta (
		IdTarifa INT IDENTITY(1,1),

		TipoTarifa VARCHAR(50) NOT NULL,  -- Ej: 'Día', 'Mes', 'Temporada'
		TipoPersona VARCHAR(50) NOT NULL, -- Ej: 'Adulto', 'Menor de 12 años'

		MontoSocio DECIMAL(12,2) NOT NULL CHECK (MontoSocio >= 0),
		MontoInvitado DECIMAL(12,2) NULL CHECK (MontoInvitado >= 0), -- puede ser NULL si no aplica

		VigenteHasta DATE NOT NULL CHECK (VigenteHasta >= '2025-01-01'), --pondría getdate() pero los datos los dubo por primera vez y me daría error.

		CONSTRAINT CK_TarifaPileta_TipoTarifa CHECK (TipoTarifa IN ('Día', 'Mes', 'Temporada')),
		CONSTRAINT CK_TarifaPileta_TipoPersona CHECK (TipoPersona IN ('Adulto', 'Menor de 12 años')),
		CONSTRAINT PK_Tarifa PRIMARY KEY (IdTarifa)
	);
END;   --25
go

ALTER TABLE Facturacion.Reembolso
ADD FechaLLuvia DATE
go

ALTER TABLE Facturacion.Reembolso  
ADD CONSTRAINT FK_ReembolsoLLuvia FOREIGN KEY (FechaLLuvia) REFERENCES Accesos.Dia_Lluvia(Fecha) ----Reembolso debería estar cargado previamente por el tema de los 
go

ALTER TABLE Facturacion.Factura ADD Detalle VARCHAR (50)
go

ALTER TABLE Socios.Socio ADD Telefono_Emergencia_2 VARCHAR (30)
go

ALTER TABLE Accesos.PasePileta ADD IdTarifa INT FOREIGN KEY REFERENCES Accesos.TarifaPileta(IdTarifa)
go

ALTER TABLE Accesos.TarifaPileta ALTER COLUMN VigenteHasta DATE;
go

ALTER TABLE Clases.Profesor DROP COLUMN Apellido
go

ALTER TABLE Clases.Profesor DROP COLUMN Nombre
go

ALTER TABLE Clases.Profesor ADD Nombre_Completo VARCHAR (100)
go

ALTER TABLE Facturacion.Factura
ALTER COLUMN Detalle VARCHAR(200) NULL;
go

ALTER TABLE Facturacion.Factura
ALTER COLUMN Fecha_Vencimiento DATE;
go

ALTER TABLE Facturacion.Cuota
ADD Socio_Cuota VARCHAR (10);
go

ALTER TABLE Accesos.Invitado
ADD Fecha_De_Nacimiento VARCHAR(10)
go

ALTER TABLE Facturacion.Factura
ADD Fecha_Emision VARCHAR(10)
go

ALTER TABLE Facturacion.Factura
ADD Fecha_Vencimiento2 VARCHAR(10)
go

ALTER TABLE Accesos.Pileta
DROP CONSTRAINT FK_Pileta_PasePileta
go

ALTER TABLE Accesos.Pileta
DROP COLUMN IdPasePileta
go

ALTER TABLE Accesos.PasePileta
ADD IdActividadExtra INT, Fec_Temporada DATE
go

ALTER TABLE Accesos.PasePileta
ADD CONSTRAINT FK_PasePileta_Pileta FOREIGN KEY (IdActividadExtra, Fec_Temporada) REFERENCES Accesos.Pileta(IdActividadExtra, Fec_Temporada);
go

ALTER TABLE Facturacion.Factura
ADD Monto_Total DECIMAL(10,2);
go

ALTER TABLE Facturacion.Cuota
ADD IdActividadExtra INT;
go

ALTER TABLE Facturacion.Cuota
ADD CONSTRAINT FK_Actividad_Extra FOREIGN KEY (IdActividadExtra) REFERENCES Accesos.ActividadExtra(IdActExtra);
go
ALTER TABLE Facturacion.Reembolso
ADD CONSTRAINT UQ_Reembolso_IdPago_Modalidad
UNIQUE (IdPago, Modalidad);       ----- es para evitar inserciones a mano en los reembolsos
=======
CREATE DATABASE Com5600G08
GO 
USE Com5600G08
go

CREATE SCHEMA ddbbaTP
go
-- Tabla SOCIO
CREATE TABLE ddbbaTP.Socio (
    NroSocio VARCHAR(10) PRIMARY KEY,
    Dni INT CHECK (Dni BETWEEN 10000000 AND 999999999), --CHEQUEO QUE EL DNI SEA VÁLIDO
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email_Personal VARCHAR(100),
    Fecha_De_Nacimiento VARCHAR(10),
    Telefono_Contacto VARCHAR(20),
    Telef_C_Emergencia VARCHAR(20),
    Nombre_Obra_Social VARCHAR(100),
    Nro_Obra_Social VARCHAR(50),
    IdGrupoFamiliar INT,
    IdCategoria INT,
	Estado VARCHAR(10) DEFAULT 'Activo',
    NroSocio2 VARCHAR(10), --RELACIÓN UNARIA
	---LAS AGREGO A LO ULTIMO PARA QUE NO TUVIERA CONFLICTO REFERENCIAL
    --CONSTRAINT FK_Socio_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES GrupoFamiliar(Id),
    --CONSTRAINT FK_Socio_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
    --CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES Socio(Nro_Socio)
);	--1
go
-- Tabla GRUPO FAMILIAR
CREATE TABLE ddbbaTP.GrupoFamiliar (
    IdGrupoFamiliar INT IDENTITY(1,1) PRIMARY KEY,
    NroSocio VARCHAR(10),
    CONSTRAINT FK_GrupoFamiliar_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio)
);   --2
go
-- Tabla CATEGORIA
CREATE TABLE ddbbaTP.Categoria (
    IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Costo DECIMAL(10,2) CHECK (Costo >= 0),		--validacion costo positivo
    Vigente_Hasta VARCHAR(10),
	Estado VARCHAR(10) DEFAULT 'Activo'
);  --3
go
-- Tabla ACTIVIDAD
CREATE TABLE ddbbaTP.Actividad (
    IdActividad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100),
    Costo DECIMAL(10,2) CHECK (Costo >= 0), --validacion costo positivo
    Vigente_Hasta VARCHAR(10),
	Estado VARCHAR(10) DEFAULT 'Activo'
);   --4
go

-- Tabla PROFESOR
CREATE TABLE ddbbaTP.Profesor (
    IdProfesor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email_Personal VARCHAR(100),
	Estado VARCHAR(10) DEFAULT 'Activo'
);  --5
go
-- Tabla CLASE
CREATE TABLE ddbbaTP.Clase (
    IdClase INT IDENTITY(1,1) PRIMARY KEY,
    Fecha VARCHAR(10),
    Hora TIME,
    Dia VARCHAR(15),
    IdProfesor INT,
    IdActividad INT,
	Estado VARCHAR(10) DEFAULT 'Activo',
    CONSTRAINT FK_Clase_Profesor FOREIGN KEY (IdProfesor) REFERENCES ddbbaTP.Profesor(IdProfesor),
    CONSTRAINT FK_Clase_Actividad FOREIGN KEY (IdActividad) REFERENCES ddbbaTP.Actividad(IdActividad)
);  --6
go
-- Tabla CUOTA
CREATE TABLE ddbbaTP.Cuota (
    IdCuota INT IDENTITY(1,1) PRIMARY KEY,
    Estado VARCHAR(20),
    NroSocio VARCHAR(10),
    CONSTRAINT FK_Cuota_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio)
); --7
go
-- Tabla DESCUENTO
CREATE TABLE ddbbaTP.Descuento (
    IdDescuento INT IDENTITY(1,1) PRIMARY KEY,
    Tipo VARCHAR(50),
    IdGrupoFamiliar INT,
    NroSocio VARCHAR(10),
	Estado VARCHAR(10) DEFAULT 'Activo',
	Porcentaje INT CHECK (Porcentaje >= 0),
    CONSTRAINT FK_Descuento_GrupoFamiliar FOREIGN KEY (IdGrupoFamiliar) REFERENCES ddbbaTP.GrupoFamiliar(IdGrupoFamiliar),
    CONSTRAINT FK_Descuento_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio)
);  --8
go
-- Tabla FACTURA
CREATE TABLE ddbbaTP.Factura (
    IdFactura INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Vencimiento VARCHAR(10),
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
    Saldo_Favor DECIMAL(10,2) DEFAULT(0) CHECK (Saldo_Favor >= 0) ,
    NroSocio VARCHAR(10),
    CONSTRAINT FK_Cuenta_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio)
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
    IdPago BIGINT PRIMARY KEY,
    Fecha_de_Pago VARCHAR(10),
    IdCuenta INT,
    IdFactura INT,
    IdMedioDePago INT,
	Monto  DECIMAL(10,2),
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
    IdPago BIGINT,
	Monto  DECIMAL(10,2),
    CONSTRAINT FK_Reembolso_MedioDePago FOREIGN KEY (IdMedioDePago) REFERENCES ddbbaTP.MedioDePago(IdMedioPago),
    CONSTRAINT FK_Reembolso_Pago FOREIGN KEY (IdPago) REFERENCES ddbbaTP.Pago(IdPago)
); --13
go
-- Tabla INVITADO (entidad débil)
CREATE TABLE ddbbaTP.Invitado (
	Dni INT CHECK (Dni BETWEEN 100000000 AND 999999999),
    IdInvitado INT IDENTITY(1,1),
    Nombre VARCHAR(50),
    Nro_Socio VARCHAR(10),
    IdFactura INT,
    CONSTRAINT PK_Invitado_Socio PRIMARY KEY (IdInvitado,Nro_Socio),
	CONSTRAINT FK_Invitado_Socio FOREIGN KEY (Nro_Socio) REFERENCES ddbbaTP.Socio(NroSocio),
    CONSTRAINT FK_Invitado_Factura FOREIGN KEY (IdFactura) REFERENCES ddbbaTP.Factura(IdFactura)
); --14
go
-- Tabla PASE PILETA
CREATE TABLE ddbbaTP.PasePileta (
    IdPasePileta INT IDENTITY(1,1) PRIMARY KEY,
    Tarifa_Socio DECIMAL(10,2) CHECK (Tarifa_Socio >= 0), --valido que sea positivo
    Tarifa_Invitado DECIMAL(10,2) CHECK (Tarifa_Invitado >= 0), --valido que sea positivo
    NroSocio VARCHAR(10),
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
	FechaFin VARCHAR(10),
	FechaInicio VARCHAR(10),
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
    NroSocio VARCHAR(10),
    IdClase INT,
    CONSTRAINT PK_Asiste PRIMARY KEY (NroSocio, IdClase),
    CONSTRAINT FK_Asiste_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio),
    CONSTRAINT FK_Asiste_Clase FOREIGN KEY (IdClase) REFERENCES ddbbaTP.Clase(IdClase)
); --20
go
CREATE TABLE ddbbaTP.Anotado_En (
    NroSocio VARCHAR(10),
    IdClase INT,
	FechaInscripcion VARCHAR(20),
    CONSTRAINT PK_Anotado_En PRIMARY KEY (NroSocio, IdClase),
    CONSTRAINT FK_Anotado_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio),
    CONSTRAINT FK_Anotado_Clase FOREIGN KEY (IdClase) REFERENCES ddbbaTP.Clase(IdClase)
); --21
go
CREATE TABLE ddbbaTP.Inscripto (
    NroSocio VARCHAR(10),
    IdActividad INT,
	FechaInscripcion VARCHAR(10),
    CONSTRAINT PK_Inscripto PRIMARY KEY (NroSocio, IdActividad),
    CONSTRAINT FK_Inscripto_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP. Socio(NroSocio),
    CONSTRAINT FK_Inscripto_Actividad FOREIGN KEY (IdActividad) REFERENCES ddbbaTP.Actividad(IdActividad)
); --22
go
CREATE TABLE ddbbaTP.Realiza(
	NroSocio VARCHAR(10),
	IdActividadExtra INT,
	Fecha VARCHAR(10),
	CONSTRAINT PK_Realiza PRIMARY KEY (NroSocio, IdActividadExtra),
	CONSTRAINT FK_Socio FOREIGN KEY (NroSocio) REFERENCES ddbbaTP.Socio(NroSocio),
    CONSTRAINT FK_Inscripto_Actividad_Extra FOREIGN KEY (IdActividadExtra) REFERENCES ddbbaTP.ActividadExtra(IdActExtra)
) --23
go
create table ddbbaTP.Dia_LLuvia --relación 1:1 con reembolso
(
	Fecha date,
	constraint PK_dia_lluvia primary key (fecha),
)

GO
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
ADD CONSTRAINT FK_Socio_A_Cargo FOREIGN KEY (NroSocio2) REFERENCES ddbbaTP.Socio(NroSocio);
GO


alter table ddbbaTP.Reembolso
add FechaLLuvia date
GO

alter table ddbbaTP.Reembolso  
add constraint FK_ReembolsoLLuvia foreign key (FechaLLuvia) references ddbbaTP.Dia_Lluvia(Fecha) ----Reembolso debería estar cargado previamente por el tema de los 
GO
--------------------------------------------------------------------------------------------

/*ALTER TABLE ddbbaTP.Categoria ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Actividad ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Clase ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Profesor ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Descuento ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Socio ADD Estado VARCHAR(10) DEFAULT 'Activo'; -
GO
ALTER TABLE ddbbaTP.Pago ADD Monto  DECIMAL(10,2); -
GO
ALTER TABLE ddbbaTP.Reembolso ADD Monto  DECIMAL(10,2);-
GO
ALTER TABLE ddbbaTP.Invitado ADD Dni INT CHECK (Dni BETWEEN 10000000 AND 99999999); --CHEQUEO QUE EL DNI SEA VÁLIDO
GO
ALTER TABLE ddbbaTP.Inscripto ADD FechaInscripcion DATE  DEFAULT GETDATE(); -
GO
ALTER TABLE ddbbaTP.Anotado_En ADD FechaInscripcionA DATE  DEFAULT GETDATE(); -
GO

ALTER TABLE ddbbaTP.Colonia ADD FechaFin DATE  DEFAULT GETDATE(); -
GO
ALTER TABLE ddbbaTP.Colonia ADD FechaInicio DATE  DEFAULT GETDATE();-
GO
ALTER TABLE ddbbaTP.Descuento ADD Porcentaje INT CHECK (Porcentaje >= 0);-
go*/


------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE ddbbaTP.Factura ADD Detalle VARCHAR (50)
go

ALTER TABLE ddbbaTP.Socio ADD Telefono_Emergencia_2 VARCHAR (30)
go

CREATE TABLE ddbbaTP.TarifaPileta (
    IdTarifa INT IDENTITY(1,1),

    TipoTarifa VARCHAR(50) NOT NULL,  -- Ej: 'Día', 'Mes', 'Temporada'
    TipoPersona VARCHAR(50) NOT NULL, -- Ej: 'Adulto', 'Menor de 12 años'

    MontoSocio DECIMAL(12,2) NOT NULL CHECK (MontoSocio >= 0),
    MontoInvitado DECIMAL(12,2) NULL CHECK (MontoInvitado >= 0), -- puede ser NULL si no aplica

    VigenteHasta DATE NOT NULL CHECK (VigenteHasta >= '2025-01-01'), --pondría getdate() pero los datos los dubo por primera vez y me daría error.

    CONSTRAINT CK_TarifaPileta_TipoTarifa CHECK (TipoTarifa IN ('Día', 'Mes', 'Temporada')),
    CONSTRAINT CK_TarifaPileta_TipoPersona CHECK (TipoPersona IN ('Adulto', 'Menor de 12 años')),
	CONSTRAINT PK_Tarifa primary key (IdTarifa)
);
go

ALTER TABLE ddbbaTP.PasePileta ADD IdTarifa INT FOREIGN KEY REFERENCES ddbbaTP.TarifaPileta(IdTarifa)
go

ALTER TABLE ddbbaTP.TarifaPileta ALTER COLUMN VigenteHasta DATE;
go

ALTER TABLE ddbbaTP.Profesor DROP COLUMN Apellido
go

ALTER TABLE ddbbaTP.Profesor DROP COLUMN Nombre
go

ALTER TABLE ddbbaTP.Profesor ADD Nombre_Completo VARCHAR (100)
go

UPDATE ddbbaTP.Socio
SET NroSocio2 = NULL
WHERE 
    TRY_CONVERT(DATE, Fecha_De_Nacimiento, 103) IS NOT NULL AND
    DATEDIFF(YEAR, TRY_CONVERT(DATE, Fecha_De_Nacimiento, 103), GETDATE()) >= 18;
>>>>>>> recuperar-historial
