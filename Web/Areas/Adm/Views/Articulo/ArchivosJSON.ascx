<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.ArticuloArchivo>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.ArticuloArchivo s in Model)
    {
        retval.Add("{id:" + s.ArticuloArchivoID + ", file:'" + s.File.Filename + "', ext:'" + s.File.Extension + "', titulo:'" + s.Titulo + "'}");

    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>