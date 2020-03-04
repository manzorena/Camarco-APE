﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
	<div class="content busqueda color09">
		<h2 class="title">Resultados de búsqueda</h2>
		<!-- NIVEL 3 - BUSQUEDA -->
		<form class="search">
			<div class="search-long">
				<div><input id="toolboxSearchText" type="text" placeholder="Ingrese el término a buscar" value="<%=ViewData["query"] %>"/></div>
				<a href="#" id="toolboxSearchBtn" title="Buscar" class="search-btn"></a>
			</div>
		</form>
		<!-- NIVEL 3 - FIN BUSQUEDA -->
		<!-- RESULTADOS BÚSQUEDA -->
		<div class="resultados">
		<h3>Se encontraron <%=ViewData["Total"] %> Resultados</h3><ul>
        <% 
            bool LoggedIn = Session["UserID"] != null;
            System.Globalization.CultureInfo provider = new System.Globalization.CultureInfo("es-AR");
            int seccionActual = 0;
            foreach (Camarco.Model.Resource r in (List<Camarco.Model.Resource>)ViewData["Resources"])
            {
                if (r.Type != Camarco.Model.ResourceType.CURSO)
                {
                    if (r.Secciones.Count == 0) continue;
                    int seccionResource = r.Secciones[0].SeccionID;
                    if (seccionActual != seccionResource)
                    {
                        seccionActual = r.Secciones[0].SeccionID;
                    %></ul><h4>Resultados en <a href="/<%=r.Secciones[0].Resource.Slug %>"><%=r.Secciones[0].Nombre%></a><input type="hidden" class="hidden-numeral" value="<%=seccionActual %>"/></h4><ul><%
                    }
                }
                else
                {
                    int seccionResource = -1;
                    if (seccionActual != seccionResource)
                    {
                        seccionActual = seccionResource;
                    %></ul><h4>Resultados en <a href="/Cursos">Cursos</a><input type="hidden" class="hidden-numeral" value="-1"/></h4><ul><%
                    }
                }
                switch (r.Type)
                {
                    case Camarco.Model.ResourceType.CURSO:
                        Camarco.Model.Curso c = Camarco.Model.Cursos.GetByResource(r.ResourceID);
                        string Imagen = c.urlImagen;
                        if (c.ImagenID > 0)
                            Imagen = "/File/GetFile?id="+c.ImagenID;
                        %>
                        <li>
				            <div class="img">
					            <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider) %></span>
					            <a href="/Cursos/<%=c.CampaignID %>" title="Leer texto completo" ><img src="<%=Imagen %>" width="142" height="115" alt="<%=c.Titulo %>" title="<%=c.Titulo %>"/></a>
				            </div>
			              <div class="data">
					            <div class="archivo-tipo"><h4>CURSO</h4></div>
					            <h3><a href="/Cursos/<%=c.CampaignID %>"><%=Html.Encode(c.Titulo) %></a></h3>
					            <p><%=Html.Encode(c.Copete)%> <a href="/Cursos/<%=c.CampaignID %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                                <%if (c.CronogramaFin.Subtract(c.CronogramaInicio).TotalDays > 1)
                                  {  %>
                                <p class="curso-data"><strong>Inicio:</strong> <%=c.CronogramaInicio.ToString("dd-MM-yyyy")%></p>
                                <p class="curso-data"><strong>Frecuencia:</strong> <%=c.DiasSemanaCantidad%></p>
                                <p class="curso-data"><strong>Horario:</strong> <%=c.CronogramaHorarioInicio.ToString("HH:mm")%> a <%=c.CronogramaHorarioFin.ToString("HH:mm")%> hs.</p>
                                <%}
                                  else
                                  {%>
                                  <p class="curso-data"><strong>Fecha:</strong> <%=c.CronogramaInicio.ToString("dd-MM-yyyy")%></p>
                                <p class="curso-data"><strong>Horario:</strong> <%=c.CronogramaHorarioInicio.ToString("HH:mm")%> a <%=c.CronogramaHorarioFin.ToString("HH:mm")%> hs.</p>
                                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=c.Duracion%></p>
                                  <%
                                  } %>
				            </div>
			            </li>
                        <%
                        break;
                   case Camarco.Model.ResourceType.ARTICULO:
                        Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                        a.LoadImagenes();
                        string imagen = (a.Imagenes.Count > 0 ? "/File/GetFile?id=" + (a.Imagenes[0].FileThumb != null ? a.Imagenes[0].FileThumb.FileID.ToString() : a.Imagenes[0].File.FileID.ToString()) : "/Content/CSS/Front/imagenes/articulo_sinthumb.png");
                        %><li>
				            <div class="img"><a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" ><img src="<%=imagen %>" alt="<%=r.Nombre %>" title="<%=r.Nombre %>"/></a>
				            </div>
				            <div class="data">
					            <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
				              <h3><a href="/<%=r.GetPublicUrl(seccionActual) %>"><%=Html.Encode(a.Titulo)%></a></h3>
					            <p><%=Html.Encode(a.Subtitulo)%> <a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
				            </div>
			            </li><%
                        break;
                   case Camarco.Model.ResourceType.DOCUMENTO:
                        Camarco.Model.Documento d = Camarco.Model.DocumentoManager.GetByResource(r.ResourceID);
                        string url = (!d.Publico && !LoggedIn ? "\" onclick=\"Session.ShowLogin(false," + d.FileID + ");return false;\"" : r.GetPublicUrl(seccionActual));
                        %><li class="archivo-li">
					    <a href="<%=url %>" title="Descargar PDF" class="pdf-btn"></a>
					    <div class="archivo-tipo"><h4>DESCARGABLE</h4>
                        <%if(!d.Publico && !LoggedIn) {
                        %> // <a href="#" class="tooltip"><span>Requiere ser socio</span><div class="tooltip-text"><h4>Este archivo sólo se encuentra disponible para socios de la Cámara.</h4><p>Haga click para descubrir los beneficios de ser socio.</p></div></a> <%
                        }%>
                        // Actualizado <%=d.FechaModificacion.ToString("dd-MM-yyyy") %></div>
					    <h3><a href="<%=url %>" title="Descargar PDF"><%=Html.Encode(d.Titulo) %></a></h3>
					    <p><%=Html.Encode(d.Descripcion) %></p>
					    <% if (url.Length > 0) {%>
					    <a href="<%=url %>" title="Descargar archivo PDF" class="leer-mas"><span>Descargar PDF</span></a>
                        <%} %>
				        </li><%
                        break;
                        
                }
            }
        %>
        </ul>
        </div>
        <!-- FIN RESULTADOS INDICADORES -->
        <!-- MAS RESULTADOS -->
        <% if(!(bool)ViewData["last"]) {%>
		<div class="masresultados"><a style="cursor:pointer" onclick="LoadMore()">ver m&aacute;s resultados &raquo;</a></div>
        <%} %>
        <!-- FIN MAS RESULTADOS -->
	  <!-- NIVEL 3 - FIN AGENDA Y NOVEDADES -->
  </div>
  <!-- NIVEL 2 - FIN CONTENT -->
	<!-- NIVEL 2 - TOOLBOX -->
	<div class="toolbox busqueda">
		<!-- INDICADORES --><!-- FIN INDICADORES -->
		<!-- INFORMACIÓN IMPORTANTE -->
		<div class="importante">
			<h2>CONSEJOS DE B&Uacute;SQUEDA</h2>
			<p><strong>Si no encuentra</strong>&nbsp;lo que est&aacute; buscando y desea asistencia <a href="/contacto" title="Contáctenos para que podamos ayudarle a encontrar la información que busca">p&oacute;ngase en contacto con nosotros.</a></p>
		</div>
		<!-- FIN INFORMACIÓN IMPORTANTE -->
	</div>
  <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    var Init={page:<%=ViewData["page"] %>, query:'<%=ViewData["query"] %>'};
    function LoadMore()
    {
        var seccionActual = $('.hidden-numeral').last().val();
        $('.resultados').append('<div class="preloader"></div>');
            $.get("/Search/GlobalSearchParcial?query="+Init.query+"&page="+(++Init.page)+"&seccion="+seccionActual,function(h){
                $('.preloader').remove();
                if(h.length==0)
                    $('.masresultados').hide();
                else
                    $('.resultados > ul').append(h);
            });
    }
</script>
</asp:Content>
