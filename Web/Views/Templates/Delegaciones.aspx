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
      <h2 class="title"><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.ToUpper()) %></h2>
      <div class="articulo">
      	<% Html.RenderPartial("~/Views/Shared/SeccionMultimedia.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        <h3>Seleccione su ubicaci&oacute;n o la localidad m&aacute;s cercana</h3>
      <!-- MODULO SELECT CATEGORIA -->
        <!-- Este modulo tiene un script asociado que esta al pie de pagina -->
      	<form class="selectcat">
        	<ul class="categorias">
           	  <li class="long">
            	  <label>UBICACI&Oacute;N</label>
                	<div class="wrapper-dropdown sddwn" id="dropdownProvincias"><span id="dropdownProvinciasSpan">Seleccione la Ubicaci&oacute;n</span>
						<ul class="dropdown" ><li><a href="#" onclick="FilterProvincias(-1,'Todas')">Todas</a></li><% 
                                                  foreach (Camarco.Model.Provincia p in Camarco.Model.Provincias.ListAll())
                                                  {
                                                      %><li><a href="#" onclick="FilterProvincias(<%=p.ProvinciaID %>,'<%=p.Nombre %>')"><%=Html.Encode(p.Nombre) %></a></li><%
                                                  }
                                %></ul>
					</div>
                </li>
            </ul>
      </form>
        <!-- FIN SELECT CATEGORIA -->
		<h3>O busque su delegaci&oacute;n m&aacute;s pr&oacute;xima en el siguiente listado:</h3>
      </div>
      <ul class="delegaciones">
        <% 
            foreach (Camarco.Model.Delegacion d in Camarco.Model.Delegaciones.ListAll())
            {
                
                %><li class="provincia<%=d.Provincia.ProvinciaID %>"><h3><a href="/contacto/<%=d.DelegacionID %>" title="Contactarse con esta delegación"><%=d.Nombre.ToUpper()%></a></h3>
                <p><strong>Presidente:</strong> <%=Html.Encode(d.Presidente) %> </p>
                <p><strong>Direcci&oacute;n:</strong> <%=Html.Encode(d.Domicilio) %> </p>
                <p><strong>E-mail:</strong> <a href="mailto:<%=d.Email %>"><%=d.Email %></a></p>
                <p><strong>Tel&eacute;fono:</strong> <%=d.Contacto %></p>
                <p><strong>Fax:</strong> <%=d.Fax %></p>
                <a href="/contacto/<%=d.DelegacionID %>" title="Descargar" class="leer-mas"><span>Contactarse con esta delegaci&oacute;n</span></a>
                </li><%
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
    </div>
	<!-- FIN MODULO ACCESOS DIRECTOS INTERNOS -->
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    function DropDown(el)
    {
        this.sddwn = el;
        this.initEvents();
    }
    DropDown.prototype = {
        initEvents: function ()
        {
            var obj = this;

            obj.sddwn.on('click', function (event)
            {
                $(this).toggleClass('active');
                event.stopPropagation();
            });
        }
    }
    function FilterProvincias(id, nombre)
    {
        $('#dropdownProvinciasSpan').text(nombre);
        $('.delegaciones').fadeOut();
        if (id == -1)
        {
            $('.delegaciones > li').show();
        }
        else
        {
            $('.delegaciones > li').hide();
            $('.provincia'+id).show();
        }
        $('.delegaciones').fadeIn();
    }
    $(function ()
    {
       new DropDown($('#dropdownProvincias'));
       
    });
</script>
</asp:Content>
