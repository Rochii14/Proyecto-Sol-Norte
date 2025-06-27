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

