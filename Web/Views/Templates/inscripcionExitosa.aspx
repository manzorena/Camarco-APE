<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	inscripcionExitosa
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

  <div class="consultas-form" id="divDatos" style="margin:auto; width:60%; display:block; padding:18px 14px; position:relative; margin-bottom:20px; background-color:#4f91cd; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block">
                  
				<form action="/Confirmacion" method="post" style="margin-top:18px; border-top:2px solid #FFF; padding-top:9px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif">
                <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Confirmación de inscripción</h3>
                
                
                    <br />
                    <br />
                    <table style="margin:auto">
                    <tr>
                        <td style="margin:auto">
                            <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">
                            Muchas gracias por inscribirse en nuestras actividades de educación ejecutiva. 
                            Su inscripción ha sido completada con éxito.<br />
                            <br />
                            Cordialmente,
                            <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Escuela de Gestión.</label></td>
                    </tr>
                   
                </table>
                <br />

                
                
                
                </form>
				
                <br />
                <br />
                <br />
                
                </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
