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
            <!-- RESULTADOS PROXIMOS CURSOS -->.
            <div class="sin-resultados">
				<h3>Lo sentimos, no hay resultados que coincidan con su criterio de b&uacute;squeda.</h3>
				<p>Si no encuentra lo que est&aacute; buscando y desea asistencia <a href="/contacto" title="Háganos llegar su consulta para que podamos asistirlo en encontrar lo que busca">p&oacute;ngase en contacto</a> con nosotros.</p>
       	  	</div>
            <!-- FIN RESULTADOS PROXIMOS CURSOS -->
            <!-- MODULO NEWSLETTER FORM 2 -->
            <div class="newsletter-form2">
                <h3>RECIBA INFORMACI&Oacute;N SOBRE CURSOS Y CONFERENCIAS EN SU CORREO ELECTR&Oacute;NICO</h3>
                <form>
                    <input id="contactoN" type="text" placeholder="Nombre *"/>
                    <input id="contactoA" type="text" placeholder="Apellido *"/>
                    <input id="contactoEM" type="text" placeholder="Correo electrónico *"/>
                    <a href="#" id="contactoEnviar" class="system-btn">SUSCRIBIRME</a>
                </form>
            </div>
            <!-- MODULO NEWSLETTER FORM 2 -->
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
       	  <h2>CONSEJOS DE B&Uacute;SQUEDA</h2>
            <ul>
            	<li>En la mayor&iacute;a de los casos se obtienen mejores resultados de b&uacute;squeda usando <strong>t&eacute;rminos gen&eacute;ricos</strong> como &ldquo;administraci&oacute;n&rdquo; o &ldquo;arquitectura&rdquo;.</strong></li>
            	<li>&iquest;Prob&oacute; con <strong>sin&oacute;nimos</strong> o palabras similares a las ingresadas?</strong></li>
            	<li> Si no encuentra lo que busca por favor escr&iacute;banos a <a href="mailto:capacitacion@camarco.org.ar">capacitacion@camarco.org.ar</a> para que podamos ayudarlo.</li>
          </ul>
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
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

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    function SubscriptionClose()
    {
        $('#listoSubs').hide();
        $('#contactoN').val('');
        $('#contactoA').val('');
        $('#contactoEM').val('');
    }
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
        $('#contactoEnviar').on('click', function (e)
        {
            var pass = true;
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
    });
</script>
</asp:Content>
