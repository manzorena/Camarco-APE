<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
        
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Transparencia
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="../../Content/CSS/Front/css/Transparencia_styles.css" rel="stylesheet" type="text/css"/>
<link href="../../Content/CSS/Front/css/camarco-screen.css" rel="stylesheet" type="text/css"/>

    <div class="wrapper">
        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %> barra-superior">
            <h1>
                <%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
            <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        </div>

        <img style="width:100%;" class="fullcontent" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>

        <div class="cont_parrafos fullcontent">

	<p class="lead">
		Nuestro Código de Conducta (el “Código”), establece requisitos de comportamiento. Al mismo tiempo, es el cimiento de nuestra cultura y nos ofrece las bases fundamentales a la hora de hacer negocios. El Código es un reflejo de nuestros valores, estableciendo los principios rectores fundamentales que representan a COARCO S.A.
	</p>
    
	<p class="lead">
		Nuestro objetivo es progresar y ser cada día mejores, nuevos principios y orientaciones serán incorporados a este código a medida que evolucionemos como compañía. De esta forma, se incorporarán nuevas políticas cuando se considere necesario para preservar la actividad de nuestra organización.
	</p>
	<p class="lead">
		Es nuestra responsabilidad preservar nuestra marca manteniendo los estándares éticos más elevados y trabajando con total honestidad e integridad.
	</p>
	<div class="row">
		<div class="span3">
			<h3>Programa de integridad</h3>
			<p>Incluye el código de conducta, el plan de capacitación e información sobre nuestro <em>Comité de compliance</em>.</p>
			<p> 
				<a class="link" href="/transparencia/programa-de-integridad">Ir al programa de integridad</a>			</p>
		</div>
		<div class="span3">
			<h3>Consultas y denuncias</h3>
			<p>Acceda al instructivo para consultas y denuncias de nuestro programa de integridad y los distintos medios de contacto para denuncias y consultas —incluyendo el formulario para denuncias.</p>
			<p>
				<a class="link" href="/transparencia/consultas">Ir a consultas y denuncias</a>			</p>
		</div>
		<div class="span3">
			<h3>Adhesión al programa</h3>
			<p>Es fundamental que nuestros Socios, Proveedores y Clientes compartan nuestro compromiso por hacer negocios con integridad y de alli que deban adherir al contenido de nuestro Código.</p>
			<p>
				<a class="link" href="/transparencia/adhesion-al-programa">Ir a adhesión al programa</a>			</p>
		</div>


	</div>
	<br><br><br>

</div>



    </div>


<%--    <div id="contenedor">

        <h1 class="titulo">transparencia</h1>
        <ul class="breadcrumb" style="color: #5dc2a5">
            <li ></li>  
            <li class="active">LEYES Y CONVENIOS</li>
        </ul>
        <img class="banner-calidad" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>
    
    </div>--%>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>


