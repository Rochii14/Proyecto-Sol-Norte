/*Entrega 4- Documento de instalaci�n y configuraci�n
Luego de decidirse por un motor de base de datos relacional, lleg� el momento de generar la base de datos. En esta oportunidad utilizar�n
SQL Server. Deber� instalar el DMBS y documentar el proceso. No incluya capturas de pantalla. Detalle las configuraciones aplicadas 
(ubicaci�n de archivos, memoria asignada, seguridad, puertos, etc.) en un documento como el que le entregar�a al DBA. Cree la base de datos, 
entidades y relaciones. Incluya restricciones y claves. Deber� entregar un archivo .sql con el scriptcompleto de creaci�n (debe funcionar 
si se lo ejecuta �tal cual� es entregado en una sola ejecuci�n). Incluya comentarios para indicar qu� hace cada m�dulo de c�digo.  Genere 
store procedures para manejar la inserci�n, modificado, borrado (si corresponde, tambi�n debe decidir si determinadas entidades solo admitir�n
borrado l�gico) de cada tabla. Los nombres de los store procedures NO deben comenzar con �SP�.  Algunas operaciones implicar�n store procedures 
que involucran varias tablas, uso de transacciones, etc. Puede que incluso realicen ciertas operaciones mediante varios SPs. Aseg�rense de que 
los comentarios que acompa�en al c�digo lo expliquen. Genere esquemas para organizar de forma l�gica los componentes del sistema y aplique esto 
en la creaci�n de objetos. NO use el esquema �dbo�.  Todos los SP creados deben estar acompa�ados de juegos de prueba. Se espera que realicen 
validaciones b�sicas en los SP (p/e cantidad mayor a cero, CUIT v�lido, etc.) y que en los juegos de prueba demuestren la correcta aplicaci�n 
de las validaciones. Las pruebas deben realizarse en un script separado, donde con comentarios se indique en cada caso el resultado esperado
El archivo .sql con el script debe incluir comentarios donde consten este enunciado, la fecha de entrega, n�mero de grupo, nombre de la materia, 
nombres y DNI de los alumnos.  Entregar todo en un zip (observar las pautas para nomenclatura antes expuestas) mediante la secci�n de pr�cticas de 
MIEL. Solo uno de los miembros del grupo debe hacer la entrega. 

*FECHA DE ENTREGA: 23/05/2025
*NUMERO DE GRUPO: 08
*NOMBRE DE LA MATERIA: Base de Datos Aplicadas
*INTEGRANTES: 45318374 | Di Marco Jazm�n
			  46346548 | Medina Federico Gabriel
			  42905305 | Mendez Samuel Omar
			  44588998 | Valdevieso Roc�o Elizabeth
*/

create database Com5600G08
go 

drop database if exists Com5600G08

use Com5600G08

go 

create schema dbaTP
 ----------------CREAR TABLAS------------------------------------------------------------------
--create table SOCIO()
--create table GRUPO_FAMILIAR()
--create table INVITADO()
--create table CUOTA()
--create table ACTIVIDAD()
--create table ACTIVIDAD_EXTRA()
--create table PILETA()                   ---PROVIENE JERARQU�A ACT EXTRA
--create table SUM()                   ---PROVIENE JERARQU�A ACT EXTRA
--create table COLONIA()                   ---PROVIENE JERARQU�A ACT EXTRA
--create table PASE_PILETA()
--create table CATEGORIA()
--create table CLASE()
--create table DESCUENTO()
--create table FACTURA()
--create table PAGO()
--create table MEDIO_PAGO()
--create table REEMBOLSO()
--create table PROFESOR()
--create table CUENTA()						--relaci�n pago-medio de pago

 ----------------CREAR RELACIONES------------------------------------------------------------------
 --create table Pertenece()                             --relacion socio-categoria
 --create table Responsable_De()							--relacion socio-socio		->unaria
 --create table Inscripto_En()                             --relacion socio-actividad
  --create table Dividida_En()                             --relacion actividad-clase
  --create table Dictada_Por()							--relacion clase-proferor
  --create table A_Cargo_De()							--relacion socio-grupo familiar
  --create table Habilita()							--relacion grupo familiar-descuento
  --create table Forma_Parte_De()							--relacion socio-grupo familiar
  --create table Dispone()							--relacion socio-descuento
  --create table Corresponde()							--relacion socio-cuota
  --create table Puede_tener()							--relacion invitado-socio
  --create table Aplicado_A()							--relacion descuento-factura
  --create table Contiene()							--relacion cuota-factura
  --create table Obtiene()							--relacion invitado-factura
  --create table Realiza()							--relacion socio-actividad Extra
  --create table Usa()							--relacion invitado-pase_pileta
  --create table Posee()							--relacion pileta-pase_pileta
  --create table Conlleva ()                   --relacion  pago-factura
  --create table Realizado_Por()						--relaci�n pago-medio de pago
  --create table Permite()						--relaci�n medio de pago-reembolso
  --create table Corresponde()						--relaci�n pago-reembolso
  --create table Tiene()						--relaci�n socio-cuenta

  /*Socio (Nro_socio, Dni, Nombre, Apellido, email_personal, Fec_Nac, Telefono_Contacto, Telef_C_Emergencia, Nombre_Obra_Social, Nro_Obra_Social, IdGrupoFamiliar, IdCategoria, NroSocio2)
 
Actividad(Id, Nombre, Costo, Vigente_Hasta, IdAct, IdCategoria
 
Categoria ( Id, Nombre, Costo, Vigente_Hasta)
 
Clase( Id, Fecha, Hora, D�a, IdProfesor, IdActividad)
 
Profesor( Id, Nombre, Apellido, email_personal)
 
GrupoFamiliar(Id, NroSocio)
 
Cuota( Id, Estado, NroSocio)
 
Descuento(Id, Tipo, IdGrupoFamiliar, NroSocio)
 
Factura(Id, Fecha_Vencimiento, Dias_Atrasados, Estado, IdDescuento, IdCuota)
 
Cuenta( Id, Saldo_Favor, NroSocio)
 
Pago(Id, Fecha_de_Pago, IdCuenta, IdFactura, IdMedioDePago)
 
MedioDePago(Id, Nombre, Tipo, Modalidad)
 
Reembolso( Id, Modalidad, IdMedioDePago, IdPago)
 
PasePileta( Id, Tarifa_Socio, Tarifa_Invitado, NroSocio, IdInvitado)
 
DEBIL
Invitado(Id, Nombre, Nro_Socio, IdFactura)
 
JERARQUIA
ActividadExtra(Id, Tipo)
 
Colonia(Precio,IdActividadExtra)
Sum(Precio, IdActividadExtra)
Pileta(Fec_Temporada, IdActividadExtra, IdPasePileta)
 
Asiste(NroSocio, IdClase)
 
Anotado_En(NroSocio, IdClase)
 
Inscripto(NroSocio, IdActividad)
 
Realiza(NroSocio, IdActividadExtra, Fecha)*/



 

