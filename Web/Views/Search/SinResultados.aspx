<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content busqueda color09">
    	<!-- NIVEL 3 - BUSQUEDA -->
		<form class="search">
			<div class="search-long">
				<div><input id="toolboxSearchText" type="text" placeholder="Ingrese el término a buscar"/></div>
				<a href="toolboxSearchBtn" title="Buscar" class="search-btn"></a>
			</div>
		</form>
		<!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- RESULTADOS BÚSQUEDA -->
        <div class="sin-resultados">
        		<h3>Lo sentimos, no se hallaron resultados para &quot;<%=ViewData["query"]%>&quot;.</h3>
                <p>Si no encuentra lo que est&aacute; buscando y desea asistencia <a href="/Contacto" title="Háganos llegar su consulta para que podamos asistirlo en encontrar lo que busca">p&oacute;ngase en contacto</a> con nosotros.</p>
       	  </div>
  <!-- FIN RESULTADOS BÚSQUEDA -->
  </div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox busqueda">
        <!-- INDICADORES --><!-- FIN INDICADORES -->
        <!-- INFORMACIÓN IMPORTANTE -->
        <div class="importante">
        	<h2>CONSEJOS DE B&Uacute;SQUEDA</h2>
            <ul>
            	<li>En la mayor&iacute;a de los casos se obtienen mejores resultados de b&uacute;squeda usando <strong>t&eacute;rminos gen&eacute;ricos</strong> como &ldquo;administraci&oacute;n&rdquo; o &ldquo;arquitectura&rdquo;.</strong></li>
            	<li>&iquest;Prob&oacute; con <strong>sin&oacute;nimos</strong> o palabras similares a las ingresadas?</strong></li>
            	<li>Si est&aacute; buscando un curso y no figura en los resultados, le aconsejamos que <strong>visite la secci&oacute;n Capacitaci&oacute;n</strong> y consulte los cursos disponibles actualmente.</li>
                </ul>
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
