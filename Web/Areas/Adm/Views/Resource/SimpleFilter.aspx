<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Resource>>" %>
<% 
    foreach (Camarco.Model.Resource r in ViewData.Model)
    {
        %><tr ><td><a href="#" title="SELECCIONAR RECURSO" onclick="SimpleHandlerOnClick(this,<%=r.ResourceID %>)"><img src="/Content/CSS/Back/icons/tag_blue_add.png" width="16" height="16" /></a>&nbsp;<span><%=r.Nombre %></span></td></tr><%
    }
%>