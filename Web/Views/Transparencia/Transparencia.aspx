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
    <%
        if (ViewData["Errors"] != null)
        {
            %>
                <div class="alert alert-warning" style="backround-color: red;">Se ha enviado su mensaje. Muchas gracias</div>
            <%
        }
        else
        {
            if (ViewData["send?"] == "true")
            {
    %>
                <div class="alert alert-warning">Se ha enviado su mensaje. Muchas gracias</div>
    <% 
            }
        }
    %>


        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %> barra-superior">
            <h1>
                <%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
            <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        </div>

        <img style="width:100%;" class="fullcontent" src=""/>
        <!--../../Content/CSS/Front/imagenes/banner-calidad.jpg-->

        <div class="cont_parrafos fullcontent">

	<p class="lead" >
		La Cámara se enfrenta actualmente a una serie de desafíos que la ponen ante la oportunidad de ser líder y referente en materia de ética, integridad y competitividad. Por ello, es necesario adecuar las reglas que la rigen, a fin de conducir sus relaciones internas, las conductas de sus Empleados, Directivos, Delegaciones y las de los Asociados, para que sus vínculos institucionales y gubernamentales se desarrollen de forma transparente.
	</p>
    
	<p class="lead" >
		La ética en los negocios ya es un atributo empresarial decisivo para el buen desempeño de las empresas y su estatus reputacional ante la sociedad.
	</p>
	<p class="lead" >
		Conscientes de lo anterior, la Cámara se abocó a la tarea de definir los lineamientos que orienten el accionar de la misma y permitan una buena relación entre las partes que intervienen en el proceso constructivo. 
	</p>
    <p class="lead" >
		Nuestro Código de Ética invita a nuestros Asociados a la adhesión y consciencia respecto de la conducta y comportamiento ético ejemplar que la comunidad espera. Asimismo, pretendemos colocar a disposición del sector y del país las premisas e iniciativas más actualizadas y alineadas a los estándares internacionales, que favorecen los principios de actuación de la Cámara y servirán de referencia para las empresas asociadas.
	</p>
	<div class="row">

		<div class="span3">
			<h3>Programa de integridad</h3>
			<p> Incluye el Código de Ética, el Plan de Capacitación e información sobre nuestro <em>Comité Asesor de Integridad</em>.</p>
			<p> 
				<a class="link" href="/transparencia/programa-de-integridad">Ir al programa de integridad</a>			</p>
		</div>
		<div class="span3">
			<h3>Consultas y denuncias</h3>
			<p>Conozca nuestro canal de consultas y los mecanismos para efectuar denuncias. </p>
			<p>
				<a class="link" href="/transparencia/consultas">Ir a consultas y denuncias</a>			</p>
		</div>
		<div class="span3">
			<h3>Adhesión al programa</h3>
			<p>Es fundamental que nuestras Empresas Asociadas, Directivos, Delegaciones y Empleados compartan nuestro compromiso por hacer negocios con integridad. Conozca cómo adherirse al contenido de nuestro Código de Ética.</p>
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


