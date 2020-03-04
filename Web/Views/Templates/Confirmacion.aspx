<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Confirmacion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
    function Seteo() {
        document.getElementsByName("referenceCode")[0].value = document.getElementById("codigo").value;
        document.getElementsByName("description")[0].value = document.getElementById("codigo").value;
        var apiKey = "6u39nqhq8ftd0hlvnjfs66eh8c";
        var merchantId = "500238";
        var referenceCode = document.getElementById("codigo").value;
        var amount = document.getElementsByName("amount")[0].value;
        var currency = document.getElementsByName("currency")[0].value;
        var sign = apiKey + "~" + merchantId + "~" + referenceCode + "~" + amount + "~" + currency;
        var signMD5 = md5(sign); 
        document.getElementsByName("signature")[0].value = signMD5; 
        }
</script>
<div class="consultas-form" id="divDatos" style="margin:auto; width:60%; display:block; padding:18px 14px; position:relative; margin-bottom:20px; background-color:#4f91cd; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block">
                  
				
                
                  <%if (Session["modoPago"].ToString() == "Online")
                  { %>
                  <table style="margin:auto; width:100%">
                      <tr>
                            <td style="margin:auto">
                                <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">
                                Usted ha realizado una preinscripción correcta a la actividad elegida.<br />
                                <br />
                                Muchas gracias por inscribirse en nuestras actividades de educación ejecutiva.<br />
                                En breve recibirá en el correo <%=Session["contactoMail"].ToString().ToUpper()%> la confirmación de la preinscripción y más 
                                información del curso.<br />
                                Te esperamos.<br />
                                <br />
                                Recuerde que la inscripción queda confirmada una vez que ha sido abonado el 
                                arancel. Por favor, haga click en el siguiente botón para dirigirse a la web de 
                                PayU (ex DineroMail) y proceder a la cancelación del monto.Cordialmente,
                                <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                Escuela de Gestión.</label>
                            </td>
                      </tr>
                  </table>
                  <br />
                  <table style="margin:auto; width:100%">
                      
                      <tr style="margin:auto; width:100%">
                          <td style="margin:auto; width:20%"></td>
                          <td style="margin:auto; width:60%">

                            <form style='margin:auto' method="post" action="https://gateway.payulatam.com/ppp-web-gateway" onclick="">  
                                <input name="merchantId"    type="hidden"  value="<%=ViewData["merchantId"]%>"   />  
                                <input name="accountId"     type="hidden"  value="<%=ViewData["accountId"]%>" />  
                                <input name="description"   type="hidden"  value="<%=Session["cCursoNombre"]%>"  />  
                                <input name="referenceCode" type="hidden"  value="<%=ViewData["rtaCam"]%>" />  
                                <input name="amount"        type="hidden"  value="<%=ViewData["amount"]%>"   />  
                                <input name="tax"           type="hidden"  value="0"  />  
                                <input name="taxReturnBase" type="hidden"  value="0" />  
                                <input name="currency"      type="hidden"  value="<%=ViewData["currency"]%>" />  
                                <input name="signature"     type="hidden"  value="<%=ViewData["signature"]%>"  />  
                                <input name="test"          type="hidden"  value="0" />
                                <input name="buyerEmail"    type="hidden"  value="<%=Session["contactoMail"]%>" />  
                                <input name="responseUrl"    type="hidden"  value="" />  
                                <input name="confirmationUrl"    type="hidden"  value="http://www.camarco.org.ar/respuestapayu" /> 
                                <input name="Submit"        type="submit"  value="Ir a plataforma de pago" style="cursor:pointer; margin:auto;width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; height: 52px;"/>
                             </form>

                             
                              
                          </td>
                          <td style="margin:auto; width:20%"></td>
                     </tr>
                 </table>
                <%;
                  } %>
                    
                
                
				
                </div>
               
                <%
                    Session.Clear();
                    Session.Abandon();
                     %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript">
        dataLayer.push({
            'event': 'inscriptionSuccess'
        });
    </script>
</asp:Content>
