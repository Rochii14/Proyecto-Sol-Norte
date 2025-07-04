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

SELECT * FROM Socios.Socio
FOR XML PATH('Socio'), ROOT ('Socios.Socio');
go

SELECT * FROM Socios.GrupoFamiliar 
FOR XML PATH('GrupoFamiliar'), ROOT('Socios.GrupoFamiliar');
go

SELECT * FROM Clases.Actividad
FOR XML PATH('Actividad'), ROOT('Clases.Actividad');
go

SELECT * FROM Socios.Categoria
FOR XML PATH('Categoria'), ROOT('Socios.Categoria');
go

SELECT * FROM Accesos.Invitado
FOR XML PATH('Invitado'), ROOT('Accesos.Invitado');
go

SELECT * FROM Clases.Profesor
FOR XML PATH('Profesor'), ROOT('Clases.Profesor');
go

SELECT * FROM Accesos.Pileta
FOR XML PATH('Pileta'), ROOT('Accesos.Pileta');
go

SELECT * FROM Clases.Asiste
FOR XML PATH('Presentismo'), ROOT('Clases.Presentismo')
go

SELECT * FROM Facturacion.Pago 
FOR XML PATH('Pago'), ROOT('Facturacion.Pago');
go

SELECT * FROM Facturacion.Factura 
FOR XML PATH('Factura'), ROOT('Facturacion.Factura');
go

SELECT * FROM Facturacion.Descuento 
FOR XML PATH('Descuento'), ROOT('Facturacion.Descuento');
go

SELECT * FROM Facturacion.Cuota 
FOR XML PATH('Cuota'), ROOT('Facturacion.Cuota');
go

SELECT * FROM Accesos.Dia_LLuvia
FOR XML PATH('LLuvia'), ROOT('Accesos.Dia_LLuvia');
go

SELECT * FROM Clases.Asiste
FOR XML PATH('Presentismo'), ROOT('Clases.Presentismo');
go

SELECT * FROM Socios.Cuenta
FOR XML PATH('Cuenta'), ROOT('Socios.Cuenta');
go