<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache Duration="3600" VaryByParam="None" %>
<%
    List<Camarco.Model.Curso> cursos = Camarco.Model.Cursos.GetProximos(1);    
%>
<span>PR&Oacute;XIMOS CURSOS :</span>
<ul>
<% 
    int contador = 0;
    foreach (Camarco.Model.Curso c in cursos)
    {
        if (contador < 5)
        {
        string url = "href='/Cursos/" + c.CampaignID + "'";
        %><li><h3><a <%=url %>><span><b><%=Html.Encode(c.CronogramaInicio.ToString().Substring(0,5))%></b></span> <%=Html.Encode(c.Titulo)%></a></h3><p><%=(c.Copete.Length <= 120 ? Html.Encode(c.Copete) : Html.Encode(c.Copete.Substring(0, 117)) + "...")%></p> </li><%
        
        }
        contador++;
    }
%>
</ul>
