<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.ArticuloImagen>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.ArticuloImagen s in Model)
    {
        retval.Add("{orden:" + s.Orden + ",id:" + s.ArticuloImagenID + ", img:'" + s.File.Filename + "', ext:'" + s.File.Extension + "',thumb:'/File/GetFile?id=" + s.File.FileID + "'}");

    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>