<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="consultas-form" id="divDatos" style="margin:auto; width:60%; display:block; padding:18px 14px; position:relative; margin-bottom:20px; background-color:#4f91cd; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block">
                  
				<form action="/Confirmacion" method="post" style="margin-top:18px; border-top:2px solid #FFF; padding-top:9px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif">
                <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Confirmación de inscripción</h3>
                <%if (Session["modoPago"].ToString() == "Camara")
                          { %>
                    <table style="margin:auto">
                        <tr>
                             <td style="margin:auto">
                                <input style="cursor:pointer;margin:auto;width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 52px;" type="submit" id="btnInscribir" value="Clic aquí para confirmar inscripción" class="system-color-btn" /></td>
                        </tr>
                    </table>
                 <%} %>
               <%else{ %>
                    <table style="margin:auto">
                    <tr>
                        <td style="margin:auto">
                            <input style="cursor:pointer;margin:auto;width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 52px;" type="submit" id="btnInscribir2" value="Clic aquí para continuar a pago online" class="system-color-btn" /></td>
                        
                    </tr>
                    </table>
                <%} %>
                <table style="margin:auto">
                    <tr>
                        <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">Nombre y apellido del inscripto: <%=ViewData["cNombreApellido"] %></label></td>
                    </tr>
                    <tr>
                        <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">Nombre del curso: <%=Session["cCursoNombre"]%></label></td>
                    </tr>
                    <tr>
                        <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">Costo del curso: $<%=ViewData["cCostoCurso"]%> </label></td>
                    </tr>
                    <tr>
                        <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">Monto a pagar: $<%=ViewData["cCosto"] %> </label></td>
                    </tr>
                     <tr>
                    <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact"><%=ViewData["mensajeCodigoProm"]%> </label></td>
                    </tr>
                    </table>
                    <br />
                    <br />
                    <table style="margin:auto">
                    <tr>
                        <td style="margin:auto">
                            <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">
                            Muchas gracias por inscribirse en nuestras actividades de educación ejecutiva.<br />
                            Una vez que confirme la inscripción recibirá a la brevedad en el correo <%=Session["contactoMail"].ToString().ToUpper()%> la 
                            confirmación de la preinscripción y más información del curso.<br />
                            Te 
                            esperamos.<br />
                            <br />
                            Recuerde que la inscripción queda confirmada una vez que ha sido 
                            abonado el arancel.<br />
                            Cordialmente,
                            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Escuela de Gestión.</label></td>
                    </tr>
                   
                </table>
                <br />
                <br />
                <table style="margin:auto">
                    <tr>
                        <td style="margin:auto"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:14px; color:#F2F5A9; max-width:100px; margin-bottom:14px;" for="Cuil_fact"><%=ViewData["cError"] %></label></td>
                    </tr>
                </table>
                <br />

                </form>
                
                 
               
                <br />
                <br />
               <%if (Session["cursoGratis"].ToString() == "si")
                  { %>
                <h3 id="h3_pagina1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 3/3</h3>
				<%} %>
                <%else
                    { %>
                    <h3 id="h1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 4/4</h3>
                <%} %>	
				
                <br />
                <br />
                <br />
                
                </div>
    

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    dataLayer.push({
        'event': 'trackStep',
        'step': 4
    });
</script>
</asp:Content>
