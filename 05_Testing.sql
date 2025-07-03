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
<<<<<<< HEAD

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
=======
EXEC ddbbaTP.InsertarCategoria 'Veterano', 45789.12, '2025-10-12', '' --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarCategoria 'Menores', -2, '2025-10-12', 'Inactivo' --Debe provocarse un error por no respetar la validaacion Costo>=0
select * from ddbbatp.Categoria

----------------------------------------- P2
select * from ddbbaTP.GrupoFamiliar
--Debe insertar el registro correctamente, teniendo previos insert en grupo familiar
EXEC ddbbaTP.InsertarSocio
    40200111,
    'Lucía',
    'Martínez',
    'lucia.martinez@mail.com',
    '1995-07-20',
    '1122334455',
    '1166778899',
    'OSDE',
    '12345678',
    NULL, --ID_Grupo Familiar
    1,
    NULL, --Id de su resposnable
	'Moroso'
-----------------------------------------P3
select * from ddbbaTP.Socio
--Debe provocarse un error de integridad referencial (2 no es un ID existente en la tabla ddbbaTP.Categoria)
	EXEC ddbbaTP.InsertarSocio
    40200111,
    'Lucas',
    'Martínez',
    'lucas.martinez@mail.com',
    '1995-01-20',
    '1123411115',
    '1166724567',
    'OSDE',
    '12345678',
    NULL, --ID_Grupo Familiar
    2,
    NULL, --Id de su resposnable
	'Moroso'

--Debe provocar un error de conflicto por no respetar la reestricción DNI BETWEEN 10000000 AND 99999999
	EXEC ddbbaTP.InsertarSocio
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
	EXEC Socios.InsertarSocio
=======
	EXEC ddbbaTP.InsertarSocio
>>>>>>> recuperar-historial
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
<<<<<<< HEAD
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
=======
EXEC ddbbaTP.InsertarGrupoFamiliar 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarGrupoFamiliar 2 --Debe provocar un error de integridad referencial

----------------------------------------- P5
EXEC ddbbaTP.InsertarActividad 'Handball', 34550, '2025-11-12', 'Inactivo'  --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarActividad 'Handball', -34550, '2025-11-12', 'Inactivo' --Debe provocar un error de conflicto por no respetar la reestricción Costo>=0

----------------------------------------- P6
EXEC ddbbaTP.InsertarProfesor 'Gabriel', 'Medina', 'Gabriel@Hotmail', 'Inactivo' --Debe insertar el registro correctamente

----------------------------------------- P7
EXEC ddbbaTP.InsertarClase '2025-12-02', '17:00:00', 'Lunes', 1, 1, 'Inactivo' --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarClase '1999-12-02', '17:00:00', 'Lunes', 1, 1, 'Inactivo' --Debe provocar un error de conflicto por no respetar la reestricción Fecha>= 2000-01-01
EXEC ddbbaTP.InsertarClase '1999-12-02', '17:00:00', 'Lunes', 1, 3 --Debe  provocar un error de integridad referencial por Id_Actividad

----------------------------------------- P8
EXEC ddbbaTP.InsertarCuota 'Impaga', '1' --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarCuota 'Paga', '2' --Debe provocar un error de integridad referencial por NroSocio

----------------------------------------- P9
EXEC ddbbaTP.InsertarDescuento 'LLuivia', '1', '1', 'Inactivo' --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarDescuento 'Grupo Familiar', '1', '2', 'Inactivo' --Debe provocar un error de integridad referencial por el NroSocio

----------------------------------------- P10
EXEC ddbbaTP.InsertarFactura  '2025-12-04', 2, 'Impaga', 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarFactura  '2025-12-04', 2, 'Impaga', 1, 2 --Debe provocar un error de integridad referencial por el Id_Cuota

----------------------------------------- P11
EXEC ddbbaTP.InsertarCuenta 345123, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarCuenta -1, 1 --Debe provocar un error de conflicto por no respetar la reestricción Saldo_Favor>=0
EXEC ddbbaTP.InsertarCuenta 345123, 3 --Debe provocar un error de integridad referencial por el NroSocio

----------------------------------------- P12
EXEC ddbbaTP.InsertarMedioDePago '','Tarjeta','Virtaul'--Debe insertar el registro correctamente

----------------------------------------- P13
EXEC ddbbaTP.InsertarPago '2025-09-12', 1, 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarPago '2025-09-12', 1, 1, 2 --Debe provocar un error de integridad referencial por IdMedioDePago

----------------------------------------- P14
EXEC ddbbaTP.InsertarReembolso 'credito', 1, 2 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarReembolso 'debito', 1, 10 --Debe provocar un error de integridad referencial por IdPago

----------------------------------------- P15
EXEC ddbbaTP.InsertarInvitado 'Juan Juano', 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarInvitado 'Juan Juano', 1, 10 --Debe provocar un error de integridad referencial por IdFactura

----------------------------------------- P16
EXEC ddbbaTP.InsertarPasePileta 10000.50, 15000.50, 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarPasePileta 10000.50, 15000.50, 1, 10 --Debe provocar un error de integridad referencial por IdFactura
EXEC ddbbaTP.InsertarPasePileta -10000.50, 15000.50, 1, 1--Debe provocarse un error por no respetar la validaacion TarifaSocio>=0

----------------------------------------- P17
EXEC ddbbaTP.InsertarActividadExtra NULL --Debe insertar el registro correctamente

----------------------------------------- P18
EXEC ddbbaTP.InsertarColonia 1, 13000 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarColonia 3, 13000 --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P19
EXEC ddbbaTP.InsertarSum 1, 13000 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarSum 11, 13000 --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P20
EXEC ddbbaTP.InsertarPileta 1, 1, '2025-12-30' --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarPileta 10, 1, '2025-12-30' --Debe provocar un error de integridad referencial por IdActividadExtra

----------------------------------------- P21
EXEC ddbbaTP.InsertarAsiste 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarAsiste 12, 1 --Debe provocar un error de integridad referencial por NroSocio

----------------------------------------- P22
EXEC ddbbaTP.InsertarAnotadoEn 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarAnotadoEn 20, 1 --Debe provocar un error de integridad referencial por NroSocio
 
----------------------------------------- P23
EXEC ddbbaTP.InsertarInscripto 1, 1 --Debe insertar el registro correctamente
EXEC ddbbaTP.InsertarAnotadoEn 1, 11 --Debe provocar un error de integridad referencial por IdActividad
 
-- =============================================
-- MODIFICACIÓN
-- =============================================

----------------------------------------- P1
EXEC ddbbaTP.ModificarSocio --  Modificar un socio existente (éxito esperado)
>>>>>>> recuperar-historial
    @NroSocio = 1,
    @Telefono_Contacto = '1122334455',
    @Email_Personal = 'nuevoemail@example.com';
GO
----------------------------------------- P2

<<<<<<< HEAD
EXEC Socios.ModificarSocio --  Modificar socio con DNI inválido (error esperado)
=======
EXEC ddbbaTP.ModificarSocio --  Modificar socio con DNI inválido (error esperado)
>>>>>>> recuperar-historial
    @NroSocio = 1,
    @Dni = 1234567; -- DNI inválido (7 dígitos)
GO
----------------------------------------- P3

<<<<<<< HEAD
EXEC Socios.ModificarCategoria       -- Modificar categoría con costo negativo (error esperado)
=======
EXEC ddbbaTP.ModificarCategoria       -- Modificar categoría con costo negativo (error esperado)
>>>>>>> recuperar-historial
    @IdCategoria = 1,
    @Costo = -100; -- Costo negativo
GO
----------------------------------------- P4

<<<<<<< HEAD
EXEC Clases.ModificarClase      --  Modificar clase con fecha inválida (error esperado)
=======
EXEC ddbbaTP.ModificarClase      --  Modificar clase con fecha inválida (error esperado)
>>>>>>> recuperar-historial
    @IdClase = 1,
    @Fecha = '1999-12-31'; -- Fecha anterior a 2000
GO
----------------------------------------- P5

<<<<<<< HEAD
EXEC Facturacion.ModificarDescuento       --  Modificar descuento sin especificar grupo o socio (error esperado si no tenía ninguno)
=======
EXEC ddbbaTP.ModificarDescuento       --  Modificar descuento sin especificar grupo o socio (error esperado si no tenía ninguno)
>>>>>>> recuperar-historial
    @IdDescuento = 1,
    @Tipo = 'Promoción verano',
    @IdGrupoFamiliar = NULL,
    @NroSocio = NULL;
GO
