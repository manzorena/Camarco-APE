<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache Duration="3600" VaryByParam="None" %>
<%
   List<Camarco.Model.Curso> cursos = Camarco.Model.Cursos.GetProximos(1);    
%>
<h3 class="footer-div-cursos"><span>PR&Oacute;XIMOS CURSOS</span></h3>
<ul><% 
        //c.Resource.GetPublicUrl("Cursos")
    int contador = 0;
    foreach (Camarco.Model.Curso c in cursos)
    {
        string url = "href='/Cursos/" + c.CampaignID + "'";
        
        if (contador < 5)
        {
             %><li ><a <%=url %>><span><b><%=Html.Encode(c.CronogramaInicio.ToString().Substring(0,5))%></b></span> <%=Html.Encode(c.Titulo)%></a></li><%
        
        }
    contador++;
    }
%></ul>