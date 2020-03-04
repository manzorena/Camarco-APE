<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content color09">
    	<h1>Cursos de perfeccionamiento para mejorar los resultados </h1>
        <ul class="breadcrumb">
       	  <li><a href="/">INICIO</a></li>
          <li class="active">CONTACTO</li>
	  </ul>
	<h2 class="title">CONTACTO</h2>
    <img src="/Content/CSS/Front/imagenes/contacto-pic.jpg" width="616" height="227" alt="CAMARCO, formulario de contacto">
    <p class="content-p">Para ponerse en contacto con la C&aacute;mara de la Construcci&oacute;n complete el siguiente formulario</p>
    <!-- MODULO CONSULTAS -->
	<div class="consultas-form consultas-system">
    	<h3>CONSULTAS</h3>
		<form>
			<input id="contactoNA" type="text" placeholder="Nombre y apellido *" class="halfWidth"/>
			<input id="contactoEM" type="text" placeholder="Correo electrónico *" class="halfWidth"/>
            <input id="contactoE" type="text" placeholder="Empresa" class="halfWidth"/>
			<input id="contactoTE" type="text" placeholder="Teléfono" class="halfWidth"/>
            <input id="contactoD" type="text" placeholder="Dirección"/>
            <input id="contactoL" type="text" placeholder="Localidad" class="halfWidth"/>
			<input id="contactoP" type="text" placeholder="Provincia" class="halfWidth"/>
			<textarea id="contactoM" cols="" rows="" placeholder="Escriba aquí su mensaje"></textarea>
            <ul class="search-filters">
				<li><input id="contactoSub" type="checkbox" name="contactoSub" value="1"/><label for="contactoSub">Deseo suscribirme al newsletter</label></li>
        	</ul>
			<a href="#" class="system-btn" id="btnEnviar">ENVIAR<div id="envioOk" class="tooltip-text"><h4>ENVÍO REALIZADO CON ÉXITO</h4><p>Nos pondremos en contacto con usted en breve a través de la dirección de correo electrónico provista.</p></div></a>
		</form>
	</div>
	<!-- FIN MODULO CONSULTAS -->
</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox color03">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- DIRECCIÓN -->
        <div class="importante">
        	<h2>INFORMACI&Oacute;N DE CONTACTO</h2>
        	<div class="contacto-agenda">
            	<p><strong>TEL&Eacute;FONO:</strong> 011 4361-8778</p>
            	<p><strong>EMAIL:</strong><a href="mailto:cac@camarco.org.ar">cac@camarco.org.ar</a></p>
            </div>
            <div class="contacto-direccion">
            	<p><strong>Av. Paseo Col&oacute;n 823 (1063)</strong></p>
            	<p>CABA, Argentina</p>
            </div>
          	<iframe width="271" height="277" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com.ar/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Av.+Paseo+Col%C3%B3n+823&amp;aq=&amp;sll=-38.452918,-63.598921&amp;sspn=37.786351,86.572266&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear=Av+Paseo+Col%C3%B3n+823,+San+Telmo,+Buenos+Aires&amp;z=14&amp;ll=-34.617437,-58.369695 &amp;iwloc=near &amp;output=embed"></iframe><br /><a href="https://maps.google.com.ar/maps?f=q&amp;source=embed&amp;hl=en&amp;geocode=&amp;q=Av.+Paseo+Col%C3%B3n+823&amp;aq=&amp;sll=-38.452918,-63.598921&amp;sspn=37.786351,86.572266&amp;t=m&amp;ie=UTF8&amp;hq=&amp;hnear=Av+Paseo+Col%C3%B3n+823,+San+Telmo,+Buenos+Aires&amp;z=14&amp;ll=-34.617437,-58.369695" class="google-map" target="_blank" >Ver mapa en Google Maps</a>
        </div>
        <!-- FIN DIRECCIÓN -->
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/jqueryJSON.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#btnEnviar').on('click', function (e) {
            e.preventDefault();
            var pass = true;
            if (PageCore.IsEmpty($('#contactoNA').val())) {
                $('#contactoNA').addClass('formError');
                pass = false;
            }
            else
                $('#contactoNA').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoEM').val())) {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoEM').removeClass('formError');
            var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
            if (pass && !filter.test($('#contactoEM').val())) {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else if (pass)
                $('#contactoEM').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoM').val())) {
                $('#contactoM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoM').removeClass('formError');
            if (pass) {
                dataLayer.push({ 'event': 'formCompleted' });
                dataLayer.push({ 'event': 'newsLetterSuscribe' });
                $('#btnEnviar').toggleClass("waiting");
                PageCore.AjaxPost('/Contacto', $.toJSON({ del: -1, na: $('#contactoNA').val(), em: $('#contactoEM').val(), e: $('#contactoE').val(),
                    te: $('#contactoTE').val(), d: $('#contactoD').val(), l: $('#contactoL').val(), p: $('#contactoP').val(), m: $('#contactoM').val(), s: $('#contactoSub').is(":checked")
                }), function () {
                    $('#btnEnviar').toggleClass("waiting");
                    $('#contactoNA').val('');
                    $('#contactoEM').val('');
                    $('#contactoE').val('');
                    $('#contactoTE').val('');
                    $('#contactoD').val('');
                    $('#contactoL').val('');
                    $('#contactoP').val('');
                    $('#contactoM').val('');
                    $('#contactoSub').prop('checked', false);
                    $('#envioOk').show();
                    setTimeout(function () { $('#envioOk').hide(); }, 3000);
                });
            }
        });
    });
</script>
</asp:Content>