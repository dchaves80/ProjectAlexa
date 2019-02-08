USE [SistemaDispensario]
GO
/****** Object:  StoredProcedure [dbo].[InsertarPeriodo_Cronograma_Entrada]    Script Date: 8/2/2019 02:19:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[InsertarPeriodo_Cronograma_Entrada]
(
@UserId bigint,
@EntradaJornada varchar(50),
@IdServicio bigint
) 
as 
begin 
insert into CronogramaLaboral(UserId,EntradaJornada,IdServicio) values (@UserId,Convert(datetime,@EntradaJornada,120),@IdServicio)
end

