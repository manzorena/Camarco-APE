<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    //int seccionid = Model.SeccionID;
 
    //List<Camarco.Model.Articulo> Recientes = Camarco.Model.Noticias.GetUltimos5Eventos(seccionid);

    var videos = (List<Camarco.Model.VideoYoutubeModel>)ViewData["videos"];
%>

<!-- NIVEL 1 - CONTENIDO -->
    <div class="wrapper">
        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %> barra-superior">
            <h1>
                <%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
            <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        </div>
        <!-- NIVEL 2 - CONTENT -->
        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
            <!-- MODULO SHOWCASE INTERNO -->
            <% Html.RenderPartial("~/Views/Shared/ShowcaseSmall.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
            <!-- FIN MODULO SHOWCASE INTERNO -->
            <!-- NIVEL 3 - BUSQUEDA -->
            <form class="search" style="display: none">
            <div class="search-long">
                <div>
                    <input id="capacitacionSearch" type="text" placeholder="Ingrese el término a buscar" /></div>
                <a href="#" id="capacitacionSearchBtn" title="Buscar" class="search-btn"></a>
            </div>
            </form>
            <!-- NIVEL 3 - FIN BUSQUEDA -->
            <!-- EmaNOB: Reemplaar por videos y twitter-->
            <div class="masresultados">
                <a style="cursor: pointer" onclick="LoadSiguientes()">ver m&aacute;s &raquo;</a></div>
            <div class="novedades" id="logo">
                <span class="separador"></span>
                <h2 class="title" style="color: #00b5cb; font-family: 'Roboto Condensed', sans-serif;
                    font-size: 26px; line-height: 28px; display: block; text-transform: uppercase;
                    font-weight: normal;">
                    Noticias</h2>
                <ul>
                    <% 
                        int seccionActual = ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID;

                        if (seccionActual == 13)
                        {
                            foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.Capacitacion_List(seccionActual, 1))
                            {
                                switch (r.Type)
                                {
                                    case Camarco.Model.ResourceType.ARTICULO:
                                        Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                    %><li style="border-top-style: dashed; border-top-width: thin; color: Gray">
                        <br /><div class="sub-data">
				                    <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
					                    <h3><a style="color: inherit;text-decoration: none;font-family:'Trebuchet MS', Arial, Helvetica, sans-serif;font-size: 18px;color: #565656; font-weight: normal;display: block;text-transform: uppercase;margin-bottom: 5px;display: block;" href="/<%=r.GetPublicUrl(seccionActual) %>"><%=Html.Encode(a.Titulo)%></a></h3>
					                    <p style="font-family:'Trebuchet MS', Arial, Helvetica, sans-serif;font-size: 13px;color: #565656;line-height: 17px;margin-bottom: 4px;" class="resultados sub-data"><%=Html.Encode(a.Subtitulo)%> <a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" class="leer-mas"><span>Leer más</span></a></p>
				                    </div>
			                    <br /></li><%
                            break;
                        }
                    }
                }
      
            %>
            </ul>
            <div class="masresultados"><a style="cursor:pointer" onclick="LoadSiguientesNoticias()">ver más</a></div>
            <span class="separador"></span>
      </div>
        <div class="resultados" id="otrosResultados">
        	<ul >
            <% 
                seccionActual = ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID;

                if (seccionActual != 13)
                {
                    foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.Capacitacion_List(seccionActual, 1))
                    {
                        switch (r.Type)
                        {
                            case Camarco.Model.ResourceType.ARTICULO:
                                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                                %><li>
				                    <div class="sub-data">
				                    <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
					                    <h3><a href="/<%=r.GetPublicUrl(seccionActual) %>"><%=Html.Encode(a.Titulo)%></a></h3>
					                    <p><%=Html.Encode(a.Subtitulo)%> <a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
				                    </div>
			                    </li><%
                            break;
                        }
                    }
                }       
            %>
            </ul>
        </div>
        <div class="masresultados"><a style="cursor:pointer" onclick="LoadMore()">ver m&aacute;s &raquo;</a></div>
		<!-- FIN RESULTADOS BÚSQUEDA PREDETERMINADA-->

        <!--empiezan los videos-->
      
                 <div class="columna-6 tutoriales videos">
                <h2>Videos #EscueladeGestión</h2>
                <ul> 
                    <%
                        if (videos.Count > 1)
                        {
                            for (int i = 0; i < 2; i++)
                            { %>
                        <li>
                            <a href="<%=(videos[i].UrlVideo)%>" target="_blank">
                                <div>
                                    <img src="<%=(videos[i].UrlImagen)%>" alt="<%=(videos[i].Titulo)%>" class="video-imagen"/>
                                </div>
                                <div class="video-informacion">
                                    <%=(videos[i].Titulo)%>
                                    <p class="video-descripcion"><%=(videos[i].Descripcion)%>
                                    <%if (videos[i].Descripcion.Length > 39) {%> 
                                    ...
                                    <% }%> 
                                      <span class="leer-mas ver-mas-video">Ver más</span>
                                     
                                    </p>
                               </div>
                            </a>
                        </li>
                    <% }
                        }
                        else
                        { %>
                           <li>No hay videos</li> 
                        <% }
                        %>
                </ul>
                  
            </div>
                   
        <!--termina los videos-->

        <!--empieza los tweets-->

         <div  class="columna-6 widthTweet" style="width: 35%; float: right;">
                <div class="tweets">

                    <%--Determino la altura de los tweets dependiendo de la cantidad de eventos que hay en agenda--%>
                    <%--<%double altura = 200;
                      if (Recientes.Count > 0)
                      {
                          altura = (200 + (30 * (Recientes.Count)));
                      }
                      else 
                      {
                          altura = 315;
                      }%>  
--%>
                    <h3>TWEETS por <a href="https://twitter.com/egc_argentina?ref_src=twsrc%5Etfw">@egc_argentina</a></h3>
                    <a class="twitter-timeline" data-height="<%=315%>px" href="https://twitter.com/egc_argentina?ref_src=twsrc%5Etfw" data-chrome="noheader noborders nofooter noscrollbar transparent"></a>
                </div>
                  
            </div>

        <!--termina los tweets-->
       
       <span class="separador videosytweet"></span>

</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX --><!--º-->
    <a href="javascript:void(0)" title="Beneficios de ser socio de la Cámara Argentina de la Construcción" class="banner" id="redirect-to-educacionejecutiva"><img class="educacionejecutiva" src="/Content/CSS/Front/imagenes/BANNER-CAPACITACIONES.png" alt="Beneficios de ser socio de la Cámara Argentina de la Construcción"/></a>
    <div class="toolbox busqueda">
    	<!-- NIVEL 3 - BUSQUEDA -->
        <mvc:SearchAll runat="server" />
    	<!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- MODULO ACCESOS DIRECTOS INTERNOS -->
        <% Html.RenderPartial("~/Views/Shared/AccesosDirectosInternos.ascx"); %>
        
	<!-- FIN MODULO ACCESOS DIRECTOS INTERNOS -->
    <!-- MODULO NEWSLETTER FORM 1 -->
        <div class="newsletter-form1">
            <h3>
                MÁS INFORMACIÓN</h3>
            <form id="myForm">
            <div class="mas-informacion-item">
                <span>
                    <input type="radio" name="mail" checked="checked" value="mailto:educacionejecutiva.camarco.org.ar?subject=Quiero recibir el calendario de cursos" />
                    Recibir el calendario de cursos </span>
                <br />
            </div>
            <div class="mas-informacion-item">
                <span>
                    <input type="radio" name="mail" value="subscripcion" />
                    Suscripción al Newsletter </span>
                <br />
            </div>
            <div class="mas-informacion-item">
                <a id="myEmail" class="system-btn" href="mailto:educacionejecutiva.camarco.org.ar?subject=Quiero recibir el calendario de cursos" style="margin-left: 5px">
                    ENVIAR</a>
            </div>
            </form>
        </div>
	<div id="newsletter" class="newsletter-form1" style="display:none">

    	<h3>SUSCRÍBASE AL NEWSLETTER</h3>
        <p>SOBRE CURSOS Y CONFERENCIAS EN SU CORREO ELECTR&Oacute;NICO SUSCRIBI&Eacute;NDOSE AL NEWSLETTER DE CAPACITACI&Oacute;N</p>
        <form>
        	<input id="contactoN" type="text" placeholder="Nombre *"/>
            <input id="contactoA" type="text" placeholder="Apellido *"/>
            <input id="contactoEM" type="text" placeholder="Correo electrónico *"/>
            <a href="#" id="contactoEnviar" class="system-btn">SUSCRIBIRME<div id="newsTooltip" class="tooltip-text"><p><span id="newsTooltipText"></span></p></div></a>
        </form>
    </div>
    <!-- FIN MODULO NEWSLETTER FORM 1 -->
        <!-- INFORMACIÓN IMPORTANTE -->
        <div class="importante consultas" onclick="PageCore.Ir('/Contacto')">
        	
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
        <% Html.RenderPartial("~/Views/Shared/Banners/BannerSepyme.ascx"); %>
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
<div class="popup small" id="listoSubs" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;">
	<h2>&iexcl;LISTO!</h2>
	<p>Se ha suscripto correctamente a nuestro sistema de newsletter, &iexcl;Espere noticias nuestras pronto!</p>
	<a href="#" class="close-btn" onclick="SubscriptionClose()"></a>
	<form>
		<div class="btns"><a href="#" class="btn" onclick="SubscriptionClose()">VOLVER AL SITIO</a></div>
	</form>
</div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/jqueryJSON.js"></script>
<script type="text/javascript" src="/Scripts/slider.js"></script>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        $('input[type="radio"]').click(function () {
            if ($(this).is(':checked')) {
                if ($(this).val() == "subscripcion") {
                    $('#newsletter').show();
                    $("#myEmail").addClass("disable-link");
                }
                else {
                    $('#newsletter').hide();
                    $("#myEmail").removeClass("disable-link");
                }
                var nuevo = $(this).val();
                $("#myEmail").attr('href', nuevo);
            }
        });
    });
</script>
<script type="text/javascript">
function SubscriptionClose(){
        $('#listoSubs').hide();
        $('#contactoN').val('');
        $('#contactoA').val('');
        $('#contactoEM').val('');
        PageCore.CloseLightBox();
    }
    var Init={page:1};
    var Pagina = 1;
 
    function LoadSiguientes()
    {
        for (var i = (Pagina * 5) + 1; i <= (Pagina + 1) * 5; i++) 
        {
            $('#Curso' + i).show();
        }
        Pagina = Pagina + 1;
    }
    function LoadSiguientesNoticias(){ 
        $('#logo').append('<div class="preloader"></div>');
        $.get("/Search/CapacitacionParcial?page=" + (++Init.page) + "&seccion=<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID %>", function (h)
        
        {
            $('.preloader').remove();
            if (h.length < 5)
                $('.masresultados').hide();
            $('#logo > ul').append(h);
        });
        
        
    }
    function LoadMore()
    {
        $('#otrosResultados').append('<div class="preloader"></div>');
        $.get("/Search/CapacitacionParcial?page=" + (++Init.page) + "&seccion=<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID %>", function (h)
        {
            $('.preloader').remove();
            if (h.length < 5)
                $('.masresultados').hide();
            $('#otrosResultados > ul').append(h);
        });
    }
    $(document).ready(function ()
    {
        
        new Slider($('#slider'),true);
        if ($('#otrosResultados > ul > li').length < 5)
            $('.masresultados').hide();
        $('#contactoEnviar').on('click', function (e)
        {
            <%if (Session["Subscripto_Capacitacion"] != null && (bool)Session["Subscripto_Capacitacion"] == false)
            {  %>
            $('#newsTooltipText').text("Su email ya se encuentra registrado. Si no está recibiendo nuestros envíos por favor revise en su correo basura y agregue la siguiente dirección contacto@camarco.org.ar en la libreta de direcciones de su correo para que los próximos envíos lleguen correctamente");
            $('#newsTooltip').show();
            setTimeout(3000, function ()
            {
                $('#newsTooltip').hide();
            });
            return;
            <%} %>
            var pass=true;
            e.preventDefault();
            if (PageCore.IsEmpty($('#contactoN').val()))
            {
                $('#contactoN').addClass('formError');
                pass = false;
            }
            else
                $('#contactoN').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoA').val()))
            {
                $('#contactoA').addClass('formError');
                pass = false;
            }
            else
                $('#contactoA').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoEM').removeClass('formError');
            var filter = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/igm
            //var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
            if (pass && !filter.test($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else if (pass)
                $('#contactoEM').removeClass('formError');
            if (pass)
            {
                $('#contactoEnviar').toggleClass("waiting");
                PageCore.AjaxPost('/Newsletter', $.toJSON({ t: 'capacitacion', n: $('#contactoN').val(), em: $('#contactoEM').val(), a: $('#contactoA').val() }), function ()
                {
                    $('#contactoEnviar').toggleClass("waiting");
                    $('#listoSubs').show();
                    PageCore.ShowLightBox($('#listoSubs'));
                });
            }
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
                    window.location = '/buscar-capacitacion/' + $(this).val() + '/1/1';
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
                window.location = '/buscar-capacitacion/' + $('#capacitacionSearch').val() + '/1/1';
            }
        });

        $('#redirect-to-educacionejecutiva').on('click', function (e){
            window.location.href = "http://educacionejecutiva.camarco.org.ar"
        });
    });
</script>
</asp:Content>
