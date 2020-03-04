<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
		<ul class="navigation-secondary">
        	<li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" href="<%=Url.Action("Nuevo","Articulo") %>" >Nueva noticia / artículo</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/page_white.png);">NOTICIAS / ARTICULOS</h1>
        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);">Resultados para filtros de b&uacute;squeda aplicados. <a href="<%=Url.Action("List","Articulo") %>" style="cursor:pointer;text-decoration:underline;">Mostrar todas las noticias</a>.</div>
		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);"><strong>Total:</strong> <%=ViewData["Paginator_Total"]%>. Mostrando <%=((List<Camarco.Model.Articulo>)ViewData["Items"]).Count%></div>
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
			 			<th width="200"><a>T&iacute;tulo</a></th>
			 			<th width="200"><a>Subtitulo</a></th>
                        <th width="100"><a>Publicado</a></th>
			 			<th width="50">Acciones</th>
			        </tr>
                    <% 
                        foreach (Camarco.Model.Articulo d in (List<Camarco.Model.Articulo>)ViewData["Items"])
                        {
                            %><tr id="row<%=d.ArticuloID %>"><td><%=Html.Encode(d.Titulo) %></td><td><%=Html.Encode(d.Subtitulo) %></td><td><%=d.FechaPublicacion.ToString("dd/MM/yyyy") %></td>
                            <td class="table-actions"><a href="<%=Url.Action("Editar","Articulo", new {id=d.ArticuloID}) %>" title="EDITAR"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a onclick="Eliminar(<%=d.ArticuloID%>)" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a></td>
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
                  <label>Nombre</label><input type="text" class="sti-l" id="filtroNombre" value="<%=ViewData["Filter_Nombre"] %>" /></li>
                <li>
                  <label>Secci&oacute;n</label>
                  <select class="styled-select" id="filtroSeccion" size="1" ><option value="-1" selected="selected">Todos</option><% Html.RenderPartial("~/Areas/Adm/Views/Shared/SeccionesSELECT.ascx"); %></select></li>
                </ul></fieldset>
    </div>
   
</div>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    $(document).ready(function ()
    {
         $('#filtroSeccion').val(<%=ViewData["Filter_Seccion"] %>);
    });
    function Eliminar(ids, ask)
    {
        if (!confirm("Esta seguro que desea eliminar el Articulo?"))
        {
            return false;
        }
        $('#ajaxLoading').show();

        PageCore.AjaxPost('<%=Url.Action("Delete","Articulo") %>?id=' + ids, '', function (obj)
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
            if (PageCore.IsEmpty($('#filtroNombre').val()) && $('#filtroSeccion').val() == "-1")
            {
                alert("No ha introducido ningun filtro para los datos.");
                return false;
            }
            window.location = '<%=Url.Action("ListFiltered","Articulo") %>?page=1&perpage=20&nombre=' + $('#filtroNombre').val() + '&seccion=' + $('#filtroSeccion').val();
        }
    };
</script>
<script type="text/javascript">
    function SetPage(p)
    {
        window.location = '<%=Url.Action("ListFiltered","Articulo") %>?nombre=<%=ViewData["Filter_Nombre"] %>&seccion=<%=ViewData["Filter_Seccion"] %>&page=' + p + '&perpage=<%=ViewData["Paginator_PerPage"] %>'
    }
    function ChangeMaxPageRows(r)
    {
        window.location = '<%=Url.Action("ListFiltered","Articulo") %>?nombre=<%=ViewData["Filter_Nombre"] %>&seccion=<%=ViewData["Filter_Seccion"] %>&page=1&perpage=' + r;
    }
</script>
</asp:Content>
