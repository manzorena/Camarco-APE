<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<ul class="breadcrumb"><li><a href="/">INICIO</a></li><% 
    if (Model.Parent != null && Model.Parent.Nombre.ToUpper()!="INICIO")
    {%><li><a href="/<%=Model.Parent.Resource.Slug %>"><%=Html.Encode(Model.Parent.Nombre.ToUpper())%></a></li><%    }%><li ><a href="/<%=Model.Resource.Slug %>"><%=Html.Encode(Model.Nombre.ToUpper()) %></a></li>
    <li class="active"><%=(((Camarco.Model.Articulo)ViewData["resource"]).Titulo.Length > 60 ? Html.Encode(((Camarco.Model.Articulo)ViewData["resource"]).Titulo.Substring(0, 60) + "...") : Html.Encode(((Camarco.Model.Articulo)ViewData["resource"]).Titulo))%></li>
</ul>