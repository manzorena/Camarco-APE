<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content busqueda color03">	
        <h2 class="title">Capacitaci&oacute;n y Desarrollo</h2>
        <!-- NIVEL 3 - BUSQUEDA -->
      <form class="search">
      	<div class="search-long">
      		<div><input value="<%=ViewData["query"] %>" id="capacitacionSearch" type="text" placeholder="Ingrese el término a buscar"/></div>
			<a href="#" id="capacitacionSearchBtn" title="Buscar" class="search-btn"></a>
        </div>
        <ul class="search-filters">
			<li><input id="checkNoticias" type="checkbox" <%=ViewData["checknoticias"] %>/>
			<label for="checkNoticias">Mostrar noticias</label></li>
            <li><input id="checkCursosPasados" type="checkbox" <%=ViewData["checkcursos"] %>/>
            <label for="checkCursosPasados">Mostrar cursos pasados</label></li>
        </ul>
        </form>
        <!-- NIVEL 3 - FIN BUSQUEDA -->
		<div class="resultados">
			<h3>Se encontraron <%=ViewData["Total"] %> Resultados</h3>
            <!-- RESULTADOS PROXIMOS CURSOS -->
            <h4>Resultados en <a href="#">Pr&oacute;ximos cursos</a></h4>
                <ul>
                    <% 
                        System.Globalization.CultureInfo provider = new System.Globalization.CultureInfo("es-AR");
                        foreach (Camarco.Model.Curso c in (List<Camarco.Model.Curso>)ViewData["Cursos"])
                        {
                            string sub = (c.Copete.Length <= 200 ? Html.Encode(c.Copete) : Html.Encode(c.Copete.Substring(0, 197)) + "...");
                            string Imagen = c.urlImagen;
                            if (c.ImagenID > 0)
                                Imagen = "/File/GetFile?id=" + c.ImagenID;
                            %><li>
				                <div class="img">
					                <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider) %></span>
					                <a href="/Cursos/<%=c.CampaignID %>" title="Leer texto completo" ><img src="<%=Imagen %>" width="142" height="115" alt="<%=c.Titulo %>" title="<%=c.Titulo %>"/></a>
				                </div>
			                  <div class="data">
					                <div class="archivo-tipo"><h4>CURSO</h4></div>
					                <h3><a href="/Cursos/<%=c.CampaignID %>"><%=Html.Encode(c.Titulo) %></a></h3>
					                <p><%=sub%> <a href="/Cursos/<%=c.CampaignID %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
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
			                </li><%
                            
                        }
                    %>
                </ul>
            <!-- FIN RESULTADOS PROXIMOS CURSOS -->
            <!-- RESULTADOS NOTICIAS / CURSOS PASADOS -->
            <h4 id="otrosResultados">Otros resultados</h4>
                <ul id="ulResultados">
                <% 
                    foreach (Camarco.Model.Resource r in (List<Camarco.Model.Resource>)ViewData["Otros"])
                    {
                        switch (r.Type)
                        {
                            case Camarco.Model.ResourceType.CURSO:
                                Camarco.Model.Curso c = Camarco.Model.Cursos.GetByResource(r.ResourceID);
                                string sub = (c.Copete.Length <= 200 ? Html.Encode(c.Copete) : Html.Encode(c.Copete.Substring(0, 197)) + "...");
                                %><li>
                                    <div class="sub-data">
                                    <div class="archivo-tipo"><h4>CURSO</h4> // INICIO <%=c.CronogramaInicio.ToString("dd-MM-yyyy") %> // DURACI&Oacute;N <%=Html.Encode(c.Duracion) %> // <em>FINALIZADO</em></div>
                                        <h3><a href="/Cursos/<%=c.CampaignID %>"><%=Html.Encode(c.Titulo) %></a></h3>
                                        <p><%=sub %> <a href="/Cursos/<%=c.CampaignID %>"" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                                    </div>
                                </li><%
                                break;
                            case Camarco.Model.ResourceType.ARTICULO:
                                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                                string suba = (a.Subtitulo.Length <= 200 ? Html.Encode(a.Subtitulo) : Html.Encode(a.Subtitulo.Substring(0, 197)) + "...");
                                string url = r.GetPublicUrl(0);
                                %><li>
                                    <div class="sub-data">
                                    <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
                                        <h3><a href="/<%=url %>"><%=Html.Encode(a.Titulo)%></a></h3>
                                        <p><%=suba%><a href="/<%=url %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                                    </div>
                                </li><%
                                break;
                        }
                    }    
                %>
            </ul>
      </div>
      <div class="masresultados"><a href="#" style="cursor:pointer;" onclick="MasResultados.Mas()">ver m&aacute;s &raquo;</a></div>
      <!-- FIN RESULTADOS NOTICIAS / CURSOS PASADOS -->
</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox busqueda">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- INDICADORES --><!-- FIN INDICADORES -->
        <!-- INFORMACIÓN IMPORTANTE -->
        <div class="importante">
        	<h2>RESULTADOS DE B&Uacute;SQUEDA</h2>
            <p>Los resultados de la b&uacute;squeda se obtienen de los contenidos generales del sitio. Si no encuentra lo que busca por favor escr&iacute;banos a <a href="mailto:contacto@camarco.org.ar">contacto@camarco.org.ar</a> para que podamos ayudarlo.</p>
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/masresultados.js"></script>
<script type="text/javascript">
    $(document).ready(function ()
    {
        $('#checkNoticias').on('click', function (event)
        {
            window.location = '/buscar-capacitacion/' + $('#capacitacionSearch').val() + '/' + ($('#checkNoticias').is(":checked") ? "1" : "0") + '/' + ($('#checkCursosPasados').is(":checked") ? "1" : "0");
        });
        $('#checkCursosPasados').on('click', function (event)
        {
            window.location = '/buscar-capacitacion/' + $('#capacitacionSearch').val() + '/' + ($('#checkNoticias').is(":checked") ? "1" : "0") + '/' + ($('#checkCursosPasados').is(":checked") ? "1" : "0");
        });
        $('#capacitacionSearch').on('keydown', function (event)
        {
            if (event.which == 13)
            {
                event.preventDefault();
                if ($(this).val().split(' ').join('').length > 0)
                {
                    if ($(this).val().split(' ').join('').length < 5)
                    {
                        alert("Ingrese al menos 4 letras para la búsqueda.");
                        return false;
                    }
                    window.location = '/buscar-capacitacion/' + $(this).val();
                }
            }
        });
        $('#capacitacionSearchBtn').on('click', function (event)
        {
            if ($('#capacitacionSearch').val().split(' ').join('').length > 0)
            {
                if ($('#capacitacionSearch').val().split(' ').join('').length < 5)
                {
                    alert("Ingrese al menos 4 letras para la búsqueda.");
                    return false;
                }
                window.location = '/buscar-capacitacion/' + $('#capacitacionSearch').val();
            }
        });
        if ($('#ulResultados > li').length == 0)
        {
            $('#otrosResultados').hide();
        }
        MasResultados.Init($('#ulResultados'), 10, $('.masresultados'));
        MasResultados.Redraw();
    });
</script>
</asp:Content>
