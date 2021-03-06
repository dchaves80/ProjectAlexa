USE [SistemaDispensario]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Post]    Script Date: 21/2/2019 04:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_Post](
										@TituloPost varchar(60),
										@IdProfesional bigint,
										@FechaCreacion varchar(50),
										@IdPaciente bigint,
										@Estado varchar(20))
as
BEGIN
INSERT INTO [PizarraPosts] VALUES
						   (
						   @TituloPost,
						   @IdProfesional,
						   convert(date,@FechaCreacion,120),
						   @IdPaciente,
						   @Estado
						   )
SELECT Max(Id) FROM PizarraPosts
END

