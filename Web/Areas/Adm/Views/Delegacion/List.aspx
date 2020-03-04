<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Delegacion>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
		<ul class="navigation-secondary">
        	<li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" href="<%=Url.Action("Nueva","Delegacion") %>" >Nueva delegaci&oacute;n</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/page_white.png);">DELEGACIONES</h1>
		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);" id="registrosTotal"></div>
        	<div class="tools-top">
				<ul class="ul-floatleft">
               	  </ul>
                 <ul class="ul-floatright">
                    <li title="Filtrar por Provincia"><input id="formSearchText" type="text" class="styled-input-search"/></li><li><a onclick="globalPagination.Redraw();" class="form-filter"  style="cursor:pointer" title="BUSCAR"></a></li><li><a onclick="$('#formSearchText').val('');globalPagination.Redraw();" class="form-filter-clear"  style="cursor:pointer" title="LIMPIAR FILTRO"></a></li>
                </ul>

        </div>
        <div class="minicontainer-sub-m">
       	   	<table border="0" cellpadding="0" cellspacing="0" class="table-m">
                <thead>
                	<tr>
                        <th width="200"><a>Nombre</a></th>
			 			<th width="200"><a>Provincia</a></th>
			 			<th width="200"><a>Domicilio</a></th>
			 			<th width="50">Acciones</th>
			        </tr>
                    </thead>
                    <tbody>
                    <% 
                        foreach (Camarco.Model.Delegacion s in ViewData.Model)
                        {
                            %><tr id="row<%=s.DelegacionID %>"><td><%=Html.Encode(s.Nombre) %></td><td><%=s.Provincia.Nombre %></td><td><%=Html.Encode(s.Domicilio) %></td>
                            <td class="table-actions"><a href="<%=Url.Action("Editar","Delegacion", new {id=s.DelegacionID}) %>" title="EDITAR"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a onclick="Eliminar(<%=s.DelegacionID %>)" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                            </td>
                            </tr><%
                        }
                    %>
                    </tbody>
              </table>
        </div>
        <div class="tools-bot"></div>
	</div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/pagination.js"></script>
<script type="text/javascript">
    var globalPagination = null;
    $(document).ready(function ()
    {
        globalPagination = new Pagination($('.table-m > tbody'), 20, $('.tools-bot'), 'globalPagination', { column: 0, box: $('#formSearchText') });
        globalPagination.Redraw();


    });

    function Eliminar(ids, ask)
    {
        if (!confirm("Esta seguro que desea eliminar la Delegacion?"))
        {
            return false;
        }
        $('#ajaxLoading').show();

        PageCore.AjaxPost('<%=Url.Action("Delete","Delegacion") %>?id=' + ids, '', function (obj)
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

</script>
</asp:Content>
