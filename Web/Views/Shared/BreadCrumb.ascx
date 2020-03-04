<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<ul class="breadcrumb"><li><a href="/">INICIO</a></li><% 
    if (Model.Parent != null && Model.Parent.Nombre.ToUpper()!="INICIO")
    {%><li><a href="/<%=Model.Parent.Resource.Slug %>"><%=Html.Encode(Model.Parent.Nombre.ToUpper())%></a></li><%    }%><li class="active"><%=Html.Encode(Model.Nombre.ToUpper()) %></li></ul>