<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
    	<h1><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
        <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
      <h2 class="title"><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.ToUpper()) %></h2>
      <!-- MODULO ARTICULO -->
      <div class="articulo">
        <% Html.RenderPartial("~/Views/Shared/SeccionMultimedia.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        <%=((Camarco.Model.Seccion)ViewData["seccion"]).Texto%>
      </div>
      <!-- FIN MODULO ARTICULO -->
      <!-- PDF WARNING -->
      <% 
            ((Camarco.Model.Seccion)ViewData["seccion"]).LoadArchivos();
            if (((Camarco.Model.Seccion)ViewData["seccion"]).Archivos.Count > 0)
            { 
      %>
	<span class="pdf-warning">Para visualizar los descargables de distintos formatos es necesario contar con los software apropiados para cada caso.<a href="http://get.adobe.com/es/reader/" target="_blank" title="Descargar Adobe Reader"></a></span>

	<!-- FIN PDF WARNING -->
    <!-- DESCARGABLES MODO LISTADO -->
    <div class="resultados">
        <ul class="descargables-list" id="ulResultados">
        <% 
                foreach (Camarco.Model.SeccionArchivo sa in ((Camarco.Model.Seccion)ViewData["seccion"]).Archivos)
                {
                    string type = "";
                    switch (sa.File.Extension.ToLower())
                    {
                        case "doc":
                        case "docx":
                            type = "docx";
                            break;
                        case "png":
                        case "jpg":
                            type = "png";
                            break;

                        default: type = "pdf"; break;
                    }
                %><li><a target="_blank" href="/File/GetFile?id=<%=sa.File.FileID %>" class="filetype <%=type %>" title="Descargar"></a><h3><a href="/File/GetFile?id=<%=sa.File.FileID %>" target="_blank" title="Descargar"><%=Html.Encode(sa.Titulo)%></a></h3><span><%=sa.File.Extension.ToUpper()%> // <%=sa.File.Kb%> Kb.</span><a target="_blank" href="/File/GetFile?id=<%=sa.File.FileID %>" title="Descargar" class="leer-mas"><span>Descargar</span></a></li><%
                }
        %>
    	</ul>
    </div>
    <!-- FIN DESCARGABLES MODO LISTADO -->
    <div class="masresultados"><a href="#">ver m&aacute;s resultados &raquo;</a></div>
    <% } %>
</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <% Html.RenderPartial("~/Views/Shared/AccesosDirectosInternos.ascx"); %>
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/masresultados.js"></script>
<script type="text/javascript">
    $(document).ready(function ()
    {
        MasResultados.Init($('#ulResultados'), 3, $('.masresultados'));
        MasResultados.Redraw();
    });
</script>
</asp:Content>
