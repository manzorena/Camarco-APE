<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.SeccionArchivo>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.SeccionArchivo s in Model)
    {
        retval.Add("{id:" + s.SeccionArchivoID + ", file:'" + s.File.Filename + "', ext:'" + s.File.Extension + "', titulo:'" + s.Titulo + "'}");

    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>