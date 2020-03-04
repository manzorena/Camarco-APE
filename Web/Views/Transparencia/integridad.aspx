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

        <img style="width:100%; margin-bottom: 15px;" class="fullcontent" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>

        <div class="cont_parrafos content">

           <div class="span6" style="margin-left: 60px;">

			<h3 class="underlined">Código de conducta</h3>

			<p>Nuestra actividad se viene transformando de manera vertiginosa en un sentido muy positivo en pos de mayores controles y transparencia. Nuestro modelo de negocio se va a ver beneficiado por este cambio, ya que nuestras prácticas siempre han apuntado a competir en un marco ético y de plena transparencia. Por ello hoy hemos decidido presentar a todos ustedes este nuevo Código que servirá como lineamiento de nuestra actuación corporativa.</p>
			<p>Este Código de Conducta (el “Código”), establece requisitos de comportamiento. Al mismo tiempo, es el cimiento de nuestra cultura y nos ofrece las bases fundamentales a la hora de hacer negocios. El Código es un reflejo de nuestros Valores y por eso en caso de dudas debemos remitirnos a ellos.</p>
			<p><a href="/File/GetPublicFile?id=1494">Descargar código de conducta</a></p>
			<br/>

			<h3 class="underlined">Aprobación del programa</h3>

			<p>Con fecha 1º de Noviembre de 2018, el Directorio de COARCO SA, a fin de dar cumplimiento a los lineamientos previstos en la ley 27.401 y más allá de los elementos mandatorios requeridos en ella en sus artículos 22 y 23, ha aprobado la implementación de un <em>programa de integridad</em> para impulsar e instalar prácticas de control sobre las políticas de transparencia y ética que deben regir el accionar de la empresa.</p>
			<p><a href="/File/GetPublicFile?id=1495">Descargar el Acta de aprobación y compromiso de la alta dirección con el programa de transparencia</a>.</p>
			<br/>

			<h3 class="underlined">Comité de compliance</h3>

			<p>El Directorio de COARCO SA ha decidido la constitución de un Comité de Compliance, integrado por cuatro miembros, quien será responsable de la aplicación  del <em>programa de integridad</em>, asignándole la responsabilidad de la implementación, aseguramiento y mantenimiento de dicho programa.</p>

			<table class="table">
				<tbody>
					<tr>
						<th>Coordinador</th>
						<td>Sr. Juan Carlos Gonzalez</td>
					</tr>
					<tr>
						<th rowspan="4">Integrantes del Comité</th>
					</tr>
					<tr>
						<td>Ing. Marcelo López</td>
					</tr>
					<tr>
						<td>Cdor. Manuel Mendez</td>
					</tr>
					<tr>
						<td>Cdor. Marcelo Pappolla</td>
					</tr>
				</tbody>
			</table>

			<h3 class="underlined">Capacitación</h3>

			<p>COARCO SA ha encomendado a la firma de Abogados WORTMAN JOFRË–ISOLA la preparación e implementación de una serie de actividades programáticas con el fin de dotar a la Empresa de un esquema continuo de capacitación en materia de ética y transparencia, que permita planificar las acciones y otorgar previsibilidad a las acciones emprendidas en la materia. De esta forma, se evidencia el compromiso “Tone from the Top”  a la hora de implementar las políticas adoptadas.</p>
			<p><a href="/File/GetPublicFile?id=1496">Descargar plan de capacitación el programa de integridad</a></p>
			<br/>

			<hr/>

			<h4>Ver también</h4>

			<h5>Consultas y denuncias</h5>
			<p>Acceda al instructivo para consultas y denuncias de nuestro programa de integridad y los distintos medios de contacto para denuncias y consultas —incluyendo el formulario para denuncias.</p>
			<p><a href="/transparencia/consultas">Ir a consultas y denuncias</a></p>
			<br/>

			<h5>Adhesión al programa</h5>
			<p>Es fundamental que nuestros Socios, Proveedores y Clientes compartan nuestro compromiso por hacer negocios con integridad y de alli que deban adherir al contenido de nuestro Código.</p>
			<p>
				<a href="/transparencia/adhesion-al-programa">Ir a adhesión al programa</a>			</p>
			<br/>
			<br/>

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


