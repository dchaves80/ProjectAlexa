﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ConnectionDispensario.Modelos;
using System.Web.Script.Serialization;

namespace Christoc.Modules.Pizarra
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();

            string json = "null";

            if (Request["busquedaPaciente"] != null)
                json = GetPacientes(Request["busquedaPaciente"], Request["tipoDeDatos"]);

            if (Request["newPost"] != null)
                json = InsertPost(Request["titulo"], int.Parse(Request["idProfesional"]), int.Parse(Request["idPaciente"]));

            if (Request["getPosts"] != null)
                json = GetPostsByIdPaciente(int.Parse(Request["idPaciente"]));

            if (Request["newComment"] != null)
                json = InsertComment(int.Parse(Request["idPost"]), Request["comentario"], int.Parse(Request["idProfesional"]));

            Response.Write(json);
            Response.Flush();
            Response.End();
        }

        private string InsertPost(
            string titulo,
            int idProfesional,
            int idPaciente)
        {
            int idNewPost = PizarraPost.InsertarPost(
                titulo,
                idProfesional,
                DateTime.Now,
                idPaciente,
                "Pendiente");
            
            if (idNewPost == 0)
                return "False";
            else return "True";

        }

        private string GetPacientes(
            string busqueda,
            string searchType)
        {
            if (searchType == "1")
            {
                List<Paciente> resultados = 
                    Paciente.BuscarPacientesByApellido(busqueda);
                return new JavaScriptSerializer().Serialize(resultados);
            }
            else
            {
                List<Paciente> resultados =
                    Paciente.BuscarPacientesByDNI(busqueda);
                return new JavaScriptSerializer().Serialize(resultados);
            }            
        }

        private string GetPostsByIdPaciente(int idPaciente)
        {
            List<PizarraPost> resultados =
                PizarraPost.PostsPorPaciente(idPaciente);           

            return new JavaScriptSerializer().Serialize(resultados);
        }

        private string InsertComment(
            int idPost,
            string comentario,
            int idProfesional)
        {
            int idComment = 
                PizarraComentario.InsertarComentario(idPost, comentario, idProfesional, DateTime.Now);

            if (idComment == 0)
                return "False";
            else return "True";
        }
    }
}