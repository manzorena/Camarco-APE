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

        <img style="width:100%; margin-bottom: 17px;" class="fullcontent" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>

        <div class="cont_parrafos content" style="margin-left: 60px;">


        <div class="span6">

			<h3 class="underlined">Adhesión al programa de integridad</h3>

			<p>Es fundamental que nuestros Socios, Proveedores y Clientes compartan nuestro compromiso por hacer negocios con integridad y de alli que deban adherir al contenido de nuestro Código. Estas normas se aplican a personas humanas, personas jurídicas, organizaciones no gubernamentales y/u organismos estatales que se relacionen con nosotros (“Socios, Proveedores y Clientes”).</p>

			<br>

			<h4>Cómo adherirse</h4>

			<ol>
				<li>Asegurese de haber leído, comprendido y estar de acuerdo con nuestro código de conducta. Puede consultarlo en esta sección:
				<a href="/transparencia/programa-de-integridad">Ir al programa de integridad</a>				</li>
				<li>
					Descargar nota de adhesión al programa a continuación: <br>
					<a class="btn btn-success" style="margin-top:8px" href="/File/GetPublicFile?id=1497">Descargar nota de adhesión al programa</a>
				</li>
				<li>Imprima y firme la nota, adjunte copia escaneada en el siguiente formulario:</li>
			</ol>

			<h5>Formulario de adhesión al programa de integridad</h5>

			<form action="/transparencia-adhesion-al-programa" class="form form-vertical" id="ContactAdherenceForm" enctype="multipart/form-data" method="post" accept-charset="utf-8"><div style="display:none;"><input type="hidden" name="_method" value="POST"></div>
				<div class="control-group"><label for="ContactNames" class="control-label">Nombre/s y Apellido/s</label><div class="controls"><input name="data[Contact][names]" class="span4" type="text" id="ContactNames" required="required"></div></div><div class="control-group"><label for="ContactCompany" class="control-label">Empresa</label><div class="controls"><input name="data[Contact][company]" class="span4" maxlength="200" type="text" id="ContactCompany" required="required"></div></div><div class="control-group"><label for="ContactOccupation" class="control-label">Cargo</label><div class="controls"><input name="data[Contact][occupation]" class="span4" type="text" id="ContactOccupation" required="required"></div></div>	         	<div class="control-group"><label for="ContactAttachment" class="control-label">Adjuntar nota de adhesión</label><div class="controls"><input type="file" name="data[Contact][attachment]" class="span4" id="ContactAttachment"></div></div>	         	<p class="muted">
	         		Puede subir archivos pdf, jpg, jpeg, o png de hasta 10MB
	         	</p>
	         	<br>

				<div class="control-group">
	          		<div class="controls">

            <script src="https://www.google.com/recaptcha/api.js"></script> 
		             	
            <div class="g-recaptcha" data-sitekey="6Lf4fKgUAAAAADIW5b15wHnsuNs6WBHARl_uSW-A"></div>

		          	</div>
		        </div>

				<button class="btn btn-large btn-success btn" type="submit">Enviar</button>
			</form>
			<hr>

			<h4>Ver también</h4>

			<h5>Programa de integridad</h5>
			<p>Incluye el código de conducta, el plan de capacitación e información sobre nuestro <em>Comité de compliance</em>.</p>
			<p>
				<a href="/transparencia/programa-de-integridad">Ir al programa de integridad</a>			</p>
			<br>

			<h5>Consultas y denuncias</h5>
			<p>Acceda al instructivo para consultas y denuncias de nuestro programa de integridad y los distintos medios de contacto para denuncias y consultas —incluyendo el formulario para denuncias.</p>
			<p><a href="/transparencia/consultas">Ir a consultas y denuncias</a></p>
			<br>
			<br>

		</div>


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


