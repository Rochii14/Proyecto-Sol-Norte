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

------------------------///////////////////////////CASOS DE TESTING /////////////////////////////////------------------------

-- =============================================
--					INSERCIÓN
-- =============================================
USE Com5600G08
go
----------------------------------------- P1

EXEC Socios.InsertarCategoria 'Menor', 45789.12, '2025-10-12', 'Inactivo' --Debe insertar el registro correctamente
GO

EXEC Socios.InsertarCategoria 'Mayor', -2, '2025-10-12', 'Inactivo' --Debe provocarse un error por no respetar la validaacion Costo>=0
GO

SELECT * FROM Socios.Categoria

----------------------------------------- P2

	EXEC Socios.InsertarSocio
		@NroSocio = 'SN-9999',
		@Dni = 40200111,
		@Nombre = 'Lucas',
		@Apellido = 'Martínez',
		@Email = 'lucas.martinez@mail.com',
		@Fecha_Nac = '1995-01-20',
		@Telf_Contacto = '112341115',
		@Telf_Contacto_Emergencia = '1166724567',
		@Nombre_O_Social = 'OSDE',
		@Nro_Obra_Social = '12345678',
		@IdGrupoFamiliar = 100,
		@IdCategoria = 2,
		@Estado = 'Activo',
		@NroSocio2 = 'SN-9989',
		@Telefono_Emergencia_2 = '1187349323'

--Debe provocarse un error de integridad referencial (2 no es un ID existente en la tabla Socios.Categoria)

SELECT * FROM Socios.Socio

----------------------------------------- P3

--Debe provocar un error de conflicto por no respetar la reestricción DNI BETWEEN 10000000 AND 99999999
	EXEC Socios.InsertarSocio
    4567872 ,
	'Lucas',
    'Martínez',
    'lucas.martinez@mail.com',
    '1995-01-20',
    '1123411115',
    '1166724567',
    'OSDE',
    '12345678',
    NULL, --ID_Grupo Familiar
    1,
    NULL, --Id de su resposnable
	'Moroso'
---- Debe provocar un error por no respetar el tipo de dato que se espera en campo nombre: VARCHAR
--	EXEC ddbbaTP.InsertarSocio
--    40200111,
--    1,
--    'Martínez',
--    'lucas.martinez@mail.com',
--    '1995-01-20',
--    '1123411115',
--    '1166724567',
--    'OSDE',
--    '12345678',
--    NULL, --ID_Grupo Familiar
--    1,
--    NULL, --Id de su resposnable
--	'Moroso'

--Debe provocar un error por superar la cantidad de caracteres en Apellido
	--EXEC ddbbaTP.InsertarSocio
 --   40200111,
 --   'Lucas',
 --   'MartínezMartínezMartínezMartínezMartínezMartínezMartínezaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
 --   'lucas.martinez@mail.com',
 --   '1995-01-20',
 --   '1123411115',
 --   '1166724567',
 --   'OSDE',
 --   '12345678',
 --   NULL, --ID_Grupo Familiar
 --   1,
 --   NULL, --Id de su resposnable
	--'Moroso'

--Debe provocar un error por superar la fecha actual
	EXEC Socios.InsertarSocio
    40200111,
    'Lucas',
    'Martínez',
    'lucas.martinez@mail.com',
    '2995-01-20',
    '1123411115',
    '1166724567',
    'OSDE',
    '12345678',
    NULL, --ID_Grupo Familiar
    1,
    NULL, --Id de su resposnable
	'Moroso'
-----------------------------------------P4
EXEC Socios.InsertarGrupoFamiliar  --Debe insertar el registro correctamente
EXEC Socios.InsertarGrupoFamiliar 2 --Debe provocar un error de integridad referencial

----------------------------------------- P5
EXEC Clases.InsertarActividad 'Handball', 34550, '2025-11-12', 'Inactivo'  --Debe insertar el registro correctamente
EXEC Clases.InsertarActividad 'Handball', -34550, '2025-11-12', 'Inactivo' --Debe provocar un error de conflicto por no respetar la reestricción Costo>=0

----------------------------------------- P6
EXEC Clases.InsertarProfesor 'Gabriel', 'Medina', 'Gabriel@Hotmail', 'Inactivo' --Debe insertar el registro correctamente

----------------------------------------- P7
EXEC Clases.InsertarClase '2025-12-02', '17:00:00', 'Lunes', 1, 1, 'Inactivo' --Debe insertar el registro correctamente
EXEC Clases.InsertarClase '1999-12-02', '17:00:00', 'Lunes', 1, 1, 'Inactivo' --Debe provocar un error de conflicto por no respetar la reestricción Fecha>= 2000-01-01
EXEC Clases.InsertarClase '1999-12-02', '17:00:00', 'Lunes', 1, 3 --Debe  provocar un error de integridad referencial por Id_Actividad

----------------------------------------- P8
EXEC Facturacion.InsertarCuota 'Impaga', '1' --Debe insertar el registro correctamente
EXEC Facturacion.InsertarCuota 'Paga', '2' --Debe provocar un error de integridad referencial por NroSocio

----------------------------------------- P9
EXEC Facturacion.InsertarDescuento 'LLuivia', '1', '1', 'Inactivo' --Debe insertar el registro correctamente
EXEC Facturacion.InsertarDescuento 'Grupo Familiar', '1', '2', 'Inactivo' --Debe provocar un error de integridad referencial por el NroSocio

----------------------------------------- P10
EXEC Facturacion.InsertarFactura  '2025-12-04', 2, 'Impaga', 1, 1 --Debe insertar el registro correctamente
EXEC Facturacion.InsertarFactura  '2025-12-04', 2, 'Impaga', 1, 2 --Debe provocar un error de integridad referencial por el Id_Cuota

----------------------------------------- P11
EXEC Socios.InsertarCuenta 345123, 1 --Debe insertar el registro correctamente
EXEC Socios.InsertarCuenta -1, 1 --Debe provocar un error de conflicto por no respetar la reestricción Saldo_Favor>=0
EXEC Socios.InsertarCuenta 345123, 3 --Debe provocar un error de integridad referencial por el NroSocio

----------------------------------------- P12
EXEC Facturacion.InsertarMedioDePago '','Tarjeta','Virtaul'--Debe insertar el registro correctamente

----------------------------------------- P13
EXEC Facturacion.InsertarPago '2025-09-12', 1, 1, 1 --Debe insertar el registro correctamente
EXEC Facturacion.InsertarPago '2025-09-12', 1, 1, 2 --Debe provocar un error de integridad referencial por IdMedioDePago

----------------------------------------- P14
EXEC Facturacion.InsertarReembolso 'credito', 1, 2 --Debe insertar el registro correctamente
EXEC Facturacion.InsertarReembolso 'debito', 1, 10 --Debe provocar un error de integridad referencial por IdPago

----------------------------------------- P15
EXEC Accesos.InsertarInvitado 'Juan Juano', 1, 1 --Debe insertar el registro correctamente
EXEC Accesos.InsertarInvitado 'Juan Juano', 1, 10 --Debe provocar un error de integridad referencial por IdFactura

----------------------------------------- P16
EXEC Accesos.InsertarPasePileta 10000.50, 15000.50, 1, 1 --Debe insertar el registro correctamente
EXEC Accesos.InsertarPasePileta 10000.50, 15000.50, 1, 10 --Debe provocar un error de integridad referencial por IdFactura
EXEC Accesos.InsertarPasePileta -10000.50, 15000.50, 1, 1--Debe provocarse un error por no respetar la validaacion TarifaSocio>=0

----------------------------------------- P17
EXEC Accesos.InsertarActividadExtra NULL --Debe insertar el registro correctamente

----------------------------------------- P18
EXEC Accesos.InsertarColonia 1, 13000 --Debe insertar el registro correctamente
EXEC Accesos.InsertarColonia 3, 13000 --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P19
EXEC Accesos.InsertarSum 1, 13000 --Debe insertar el registro correctamente
EXEC Accesos.InsertarSum 11, 13000 --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P20
EXEC Accesos.InsertarPileta 1, 1, '2025-12-30' --Debe insertar el registro correctamente
EXEC Accesos.InsertarPileta 10, 1, '2025-12-30' --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P21
EXEC Clases.InsertarAsiste 1, 1 --Debe insertar el registro correctamente
EXEC Clases.InsertarAsiste 12, 1 --Debe provocar un error de integridad referencial por NroSocio

----------------------------------------- P22
EXEC Clases.InsertarAnotadoEn 1, 1 --Debe insertar el registro correctamente
EXEC Clases.InsertarAnotadoEn 20, 1 --Debe provocar un error de integridad referencial por NroSocio
 
----------------------------------------- P23
EXEC Clases.InsertarInscripto 1, 1 --Debe insertar el registro correctamente
EXEC Clases.InsertarAnotadoEn 1, 11 --Debe provocar un error de integridad referencial por IdActividad
 
-- =============================================
--				 MODIFICACIÓN
-- =============================================

----------------------------------------- P1
EXEC Socios.ModificarSocio --  Modificar un socio existente (éxito esperado)
    @NroSocio = 1,
    @Telefono_Contacto = '1122334455',
    @Email_Personal = 'nuevoemail@example.com';
GO
----------------------------------------- P2

EXEC Socios.ModificarSocio --  Modificar socio con DNI inválido (error esperado)
    @NroSocio = 1,
    @Dni = 1234567; -- DNI inválido (7 dígitos)
GO
----------------------------------------- P3

EXEC Socios.ModificarCategoria       -- Modificar categoría con costo negativo (error esperado)
    @IdCategoria = 1,
    @Costo = -100; -- Costo negativo
GO
----------------------------------------- P4

EXEC Clases.ModificarClase      --  Modificar clase con fecha inválida (error esperado)
    @IdClase = 1,
    @Fecha = '1999-12-31'; -- Fecha anterior a 2000
GO
----------------------------------------- P5

EXEC Facturacion.ModificarDescuento       --  Modificar descuento sin especificar grupo o socio (error esperado si no tenía ninguno)
    @IdDescuento = 1,
    @Tipo = 'Promoción verano',
    @IdGrupoFamiliar = NULL,
    @NroSocio = NULL;
GO
----------------------------------------- USUARIOS

EXECUTE AS USER = 'Usuario_JefeTesoreria';					
go
--En schema Facturacion
-- Debe permitir:
SELECT TOP 5 * FROM Facturacion.Cuota;         
INSERT INTO Facturacion.Cuota(Estado) VALUES('Test Cuota'); 
UPDATE Facturacion.Cuota SET Estado='Test cuota actualizado'  WHERE Estado='Test Cuota';
DELETE FROM Facturacion.Cuota WHERE Estado='Test cuota actualizado';

REVERT;-- Volver al contexto original

---------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Cobranza';					
go
 -- Debe permitir:
SELECT TOP 5 * FROM Facturacion.MedioDePago;
-- NO debe permitir:
INSERT INTO Facturacion.MedioDePago (Nombre) VALUES ('Test MP');
UPDATE Facturacion.MedioDePago SET Nombre = 'Actualizado' WHERE IdMedioPago = 1;
DELETE FROM Facturacion.MedioDePago WHERE  IdMedioPago= 1;


REVERT;
---------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Morosidad';					
go
-- Debe permitir:
SELECT TOP 5 * FROM Facturacion.Descuento;
-- No debe permitir:
INSERT INTO Facturacion.Descuento (NroSocio) VALUES ('SN-8000'); 
UPDATE Facturacion.Descuento SET Estado= 'No debería actualizarse' WHERE IdDescuento = 1;
DELETE FROM Facturacion.Descuento WHERE NroSocio = ('SN-4005');

-- No debe permitir (Revoke):
SELECT TOP 5 * FROM Facturacion.Pago;
INSERT INTO Facturacion.Pago (Monto) VALUES (99999); 
UPDATE Facturacion.Pago SET Monto= 99999 WHERE IdPago = 1;
DELETE FROM Facturacion.Pago WHERE IdPago = 107433442786;

REVERT;

---------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Facturacion';					
go
-- Debe permitir:
SELECT TOP 5 * FROM Facturacion.Cuota;
UPDATE Facturacion.Cuota SET Estado= 'Actualizada' WHERE IdCuota = 1;
-- No debe permitir:
DELETE FROM Facturacion.Cuota WHERE IdCuota = 1;

REVERT;

---------------------------------------------------------------------------

EXECUTE AS USER = 'Usuario_Socio';					
go

-- Debe permitir:
SELECT TOP 5 * FROM Socios.Socio;
UPDATE Socios.Socio SET Nro_Obra_Social= 99999 WHERE Nombre = ('Probando Insercion');
DELETE FROM Socios.Socio WHERE NroSocio = ('SN-4005');

-- No debe permitir (REVOKE):
SELECT TOP 5 * FROM Socios.Categoria;
INSERT INTO Socios.Categoria (Nombre) VALUES ('No debería insertarse'); 
UPDATE Socios.Categoria SET Costo= 99999 WHERE IdCategoria = 1;
DELETE FROM Socios.Categoria WHERE IdCategoria = 1;

REVERT;

---------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_SociosWeb';					
go

-- Debe permitir:
SELECT TOP 5 * FROM Clases.Profesor;
-- No debe permitir:
INSERT INTO Clases.Profesor (Email_Personal) VALUES ('Probando@Insercion'); 
UPDATE Clases.Profesor SET Estado= 'No debería actualizarse' WHERE IdProfesor = 1;
DELETE FROM Clases.Profesor WHERE Nombre_Completo = ('Pablo Rodrigez');

-- Debe permitir:
SELECT TOP 5 * FROM Accesos.Invitado;
INSERT INTO Accesos.Invitado (Nro_Socio) VALUES ('SN-8000'); 
UPDATE Accesos.Invitado SET Nombre='Probando Insercion' WHERE Nombre = ('SN-8000');
DELETE FROM Accesos.Invitado WHERE Nro_Socio = ('SN-4005');

REVERT;

---------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Presidente'; 
go 

-- No debe permitir: 
INSERT INTO Socios.Categoria ( Nombre, Costo, Vigente_Hasta, Estado ) VALUES ('Infantil', '12000.00', '31/5/2025', 'Inactivo') 

--Debe permitir: 
SELECT * FROM Facturacion.MedioDePago 

REVERT;
---------------------------------------------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Vicepresidente'; 
go 

-- No debe permitir: 
UPDATE Socios.Socio 
SET Fecha_De_Nacimiento = NULL 
WHERE NroSocio2 IS NOT NULL; 

--Debe permitir: 
SELECT * FROM Clases.Clase 

REVERT;
-----------------------------------------------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Secretario'; 
go 

-- No debe permitir: 
DELETE FROM Clases.Asiste 

--Debe permitir: 
SELECT * FROM Accesos.Invitado 

REVERT;
-----------------------------------------------------------------------------------------------------------------
EXECUTE AS USER = 'Usuario_Vocal'; 
go 

--No debe permitir: 
ALTER TABLE Clases.Actividad ADD Dificultad VARCHAR (20); 

--Debe permitir: 
SELECT * FROM Accesos.PasePileta 

REVERT;
