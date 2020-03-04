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
      <!-- REDES SOCIALES -->
      <ul class="redes-sociales">
      	<li><a target="_blank" href="http://twitter.com/share?url=<%=Request.Url.AbsoluteUri.Replace("/","%2F").Replace(":","%3A") %>&text=<%=((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.Replace(" ","%20") %>" class="twitter" title="Twittear">TWITTEAR</a></li>
        <li><a href="http://www.linkedin.com/shareArticle?mini=true&url=<%=Request.Url.AbsoluteUri %>&title=<%=((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina %>&summary=<%=((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion %>&source=www.camarco.org.ar" target="_blank" class="linkedin" title="Compartir en LinkedIn">COMPARTIR</a></li>
        <li><a target="_blank" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=<%=Request.Url.AbsoluteUri %>&amp;p[title]=<%=((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina %>&amp;p[summary]=<%=((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion %>" class="facebook" title="Me gusta">ME GUSTA</a></li>
      </ul>
      <!-- FIN REDES SOCIALES -->
      <h2 class="title"><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.ToUpper()) %></h2>
      <ul class="guias-practicas">
        <%
            foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.ListBySeccionType(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID, (int)Camarco.Model.ResourceType.ARTICULO, 100))
            {
                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                %><li><a href="<%=r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID) %>" title="<%=Html.Encode(a.Titulo)%>"><%=Html.Encode(a.Titulo)%></a></li><%
            }    
        %>
      </ul>
</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- MODULO ACCESOS DIRECTOS INTERNOS -->
      <% Html.RenderPartial("~/Views/Shared/AccesosDirectosInternos.ascx"); %>
	<!-- FIN MODULO ACCESOS DIRECTOS INTERNOS -->
       <!-- MODULO NEWSLETTER FORM 1 -->
	<div class="newsletter-form1">
    	<h3>RECIBA INFORMACI&Oacute;N</h3>
        <p>SOBRE CURSOS Y CONFERENCIAS EN SU CORREO ELECTR&Oacute;NICO SUSCRIBI&Eacute;NDOSE AL NEWSLETTER DE CAPACITACI&Oacute;N</p>
        <form>
        	<input id="contactoN" type="text" placeholder="Nombre *"/>
            <input id="contactoA" type="text" placeholder="Apellido *"/>
            <input id="contactoEM" type="text" placeholder="Correo electrónico *"/>
            <a href="#" id="contactoEnviar" class="system-btn">SUSCRIBIRME<div id="newsTooltip" class="tooltip-text"><p><span id="newsTooltipText"></span></p></div></a>
        </form>
    </div>
    <!-- FIN MODULO NEWSLETTER FORM 1 -->
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
<script type="text/javascript" src="/Scripts/jqueryJSON.js"></script>
<script type="text/javascript">
    function SubscriptionClose(){
        $('#listoSubs').hide();
        $('#contactoN').val('');
        $('#contactoA').val('');
        $('#contactoEM').val('');
    }
    $(document).ready(function ()
    {
     $('.redes-sociales > li > a').on('click',function(e){
           e.preventDefault();
           window.open($(this).attr("href"), 'share', 'width=600, height=400,location=no,status=yes,resizable=yes,scrollbars=no, menubar=yes');
        });
        $('#contactoEnviar').on('click', function (e)
        {
            <%if (Session["Subscripto_Capacitacion"] != null && (bool)Session["Subscripto_Capacitacion"] == false)
            {  %>
            $('#newsTooltipText').text("Su email ya se encuentra registrado. Si no está recibiendo nuestros envíos por favor revise en su correo basura y agregue la siguiente dirección contacto@camarco.org.ar en la libreta de direcciones de su correo para que los próximos envíos lleguen correctamente");
            $('#newsTooltip').show();
            setTimeout(3000, function(){
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
                });
            }
        });
        });
</script>
</asp:Content>
