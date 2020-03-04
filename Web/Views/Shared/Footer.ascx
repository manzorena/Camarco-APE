<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<%@ Register Src="~/Views/Shared/FooterMenu.ascx" TagPrefix="mvc" TagName="Menu" %>
<%@ Register Src="~/Views/Shared/FooterAccesosDirectos.ascx" TagPrefix="mvc" TagName="Accesos" %>

<div class="footer">
	<div class="footer-content">
    	<!-- NIVEL 2 - NOTICIAS -->
    
        <!-- NIVEL 2 - FIN NOTICIAS -->
        <!-- NIVEL 2 - SECCIONES PRINCIPALES -->
        <div class="footer-div2">
        	<h3><span>SECCIONES PRINCIPALES</span></h3>
            <mvc:Menu runat="server" />
        </div>
        <!-- NIVEL 2 - FIN SECCIONES PRINCIPALES -->
        <!-- NIVEL 2 - ACCESOS DIRECTOS -->
        <div class="footer-div2">
        	<h3><span>ACCESOS DIRECTOS</span></h3>
           <mvc:Accesos runat="server" />
        </div>
        <!-- NIVEL 2 - FIN ACCESOS DIRECTOS -->
        <h4 class="footer-nota">C&Aacute;MARA ARGENTINA DE LA CONSTRUCCI&Oacute;N. Av. Paseo Col&oacute;n 823 (1063) / Buenos Aires, Argentina. Tel: 4361-8778 (l&iacute;neas rotativas)</h4>
        <br /><a style="margin-bottom:30px" href="http://qr.afip.gob.ar/?qr=bcez8G9HxRW-fgp1gpJ2cQ,," target="_F960AFIPInfo"><img width="57" height="78" src="http://www.afip.gob.ar/images/f960/DATAWEB.jpg" border="0"></a>
    </div>
</div>