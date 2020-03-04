<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.DocumentoCategoria>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.DocumentoCategoria c in Model)
    {
        retval.Add("{id:"+c.DocumentoCategoriaID+",nombre:'"+c.Nombre+"'}");
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>