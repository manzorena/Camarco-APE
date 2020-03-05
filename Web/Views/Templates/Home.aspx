<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
<div class="content">
	<!-- NIVEL 2 - SHOWCASE -->
	<% Html.RenderPartial("~/Views/Shared/Showcase.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
	<!-- NIVEL 2 - FIN SHOWCASE -->
    
    <!-- NIVEL 2 - NOTICIAS DE LA CAMARA Y DEL SECTOR -->
    <% Html.RenderPartial("~/Views/Shared/NoticiasResumen.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>

    <!-- FIN NIVEL 2 - NOTICIAS DE LA CAMARA Y DEL SECTOR -->
    
<!-- NIVEL 1 - FIN CONTENIDO -->
</div>
<!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox">
    	<!-- NIVEL 3 - BUSQUEDA -->
        <mvc:SearchAll runat="server" />
    	<!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- NIVEL 3 - ACCESOS DIRECTOS -->
        <% Html.RenderPartial("~/Views/Shared/AccesosDirectos.ascx"); %>
        <!-- NIVEL 3 - FIN ACCESOS DIRECTOS -->
        <!-- BANNER -->
        <!--<a href="/EspacioPyme" title="Ingresar al Espacio PYME" class="banner" ><img src="/Content/CSS/Front/imagenes/home-banner-pyme.jpg" width="300" height="154" alt="Espacio Pyme"/></a>-->
        <!-- FIN BANNER -->
        <!-- BANNER -->
        <!--<a href="http://www.camarco.org.ar/noticias-generales-de-la-camara/4o-premio-latinoamericano-de-responsabilidad-social-empresarial-fiic" title="4º PREMIO LATINOAMERICANO DE RESPONSABILIDAD SOCIAL EMPRESARIAL FIIC" class="banner" ><img src="/Content/CSS/Front/imagenes/Flyer 4to. Premio RSE.png" width="300" height="388" alt="4º PREMIO LATINOAMERICANO DE RESPONSABILIDAD SOCIAL EMPRESARIAL FIIC"/></a> -->
        <!--<a href="http://www.convocatoriatiic.camarco.org.ar/" title="Postulate a TIIC" class="banner" ><img src="/Content/CSS/Front/imagenes/Aviso_Home_ConvocatoriaTIIC.jpg" width="300" height="154" alt="Postulate a TIIC"/></a>-->
        <!--<br/>-->
        <a href="/Institucional" title="Beneficios de ser socio de la Cámara Argentina de la Construcción" class="banner" ><img src="/Content/CSS/Front/imagenes/home-banner-socios.jpg" width="300" height="154" alt="Beneficios de ser socio de la Cámara Argentina de la Construcción"/></a>
        
        <!-- FIN BANNER -->
        <div class="newsletter-form1 importante">
    	<h3>SUSCR&Iacute;BASE AL NEWSLETTER</h3>
        <form>
        	<input id="contactoN" type="text" placeholder="Nombre *">
            <input id="contactoA" type="text" placeholder="Apellido *">
            <input id="contactoEM" type="text" placeholder="Correo electrónico *">
            <a href="#" id="contactoEnviar" class="system-btn">SUSCRIBIRME<div id="newsTooltip" class="tooltip-text"><p><span id="newsTooltipText"></span></p></div></a>
        </form>
    </div>
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
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/slider.js"></script>
<script type="text/javascript">
    function SubscriptionClose(){
        $('#listoSubs').hide();
        $('#contactoN').val('');
        $('#contactoA').val('');
        $('#contactoEM').val('');
        PageCore.CloseLightBox();
    }
    $(document).ready(function ()
    {
        new Slider($('#slider'), false);
        $('#contactoEnviar').on('click', function (event)
        {
            
            <%if (Session["Subscripto_Institucional"] != null && (bool)Session["Subscripto_Institucional"] == false)
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
            event.preventDefault();
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
            if (!pass) return false;
            $('#contactoEnviar').toggleClass("waiting");
            PageCore.AjaxPost('/Newsletter', $.toJSON({ t: 'institucional', n: $('#contactoN').val(), em: $('#contactoEM').val(), a: $('#contactoA').val() }), function ()
            {
                $('#contactoEnviar').toggleClass("waiting");
                $('#listoSubs').show();
                PageCore.ShowLightBox($('#listoSubs'));
            });
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
    });</script>
</asp:Content>
