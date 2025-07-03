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

-------------------------------------------- CREACIÓN DE LOGINS -----------------------------------------------------
USE master
go

--AREA TESORERIA:

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_JefeTesoreria')
BEGIN
	CREATE LOGIN Usuario_JefeTesoreria WITH PASSWORD = 'Tesoreria123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Cobranza')
BEGIN
	CREATE LOGIN Usuario_Cobranza WITH PASSWORD = 'Cobranza123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Morosidad')
BEGIN
	CREATE LOGIN Usuario_Morosidad WITH PASSWORD = 'Morosidad123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Facturacion')
BEGIN
	CREATE LOGIN Usuario_Facturacion WITH PASSWORD = 'Facturacion123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

--/////////////////////////////////////////////////////////////////////////////////////////////

--AREA SOCIOS:

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Socio')
BEGIN
	CREATE LOGIN Usuario_Socio WITH PASSWORD = 'Socio123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_SociosWeb')
BEGIN
	CREATE LOGIN Usuario_SociosWeb WITH PASSWORD = 'SociosWeb123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

--//////////////////////////////////////////////////////////////////////////////////////////////

--AREA AUTORIDADES:

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Presidente')
BEGIN
	CREATE LOGIN Usuario_Presidente WITH PASSWORD = 'Presidente123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Vicepresidente')
BEGIN
	CREATE LOGIN Usuario_Vicepresidente WITH PASSWORD = 'Vicepresidente123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Secretario')
BEGIN
	CREATE LOGIN Usuario_Secretario WITH PASSWORD = 'Secretario123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'Usuario_Vocal')
BEGIN
	CREATE LOGIN Usuario_Vocal WITH PASSWORD = 'Vocal123!',
	CHECK_POLICY = ON,
	CHECK_EXPIRATION = ON;
END;
go

-------------------------------------------- CREACIÓN DE USUARIOS EN LA BASE DE DATOS --------------------------------------------
USE Com5600G08
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_JefeTesoreria')
BEGIN
    CREATE USER Usuario_JefeTesoreria FOR LOGIN Usuario_JefeTesoreria;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Cobranza')
BEGIN
    CREATE USER Usuario_Cobranza FOR LOGIN Usuario_Cobranza;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Morosidad')
BEGIN
    CREATE USER Usuario_Morosidad FOR LOGIN Usuario_Morosidad;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Facturacion')
BEGIN
    CREATE USER Usuario_Facturacion FOR LOGIN Usuario_Facturacion;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Socio')
BEGIN
    CREATE USER Usuario_Socio FOR LOGIN Usuario_Socio;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_SociosWeb')
BEGIN
    CREATE USER Usuario_SociosWeb FOR LOGIN Usuario_SociosWeb;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Presidente')
BEGIN
    CREATE USER Usuario_Presidente FOR LOGIN Usuario_Presidente;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Vicepresidente')
BEGIN
    CREATE USER Usuario_Vicepresidente FOR LOGIN Usuario_Vicepresidente;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Secretario')
BEGIN
    CREATE USER Usuario_Secretario FOR LOGIN Usuario_Secretario;
END;
go

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'Usuario_Vocal')
BEGIN
    CREATE USER Usuario_Vocal FOR LOGIN Usuario_Vocal;
END;
go
