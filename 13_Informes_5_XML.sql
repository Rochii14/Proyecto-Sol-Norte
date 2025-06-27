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

SELECT * FROM ddbbaTP.Socio
FOR XML PATH('Socio'), ROOT ('ddbbaTP.Socio');
go

SELECT * FROM ddbbaTP.GrupoFamiliar 
FOR XML PATH('ddbbaTP.GrupoFamiliar'), ROOT('ddbbaTP.GrupoFamiliar');
go

SELECT * FROM ddbbaTP.Actividad
FOR XML PATH('Actividad'), ROOT('ddbbaTP.Actividad');
go

SELECT * FROM ddbbaTP.Categoria
FOR XML PATH('Categoria'), ROOT('ddbbaTP.Categoria');
go

SELECT * FROM ddbbaTP.Invitado
FOR XML PATH('Invitado'), ROOT('ddbbaTP.Invitado');
go

SELECT * FROM ddbbaTP.Profesor
FOR XML PATH('ddbbaTP.Profesor'), ROOT('ddbbaTP.Profesor');
go

SELECT * FROM ddbbaTP.Pileta
FOR XML PATH('Pileta'), ROOT('ddbbaTP.Pileta');
go

SELECT * FROM ddbbaTP.Asiste
FOR XML PATH('Presentismo'), ROOT('ddbbaTP.Presentismo')
go

SELECT * FROM ddbbaTP.Pago 
FOR XML PATH('Pago'), ROOT('ddbbaTP.Pago');
go

SELECT * FROM ddbbaTP.Factura 
FOR XML PATH('Factura'), ROOT('ddbbaTP.Factura');
go

SELECT * FROM ddbbaTP.Descuento 
FOR XML PATH('Descuento'), ROOT('ddbbaTP.Descuento');
go

SELECT * FROM ddbbaTP.Cuota 
FOR XML PATH('Cuota'), ROOT('ddbbaTP.Cuota');
go

SELECT * FROM ddbbaTP.Dia_LLuvia
FOR XML PATH('LLuvia'), ROOT('ddbbaTP.Dia_LLuvia');
go

SELECT * FROM ddbbaTP.Asiste
FOR XML PATH('Presentismo'), ROOT('ddbbaTP.Presentismo');
go

SELECT * FROM ddbbaTP.Asiste
FOR XML PATH('Cuenta'), ROOT('ddbbaTP.Cuenta');
go