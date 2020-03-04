<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.Seccion c in Camarco.Model.Secciones.ListAll())
    {
        %><option value="<%=c.SeccionID %>"><%=c.Nombre %></option><%
    }
%>