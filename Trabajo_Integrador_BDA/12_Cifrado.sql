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

--CRACIÓN DE TABLA EMPLEADO

CREATE TABLE ddbbaTP.Empleado (
	Id INT PRIMARY KEY,
	Dni VARBINARY (MAX),
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Email VARBINARY(MAX),
	Nro_Telefono VARBINARY(MAX),
	Puesto VARCHAR(30) );
go


--CREACIÓN DE SP PARA INSERTTAR EMPLEADOS CON DATOS SENSIBLES CIFRADOS

CREATE OR ALTER PROCEDURE ddbbaTP.Insertar_Empleado_Cifrado
	@Id INT,
	@Dni NVARCHAR (12),
	@Nombre VARCHAR(50),
	@Apellido VARCHAR(50),
	@Email NVARCHAR(100),
	@Nro_Telefono NVARCHAR(15),
	@Puesto VARCHAR(30),
	@FraseClave NVARCHAR(128)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM ddbbaTP.Empleado WHERE Id = @Id)
    BEGIN
        PRINT ('El Id ya existe. No se inserto el registro');
        RETURN;
	END;

	IF EXISTS (SELECT 1 FROM ddbbaTP.Empleado WHERE Dni = @Dni)
    BEGIN
        PRINT ('El dni ya existe. No se inserto el registro');
        RETURN;
	END;

	IF EXISTS (SELECT 1 FROM ddbbaTP.Empleado WHERE Email = @Email)
    BEGIN
        PRINT ('El email ya existe. No se inserto el registro');
        RETURN;
	END;

	IF EXISTS (SELECT 1 FROM ddbbaTP.Empleado WHERE Nro_Telefono = Nro_Telefono)
    BEGIN
        PRINT ('El numero de telefono ya existe. No se inserto el registro');
        RETURN;
    END;

	INSERT INTO ddbbaTP.Empleado (Id, Dni, Nombre, Apellido, Email, Nro_Telefono, Puesto) VALUES
	( 
		@Id,
		EncryptByPassPhrase ( @FraseClave, @Dni, 1, CONVERT(VARBINARY, @Id) ),
		@Nombre,
		@Apellido,
		EncryptByPassPhrase ( @FraseClave, @Email, 1, CONVERT(VARBINARY, @Id) ),
		EncryptByPassPhrase ( @FraseClave, @Nro_Telefono, 1, CONVERT(VARBINARY, @Id) ),
		@Puesto 
	 )
END;
go
------------------------------------------------------------------------------------------------------------------------------------------------------

--CREACIÓN PARA DESENCRIPTAR DATOS SENSIBLES DE EMPLEADOS

CREATE OR ALTER PROCEDURE ddbbaTP.Desencriptar_Empleado
    @Id INT,
    @FraseClave NVARCHAR(128)
AS
BEGIN
    SELECT
        Id,
        CONVERT(NVARCHAR(12), DecryptByPassPhrase( @FraseClave, Dni, 1, CONVERT(VARBINARY, Id)) ) AS Dni,
        Nombre,
        Apellido,
		CONVERT(NVARCHAR(100), DecryptByPassPhrase(@FraseClave, Email, 1, CONVERT(VARBINARY, Id)) ) AS Email,
		CONVERT(NVARCHAR(15), DecryptByPassPhrase(@FraseClave, Nro_Telefono, 1, CONVERT(VARBINARY, Id)) ) AS Nro_Telefono,
        Puesto
    FROM ddbbaTP.Empleado
    WHERE Id = @Id;
END;
go

------------------------------------------------------------------------------------------------------------------------------------------------------
--PRUEBAS:

EXEC ddbbaTP.Insertar_Empleado_Cifrado 1, 46346548, 'Javier Juan', 'Mendez', 'Mendez@gmail.com', '11-42376512', 'Presidente', 'MiPerro123'
go	--Debe insertar

EXEC ddbbaTP.Insertar_Empleado_Cifrado 2, 42356548, 'Marcos Martin', 'Dotta', 'Dotta@gmail.com', '11-11345103', 'Administrador', 'Messi'  
go	--Debe insertar

EXEC ddbbaTP.Insertar_Empleado_Cifrado 2, 42356548, 'Marcos Martin', 'Dotta', 'Dotta@gmail.com', '11-11345103', 'Administrador', 'Messi'   
go	--Debe no insertar, repite ID

SELECT * FROM ddbbaTP.Empleado

EXEC ddbbaTP.Desencriptar_Empleado 1, 'MiPerro123'
go --Debe mostrar datos

EXEC ddbbaTP.Desencriptar_Empleado 2, 'Messi'
go --Debe mostrar datos

EXEC ddbbaTP.Desencriptar_Empleado 2, 'Mesi'
go --Debe mostrar datos sensibles en NULL (La FraseClave del empleado 2 es incorrecta)

