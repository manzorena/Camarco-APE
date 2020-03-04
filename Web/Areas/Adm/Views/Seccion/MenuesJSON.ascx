<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.AccesoDirecto>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.AccesoDirecto s in Model)
    {
        List<string> links = new List<string>();
        foreach (Camarco.Model.AccesoDirectoLink l in s.Links)
        {
            links.Add("{id:"+l.Id+",titulo:'" + l.Titulo + "', link:'" + l.Link + "',resourcetype:" + (l.Resource != null ? (int)l.Resource.Type : 0) + ", resourceid:" + (l.Resource != null ? (int)l.Resource.ResourceID : 0) + " }");
        }
        retval.Add("{id:" + s.Id + ",titulo:'" + s.Titulo + "', orden:"+s.Orden+",links:[" + string.Join(",", links.ToArray()) + "]}");
        links = null;
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>