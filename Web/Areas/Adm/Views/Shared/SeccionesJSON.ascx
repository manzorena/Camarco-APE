<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<int>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.Seccion c in Camarco.Model.Secciones.ListAll())
    {
        if (Model == (int)Camarco.Model.ResourceType.DOCUMENTO)
        {
            if (c.Template != 1 && c.Template != 3 && c.Template != 5) continue;
        }
        if (Model == (int)Camarco.Model.ResourceType.ARTICULO)
        {
            if (c.Template != 1 && c.Template != 2 && c.Template != 4 && c.Template != 6) continue;
        }
        retval.Add("{id:" + c.SeccionID + ",nombre:'" + (c.Parent != null ? c.Parent.Nombre + ">" : "") + c.Nombre + "', parentS:" + (c.Parent == null ? "false" : "true") + "}");
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>