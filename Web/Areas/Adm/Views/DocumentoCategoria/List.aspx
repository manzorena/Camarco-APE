<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.DocumentoCategoria>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
		<ul class="navigation-secondary">
        	<li class="ns-last"><a style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);" onclick="Categoria.Show(0,0)" href="#">Nueva categor&iacute;a</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/page_white.png);">CATEGORIAS DE DOCUMENTOS</h1>
        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); display:none;" id="categoriaEliminadaDiv">Categor&iacute;a <label id="categoriaEliminadaDivNombre"> </label> eliminada</div>
		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);" id="registrosTotal"></div>
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
                        <th width="600"><a>Nombre</a></th>
			 			<th width="50">Acciones</th>
			        </tr>
                    </thead>
                    <tbody data-bind="foreach: categorias">
                        <tr data-bind="attr:{id: 'row'+id}" style="background-image:none"><td><label data-bind="text:nombre"></label></td>
                        <td class="table-actions"><a title="EDITAR" href="#" data-bind="click:function(){Categoria.Show(id, nombre,parentid)}"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a data-bind="click:function(){Eliminar(id,nombre)}" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                        </td></tr>
                    </tbody>
              </table>
        </div>
        <div class="tools-bot"></div>
	</div>
</div>

<div class="overlay o-filtros" id="categoria" style="display:none;position:absolute;z-index:3;top:20%;left:50%;width:50%;margin-left:-17%;"  >
	<div class="overlay-tools">
  		<h3>Categor&iacute;a de Documento</h3>
        <a onclick="Categoria.Close()" class="btn btn-red">Cancelar</a>
  		<a href="javascript:void(0);" class="btn btn-green btn-img floatright" onclick="Categoria.Confirm();" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Confirmar</a><div class="clearing"></div>
  		
    </div>
    <div class="overlay-content">
    	<fieldset class="styled-fieldset">
        	<ul>
				<li>
                  <label>Nombre</label><input type="text" class="sti-l" id="categoriaNombre" value="" /></li>
                <li>
                    <input type="checkbox" id="categoriasub" onclick="Categoria.Toggle()" />&nbsp;<label for="categoriasub" style="display:inline">Es subcategor&iacute;a?</label>
                </li>
                <li id="categoriaselectorsub">
                    <label>De la Categor&iacute;a&nbsp;</label><select id="categoriapadre" size="1" data-bind="foreach: categorias" style="width:90%" class="styled-select">
                        <option data-bind="visible:!parent,value:id, text:nombre"></option>
						</select>
                </li>
           </ul></fieldset>
    </div>
   
</div>

<div class="overlay o-filtros" id="unificar" style="display:none;position:absolute;z-index:3;top:20%;left:50%;width:50%;margin-left:-17%;"  >
	<div class="overlay-tools">
  		<h3>Unificar Categor&iacute;as</h3>
        <a onclick="Unificar.Close()" class="btn btn-red">Cancelar</a>
  		<a href="javascript:void(0);" class="btn btn-green btn-img floatright" onclick="Unificar.Confirm();" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Confirmar</a><div class="clearing"></div>
  		
    </div>
    <div class="overlay-content">
    	<fieldset class="styled-fieldset">
        	<ul>
				<li >
                    <label>Pasar todos los Documentos a la categor&iacute;a</label>
                        <select id="categoriaunificar" size="1" data-bind="foreach: categorias" style="width:90%" class="styled-select">
                        <option data-bind="value:id, text:nombre"></option>
						</select>
                </li>
           </ul></fieldset>
    </div>
   
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/pagination.js"></script>
<script type="text/javascript">
    var globalPagination = null;
    var ViewModel = function(){
	var self = this;
	self.categorias = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Shared/CategoriasJSON.ascx"); %>]);
    self.categoria_add = function(id,nombre,parent,parentid){
        self.categorias.push({id:Number(id), nombre:nombre,parent:parent,parentid:parentid});
        
    };
    self.categoria_remove = function(i){
        self.categorias.remove(function(item) { return item.id == i });
        var match = ko.utils.arrayFilter(self.categorias(), function(item) {
            return item.parentid == i;
        });
        for(var j=0;i<match.length;j++)
        {
        match[j].parent=false;
        match[j].parentid=0;
        }
    };
    self.categoria_update = function(id,nombre,parent,parentid){
        var match = ko.utils.arrayFirst(self.categorias(), function(item) {
            return item.id == id;
        });
        match.nombre=nombre;
        match.parent=parent;
        match.parentid=parentid;
        $('#row'+id).find('span').text(nombre);
        
    };
    };

    $(document).ready(function () {
        baseKOobj = new ViewModel();
        ko.applyBindings(baseKOobj);
        globalPagination = new Pagination($('.table-m > tbody'), 20, $('.tools-bot'), 'globalPagination', { column: 0, box: $('#formSearchText') });
        globalPagination.Redraw();


    });

    function Eliminar(id,n) {
        var del = function(ids){
            if (!confirm("Esta seguro que desea eliminar la Categoria?")) {
                return false;
            }
            $('#ajaxLoading').show();

            PageCore.AjaxPost('<%=Url.Action("Delete","DocumentoCategoria") %>?id=' + ids, '', function (obj) {
                $('#ajaxLoading').hide();
                if (obj.status == "error") {
                    alert(Utils.GetErrors(obj));
                    return;
                }
                $('#row' + ids).remove();
                $('#categoriaEliminadaDivNombre').text(n);
                $('#categoriaEliminadaDiv').show();
                
                setTimeout(function(){$('#categoriaEliminadaDiv').hide();}, 5000);
                baseKOobj.categoria_remove(ids);
                globalPagination.Redraw();
            });
        };

        PageCore.AjaxPost('<%=Url.Action("TieneDocumentos","DocumentoCategoria") %>?id=' + id, '', function (obj) {
            if (obj.status == "error") {
                alert(Utils.GetErrors(obj));
                return;
            }
            var go=true;
            if(obj.tiene=="1"){
                if(confirm("La Categoria tiene Documentos asociados, quiere migrarlos a otra?"))go=false;
            }
            if(go)
                del(id);
            else
                Unificar.Show(id, n, function(){del(id)});
        });

        
    }
    var Unificar = {
        id:null,
        nombre:null,
        handler:null,
        Show:function(i,n,h){
        this.id=i;
        this.nombre=n;
        this.handler=h;
            $('#categoriaunificar').val('');
            $("#unificar").show();
            PageCore.ShowLightBox($("#unificar"));
        },
        Close: function () {
            $("#unificar").hide();
            PageCore.CloseLightBox();
        },
        Confirm:function(){
             if (PageCore.IsEmpty($('#categoriaunificar').val())) {
                alert("Debe seleccionar la Categoria destino de los Documentos.");
                $('#categoriaunificar').focus();
                return false;
            }
            if (this.id == $('#categoriaunificar').val()) {
                alert("La Categoria de destino es la misma que la de origen.");
                $('#categoriaunificar').focus();
                return false;
            }
            if(!confirm("Se migraran todos los documentos asociados a la Categoria "+this.nombre+" a la Categoria "+$("#categoriaunificar option:selected").text()+", esta seguro?"))return false;
            $('#ajaxLoading').show();
            var self = this;
            PageCore.AjaxPost('<%=Url.Action("Unificar","DocumentoCategoria")%>', $.toJSON({ id: this.id, target: Number($('#categoriaunificar').val()) }), function (obj) {
                $('#ajaxLoading').hide();
                if (obj.status == "error") {
                    alert(Utils.GetErrors(obj));
                    return;
                }
                self.Close();
                if(self.handler!=null)self.handler();
            });
        }
    }
    var Categoria = {
        id: null,
        Show: function (i,n,p) {
            this.id = i;
            if(i>0){
                $('#categoriaNombre').val(n);
                $("#categoriasub").attr("checked", p>0);
                this.Toggle();
                $('#categoriapadre').val(p);
            }
            else{
                $('#categoriaNombre').val('');
            $("#categoriasub").attr("checked", false);
            $("#categoriaselectorsub").hide();
            $('#categoriapadre').val("");
            }
            $("#categoria").show();
            PageCore.ShowLightBox($("#categoria"));
        },
        Close: function () {
            $("#categoria").hide();
            PageCore.CloseLightBox();
        },
        Toggle: function () {

            if ($("#categoriasub").prop("checked"))
                $("#categoriaselectorsub").show();
            else
                $("#categoriaselectorsub").hide();
        },
        Confirm: function () {
            if (PageCore.IsEmpty($('#categoriaNombre').val())) {
                alert("Debe ingresar el nombre.");
                $('#categoriaNombre').focus();
                return false;
            }
            if ($("#categoriasub").prop("checked") && PageCore.IsEmpty($('#categoriapadre').val())) {
                alert("Debe seleccionar la Categoria de la cual depende.");
                $('#categoriapadre').focus();
                return false;
            }
            var self = this;
            $('#ajaxLoading').show();
            PageCore.AjaxPost('<%=Url.Action("Save","DocumentoCategoria")%>', $.toJSON({ id: self.id, nombre: $('#categoriaNombre').val(), parent: (!$("#categoriasub").prop("checked") ? "0" : $('#categoriapadre').val()) }), function (obj) {
                $('#ajaxLoading').hide();
                if (obj.status == "error") {
                    alert(Utils.GetErrors(obj));
                    return;
                }
                self.Close();
                if(self.id==0)
                    baseKOobj.categoria_add(obj.id, $('#categoriaNombre').val(), $("#categoriasub").prop("checked"),($("#categoriasub").prop("checked")?$('#categoriapadre').val():0));
                else
                    baseKOobj.categoria_update(obj.id, $('#categoriaNombre').val(), $("#categoriasub").prop("checked"),($("#categoriasub").prop("checked")?$('#categoriapadre').val():0));
                
                globalPagination.Redraw();
            });
        }
    };
</script>
</asp:Content>
