/*ENTREGA 7
*FECHA DE ENTREGA: 20/06/2025
*COMISION:5600
*NUMERO DE GRUPO: 08
*NOMBRE DE LA MATERIA: Base de Datos Aplicadas
*INTEGRANTES: 45318374 | Di Marco Jazmín
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Rocío Elizabeth
*/
<<<<<<< HEAD

-------------------------------------------- CREACIÓN DE LOGINS -----------------------------------------------------
USE master
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Rocio_Tesoreria')
BEGIN
	CREATE LOGIN Rocio_Tesoreria WITH PASSWORD = 'Leon123'
END;
go
 
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Jazmin_Socios')
BEGIN
	CREATE LOGIN Jazmin_Socios 
	WITH PASSWORD = 'Elefante123',
	CHECK_POLICY = OFF,
	CHECK_EXPIRATION = OFF;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Samuel_Presidente')
BEGIN
	CREATE LOGIN Samuel_Presidente 
	WITH PASSWORD = 'Oso123',
	DEFAULT_DATABASE = Com5600G08,
	CHECK_POLICY = OFF,
	CHECK_EXPIRATION = OFF;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Gabriel_Tesoreria')
BEGIN
	CREATE LOGIN Gabriel_Tesoreria WITH PASSWORD = 'Puma123'
END;
go

-------------------------------------------- CREACIÓN DE USUARIOS EN LA BASE DE DATOS --------------------------------------------

USE Com5600G08;
go


IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Rocio_Tesoreria')
BEGIN
    CREATE USER Rocio_Tesoreria FOR LOGIN Rocio_Tesoreria;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Jazmin_Socios')
BEGIN
	CREATE USER Jazmin_Socios FOR LOGIN Jazmin_Socios;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Samuel_Presidente')
BEGIN
    CREATE USER Samuel_Presidente FOR LOGIN Samuel_Presidente;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Gabriel_Tesoreria')
BEGIN
	CREATE USER Gabriel_Tesoreria FOR LOGIN Gabriel_Tesoreria;
END;
go

----------------------------------------- CREACIÓN DE ROLES Y ASIGNACIÓN DE PERMISOS --------------------------------------------

--AREA TESORERIA: Jefe de tesoreria.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Jefe_De_Tesoreria')  
BEGIN
	CREATE ROLE Jefe_De_Tesoreria;
END;
go

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Facturacion  TO Jefe_De_Tesoreria;

GRANT SELECT, INSERT, UPDATE, DELETE ON Accesos.TarifaPileta TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON Socios.Cuenta		 TO Jefe_De_Tesoreria;


--AREA TESORERIA: Administrativo de cobranza.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Administrativo_De_Cobranza')
BEGIN
	CREATE ROLE Administrativo_De_Cobranza;
END;
go


GRANT SELECT ON Facturacion.MedioDePago					TO Administrativo_De_Cobranza;
GRANT SELECT, UPDATE ON Facturacion.Cuota				TO Administrativo_De_Cobranza;
GRANT SELECT, UPDATE ON Facturacion.Factura				TO Administrativo_De_Cobranza;
GRANT SELECT, INSERT, UPDATE ON Facturacion.Pago		TO Administrativo_De_Cobranza;	
GRANT SELECT, INSERT, UPDATE ON Facturacion.Reembolso	TO Administrativo_De_Cobranza;
GRANT SELECT, INSERT, UPDATE ON Socios.Cuenta			TO Administrativo_De_Cobranza; 


--AREA TESORERIA: Administrativo de morosidad.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Administrativo_De_Morosidad')
BEGIN
	CREATE ROLE Administrativo_De_Morosidad;
END;
go

GRANT SELECT ON SCHEMA::Facturacion TO Administrativo_De_Morosidad;

REVOKE SELECT ON Facturacion.MedioDePago FROM Administrativo_De_Morosidad;
REVOKE SELECT ON Facturacion.Pago		 FROM Administrativo_De_Morosidad;
REVOKE SELECT ON Facturacion.Reembolso	 FROM Administrativo_De_Morosidad;


--AREA TESORERIA: Administrativo de facturacion.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Administrativo_De_Facturacion')
BEGIN
	CREATE ROLE Administrativo_De_Facturacion;
END;
go

GRANT SELECT, INSERT, UPDATE  ON Facturacion.Cuota		TO Administrativo_De_Facturacion; 
GRANT SELECT, INSERT, UPDATE  ON Facturacion.Factura	TO Administrativo_De_Facturacion;
GRANT SELECT, INSERT, UPDATE  ON Facturacion.Descuento	TO Administrativo_De_Facturacion;


--AREA SOCIOS: Administrativo Socio.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Administrativo_Socio')
BEGIN
	CREATE ROLE Administrativo_Socio;
END;
go


GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Socios TO Administrativo_Socio;

REVOKE SELECT, INSERT, UPDATE, DELETE ON Socios.Categoria FROM Administrativo_Socio;


GRANT SELECT ON Accesos.ActividadExtra						  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Accesos.Realiza		  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Accesos.Invitado	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clases.Inscripto	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clases.Anotado_En	  TO Administrativo_Socio;
GRANT SELECT ON Clases.Actividad							  TO Administrativo_Socio;


--AREA SOCIOS: Socio_Web.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Socio_Web')
BEGIN
	CREATE ROLE Socio_Web;
END;
go

GRANT SELECT ON SCHEMA::Clases		 TO Socio_Web;
GRANT SELECT ON SCHEMA::Facturacion  TO Socio_Web;
GRANT SELECT ON SCHEMA::Accesos		 TO Socio_Web;

GRANT SELECT ON Socios.Socio								  TO Socio_Web;
GRANT SELECT ON Socios.Cuenta								  TO Socio_Web;
GRANT SELECT ON Socios.Categoria							  TO Socio_Web;

GRANT SELECT, UPDATE, INSERT, DELETE ON Accesos.Invitado	  TO Socio_Web;
GRANT SELECT, UPDATE, INSERT, DELETE ON Socios.GrupoFamiliar  TO Socio_Web;


--AREA AUTORIDADES: Presidente.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Presidente')
BEGIN
	CREATE ROLE Presidente;
END;
go

GRANT SELECT ON SCHEMA::Socios      TO Presidente;
GRANT SELECT ON SCHEMA::Facturacion TO Presidente;
GRANT SELECT ON SCHEMA::Clases      TO Presidente;
GRANT SELECT ON SCHEMA::Accesos     TO Presidente;


--AREA AUTORIDADES: Vicepresidente.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Vicepresidente')
BEGIN
	CREATE ROLE Vicepresidente;
END;
go

GRANT SELECT ON SCHEMA::Socios      TO Vicepresidente;
GRANT SELECT ON SCHEMA::Clases      TO Vicepresidente;
GRANT SELECT ON SCHEMA::Accesos     TO Vicepresidente;

REVOKE SELECT ON Socios.Cuenta FROM Vicepresidente;


--AREA AUTORIDADES: Secretario.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Secretario')
BEGIN
	CREATE ROLE Secretario;
END;
go

GRANT SELECT ON SCHEMA::Clases TO Secretario;

GRANT SELECT ON SCHEMA::Socios TO Secretario;
REVOKE SELECT ON Socios.Cuenta FROM Secretario; 


GRANT SELECT ON Accesos.Invitado		TO Secretario;
GRANT SELECT ON Accesos.ActividadExtra  TO Secretario;
GRANT SELECT ON Accesos.PasePileta      TO Secretario;


--AREA AUTORIDADES: Vocal.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Vocal')
BEGIN
	CREATE ROLE Vocal;
END;
go

GRANT SELECT ON Socios.Socio		    TO Vocal;
GRANT SELECT ON Socios.Categoria	    TO Vocal;
GRANT SELECT ON Clases.Actividad	    TO Vocal;
GRANT SELECT ON Clases.Clase		    TO Vocal;
GRANT SELECT ON Socios.GrupoFamiliar    TO Vocal;
GRANT SELECT ON Clases.Profesor			TO Vocal;
GRANT SELECT ON Accesos.ActividadExtra  TO Vocal;
GRANT SELECT ON Accesos.PasePileta      TO Vocal;


----------------------------------------- ASIGNACIÓN DE ROLES A USUARIOS --------------------------------------------

ALTER ROLE Jefe_De_Tesoreria ADD MEMBER Rocio_Tesoreria;
go

ALTER ROLE Administrativo_Socio ADD MEMBER Jazmin_Socios;
go

ALTER ROLE Presidente ADD MEMBER Samuel_Presidente;
go

ALTER ROLE Administrativo_De_Cobranza ADD MEMBER Gabriel_Tesoreria;
go
=======
USE Com5600G08
go

--CREACIÓN DE ROLES Y PERMISOS PARA EL AREA DE TESORERÍA

CREATE ROLE Jefe_De_Tesoreria;
go

GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Pago		 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Cuenta		 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Factura		 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Cuota		 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Descuento	 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Reembolso	 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.MedioDePago	 TO Jefe_De_Tesoreria;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.TarifaPileta TO Jefe_De_Tesoreria;


CREATE ROLE Administrativo_De_Cobranza;
go

GRANT SELECT ON ddbbaTP.MedioDePago					TO Administrativo_De_Cobranza;
GRANT SELECT, UPDATE ON ddbbaTP.Cuota				TO Administrativo_De_Cobranza;
GRANT SELECT, UPDATE ON ddbbaTP.Factura				TO Administrativo_De_Cobranza;
GRANT SELECT, INSERT, UPDATE ON ddbbaTP.Pago		TO Administrativo_De_Cobranza;		
GRANT SELECT, INSERT, UPDATE ON ddbbaTP.Cuenta		TO Administrativo_De_Cobranza; 
GRANT SELECT, INSERT, UPDATE ON ddbbaTP.Reembolso	TO Administrativo_De_Cobranza;


CREATE ROLE Administrativo_De_Morosidad;
go

GRANT SELECT ON ddbbaTP.Pago	TO Administrativo_De_Morosidad;
GRANT SELECT ON ddbbaTP.Cuota	TO Administrativo_De_Morosidad;
GRANT SELECT ON ddbbaTP.Factura	TO Administrativo_De_Morosidad;


CREATE ROLE Administrativo_De_Facturacion;
go

GRANT SELECT, INSERT, UPDATE  ON ddbbaTP.Cuota		TO Administrativo_De_Facturacion; 
GRANT SELECT, INSERT, UPDATE  ON ddbbaTP.Factura	TO Administrativo_De_Facturacion;
GRANT SELECT, INSERT, UPDATE  ON ddbbaTP.Descuento	TO Administrativo_De_Facturacion;

----------------------------------------------------------------------------------------------------------------------------------
--CREACIÓN DE ROLES Y PERMISOS PAR EL AREA DE SOCIOS

CREATE ROLE Administrativo_Socio;
go

GRANT SELECT ON ddbbaTP.Categoria							  TO Administrativo_Socio;
GRANT SELECT ON ddbbaTP.Actividad							  TO Administrativo_Socio;
GRANT SELECT ON ddbbaTP.ActividadExtra						  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE ON ddbbaTP.Socio				  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Realiza		  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Invitado	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Inscripto	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.Anotado_En	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON ddbbaTP.GrupoFamiliar TO Administrativo_Socio;


CREATE ROLE Socio_Web
go

GRANT SELECT ON ddbbaTP.Pago								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Cuota								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Socio								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Cuenta								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Factura								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Realiza								  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Inscripto							  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Categoria							  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Actividad					          TO Socio_Web;
GRANT SELECT ON ddbbaTP.Descuento							  TO Socio_Web;
GRANT SELECT ON ddbbaTP.Anotado_En							  TO Socio_Web;
GRANT SELECT ON ddbbaTP.PasePileta							  TO Socio_Web;
GRANT SELECT ON ddbbaTP.TarifaPileta						  TO Socio_Web;
GRANT SELECT, UPDATE, INSERT, DELETE ON ddbbaTP.Invitado	  TO Socio_Web;
GRANT SELECT, UPDATE, INSERT, DELETE ON ddbbaTP.GrupoFamiliar TO Socio_Web;

----------------------------------------------------------------------------------------------------------------------------------------
--CREACIÓN DE ROLES Y PERMISOS PAR EL AREA DE AUTORIDADES

CREATE ROLE Presidente;
go

GRANT SELECT ON SCHEMA::ddbbaTP TO Presidente;


CREATE ROLE Vicepresidente;
go

GRANT SELECT ON SCHEMA::ddbbaTP TO Vicepresidente;

REVOKE SELECT ON ddbbaTP.Pago FROM Vicepresidente;
REVOKE SELECT ON ddbbaTP.Factura FROM Vicepresidente;
REVOKE SELECT ON ddbbaTP.Cuenta FROM Vicepresidente;
REVOKE SELECT ON ddbbaTP.Reembolso FROM Vicepresidente;
REVOKE SELECT ON ddbbaTP.Cuota FROM Vicepresidente;


CREATE ROLE Secretario;
go

GRANT SELECT ON ddbbaTP.Socio		    TO Secretario;
GRANT SELECT ON ddbbaTP.Categoria	    TO Secretario;
GRANT SELECT ON ddbbaTP.Actividad	    TO Secretario;
GRANT SELECT ON ddbbaTP.Clase		    TO Secretario;
GRANT SELECT ON ddbbaTP.Inscripto	    TO Secretario;
GRANT SELECT ON ddbbaTP.Anotado_En	    TO Secretario;
GRANT SELECT ON ddbbaTP.Asiste		    TO Secretario;
GRANT SELECT ON ddbbaTP.GrupoFamiliar   TO Secretario;
GRANT SELECT ON ddbbaTP.Invitado		TO Secretario;
GRANT SELECT ON ddbbaTP.Profesor		TO Secretario;
GRANT SELECT ON ddbbaTP.ActividadExtra  TO Secretario;
GRANT SELECT ON ddbbaTP.TarifaPileta    TO Secretario;
GRANT SELECT ON ddbbaTP.PasePileta      TO Secretario;


CREATE ROLE Vocal;
go

GRANT SELECT ON ddbbaTP.Socio		    TO Vocal;
GRANT SELECT ON ddbbaTP.Categoria	    TO Vocal;
GRANT SELECT ON ddbbaTP.Actividad	    TO Vocal;
GRANT SELECT ON ddbbaTP.Clase		    TO Vocal;
GRANT SELECT ON ddbbaTP.GrupoFamiliar   TO Vocal;
GRANT SELECT ON ddbbaTP.Profesor		TO Vocal;
GRANT SELECT ON ddbbaTP.ActividadExtra  TO Vocal;
GRANT SELECT ON ddbbaTP.PasePileta      TO Vocal;
>>>>>>> recuperar-historial

