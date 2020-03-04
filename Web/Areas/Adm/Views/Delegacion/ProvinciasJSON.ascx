<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache VaryByParam="None" Duration="100000" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.Provincia s in Camarco.Model.Provincias.ListAll())
    {
        retval.Add("{id:" + s.ProvinciaID + ",nombre:'" + s.Nombre + "'}");

    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>