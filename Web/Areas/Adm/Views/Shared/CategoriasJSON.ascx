<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.DocumentoCategoria c in Camarco.Model.DocumentoManager.GetCategorias())
    {
        retval.Add("{id:" + c.DocumentoCategoriaID + ",nombre:'" + c.Nombre + "', parent:" + (c.Parent == null ? "false" : "true") + ", parentid:" + (c.Parent == null ? "0" : c.Parent.DocumentoCategoriaID.ToString()) + "}");
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>