<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Articulo>" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript" src="/Scripts/jquery.fineuploader-3.0.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery-ui-1.9.1.custom.min.js"></script>
<script type="text/javascript" src="/Scripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
    tinyMCE.init({
        mode: "textareas",
        theme: "advanced",
        plugins: "preview,paste,fullscreen,visualchars,nonbreaking,autolink",
        paste_text_sticky: true,
        setup: function (ed) {
            ed.onInit.add(function (ed) {
                ed.pasteAsPlainText = true;
            });
        },
        // Theme options
        theme_advanced_buttons1: "bold,italic,underline, formatselect,link ",
        theme_advanced_buttons2: "",
        theme_advanced_blockformats: "p,h2,h3",
        theme_advanced_toolbar_location: "top",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "bottom",
        theme_advanced_resizing: false,
        theme_advanced_path: false,
        width: "900px",
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
	self.id = <%=ViewData.Model.ArticuloID%>;
	self.titulo = ko.observable('<%=ViewData.Model.Titulo%>');
    self.subtitulo = ko.observable('<%=ViewData.Model.Subtitulo%>');
    self.video = ko.observable('<%=ViewData.Model.VideoURL%>');
    self.fechaHora = ko.observable('<%=ViewData.Model.FechaHora%>');
    self.fechaPub = ko.observable('<%=ViewData.Model.FechaPublicacion.ToString("dd/MM/yyyy")%>');
    self.tags = ko.observable('<%=ViewData.Model.Resource.Tags%>');
    self.destacado = ko.observable(<%=ViewData.Model.Destacado.ToString().ToLower()%>);
    self.evento = ko.observable(<%=ViewData.Model.Evento.ToString().ToLower()%>);
	self.descripcion="";
    self.descripcionlarga="";
    self.token = "";
    self.seccionesasociadas=ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Articulo/SeccionesJSON.ascx", ViewData.Model.Resource.Secciones); %>]);
    self.secciones =ko.observableArray( [<% Html.RenderPartial("~/Areas/Adm/Views/Shared/SeccionesJSON.ascx", 2); %>]);
    self.images = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Articulo/ImagenesJSON.ascx", ViewData.Model.Imagenes); %>]);
    self.archivos = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Articulo/ArchivosJSON.ascx", ViewData.Model.Archivos); %>]);
	self.save = function(){
		PageCore.HideErrorMessages();
		if(!PageCore.TestErrorMessages()){
			return false;
		}
        if(uploadingFiles>0){
            alert("Hay imagenes siendo subidas al servidor, espere a que la transmision finalice");
            return false;
        }
        if(uploadingFilesFile>0){
            alert("Hay archivos siendo subidos al servidor, espere a que la transmision finalice");
            return false;
        }
        if(self.video().length>0 && self.images().length>0){
            if(confirm("Ha cargado Imagenes y Videos, este template no es compatible para presentar ambos en simultaneo. Si desea elegir el video, presiona aceptar. Si desea elegir la imagen, presione cancelar, y el sistema presentara solo la imagen")){
                var arrO = new Array();
                ko.utils.arrayForEach(self.images(), function(o) {
                    arrO.push(o);
                });
                for(var i=0;i<arrO.length;i++){
                    var o = arrO[i];
                    self.images.remove(o);
                }
            }
            else{
                self.video('');
            }
        }
        self.token = GlobalToken;
        self.descripcion = tinyMCE.get("txtDescripcion").getContent().replace(/[\n\r]/g, '');
        self.descripcionlarga = tinyMCE.get("txtDescripcionLarga").getContent().replace(/[\n\r]/g, '');
		$('#btnSubmit').toggleClass('btn-waiting'); 
		PageCore.AjaxPost('<%=Url.Action("Save","Articulo")%>',ko.toJSON(self), function(obj){
			$('#btnSubmit').toggleClass('btn-waiting'); 
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			PageCore.Ir('<%=Url.Action("List","Articulo")%>');
		});
	};
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
        	alert("El articulo ya esta asociado a la Seccion.");
        	return false;
        }
        self.seccionesasociadas.push({id:Number($('#selectSeccion').val()), nombre:$("#selectSeccion option:selected").text()});
        $('#selectSeccion').val('');
    };
    self.seccion_remove = function(){self.seccionesasociadas.remove(this);}
    self.Archivo_Remove = function(){
        if(this.id>0)
		{
			if(!confirm("Esta seguro que desea eliminar el Archivo? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("ArchivoDelete","Articulo")%>?id='+this.id,'', function(obj){$('#ajaxLoading').hide();});
		}
		self.archivos.remove(this);
    }
    self.Imagen_Remove = function(){
        if(this.id>0)
		{
			if(!confirm("Esta seguro que desea eliminar la Imagen? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("ImagenDelete","Articulo")%>?id='+this.id,'', function(obj){$('#ajaxLoading').hide();});
		}
		self.images.remove(this);
		self.Imagen_EliminarIndex(this.orden);
    }
    self.Imagen_Reordenar = function(o){
		var imagen=null;
		for(var i=0;i<self.images().length;i++){
			if(self.images()[i].orden == o.desde){
				imagen=self.images()[i];
		
        		continue;
			}
			
			if(o.desde < o.hasta){
				if(self.images()[i].orden>=o.desde && self.images()[i].orden<=o.hasta)
					self.images()[i].orden = self.images()[i].orden-1;
			}else{
				if(self.images()[i].orden>=o.hasta && self.images()[i].orden<=o.desde)
					self.images()[i].orden = self.images()[i].orden+1;
			}
		}
		if(imagen!=null)
		imagen.orden = o.hasta;
	};
	self.Imagen_EliminarIndex = function(i){
		var imagen=null;
		for(var i=0;i<self.images().length;i++){
			if(self.images()[i].orden>i)
				self.images()[i].orden = self.images()[i].orden-1;
		}
	};
};
function Image_Upload_Complete (img){
    /*imagesToCrop.push(img);
	if(uploadingFiles==0){
		$('#loadpic_foto').toggleClass('btn-waiting');
        
        Crop.Show(imagesToCrop.pop());
	}*/

    var lastorden=-1;
	for(var i=0;i<baseKOobj.images().length;i++){
		if(baseKOobj.images()[i].orden>lastorden)
			lastorden=baseKOobj.images()[i].orden;
	}
	var ext = PageCore.GetFileExtension(img);
	baseKOobj.images.push({orden:++lastorden,id:0, img:img, ext:ext,thumb:'/Uploads/'+GlobalToken+'/'+img, titulo:img, descripcion:''});
    if(uploadingFiles==0){
        $('#loadpic_foto').toggleClass('btn-waiting');
    }
}
function File_Upload_Complete (img){
	if(uploadingFilesFile==0)
		$('#loadpic_file').toggleClass('btn-waiting');
	var ext = PageCore.GetFileExtension(img);
    
	baseKOobj.archivos.push({id:0, file:img, ext:ext,titulo:img});
	
}
var baseKOobj=null;
var uploadingFiles = 0;var uploadingFilesFile=0;
var sortableUpdate = {desde:null,hasta:null};
$(document).ready(function(){
    PageCore.ActivateTabs();
	baseKOobj=new ViewModel();
	ko.applyBindings(baseKOobj);
    GlobalToken = PageCore.GetRandomToken();
    $( "#pictures" ).sortable({
		 start: function(e, ui) {
			sortableUpdate.desde=ui.item.index();
		},
		update: function(event, ui) {
			sortableUpdate.hasta=ui.item.index();
			baseKOobj.Imagen_Reordenar(sortableUpdate);
		}
	}	);
    $( "#pictures" ).disableSelection();
    $fub = $('#fine-uploader-basic');
	 
	var uploader = new qq.FineUploaderBasic({
		button: $fub.find("span")[0],
		request: {
            forceMultipart:true,
            //endpoint: '/File/Upload?token='+GlobalToken
            endpoint: '/File/UploadImage?width=616&height=227&token='+GlobalToken
		},
		
		callbacks: {
		 onSubmit: function(id, fileName) {
         
			var ext = PageCore.GetFileExtension(fileName).toLowerCase();
			if(ext!="jpg" && ext!="png"){
				alert("Solo se permiten extensiones JPG y PNG");
				return false;
			}

		},
		onUpload: function(id, fileName) {
		$('#loadpic_foto').toggleClass('btn-waiting');
		uploadingFiles++;
		},
		onComplete: function(id, fileName, responseJSON) {
		uploadingFiles--;
		if (responseJSON.success) {
		Image_Upload_Complete(fileName);
		} else {
		alert(responseJSON.error);
		}}
		},
		debug: false
	});
    $fub = $('#fine-uploader-basicfile');
	 
	var uploader = new qq.FineUploaderBasic({
		button: $fub.find("span")[0],
		request: {
            forceMultipart:true,
            endpoint: '/File/Upload?token='+GlobalToken
		},
		
		callbacks: {
		 onSubmit: function(id, fileName) {
         
			var ext = PageCore.GetFileExtension(fileName).toLowerCase();
			if(ext!="doc" && ext!="docx"&& ext!="pdf"&& ext!="xls"&& ext!="xlsx"&& ext!="zip"&& ext!="rar"&& ext!="png"&& ext!="jpg"){
				alert("Solo se permiten extensiones DOC, PDF, XLS, PNG, JPG y ZIP/RAR");
				return false;
			}

		},
		onUpload: function(id, fileName) {
		$('#loadpic_file').toggleClass('btn-waiting');
		uploadingFilesFile++;
		},
		onComplete: function(id, fileName, responseJSON) {
		uploadingFilesFile--;
		if (responseJSON.success) {
		File_Upload_Complete(fileName);
		} else {
		alert(responseJSON.error);
		}}
		},
		debug: false
	});
});


$(window).unload(function() {PageCore.AjaxPost('/File/Cleanup?token='+GlobalToken,'', function(){});});
function LoadTextAreas(){tinyMCE.get("txtDescripcion").setContent('<%=ViewData.Model.DescripcionCorta.Replace("'","\\'") %>');tinyMCE.get("txtDescripcionLarga").setContent('<%=ViewData.Model.DescripcionLarga.Replace("'","\\'") %>');}
var imagesToCrop=new Array();
var Crop = {
    currentImage:null,
    Show:function(img){
        if(img==null){
            this.Cancel();
            return;
        }
        this.currentImage=img;
        $('#divImageEdit>iframe').attr("src","/File/ImageCrop?token="+GlobalToken+"&image="+img+"&width=616&height=227&hudheight=338&hudwidth=506");
	    $('#divImageEdit').show();
        PageCore.ShowLightBox($('#divImageEdit'));
    },
    Cancel:function(){
        $('#divImageEdit').hide();
        PageCore.CloseLightBox();
    },
    Confirm:function(){
        var c = {x:$('#divImageEdit>iframe').contents().find('#x').val(),y:$('#divImageEdit>iframe').contents().find('#y').val(),w:$('#divImageEdit>iframe').contents().find('#w').val(),h:$('#divImageEdit>iframe').contents().find('#h').val()}
        if(c.w=="" || c.w==0){
            alert('Debe seleccionar un area para recortar.');
			return false;
        }
        var that=this;
        PageCore.AjaxPost('/File/ImageCrop?token='+GlobalToken+'&image='+this.currentImage+'&x='+Math.round(c.x,0)+'&y='+Math.round(c.y,0)+'&w='+Math.round(c.w,0)+'&h='+Math.round(c.h,0)+'&sw=617&sh=227',{}, function(obj){
            var img = obj.img;
            var lastorden=-1;
	        for(var i=0;i<baseKOobj.images().length;i++){
		        if(baseKOobj.images()[i].orden>lastorden)
			        lastorden=baseKOobj.images()[i].orden;
	        }
	        var ext = PageCore.GetFileExtension(img);
	        baseKOobj.images.push({orden:++lastorden,id:0, img:img, ext:ext,thumb:'/Uploads/'+GlobalToken+'/'+img, titulo:img, descripcion:''});
	        that.Show(imagesToCrop.pop());
        });
        
        
    }
}
</script>
<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
        <ul class="navigation-secondary">
        	<li><a href="<%=Url.Action("List","Articulo") %>" style="background-image:url(/Content/CSS/Back/icons/page_white.png);">Listado</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<form data-bind="submit:save" id="theForm">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/tag_blue_add.png);">
		<%
		if(ViewData.Model.ArticuloID==0){
			%>Nueva<%
		}else{
			%>Editar<%
		}
		%> Noticia / Art&iacute;culo</h1>
        <div style="position:relative;clear:both;">
		<ul class="tabs">
			<li class="tab-active" data-key="divTab1">General</li>
			<li data-key="divTab2">Secciones</li>
            <li data-key="divTab3">Video/Im&aacute;genes</li>
            <li data-key="divTab4">Archivos</li>
		</ul>
		</div>
		<div class="minicontainer-sub-m" id="divTab1">
        	<div class="minicontainer-sub-m" style="width:95%">
        		<fieldset class="styled-fieldset">
                    <div style="position:relative;float:left;">
                        <label>T&iacute;tulo *</label><input type="text" class="sti-l" data-bind="value:titulo" id="txtTitulo" maxlength="200"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtTitulo">Error: Por favor especifique el t&icute;tulo.</span>
                    </div>
                    <div style="position:relative;float:left;margin-left:20px;">
                         <label >Tem&aacute;ticas</label><input type="text" class="sti-l" data-bind="value:tags" id="txtTematica"/>
                        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;margin-top:3px;">Ingrese la lista de palabras separadas por coma</div>
                    </div>
                    <div style="position:relative;float:left;clear:both;margin-top:10px;">
                       <label style="">Subt&iacute;tulo *</label><input style="" type="text" class="sti-l" data-bind="value:subtitulo" id="txtSubTitulo" maxlength="200" value=""/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtSubTitulo">Error: Por favor especifique el subt&icute;tulo.</span>
                    </div>
                    <div style="position:relative;float:left;margin-top:10px;margin-left:20px;">
                        <label >Fecha y Hora (opcional)</label><input type="text" class="sti-l" data-bind="value:fechaHora" />
                		
                    </div>
                    <div style="position:relative;float:left;margin-top:10px;clear:both;">
                        <input type="checkbox" id="checkDestacado" data-bind="checked:destacado"/>&nbsp;<label style="display:inline" for="checkDestacado">Art&iacute;culo destacado</label>
                    </div>
                    <div style="position:relative;float:left;margin-top:10px;clear:both;">
                        <input type="checkbox" id="checkEvento" data-bind="checked:evento"/>&nbsp;<label style="display:inline" for="checkEvento">Evento</label>
                    </div>
                    <div style="position:relative;float:left;clear:both;margin-top:10px;">
                       <label >Fecha de Publicación</label> <input data-bind="value:fechaPub" id="datetimepicker" type="text" />
                		
                    </div>
                   
                    <div style="position:relative;float:left;clear:both;margin-top:20px;">
                        <label style="">Descripci&oacute;n Corta *</label>
                        <textarea style="" id="txtDescripcion" value=""></textarea>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtDescripcion">Error: Por favor especifique la descripci&oacute;n.</span>
                    </div>
                    <div style="position:relative;float:left;clear:both;margin-top:10px;">
                        <label>Descripci&oacute;n Completa *</label>
                        <textarea id="txtDescripcionLarga" style="height:400px"></textarea>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtDescripcionLarga">Error: Por favor especifique la descripci&oacute;n.</span>
                    </div>
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
            <div style="clear:both;width:100%;">
        		<fieldset class="styled-fieldset styled-fieldset-border" style="padding-left:10px;"><legend>Video</legend>
                <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;">Ingrese la URL completa del Video de YouTube.</div>
                <label>URL</label>&nbsp;<input type="text" class="sti-l" data-bind="value:video" style="display:inline"/>
                </fieldset>
            </div>
            <div style="clear:both;width:100%;margin-top:20px;">
        		<fieldset class="styled-fieldset styled-fieldset-border" ><legend>Im&aacute;genes</legend>
                	<ul>
                    	<li>
						<div id="fine-uploader-basic" style="margin-left:10px">
						<span id="loadpic_foto" class="btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/picture.png);">Seleccionar imagen</span>
                        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;margin-top:3px;">La resoluci&oacute;n m&iacute;nima para una correcta visualizaci&oacute;n es de 616px (ancho) x 227px (alto)</div>
						</div>
						</li>
                        <li><fieldset class="sub-fieldset" style="padding-left:10px;">
                       	  <legend>Im&aacute;genes existentes</legend>
						  <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;">La primer foto de la fila, sera siempre la foto representativa en las vistas previas. Desplaze una foto por delante de otra, para cambiar su orden en la fila.</div>
                        	<ul id="pictures" class="prodpic" data-bind="foreach: images" style="padding-left: 60px;">
                        		<li data-bind="attr: { class: $index() % 2 == 0? 'prodpicfirst' : ''}">
                        			<img data-bind="attr: {src: thumb}" />
                                    <ul>
                        				<li>
                        					<a data-bind="click: $parent.Imagen_Remove" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                        				</li>
                        			</ul>
                        		</li>

                           	
                           	</ul>
                        </fieldset></li>
                    </ul>
        		</fieldset>
        		</div>	
        </div>
        <div class="minicontainer-sub-m" id="divTab4" style="display:none">
            <div style="clear:both;width:100%">
        		<fieldset class="styled-fieldset styled-fieldset-border" ><legend>Archivos</legend>
                	<ul>
                    	<li>
						<div id="fine-uploader-basicfile" style="margin-left:10px">
						<span id="loadpic_file" class="btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);">Seleccionar archivo</span>
						
						</div>
						</li>
                        <li><fieldset class="sub-fieldset" >
                       	  <legend>Archivos existentes</legend>
						  
                        	<ul class="proddoc" data-bind="foreach: archivos" style="padding-left: 60px;">
                        		<li data-bind="attr: { class: $index() % 2 == 0? 'prodpicfirst' : ''}">
                        			<a data-bind="click: $parent.Archivo_Remove" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                                    <input type="text" class="sti-l" data-bind="value:titulo, enable: id == 0" style="display:inline"  />
                        		</li>
                           	</ul>
                        </fieldset></li>
                    </ul>
        		</fieldset>
        		</div>	
        </div>
    <div class="tools-bot">
	    	<ul class="ul-floatright">
	        	<li><a id="btnSubmit" onclick="$('#theForm').submit();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Guardar</a></li>
        		<li><a onclick="PageCore.Ir('<%=Url.Action("List","Articulo")%>');" class="btn btn-red btn-img" style="background-image:url(/Content/CSS/Back/icons/delete.png);">Cancelar</a></li>
            </ul>
		</div>
        </div>
    </form>
</div>

<div id="divImageEdit" style="display:none;position:fixed;z-index:21;top:10%;left:20%;height:420px;width:60%;" class="crop-wrapper">
<iframe border="0" frameborder="0" style="width:506px;height:340px"></iframe>

<p class="crop-legend"><label>Seleccione el &aacute;rea de la imagen a utilizar</label></p>
<ul class="crop-tools">
<li><a id="imageEditTodo" onclick="$('#divImageEdit>iframe').contents().find('#all').click()" class="btn btn-gray">Seleccionar todo</a></li>
<li><a onclick="Crop.Cancel()" class="btn btn-red">Cancelar</a></li>
<li><a onclick="Crop.Confirm()" class="btn btn-green">Guardar</a></li>
</ul>

</div>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src=""></script>


<link rel="stylesheet" type="text/css" href="../../../../Content/CSS/Back/jquery.datetimepicker.css"/ >
<script src="../../../../Scripts/datetimepicker-master/jquery.js"></script>
<script src="../../../../Scripts/datetimepicker-master/jquery.datetimepicker.js"></script>
<script type="text/javascript">
    window.onload = function () {
        
        jQuery('#datetimepicker').datetimepicker({ format: 'd/m/Y', timepicker: false })
    };
</script>
</asp:Content>