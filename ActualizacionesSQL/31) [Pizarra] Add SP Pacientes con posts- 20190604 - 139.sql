Create procedure Get_PacientesWithPostsPizarra
as

begin
SELECT Distinct IdPaciente from PizarraPosts
end