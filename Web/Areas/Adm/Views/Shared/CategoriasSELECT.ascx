<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.DocumentoCategoria c in Camarco.Model.DocumentoManager.GetCategorias())
    {
        %><option value="<%=c.DocumentoCategoriaID %>"><%=c.Nombre %></option><%
    }
    
%>