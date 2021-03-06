/*
   Friday, March 01, 20192:21:07 AM
   Usuario: sa
   Servidor: .\SQLEXPRESS
   Base de datos: SistemaDispensario
   Aplicación: 
*/

/* Para evitar posibles problemas de pérdida de datos, debe revisar este script detalladamente antes de ejecutarlo fuera del contexto del diseñador de base de datos.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Servicios ADD
	Codigo varchar(15) NULL
GO
ALTER TABLE dbo.Servicios SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
