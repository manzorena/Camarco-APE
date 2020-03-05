<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache Duration="60" VaryByParam="None" %>
<% 
    List<Camarco.Model.Seccion> secciones = Camarco.Model.Secciones.GetEspacioPyme();
    foreach (Camarco.Model.Seccion s in secciones)
    {
        %><li class="<%=s.Color %>"><input id="checkbox<%=s.SeccionID %>" type="checkbox" checked="checked"/><label for="checkbox<%=s.SeccionID %>"><%=s.Nombre.ToUpper() %></label></li> <%
    }
%>