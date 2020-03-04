<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Documento>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
        <ul class="navigation-secondary">
        	<li><a href="<%=Url.Action("List","Documento") %>" style="background-image:url(/Content/CSS/Back/icons/page_white.png);">Listado</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<form data-bind="submit:save" id="theForm">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/tag_blue_add.png);">
		<%
		if(ViewData.Model.DocumentoID==0){
			%>Nuevo<%
		}else{
			%>Editar<%
		}
		%> Documento</h1>
        <div style="position:relative;clear:both;">
		<ul class="tabs">
			<li class="tab-active" data-key="divTab1">General</li>
			<li data-key="divTab2">Secciones</li>
            <li data-key="divTab3">Categor&iacute;as</li>
		</ul>
		</div>
		<div class="minicontainer-sub-m" id="divTab1">
        	<div class="minicontainer-sub-s mcss-left">
        		<fieldset class="styled-fieldset">
                	<ul>
                		<li><label>T&iacute;tulo *</label><input type="text" class="sti-l" data-bind="value:titulo" id="txtTitulo" maxlength="300"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtTitulo">Error: Por favor especifique el t&icute;tulo.</span>
                		</li>
                        <li><label>Tem&aacute;ticas</label><input type="text" class="sti-l" data-bind="value:tags" id="txtTematica"/>
                		<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:285px;margin-top:3px;">Ingrese la lista de palabras separadas por coma</div>
                		</li>
                        <li><input type="checkbox" data-bind="checked: privado" id="checkPrivado"/>&nbsp;<label for="checkPrivado" style="display:inline">Privado (s&oacute;lo para usuarios)</label>
                		</li>
						<li style="padding-top:20px"><label>Descripci&oacute;n *</label>
                        <textarea id="txtDescripcion"></textarea>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtDescripcion">Error: Por favor especifique la descripci&oacute;n.</span>
                		</li>
                		<li><label>Fecha *</label><input data-bind="value:fechaModif" id="datetimepicker" type="text" />
                        </li> 
                    </ul>
                    
                </fieldset>
        	</div>
            <div class="minicontainer-sub-s">
         	<fieldset class="styled-fieldset">
            <ul>
                 <li>
                    <fieldset  class="styled-fieldset styled-fieldset-border"  >
                    <legend>Contenido</legend>

                    &nbsp;<input type="radio" name="radioContenido" id="radioContenidoURL" value="0" data-bind="checked:contenido"/><label style="display:inline" for="radioContenidoURL">Ubicado en una URL externa</label><br />
                    <div data-bind="visible:contenido()==0">
                        <label>URL</label><input type="url" class="sti-l" data-bind="value:url" /> 
                    </div><br />
                    &nbsp;<input type="radio" name="radioContenido" id="radioContenidoArchivo" value="1" data-bind="checked:contenido"/><label style="display:inline" for="radioContenidoArchivo">Archivo Local</label><br />
                    <div data-bind="visible:contenido()==1">
                        <div id="fine-uploader-basic" style="margin-left:10px">
						<span id="btnCargando" class="btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);">Seleccionar documento</span>
						
                        <span  class="loadpic" id="fine-uploader-basic-loaded" data-bind="visible:hasfile"><img alt="Documento cargado" src="/Content/CSS/Back/icons/accept.png" width="16" height="16" class="loadpic-img" /><span id="documentoCargado"><%=(ViewData.Model.DocumentoID>0?(new Camarco.Model.File(ViewData.Model.FileID)).Filename:"") %></span></span>
						</div>
                    </div>
                    </fieldset>
                	</li>
            </ul>
            </fieldset>
            </div>
	</div>
        <div class="minicontainer-sub-m" id="divTab2" style="display:none">
            <div style="float:left;vertical-align:top;width:300px;">
        		<fieldset class="styled-fieldset styled-fieldset-border">
        			<ul>
        				<li><label>Secci&oacute;n</label>
                		<select id="selectSeccion" size="1" data-bind="foreach: secciones" style="width:90%" class="styled-select">
                        <option data-bind="value:id, text:nombre"></option>
						</select>
                		</li>
        			</ul>
        			<div class="tools-bot" style="width:95%">
        				<ul class="ul-floatright">
					    	<li><a data-bind="click:seccion_add" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Agregar</a></li>
				        </ul>
					</div>
        		</fieldset>
        		</div>
        		<div style="float:left;margin-left:5px;vertical-align:top;width:600px;">
        		<fieldset class="styled-fieldset styled-fieldset-border"><legend>Secciones asociadas</legend>
        		<table border="0" cellpadding="0" cellspacing="0" class="table-m" style="width:100%">
        			<tr>
        				<th width="350">Nombre</th>
        			</tr>
					<tbody data-bind="foreach:seccionesasociadas">
						<tr>
							<td ><a href="#" data-bind="click: $parent.seccion_remove"><img width="16" height="16" src="/Content/CSS/Back/icons/cross.png" alt="Eliminar Categoria"/></a>&nbsp;<span data-bind="text:nombre"></span></td>
						</tr>
					</tbody>        				
        		</table>
        		</fieldset>
        		</div>
        		<div style="width:100%;clear:both;">&nbsp;</div>
        </div>
	    <div class="minicontainer-sub-m" id="divTab3" style="display:none">
            		<div style="float:left;vertical-align:top;width:300px;">
        			<fieldset class="styled-fieldset styled-fieldset-border">
        				<ul>
        					<li><label>Categor&iacute;a</label>
                		    <select id="selectCategoria" size="1" data-bind="foreach: categorias" style="width:90%" class="styled-select">
                            <option data-bind="value:id, text:nombre"></option>
						    </select><br /><br /><a data-bind="click:categoria_new" href="#" class="btn btn-blue btn-img" style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);">Nueva Categor&iacute;a</a>
                		    </li>
        				</ul>
        				<div class="tools-bot" style="width:95%">
        					<ul class="ul-floatright">
					    		<li><a data-bind="click:clasificacion_add" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Agregar</a></li>
				        	</ul>
						</div>
        			</fieldset>
        			</div>
        			<div style="float:left;margin-left:5px;vertical-align:top;width:600px;">
        			<fieldset class="styled-fieldset styled-fieldset-border"><legend>Categor&iacute;as asociadas</legend>
        			<table border="0" cellpadding="0" cellspacing="0" class="table-m" style="width:100%">
        				<tr>
        					<th width="350">Nombre</th>
        				</tr>
						<tbody data-bind="foreach:clasificacion">
							<tr>
								<td ><a href="#" data-bind="click: $parent.clasificacion_remove"><img width="16" height="16" src="/Content/CSS/Back/icons/cross.png" alt="Eliminar Categoria"/></a>&nbsp;<span data-bind="text:nombre"></span></td>
							</tr>
						</tbody>        				
        			</table>
        			</fieldset>
        			</div>
        			<div style="width:100%;clear:both;">&nbsp;</div>
         	
        </div>
    <div class="tools-bot">
	    	<ul class="ul-floatright">
	        	<li><a id="btnSubmit" onclick="$('#theForm').submit();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Guardar</a></li>
        		<li><a onclick="PageCore.Ir('<%=Url.Action("List","Documento")%>');" class="btn btn-red btn-img" style="background-image:url(/Content/CSS/Back/icons/delete.png);">Cancelar</a></li>
            </ul>
		</div>
        </div>
    </form>
</div>

<div class="overlay o-filtros" id="categoria" style="display:none;position:absolute;z-index:3;top:20%;left:50%;width:50%;margin-left:-17%;"  >
	<div class="overlay-tools">
  		<h3>Ingrese el nombre de la nueva Categor&iacute;a</h3>
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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/jquery.fineuploader-3.0.min.js"></script>
<script type="text/javascript" src="/Scripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
 tinyMCE.init({
       mode: "textareas",
        theme: "advanced",
        plugins: "preview,paste,fullscreen,visualchars,nonbreaking,autolink",
        paste_text_sticky: true,
        setup: function (ed)
        {
            ed.onInit.add(function (ed)
            {
                ed.pasteAsPlainText = true;
            });
        },
        // Theme options
        theme_advanced_buttons1: "bold,italic,underline",
        theme_advanced_buttons2: "",
        theme_advanced_buttons3: "",
        theme_advanced_buttons4: "",
        theme_advanced_toolbar_location: "top",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "bottom",
        theme_advanced_resizing: false,
        theme_advanced_path: false,
        width: "400px",
        convert_newlines_to_brs: true,
        force_br_newlines: true,
        force_p_newlines: false,
        oninit: function () { LoadTextAreas(); },
        forced_root_block: ''
    });
</script>
<script type="text/javascript">
var GlobalToken = null;
var ViewModel = function(){
	var self = this;
	self.id = <%=ViewData.Model.DocumentoID%>;
	self.titulo = ko.observable('<%=ViewData.Model.Titulo%>');
    self.fechaModif = ko.observable('<%=ViewData.Model.FechaModificacion.ToString("dd/MM/yyyy")%>');
    self.tags = ko.observable('<%=ViewData.Model.Resource.Tags%>');
	self.privado = ko.observable(<%=(!ViewData.Model.Publico).ToString().ToLower()%>);
    self.contenido = ko.observable('<%=(ViewData.Model.FileID==0?"0":"1")%>');
    self.url=ko.observable('<%=(ViewData.Model.FileID==0?ViewData.Model.Resource.URL:"")%>');
    self.descripcion="";
    self.token = "";
    self.filename='';
    self.hasfile = ko.observable(<%=(ViewData.Model.FileID>0).ToString().ToLower()%>);
    self.categorias = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Shared/CategoriasJSON.ascx"); %>]);
    self.clasificacion=ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Documento/CategoriasJSON.ascx", ViewData.Model.Categorias); %>]);
    self.seccionesasociadas=ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Documento/SeccionesJSON.ascx", ViewData.Model.Resource.Secciones); %>]);
    self.secciones =ko.observableArray( [<% Html.RenderPartial("~/Areas/Adm/Views/Shared/SeccionesJSON.ascx",1); %>]);
	self.save = function(){
		PageCore.HideErrorMessages();
		if(!PageCore.TestErrorMessages()){
			return false;
		}
        if(self.contenido()==1 && !self.hasfile()){
            alert("Ha elegido que el Contenido sea un archivo local pero no hay subido ninguno.");
            return false;
        }
        if(self.contenido()==0 && PageCore.IsEmpty(self.url())){
            alert("Ha elegido que el Contenido sea externo pero no hay ingresado la URL.");
            return false;
        }
        self.token = GlobalToken;
        self.descripcion = tinyMCE.get("txtDescripcion").getContent().replace(/[\n\r]/g, '');
		$('#btnSubmit').toggleClass('btn-waiting'); 
		PageCore.AjaxPost('<%=Url.Action("Save","Documento")%>',ko.toJSON(self), function(obj){
			$('#btnSubmit').toggleClass('btn-waiting'); 
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			window.history.go(-1);
		});
	};
    self.categoria_new = function(){
        Categoria.Show();
    };
    self.categoria_add = function(id,nombre,parent){
        self.categorias.push({id:Number(id), nombre:nombre,parent:parent});
        
    };
    self.clasificacion_add = function(){
        if($('#selectCategoria').val().length==0){
            alert("Debe seleccionar la Categoria");
            $('#selectCategoria').focus();
            return false;
        }
        var ing =  ko.utils.arrayFirst(self.clasificacion(), function(item) {
            return item.id==$('#selectCategoria').val();
        });
        if(ing!=null){
        	alert("El documento ya esta asociado a la Categoria.");
        	return false;
        }
        self.clasificacion.push({id:Number($('#selectCategoria').val()), nombre:$("#selectCategoria option:selected").text()});
        $('#selectCategoria').val('');
    };
    self.clasificacion_remove = function(){self.clasificacion.remove(this);}
    self.seccion_add = function(){
        if($('#selectSeccion').val().length==0){
            alert("Debe seleccionar la Seccion");
            $('#selectSeccion').focus();
            return false;
        }
        var ing =  ko.utils.arrayFirst(self.seccionesasociadas(), function(item) {
            return item.id==$('#selectSeccion').val();
        });
        if(ing!=null){
        	alert("El documento ya esta asociado a la Seccion.");
        	return false;
        }
        self.seccionesasociadas.push({id:Number($('#selectSeccion').val()), nombre:$("#selectSeccion option:selected").text()});
        $('#selectSeccion').val('');
    };
    self.seccion_remove = function(){self.seccionesasociadas.remove(this);}
};
var baseKOobj=null;
 var uploadingFiles=0;
$(document).ready(function(){
    PageCore.ActivateTabs();
	baseKOobj=new ViewModel();
	ko.applyBindings(baseKOobj);
    GlobalToken = PageCore.GetRandomToken();
    $fub = $('#fine-uploader-basic');
	 
	var uploader = new qq.FineUploaderBasic({
		button: $fub.find("span")[0],
        multiple:false,
		request: {
        forceMultipart:true,
		endpoint: '/File/Upload?token='+GlobalToken
		},
		
		callbacks: {
		 onSubmit: function(id, fileName) {
            /*var ext = PageCore.GetFileExtension(fileName).toLowerCase();
			if(ext!="jpg" && ext!="png"){
				alert("Solo se permiten extensiones JPG y PNG");
				return false;
			}*/
            ;
		},
		onUpload: function(id, fileName) {
		$('#btnCargando').toggleClass('btn-waiting');
		},
		onComplete: function(id, fileName, responseJSON) {
		$('#btnCargando').toggleClass('btn-waiting');
		if (responseJSON.success) {
		    baseKOobj.hasfile(true);
            baseKOobj.filename=fileName;
            $('#documentoCargado').text(fileName);
		} else {
		alert("Ha ocurrido un error al intentar enviar el archivo, intente seleccionandolo nuevamente por favor.");
		}}
		},
		debug: false
	});
});


$(window).unload(function() {
  PageCore.AjaxPost('/File/Cleanup?token='+GlobalToken,'', function(){});
  
});
function LoadTextAreas(){tinyMCE.get("txtDescripcion").setContent('<%=ViewData.Model.Descripcion.Replace("\n","<br />") %>');}
var Categoria = {
    Show:function(){
        $('#categoriaNombre').val('');
        $("#categoriasub").attr("checked",false);
        $("#categoriaselectorsub").hide();
        $('#categoriapadre').val("");
        $("#categoria").show();
        PageCore.ShowLightBox($("#categoria"));
    },
    Close:function(){
        $("#categoria").hide();
        PageCore.CloseLightBox();
    },
    Toggle:function(){
        
        if($("#categoriasub").prop("checked"))
            $("#categoriaselectorsub").show();
        else
            $("#categoriaselectorsub").hide();
    },
    Confirm:function(){
        if(PageCore.IsEmpty($('#categoriaNombre').val())){
            alert("Debe ingresar el nombre.");
            $('#categoriaNombre').focus();
            return false;
        }   
        if($("#categoriasub").prop("checked") && PageCore.IsEmpty($('#categoriapadre').val())){
            alert("Debe seleccionar la Categoria de la cual depende.");
            $('#categoriapadre').focus();
            return false;
        }  
        var self = this;
        $('#ajaxLoading').show();
        PageCore.AjaxPost('<%=Url.Action("SaveCategoria","Documento")%>',$.toJSON({nombre:$('#categoriaNombre').val(), parent:(!$("#categoriasub").prop("checked")?"0":$('#categoriapadre').val())}), function(obj){
			$('#ajaxLoading').hide();
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			self.Close();
            baseKOobj.categoria_add(obj.id, $('#categoriaNombre').val(),$("#categoriasub").prop("checked"));

		});
    }
};
</script>
<link rel="stylesheet" type="text/css" href="../../../../Content/CSS/Back/jquery.datetimepicker.css"/ >
<script src="../../../../Scripts/datetimepicker-master/jquery.js"></script>
<script src="../../../../Scripts/datetimepicker-master/jquery.datetimepicker.js"></script>
<script type="text/javascript">
    window.onload = function () { jQuery('#datetimepicker').datetimepicker({format:'d/m/Y',timepicker:false}) };
</script>
</asp:Content>