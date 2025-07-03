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


----------------------------------------- CREACIÓN DE ROLES Y ASIGNACIÓN DE PERMISOS --------------------------------------------
USE Com5600G08
go

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

DENY SELECT ON Facturacion.MedioDePago TO Administrativo_De_Morosidad;
DENY SELECT ON Facturacion.Pago	TO Administrativo_De_Morosidad;
DENY SELECT ON Facturacion.Reembolso TO Administrativo_De_Morosidad;


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

DENY SELECT, INSERT, UPDATE, DELETE ON Socios.Categoria TO Administrativo_Socio;


GRANT SELECT ON Accesos.ActividadExtra				  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Accesos.Realiza		  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Accesos.Invitado	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clases.Inscripto	  TO Administrativo_Socio;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clases.Anotado_En	  TO Administrativo_Socio;
GRANT SELECT ON Clases.Actividad				  TO Administrativo_Socio;


--AREA SOCIOS: Socio_Web.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Socio_Web')
BEGIN
	CREATE ROLE Socio_Web;
END;
go

GRANT SELECT ON SCHEMA::Clases		 TO Socio_Web;
GRANT SELECT ON SCHEMA::Facturacion   	 TO Socio_Web;
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

DENY SELECT ON Socios.Cuenta TO Vicepresidente;

--AREA AUTORIDADES: Secretario.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Secretario')
BEGIN
	CREATE ROLE Secretario;
END;
go

GRANT SELECT ON SCHEMA::Clases TO Secretario;

GRANT SELECT ON SCHEMA::Socios TO Secretario;
DENY SELECT ON Socios.Cuenta TO Secretario;


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

ALTER ROLE Jefe_De_Tesoreria ADD MEMBER Usuario_JefeTesoreria;		
go
ALTER ROLE Administrativo_De_Cobranza ADD MEMBER Usuario_Cobranza;
go
ALTER ROLE Administrativo_De_Morosidad ADD MEMBER Usuario_Morosidad;
go
ALTER ROLE Administrativo_De_Facturacion ADD MEMBER Usuario_Facturacion;
go
ALTER ROLE Administrativo_Socio ADD MEMBER Usuario_Socio;
go
ALTER ROLE Socio_Web ADD MEMBER Usuario_SociosWeb;
go
ALTER ROLE Presidente ADD MEMBER Usuario_Presidente;
go
ALTER ROLE Vicepresidente ADD MEMBER Usuario_Vicepresidente;
go
ALTER ROLE Secretario ADD MEMBER Usuario_Secretario;
go
ALTER ROLE Vocal ADD MEMBER Usuario_Vocal;
go

 
