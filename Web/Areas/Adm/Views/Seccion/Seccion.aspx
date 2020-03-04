<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
        <ul class="navigation-secondary">
        	<li><a href="<%=Url.Action("List","Seccion") %>" style="background-image:url(/Content/CSS/Back/icons/page_white.png);">Listado</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<form data-bind="submit:save" id="theForm">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/tag_blue_add.png);">
		<%
		if(ViewData.Model.SeccionID==0){
			%>Nueva Secci&oacute;n<%
		}else{
			%>Editar Secci&oacute;n > <%=Html.Encode(ViewData.Model.Nombre)%><%
		}
		%></h1>
        <div style="position:relative;clear:both;">
		<ul class="tabs">
			<li class="tab-active" data-key="divTab1">General</li>
			<li data-key="divTab2" data-bind="if: template() != 5 && template() != 7 && template() != 2 && template() != 3 && template() != 6 ">Im&aacute;genes</li>
            <li data-key="divTab3" data-bind="if: template() == 5 || template() == 7 ">Contenido de la P&aacute;gina</li>
		</ul>
		</div>
		<div class="minicontainer-sub-m" id="divTab1">
        	<div class="minicontainer-sub-s mcss-left">
        		<fieldset class="styled-fieldset">
                	<ul>
                		
						<li><label>Encabezado de P&aacute;gina *</label><input type="text" class="sti-l" data-bind="value:descripcion" id="txtDescripcion" maxlength="500"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtDescripcion">Error: Por favor especifique el Encabezado de P&aacute;gina.</span>
                		</li>
                        <li><label>Nombre de P&aacute;gina *</label><input type="text" class="sti-l" data-bind="value:nombre" id="txtNombre" maxlength="100"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtNombre">Error: Por favor especifique el nombre.</span>
                		</li>
                        <li><label>T&iacute;tulo de P&aacute;gina</label><input type="text" class="sti-l" data-bind="value:titulopagina" maxlength="100"/>
                		</li>
                		
                		
                	</ul>
                    
                </fieldset>
        	</div>
        <div class="minicontainer-sub-s">
            <fieldset class="styled-fieldset">
                <ul>
                    <li><label>Template *</label>
                		<select id="selectTemplate" size="1" data-bind="value:template, event: { change: templateChange }" class="styled-select">
						<option value="">Elija el Template</option>
						<option value="1">Home - Inicio</option>
                        <option value="2">Agenda de Art&iacute;culos/Noticias</option>
                        <option value="3">Biblioteca de Documentos</option>
                        <option value="4">Capacitaci&oacute;n</option>
                        <option value="5">Institucional / P&aacute;gina simple</option>
                        <option value="6">Gu&iacute;as Pr&aacute;cticas (art&iacute;culos)</option>
                        <option value="7">Delegaciones</option>
                        <option value="8">Espacio Pyme</option>
                        </select>
                		<span class="mensaje-negativo" style="display:none" associatedControl="selectTemplate">Error: Por favor seleccione el Template a utilizar.</span>
                		</li>
                        <li><label>Color asociado</label>
                        <select  size="1" data-bind="value:color, attr: { 'class': color }" style="border:solid 1px black">
                        <option value="" class="" style="background-color:white">Sin color&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
						<option class="color01" value="color01">Color 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color02" value="color02">Color 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color03" value="color03">Color 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color04" value="color04">Color 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color05" value="color05">Color 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color06" value="color06">Color 6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color07" value="color07">Color 7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color08" value="color08">Color 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color09" value="color09">Color 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color10" value="color10">Color 10&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color11" value="color11">Color 11&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color12" value="color12">Color 12&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color13" value="color13">Color 13&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color14" value="color14">Color 14&nbsp;&nbsp;&nbsp;&nbsp;</option>
                        <option class="color15" value="color15">Color 15&nbsp;&nbsp;&nbsp;&nbsp;</option>
						</select>
                    </li>
                    <li><input type="checkbox" id="checkPrincipal" data-bind="checked:principal"/>&nbsp;<label style="display:inline" for="checkPrincipal">Se muestra en el men&uacute; principal</label></li>
                    <li><input type="checkbox" id="checkPyme" data-bind="checked:pyme"/>&nbsp;<label style="display:inline" for="checkPyme">Se muestra en Espacio Pyme</label></li>
                    
                    
                </ul>
            </fieldset>
        </div>
        
	</div>
	<div class="minicontainer-sub-m" id="divTab2" style="display:none">
        <div style="clear:both;width:100%">
        <fieldset class="styled-fieldset styled-fieldset-border" ><legend>Im&aacute;genes</legend>
            <ul>
                <li>
				<div id="fine-uploader-basic" style="margin-left:10px">
				<span class="loadpic_foto btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/picture.png);">Seleccionar imagen</span> 
                <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:500px;margin-top:5px;">La resoluci&oacute;n m&iacute;nima para una correcta visualizaci&oacute;n es de 616px (ancho) x <span id="imagenAlto"></span> (alto)</div>
				
				</div>
				</li>
                <li><fieldset class="sub-fieldset" style="min-height:340px;margin-top:5px;">
                    <legend>Im&aacute;genes existentes</legend>
					<div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;margin-left:10px;">La primer foto de la fila, sera siempre la foto representativa en las vistas previas. Desplaze una foto por delante de otra, para cambiar su orden en la fila.</div>
                    <ul class="prodpic" data-bind="foreach: images" style="padding-left: 60px;">
                        <li data-bind="attr: { class: $index() % 2 == 0? 'prodpicfirst' : ''}">
                        	<img alt="" data-bind="attr: {src: thumb}" />
                            <label>T&iacute;tulo</label>&nbsp;<input type="text" class="sti-l" data-bind="value:titulo" style="width:80%"/>
                            <!--<div class="descripcionimagen" style="">--><label>URL</label>&nbsp;<input type="text" class="sti-l" data-bind="value:descripcion" style="width:80%"/>
                        	<label style="display:none">Url</label>&nbsp;<input type="text"data-bind="value:descripcion" style="width:80%;display:none" />
                            <ul>
                        		<li>
                        			<a data-bind="click: $parent.Destacado_Remove" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                        		</li>
                        	</ul>
                        </li>

                           	
                    </ul>
                </fieldset></li>
            </ul>
        </fieldset>
        </div>
    </div>
    <div class="minicontainer-sub-m" id="divTab3" style="display:none">
        <div style="clear:both;width:100%" id="textoPagina">
            <fieldset class="styled-fieldset styled-fieldset-border" ><legend>Texto de la P&aacute;gina</legend>
            <textarea id="txtTexto" style="height:300px"></textarea>
            </fieldset>
        </div>
        <div style="clear:both;width:100%;margin-top:20px;">
        <table cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:40%">
            <div style="clear:both;width:100%">
        	<fieldset class="styled-fieldset styled-fieldset-border" style="padding-left:10px;padding-right:10px;" ><legend>Video</legend>
            <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:294px;">Ingrese la URL completa del Video de YouTube.</div>
            <label>URL</label>&nbsp;<input type="text" class="sti-l" data-bind="value:video" style="display:inline;width:317px;" />
            </fieldset>
            </div>
            <div style="clear:both;width:100%;margin-top:10px;">
            <fieldset class="styled-fieldset styled-fieldset-border" style="padding-left:10px"><legend>Archivos</legend>
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
        </td>
        <td style="width:59%;padding-left:5px;">
        <fieldset class="styled-fieldset styled-fieldset-border" ><legend>Im&aacute;genes</legend>
            <ul>
                <li>
				<div id="fine-uploader-basic2" style="margin-left:10px">
				<span class="loadpic_foto btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/picture.png);">Seleccionar imagen</span>
                <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:auto;margin-top:3px;">La resoluci&oacute;n m&iacute;nima para una correcta visualizaci&oacute;n es de 616px (ancho) x 315px (alto)</div>
                
				</div>
				</li>
                <li><fieldset class="sub-fieldset" style="min-height:150px">
                    <legend>Im&aacute;genes existentes</legend>
					<ul class="prodpicpage" data-bind="foreach: images" style="padding-left: 60px;">
                        <li class="prodpicfirst">
                        	<img data-bind="attr: {src: thumb}" />
                            <ul>
                        		<li>
                        			<a data-bind="click: $parent.Destacado_Remove" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a>
                        		</li>
                        	</ul>
                        </li>

                           	
                    </ul>
                </fieldset></li>
            </ul>
        </fieldset>
        </td>
        </tr>
        </table>
        </div>
        
    </div>
    <div class="tools-bot">
	    	<ul class="ul-floatright">
	        	<li><a id="btnSubmit" onclick="$('#theForm').submit();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Guardar</a></li>
        		<li><a onclick="PageCore.Ir('<%=Url.Action("List","Seccion")%>');" class="btn btn-red btn-img" style="background-image:url(/Content/CSS/Back/icons/delete.png);">Cancelar</a></li>
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
<script type="text/javascript" src="/Scripts/jquery-ui-1.9.1.custom.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.fineuploader-3.0.min.js"></script>
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
        theme_advanced_buttons1: "bold,italic,underline, formatselect, link",
        theme_advanced_buttons2: "",
        cleanup: true,
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
	self.id = ko.observable(<%=ViewData.Model.SeccionID%>);
	self.nombre = ko.observable('<%=ViewData.Model.Nombre%>');
	self.descripcion = ko.observable('<%=ViewData.Model.Descripcion%>');
    self.titulopagina= ko.observable('<%=ViewData.Model.TituloPagina%>');
	self.template = ko.observable('<%=ViewData.Model.Template%>');
    self.secciones =ko.observableArray( [{id:0,nombre:'Elija una Seccion',parentS:false},<% Html.RenderPartial("~/Areas/Adm/Views/Shared/SeccionesJSON.ascx", -1); %>]);
    self.color = ko.observable('<%=ViewData.Model.Color%>');
    self.video=ko.observable('<%=ViewData.Model.Video%>');
    self.texto='';
    self.token='';
    self.subparent = null;
    self.sub= false;
    self.principal = ko.observable(<%=ViewData.Model.MenuPrincipal.ToString().ToLower()%>);
    self.pyme = ko.observable(<%=ViewData.Model.EspacioPyme.ToString().ToLower()%>);
    self.images = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Seccion/DestacadosJSON.ascx", ViewData.Model.Destacados); %>]);
    self.archivos = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Seccion/ArchivosJSON.ascx", ViewData.Model.Archivos); %>]);
	self.save = function(){
		PageCore.HideErrorMessages();
		if(!PageCore.TestErrorMessages()){
			return false;
		}
        self.token = GlobalToken;
        if(self.template()==5)
            self.texto = tinyMCE.get("txtTexto").getContent().replace(/[\n\r]/g, '');
        if(uploadingFiles>0){
            alert("Hay imagenes siendo subidas al servidor, espere a que la transmision finalice");
            return false;
        }
        if(uploadingFilesFile>0){
            alert("Hay archivos siendo subidos al servidor, espere a que la transmision finalice");
            return false;
        }
		$('#btnSubmit').toggleClass('btn-waiting'); 
		PageCore.AjaxPost('<%=Url.Action("Save","Seccion")%>',ko.toJSON(self), function(obj){
			$('#btnSubmit').toggleClass('btn-waiting'); 
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			PageCore.Ir('<%=Url.Action("List","Seccion")%>');
		});
	};
    self.Archivo_Remove = function(){
        if(this.id>0)
		{
			if(!confirm("Esta seguro que desea eliminar el Archivo? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("ArchivoDelete","Seccion")%>?id='+this.id,'', function(obj){$('#ajaxLoading').hide();});
		}
		self.archivos.remove(this);
    }
    self.Destacado_Reordenar = function(o){
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
	self.Destacado_EliminarIndex = function(i){
		var imagen=null;
		for(var i=0;i<self.images().length;i++){
			if(self.images()[i].orden>i)
				self.images()[i].orden = self.images()[i].orden-1;
		}
	};
    self.Destacado_Remove = function(){
        if(this.id>0)
		{
			if(!confirm("Esta seguro que desea eliminar la Imagen? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("DestacadoDelete","Seccion")%>?id='+this.id,'', function(obj){$('#ajaxLoading').hide();});
		}
		self.images.remove(this);
		self.Destacado_EliminarIndex(this.orden);
    };
    self.templateChange = function(){
        if(self.template()==4){
            $('#imagenAlto').text(227);
            $(".descripcionimagen").hide();
        }else{
            $('#imagenAlto').text(315);
            $(".descripcionimagen").show();
            }
		    
        var arrO = new Array();
        ko.utils.arrayForEach(self.images(), function(o) {
            if(o.id==0){
            arrO.push(o);
            }
        });
        for(var i=0;i<arrO.length;i++){
            var o = arrO[i];
            self.images.remove(o);
            self.Destacado_EliminarIndex(o.orden);
        }


        if(self.template()==5)
            $('#textoPagina').show();
        else
            $('#textoPagina').hide();
    };
};
var imagesToCrop=new Array();
var Crop = {
    currentImage:null,width:null,height:null,
    Show:function(img,width,height){
        if(img==null){
            this.Cancel();
            return;
        }
        this.width=width;
        this.height=height;
        this.currentImage=img;
        $('#divImageEdit>iframe').attr("src","/File/ImageCrop?token="+GlobalToken+"&image="+img+"&width="+width+"&height="+height+"&hudheight=338&hudwidth=506");
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
        PageCore.AjaxPost('/File/ImageCrop?token='+GlobalToken+'&image='+this.currentImage+'&x='+Math.round(c.x,0)+'&y='+Math.round(c.y,0)+'&w='+Math.round(c.w,0)+'&h='+Math.round(c.h,0)+'&sw='+Crop.width+'&sh='+Crop.height,{}, function(obj){
            var img = obj.img;
            var lastorden=-1;
	        for(var i=0;i<baseKOobj.images().length;i++){
		        if(baseKOobj.images()[i].orden>lastorden)
			        lastorden=baseKOobj.images()[i].orden;
	        }
	        var ext = PageCore.GetFileExtension(img);
	        baseKOobj.images.push({orden:++lastorden,id:0, img:img, ext:ext,thumb:'/Uploads/'+GlobalToken+'/'+img, titulo:img, descripcion:'', showdescription:(baseKOobj.template()!=4)});
	        that.Show(imagesToCrop.pop());
        });
        
        
    }
}
function Image_Upload_Complete (img,width,height){
imagesToCrop.push(img);
	if(uploadingFiles==0){
		$('.loadpic_foto').toggleClass("btn-waiting");
        Crop.Show(imagesToCrop.pop(),width,height);
	}
    
}
function File_Upload_Complete (img){
	if(uploadingFilesFile==0)
		$('#loadpic_file').toggleClass("btn-waiting");
	var ext = PageCore.GetFileExtension(img);
	baseKOobj.archivos.push({id:0, file:img, ext:ext, titulo:img});
	
}
var baseKOobj=null;
var uploadingFiles = 0;var uploadingFilesFile=0;
var sortableUpdate = {desde:null,hasta:null};
$(document).ready(function(){
    PageCore.ActivateTabs();
	baseKOobj=new ViewModel();
	ko.applyBindings(baseKOobj);
    baseKOobj.templateChange();
    GlobalToken = PageCore.GetRandomToken();
    
    $( ".prodpic" ).sortable({
		 start: function(e, ui) {
			sortableUpdate.desde=ui.item.index();
		},
		update: function(event, ui) {
			sortableUpdate.hasta=ui.item.index();
			baseKOobj.Destacado_Reordenar(sortableUpdate);
		}
	}	);
    $fub = $('#fine-uploader-basic');
	var uploader = new qq.FineUploaderBasic({
		button: $fub.find("span")[0],
		request: {
            forceMultipart:true,
            endpoint: '/File/Upload?token='+GlobalToken
		},
		
		callbacks: {
		 onSubmit: function(id, fileName) {
         
			var ext = PageCore.GetFileExtension(fileName).toLowerCase();
			if(ext!="jpg" && ext!="png" && ext!="jpeg"){
				alert("Solo se permiten extensiones JPG y PNG");
				return false;
			}

		},
		onUpload: function(id, fileName) {
		$('.loadpic_foto').toggleClass("btn-waiting");
		uploadingFiles++;
		},
		onComplete: function(id, fileName, responseJSON) {
		uploadingFiles--;
		if (responseJSON.success) {
        if(baseKOobj.template()==4)
            Image_Upload_Complete(fileName,616,227);
        else
		    Image_Upload_Complete(fileName,616,315);
		} else {
		alert(responseJSON.error);
		}}
		},
		debug: false
	});
    $fub = $('#fine-uploader-basic2');
	var uploader = new qq.FineUploaderBasic({
		button: $fub.find("span")[0],
		request: {
            forceMultipart:true,
            endpoint: '/File/Upload?token='+GlobalToken
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
		$('.loadpic_foto').toggleClass("btn-waiting");
		uploadingFiles++;
		},
		onComplete: function(id, fileName, responseJSON) {
		uploadingFiles--;
		if (responseJSON.success) {
		Image_Upload_Complete(fileName,616,227);
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
			if(ext!="doc" && ext!="docx"&& ext!="pdf"&& ext!="xls"&& ext!="xlsx"&& ext!="zip"&& ext!="rar"&& ext!="png"&& ext!="jpg" && ext!="jpeg"){
				alert("Solo se permiten extensiones DOC, PDF, XLS, PNG, JPG y ZIP/RAR");
				return false;
			}

		},
		onUpload: function(id, fileName) {
		$('#loadpic_file').toggleClass("btn-waiting");
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

function LoadTextAreas(){tinyMCE.get("txtTexto").setContent('<%=(ViewData.Model.Texto!=null?ViewData.Model.Texto.Replace("'","\\'"):"") %>');;}

$(window).unload(function() {
  PageCore.AjaxPost('/File/Cleanup?token='+GlobalToken,'', function(){});
  
});
</script>
</asp:Content>