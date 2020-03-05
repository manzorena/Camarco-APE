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

        <img style="width:100%; margin-bottom: 15px;" class="fullcontent" src=""/>
        <!--../../Content/CSS/Front/imagenes/banner-calidad.jpg-->

        <div class="cont_parrafos content">

           <div class="span6" style="margin-left: 60px;">



    <div class="resultados">
        <ul class="descargables-list" id="ulResultados">
        <% 
            foreach (Camarco.Model.SeccionDocumento sa in ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionDocumentos)
                {
                    string type = "";

                %><li style="padding: 0px;">
                    <h3 class="underlined"><%=sa.Titulo%></h3>
                    <span><%=HttpUtility.HtmlDecode(sa.Descripcion)%></span>

                    <% if(sa.ResourceURL!="http://") { %>
                    <a href="<%=sa.ResourceURL %>" title="Descargar <%=sa.Titulo %>">Descargar <%=sa.Titulo%></a>
                    <%}%>
                 </li>
                 <br />
                <%
                }                                                                                                                                                                                                                                                                                                                                                                  
        %>
    	</ul>
    </div>

    <br />
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


