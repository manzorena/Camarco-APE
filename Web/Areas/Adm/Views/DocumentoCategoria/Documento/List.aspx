<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
		<ul class="navigation-secondary">
        	<li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" href="<%=Url.Action("Nuevo","Documento") %>" >Nuevo documento/archivo</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/page_white.png);">DOCUMENTOS</h1>
        
		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);"><strong>Total:</strong> <%=ViewData["Paginator_Total"]%>. Mostrando <%=((List<Camarco.Model.Documento>)ViewData["Items"]).Count%></div>
        	<div class="tools-top">
				<ul class="ul-floatleft">
               	  <li><div class="styled-select-s"><select onchange="ChangeMaxPageRows(this.value)">
                  	  <option value="20">Ver</option>
                      <option value="20">20</option>
                      <option value="40">40</option>
                      <option value="100">100</option>
                      <option value="200">200</option>
                  </select></div></li>
               		
                 </ul>
                 <ul class="ul-floatright">
                    <li><a onclick="Filtros.Show();" class="form-filter" title="BUSCAR"></a></li>
                </ul>

        </div>
        <div class="minicontainer-sub-m">
       	   	<table border="0" cellpadding="0" cellspacing="0" class="table-m">
                	<tr>
			 			<th width="200"><a>Nombre</a></th>
			 			
			 			<th width="50">Acciones</th>
			        </tr>
                    <% 
                        foreach (Camarco.Model.Documento d in (List<Camarco.Model.Documento>)ViewData["Items"])
                        {
                            %><tr id="row<%=d.DocumentoID %>"><td><%=d.Titulo %></td>
                            <td class="table-actions"><a href="<%=Url.Action("Editar","Documento", new {id=d.DocumentoID}) %>" title="EDITAR"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a onclick="Eliminar(<%=d.DocumentoID%>)" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                            </td>
                            </tr><%
                        }
                    %>
              </table>
        </div>
        <% Html.RenderPartial("~/Areas/Adm/Views/Shared/Paginator.ascx"); %>
        
	</div>
    
</div>

<div class="overlay o-filtros" id="filtros" style="display:none;position:absolute;z-index:3;top:20%;left:50%;width:600px;margin-left:-300px;"  >
	<div class="overlay-tools">
  		<h3>Seleccione filtros de b&uacute;squeda avanzada</h3>
        <a onclick="Filtros.Close()" class="btn btn-red">Cancelar</a>
  		<a href="javascript:void(0);" class="btn btn-green btn-img floatright" onclick="Filtros.Filter();" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Aplicar</a><div class="clearing"></div>
  		
    </div>
    <div class="overlay-content">
    	<fieldset class="styled-fieldset">
        	<ul>
				<li>
                  <label>Nombre</label><input type="text" class="sti-l" id="filtroNombre" value="" /></li>
                <li>
                  <label>Secci&oacute;n</label>
                  <select class="styled-select" id="filtroSeccion" size="1" ><option value="-1" selected="selected">Todos</option><% Html.RenderPartial("~/Areas/Adm/Views/Shared/SeccionesSELECT.ascx"); %></select></li>
                  <li>
                  <label>Categor&iacute;a</label>
				  <select class="styled-select" id="filtroCategoria" size="1"><option value="-1" selected="selected">Todos</option><% Html.RenderPartial("~/Areas/Adm/Views/Shared/CategoriasSELECT.ascx"); %></select></li>
                </ul></fieldset>
    </div>
   
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    $(document).ready(function ()
    {
        ;
    });
    function Eliminar(ids, ask)
    {
        if (!confirm("Esta seguro que desea eliminar el Documento?"))
        {
            return false;
        }
        $('#ajaxLoading').show();

        PageCore.AjaxPost('<%=Url.Action("Delete","Documento") %>?id=' + ids, '', function (obj)
        {
            $('#ajaxLoading').hide();
            if (obj.status == "error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
            $('#row' + ids).remove();
        });
    }
    var Filtros = {
        Show: function ()
        {
            $('#filtros').show();
            PageCore.ShowLightBox($('#filtros'));
        },
        Close: function ()
        {
            $('#filtros').hide();
            PageCore.CloseLightBox();
        },
        Filter: function ()
        {
            var filtroAplicado = "";
            if (PageCore.IsEmpty($('#filtroNombre').val()) && $('#filtroSeccion').val() == "-1" && $('#filtroCategoria').val() == "-1")
            {
                alert("No ha introducido ningun filtro para los datos.");
                return false;
            }
            if (!PageCore.IsEmpty($('#filtroNombre').val()))
                filtroAplicado = 'Nombre [' + $('#filtroNombre').val() + ']';
            if ($('#filtroSeccion').val() != "-1")
                filtroAplicado += ' Seccion [' + $("#filtroSeccion option:selected").text() + ']';
            if ($('#filtroCategoria').val() != "-1")
                filtroAplicado += ' Categoria [' + $("#filtroCategoria option:selected").text() + ']';
            window.location = '<%=Url.Action("ListFiltered","Documento") %>?page=1&perpage=20&filtro=' + filtroAplicado + '&nombre=' + $('#filtroNombre').val() + '&seccion=' + $('#filtroSeccion').val() + '&categoria=' + $('#filtroCategoria').val();
        }
    };
</script>
<script type="text/javascript">
    function SetPage(p)
    {
        window.location = '<%=Url.Action("List","Documento") %>?page=' + p + '&perpage=<%=ViewData["Paginator_PerPage"] %>';
    }
    function ChangeMaxPageRows(r)
    {
        window.location = '<%=Url.Action("List","Documento") %>?page=1&perpage=' + r;
    }
</script>
</asp:Content>
