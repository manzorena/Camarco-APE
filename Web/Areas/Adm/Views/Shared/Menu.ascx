<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    string ControllerName = ((string)ViewContext.Controller.ValueProvider.GetValue("controller").RawValue).ToLower();
%>
<ul class="navigation-primary">
    <li><%
        if (ControllerName == "seccion")
        { 
            %><span class="navigation-primary-active">Secciones</span><%
        }
        else
        {
            %><%=Html.ActionLink("Secciones","List","Seccion") %><%
        }                                      
    %></li>
    <li><%
        if (ControllerName == "articulo")
        { 
            %><span class="navigation-primary-active">Noticias / Art&iacute;culos</span><%
        }
        else
        {
            %><%=Html.ActionLink("Noticias / Artículos", "List", "Articulo")%><%
        }                                      
    %></li>
   <li><%
        if (ControllerName == "documento")
        { 
            %><span class="navigation-primary-active">Documentos</span><%
        }
        else
        {
            %><%=Html.ActionLink("Documentos","List","Documento") %><%
        }                                      
    %></li> 
    <li><%
        if (ControllerName == "documentocategoria")
        { 
            %><span class="navigation-primary-active">Categor&iacute;as</span><%
        }
        else
        {
            %><%=Html.ActionLink("Categorías","List","DocumentoCategoria") %><%
        }                                      
    %></li> 
    <li><%
        if (ControllerName == "delegacion")
        { 
            %><span class="navigation-primary-active">Delegaciones</span><%
        }
        else
        {
            %><%=Html.ActionLink("Delegaciones","List","Delegacion") %><%
        }                                      
    %></li>
</ul>
