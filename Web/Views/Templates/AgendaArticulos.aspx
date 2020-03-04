<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción 
</asp:Content>
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/masresultados.js"></script>
<script type="text/javascript">
    var Categorias = {
        filterTematica:function(tem){
            $('.resultados').html('<div class="preloader"></div>');
            $.get("/Search/AgendaFilterArticulos?seccionid=<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID %>&tag="+tem,function(h){
                $('.resultados').html(h);
                MasResultados.Init($('#ulResultados'),10, $('.masresultados'));
                MasResultados.Redraw();
            });
        }
    };

    $(document).ready(function ()
    {
        MasResultados.Init($('#ulResultados'),10, $('.masresultados'));
        MasResultados.Redraw();
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content agenda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
    	<h1><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
        <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        
        <!-- NIVEL 3 - AGENDA Y NOVEDADES -->
        <h2 class="title"><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.ToUpper()) %></h2>
        <div class="resultados">
        <ul id="ulResultados">
        <% 
            foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.ListBySeccionType(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID, (int)Camarco.Model.ResourceType.ARTICULO, 50))
            {
                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                a.LoadImagenes();
                string imagen = (a.Imagenes.Count > 0 ? "/File/GetFile?id=" + (a.Imagenes[0].FileThumb!=null?a.Imagenes[0].FileThumb.FileID.ToString():a.Imagenes[0].File.FileID.ToString()) : "/Content/CSS/Front/imagenes/articulo_sinthumb.png");
                %>
                <li style="display:none">
				    <div class="img"><a href="<%=r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID) %>" title="Leer texto completo" ><img src="<%=imagen %>" alt="<%=r.Nombre %>" title="<%=r.Nombre %>"/></a>
				    </div>
				    <div class="data">
					    <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
				      <h3><a href="<%=r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID) %>"><%=Html.Encode(a.Titulo)%></a></h3>
					    <p><%=Html.Encode(a.Subtitulo)%> <a href="<%=r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID) %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                        <ul class="tematicas-resultado"><li>TEM&Aacute;TICAS RELACIONADAS:</li>
                        <% 
                foreach (string s in r.Tags.Split(','))
                {
                                %><li><a href="#" onclick="Categorias.filterTematica('<%=s %>')"><%=s%></a></li> <%    
                }
                        %>
			    </ul>
				    </div>
			    </li><%
            }
        %>
      </ul>
        </div>
        <!-- NIVEL 3 - FIN AGENDA Y NOVEDADES -->
        <!-- MAS RESULTADOS -->
	<div class="masresultados"><a style="cursor:pointer;" onclick="MasResultados.Mas()">ver m&aacute;s resultados &raquo;</a></div>
  </div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
       <% Html.RenderPartial("~/Views/Shared/Banners/BannerAsociese.ascx"); %>
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div></asp:Content>
