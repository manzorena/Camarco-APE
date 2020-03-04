<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Seccion>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
		<ul class="navigation-secondary">
        	<li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" href="<%=Url.Action("Nueva","Seccion") %>" >Nueva secci&oacute;n</a></li>
            <li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" href="<%=Url.Action("NuevaPagina","Seccion") %>" >Nueva p&aacute;gina</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/page_white.png);">SECCIONES</h1>
		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);"><strong>Total:</strong> <%=ViewData.Model.Count %>. Mostrando <%=ViewData.Model.Count %>.</div>
        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);">Arrastre los registros para reordenar las Secciones y definir su orden de aparici&oacute;n en los men&uacute;es</div>
        	<div class="tools-top">
				<ul class="ul-floatleft">
               	  </ul>
                 <ul class="ul-floatright">
                    <li title="Filtrar por Nombre"><input id="formSearchText" type="text" class="styled-input-search"/></li><li><a onclick="globalPagination.Redraw();" class="form-filter"  style="cursor:pointer" title="BUSCAR"></a></li><li><a onclick="$('#formSearchText').val('');globalPagination.Redraw();" class="form-filter-clear"  style="cursor:pointer" title="LIMPIAR FILTRO"></a></li>
                </ul>

        </div>
        <div class="minicontainer-sub-m">
       	   	<table border="0" cellpadding="0" cellspacing="0" class="table-m">
                    <thead>
                	<tr>
			 			<th width="200"><a>Nombre</a></th>
			 			<th width="150"><a>Template</a></th>
			 			<th width="100">Acciones</th>
			        </tr>
                    </thead>
                    <tbody>
                    <% 
                        foreach (Camarco.Model.Seccion s in ViewData.Model)
                        {
                            if (s.Parent != null) continue;
                            %><tr id="row<%=s.SeccionID %>"><td colspan="3" style="width:900px">
                            <table style="width:100%;font-size:inherit;" border="0" cellpadding="0" cellspacing="0">
                            <tr class="not-draggable" style="font-size:90%; background: url('table-tr-even.png') repeat-x scroll left top rgb(247, 247, 247);" ><td class="<%=s.Color%>" width="20" style="width:20px">&nbsp;</td><td width="200" style="width:200px"><%=(s.Parent==null?s.Nombre:s.Parent.Nombre+" > "+s.Nombre) %></td><td width="150" style="width:150px"><% Html.RenderPartial("~/Areas/Adm/Views/Seccion/Template.ascx", s.Template);%></td><td class="table-actions" width="100" style="width:100px"><a href="<%=Url.Action("AccesoDirecto","Seccion", new {id=s.SeccionID}) %>" title="ACCESOS DIRECTOS"><img src="/Content/CSS/Back/icons/layout_sidebar.png" width="16" height="16" /></a><a onclick="Contenidos.Show(<%=s.SeccionID %>,'<%=s.Nombre %>',<%=s.Template %>)" title="VER CONTENIDOS"><img src="/Content/CSS/Back/icons/folder.png" width="16" height="16" /></a><a href="<%=Url.Action((s.Parent==null?"Editar":"EditarPagina"),"Seccion", new {id=s.SeccionID}) %>" title="EDITAR"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a onclick="Eliminar(<%=s.SeccionID %>)" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a></td></tr>
                            <% 
                                List<Camarco.Model.Seccion> paginas = Camarco.Model.Secciones.GetSubsecciones(s.SeccionID);
                                if(paginas.Count>0)
                                {
                                    foreach (Camarco.Model.Seccion pagina in paginas)
                                       {
                                        %><tr class="not-draggable" style="font-size:90%;background-color:white !important;" id="row<%=pagina.SeccionID %>"><td width="20">&nbsp;</td><td width="200">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pagina.Nombre %></td><td width="150"><% Html.RenderPartial("~/Areas/Adm/Views/Seccion/Template.ascx", pagina.Template);%></td><td class="table-actions" width="100"><a onclick="Contenidos.Show(<%=pagina.SeccionID %>,'<%=pagina.Nombre %>',<%=pagina.Template %>)" title="VER CONTENIDOS" style="margin-left:22px"><img src="/Content/CSS/Back/icons/folder.png" width="16" height="16" /></a><a href="<%=Url.Action("EditarPagina","Seccion", new {id=pagina.SeccionID}) %>" title="EDITAR"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a onclick="Eliminar(<%=pagina.SeccionID %>)" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a></td></tr><%
                                       }
                                }
                            %></table></td></tr><%
                        }
                    %>
                    </tbody>
              </table>
        </div>
        
	</div>
</div>

<div class="overlay o-filtros" id="contenidos" style="display:none;position:absolute;z-index:3;top:20%;left:50%;width:600px;margin-left:-300px;"  >
	<div class="overlay-tools">
  		<h3>Ver Contenidos relacionados</h3>
        <a onclick="Contenidos.Close()" class="btn btn-red">Cancelar</a>
    </div>
    <div class="overlay-content">
    	<fieldset class="styled-fieldset">
        	<ul>
				<li id="contenidosDocumentos"><a onclick="Contenidos.Documentos()" href="#" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/page_white_acrobat.png);">Documentos / Archivos</a></li>
                 <li id="contenidosArticulos"><a onclick="Contenidos.Articulos()" href="#" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/script_edit.png);">Art&iacute;culos</a></li>
         </ul></fieldset>
    </div>
   
</div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/jquery-ui-1.9.1.custom.min.js"></script>
<script type="text/javascript" src="/Scripts/pagination.js"></script>
<script type="text/javascript">
    var globalPagination = null;
    $(document).ready(function ()
    {


        $(".table-m > tbody").sortable({
            items: "tr:not(.not-draggable)",
            start: function (e, ui)
            {
                document.body.style.cursor = 'pointer';

                sortableUpdate.desde = ui.item.index();
                sortableUpdate.id = ui.item.attr("id").replace("row", "");
            },
            update: function (event, ui)
            {
                document.body.style.cursor = 'default';
                sortableUpdate.hasta = ui.item.index();

                Reordenar(sortableUpdate);
            }
        });
        globalPagination = new Pagination($('.table-m > tbody'), 20, $('.tools-bot'), 'globalPagination', { column: 1, box: $('#formSearchText'), inner:true });
        globalPagination.Redraw();
    });

    function Eliminar(ids, ask)
    {
        if (ids == 11 || ids == 31)
        {
            //Noticias de la camara y Beneficios
            alert("No puede eliminar la pagina, es un contenido estatico del sitio");
            return false;
        }
        if (!confirm("Esta seguro que desea eliminar el registro?"))
        {
            return false;
        }
        $('#ajaxLoading').show();

        PageCore.AjaxPost('<%=Url.Action("Delete","Seccion") %>?id=' + ids, '', function (obj)
        {
            $('#ajaxLoading').hide();
            if (obj.status == "error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
            $('#row' + ids).remove();
            globalPagination.Redraw();
        });
    }

    function LoadTextAreas() { }
    var sortableUpdate = { desde: null, hasta: null };
    function Reordenar(sortableUpdate)
    {
        var payload = { id: Number(sortableUpdate.id), orden: sortableUpdate.hasta + 1 };
        PageCore.AjaxPost('<%=Url.Action("Reordenar","Seccion") %>', $.toJSON(payload), function (obj) { ; });
    }
    var Contenidos = {
        SeccionID: null,
        SeccionNombre:null,
        Show: function (id, nombre, template) {
            this.SeccionID = id;
            this.SeccionNombre = nombre;
            $('#contenidosDocumentos').show(); $('#contenidosArticulos').show();
            switch (template) {
                case 2: $('#contenidosDocumentos').hide();
                    break;
                case 3: $('#contenidosArticulos').hide();
                    break;
                case 4: $('#contenidosDocumentos').hide();
                    break;
                case 5: $('#contenidosArticulos').hide();
                    break;
                case 6: $('#contenidosDocumentos').hide();
                    break;

            }
            $('#contenidos').show();
            PageCore.ShowLightBox($('#contenidos'));
        },
        Close: function () {
            $('#contenidos').hide();
            PageCore.CloseLightBox();
        },
        Documentos: function () {
            window.location = '<%=Url.Action("ListFiltered","Documento") %>?page=1&perpage=20&filtro=Seccion [' + this.SeccionNombre + ']&nombre=&seccion=' + this.SeccionID + '&categoria=-1';
        },
        Articulos: function () {
            window.location = '<%=Url.Action("ListFiltered","Articulo") %>?page=1&perpage=20&nombre=&seccion=' + this.SeccionID;
        }
    }
</script>
</asp:Content>
