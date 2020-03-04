<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache VaryByParam="None" Duration="3600" %>
<% 
    foreach (Camarco.Model.DocumentoCategoria c in Camarco.Model.DocumentoManager.GetCategoriasParents())
    {
        %><h3><a href="#" onclick="Categorias.filterChange(<%=c.DocumentoCategoriaID %>,-1,'','<%=Html.Encode(c.Nombre) %>')"><%=Html.Encode(c.Nombre) %></a></h3><ul><%
                                                                  
        foreach (Camarco.Model.DocumentoCategoria s in c.GetSubs())
        {
            %><li><a href="#" onclick="Categorias.filterChange(-1, <%=s.DocumentoCategoriaID %>,'','<%=Html.Encode(c.Nombre) %> > <%=Html.Encode(s.Nombre) %>')"><%=Html.Encode(s.Nombre) %></a></li><%
        }
        %></ul><%
    }%>