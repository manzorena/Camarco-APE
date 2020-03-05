<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.Seccion>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.Seccion c in Model)
    {
        retval.Add("{id:"+c.SeccionID+",nombre:'"+(c.Parent!=null?c.Parent.Nombre+">":"")+c.Nombre+"'}");
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>