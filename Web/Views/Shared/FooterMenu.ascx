<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache VaryByParam="None" Duration="1800" %>
<% 
    List<Camarco.Model.Seccion> Menu = Camarco.Model.Secciones.GetMenu();
%>
<ul>
<% 
    int index = 0;
    foreach (Camarco.Model.Seccion s in Menu)
    {
        %><li><a href="/<%=s.Resource.Slug %>" title="<%=s.Nombre %>"><%=Html.Encode(s.Nombre) %></a></li><%
        if (++index % 5 == 0)
        {
            %></ul><ul><%
        }
    }    
%>
<li><a href="/Contacto" title="Contacto">Contacto</a></li>
<%--<li><a href="/EspacioPyme" title="Espacio Pyme">Espacio Pyme</a></li>--%>
</ul>