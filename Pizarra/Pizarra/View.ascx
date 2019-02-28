﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="Christoc.Modules.Pizarra.View" %>


<div>

    <h1 style="margin-bottom: 50px;">PIZARRA</h1>

    <input type="button" value="BUSCAR PACIENTE" class="FormButton" onclick="AbrirBuscarPacientePopUp()"/>
    <span onclick="UndoSelectPaciente()" id="PacienteSeleccionado"></span> <br />


    <!-- CREAR POST -->
    <div style="display: none;" id="CrearNuevoPostDiv">

        
        <input type="button" id="ButtonCrearPost" class="FormButton" value="Crear post" style="display: inline-block;" />

        
        <div style="display: none;" id="CrearNuevoPost">
            <input type="button" class="fakeButton" value="TITULO" />
            <input type="text" id="NewTituloPostText" />
            <br />
            <!-- <input type="button" class="FormButton" onclick="AbrirBuscarPacientePopUp()" value="BUSCAR PACIENTE" /> -->



            <input type="button" onclick="GuardarPost()" value="GUARDAR" />

        </div>
    </div>
    

    <%--<!-- PACIENTE 1 -->
    <div style="background: #767676;">

        <!-- Nombre Paciente -->
        <div>
            <h2>LUCIANO LAPENNA</h2>
        </div>
        

        <!-- Sprints -->
        <div style="padding: 20px;">
            <h3>Administrar 2mg de x</h3>
            
            <p>Dr. Juan Bolainas - 22/02/2019 23:14 - ESTADO: <span style="color:green;">FINALIZADO</span></p>

            <!-- Comentarios -->
            <div style="padding: 20px;">
                
                <!-- Comentario -->
                <div>
                    <p>Dra. Fernanda Pérez - 23/02/2019 0:21</p>
                    <p>Administrados con éxito los 2mg de X</p>
                </div>
            </div>
        </div>
    </div>--%>

    <div id="ListaPostsDiv">

    </div>

</div>

<!-- POP UPS -->
<div>
    <!-- Buscar Pacientes -->
    <div title="Buscar Paciente" id="BuscarPacientePopUp">
        <input type="button" value="Nombre" />
        <input type="text" id="ParametroBuscadorPacientes" /> <br />
        <input type="button" onclick="BuscarPaciente('1')" value="BUSCAR por APELLIDO" />
        <input type="button" onclick="BuscarPaciente('2')" value="BUSCAR por DOCUMENTO" />

        <table id="TablaResultadosPacientes">
            <tr>
                <th>APELLIDO</th>
                <th>NOMBRE</th>
                <th>NRO. DOCUMENTO</th>
            </tr>
        </table>
    </div>
</div>

<!-- HIDDENS -->
<div>
    
    <input type="hidden" id="IdPacienteHidden" />    
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="IdProfesional" />
    
</div>

<script>


    // POP UP BUSCAR PACIENTE
    //
    var BuscarPacientePopUp = $('#BuscarPacientePopUp').dialog(
        {
            autoOpen: false,
            closeOnEscape: false,
            modal: true,
            dialogClass: 'dnnFormPopup',
            resizable: false,
            draggable: false,
            width: 'auto',
            show: 'blind',
            hide: 'blind',
        })
    //
    function AbrirBuscarPacientePopUp() {
        ReconstruirTabla();
        $('#CrearNuevoPostDiv').hide('slow');
        BuscarPacientePopUp.dialog('open');
        UndoSelectPaciente();
    }
    function CerrarBuscarPacientePopUp() {
        BuscarPacientePopUp.dialog('close');
    }
    //
    function BuscarPaciente(tipoDeDatos) {

        var paramBusqueda = $('#ParametroBuscadorPacientes').val()
        if (paramBusqueda == "") {
            alert("Falta rellenar el campo de texto");
        }
        else {
            SearchPacientes(tipoDeDatos, paramBusqueda)
        }
        
    }
    //
    function SearchPacientes(tipoDeDatos, data) {
            $.ajax({

            url: "DesktopModules/Pizarra/WebService.aspx",
            dataType: 'json',
            data:
            {
                tipoDeDatos: tipoDeDatos,
                busquedaPaciente: data               
            },
            success: function (data)
            {
                ReconstruirTabla();
                for (a = 0; a < data.length; a++) {
                    $('#TablaResultadosPacientes').append(
                        "<tr>" +
                            "<td>" + data[a].APELLIDO + "</td>" +
                            "<td>" + data[a].NOMBRE + "</td>" +
                            "<td>" + data[a].NRODOCUMENTO + "</td>" +
                            "<td> <input type='button' value='SELECCIONAR' onclick='SelectPaciente(\"" + data[a].ID + "\",\"" + data[a].NOMBRE + "\",\"" + data[a].APELLIDO + "\",\"" + data[a].NRODOCUMENTO + "\")' /> </td>" + 
                        "</tr>"
                        );
                    }
                }
            })          
    }
    //
    function ReconstruirTabla() {
        $('#TablaResultadosPacientes').empty();
        $('#TablaResultadosPacientes').append
            (
            "<tr>" +
                "<th>APELLIDO</th>" +
                "<th>NOMBRE</th>" +
                "<th>DNI</th>" +
            "<tr>");
    }



    //
    //              SELECCIONAR PACIENTES
    //
    function SelectPaciente(idPaciente, nombre, apellido, dni) {
        CerrarBuscarPacientePopUp();
        $('#PacienteSeleccionado').text("Viendo los posts de: " + apellido + " " + nombre + " - " + "DNI: " + dni);
        $('#PacienteSeleccionado').show('slow');
        $('#IdPacienteHidden').val(idPaciente);
        $('#CrearNuevoPostDiv').show('slow');
        GetPostsByPaciente(idPaciente);        
    }
    //
    function UndoSelectPaciente() {
        $('#PacienteSeleccionado').hide('slow', function ()
        {
            $('#PacienteSeleccionado').text('');
        });        
        $('#IdPacienteHidden').val('');
        $('#ListaPostsDiv').empty();
    }
    //
    function GetPostsByPaciente(idPaciente) {

        $.ajax({
            url: "DesktopModules/Pizarra/WebService.aspx",
            dataType: 'json',
            data:
            {
                getPosts: 'true',
                idPaciente: idPaciente,
            },
            success: function (data) {
                for (a = 0; a < data.length; a++) {
                    $('#ListaPostsDiv').append(
                        "<!-- Sprint " + data[a].Titulo + " - " + data[a].Estado + " -->"+
                        "<div style='background-color: gray;'>" +
                            "<input onclick='ShowComments(this)' style='font-weight: bold;' type='button' value='+' />" +
                            "<h3 style='display: inline-block; margin-bottom: 20px;'>" + data[a].Titulo + " - " + "<span class='" + data[a].Estado + "'>" + data[a].Estado + "</span>" + "</h3>" +
                            "<div style='display: none;'>" +
                                "<p style='font-weight: bold; margin-top: -15px;'>" + data[a].NombreProfesional + " " + data[a].ApellidoProfesional + " - " + data[a].FechaCreacionString + "</p>" +
                                "<!-- Comentarios -->" +
                                "<div>" +
                                    "<p>Dr Xxx Yyy - dd/mm/aa </p>" +
                                    "<p> Lorem ipsum </p>" +
                                "</div>" +
                            "</div>" +
                        "</div>")
                }
                
            }

        })
    }
    //
    function ShowComments(object) {
        var commentsDiv = $(object).siblings('div');
        var button = $(object);

        if (commentsDiv.is(":hidden")) {
            commentsDiv.show('slow');
            button.val("-");
        }
        else {
            commentsDiv.hide('slow');
            button.val("+");
        }

    }
    

    function AbrirCerrarCreatePost() {
        var div = $('#CrearNuevoPost');
        var button = $('#ButtonCrearPost')

        if (div.is(":hidden")) {
            div.show('slow');
            button.val("CERRAR")
        }
        else {
            div.hide('slow');
            button.val("CREAR POST")
        }
    }

    function OpenPost() {

    }

    function GuardarPost() {
        var titulo = $('#NewTituloPostText').val();
        var idPaciente = $('#IdPacienteHidden').val();
        var idProfesional = $('#IdProfesional').val();


        if (titulo != "" && idPaciente != "") {
            $.ajax({
                url: "DesktopModules/Pizarra/WebService.aspx",
                dataType: 'text',
                data:
                {
                    newPost: 'true',
                    idPaciente: idPaciente,
                    titulo: titulo,
                    idProfesional: idProfesional,
                },
                success: function (data) {
                    if (data == "True") {
                        alert("Post agregado con éxito.");
                    }
                    else {
                        alert("Hubo un error inesperado y no se agregó el post.")
                    }
                }
            })
        }
        else {
            alert("Falta completar un campo.");
        }
    }

</script>