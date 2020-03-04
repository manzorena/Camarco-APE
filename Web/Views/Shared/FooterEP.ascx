<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Register Src="~/Views/Shared/FooterEPAccesosDirectos.ascx" TagPrefix="mvc" TagName="Accesos" %>
<%@ Register Src="~/Views/Shared/NoticiasResumenEP.ascx" TagPrefix="mvc" TagName="Noticias" %>
<div class="espacio-pyme-footer">
	<div class="fcontent">
    	<!-- NOVEDADES -->
		<mvc:Noticias runat="server" />
        <!-- FIN  NOVEDADES -->
        <!-- ACCESOS DIRECTOS -->
        <div class="accesos-directos-pyme">
        	<h3>ACCESOS DIRECTO</h3>
            <mvc:Accesos runat="server" />
        </div>
        <!-- FIN ACCESOS DIRECTOS -->
    </div>
</div>
<div class="espacio-pyme-footerend">
	<div class="footer-content">
		<span>ESPACIO PYME es un producto de la C&Aacute;MARA ARGENTINA DE LA CONSTRUCCI&Oacute;N</span>
        <a href="/" class="btn">IR AL SITIO DE LA C&Aacute;MARA</a>
    </div>
    <br /><a style="margin-bottom:30px" href="http://qr.afip.gob.ar/?qr=bcez8G9HxRW-fgp1gpJ2cQ,," target="_F960AFIPInfo"><img width="57" height="78" src="http://www.afip.gob.ar/images/f960/DATAWEB.jpg" border="0"></a>
</div>
