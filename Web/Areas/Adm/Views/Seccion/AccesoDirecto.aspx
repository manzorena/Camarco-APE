<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage" %>

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
		<h1 style="background-image:url(/Content/CSS/Back/icons/layout_sidebar.png);">Accesos Directos <%=(((Camarco.Model.Seccion)ViewData["Seccion"]).Parent != null ? "> " + Html.Encode(((Camarco.Model.Seccion)ViewData["Seccion"]).Parent.Nombre): "")%>> <%=Html.Encode(((Camarco.Model.Seccion)ViewData["Seccion"]).Nombre)%></h1>
        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);">Puede crear la cantidad de menues de accesos directos que desee, el Template de la secci&oacute;n puede tener alguna restricci&oacute;n visual.</div>
        <div class="minicontainer-sub-m">
        	<div class="minicontainer-sub-m mcss-left" id="divMenues">
                <fieldset class="styled-fieldset styled-fieldset-border"><legend>Nuevo Men&uacute;</legend>
        			<ul>
        				<li><label>T&iacute;tulo</label>
        				<input type="text" class="sti-l" id="txtNuevoMenuTitulo" />
                        <span class="mensaje-negativo" style="display:none" id="nuevoTituloMensaje">Por favor especifique un t&iacute;tulo.</span>
        				</li>
        			</ul>
        			<div class="tools-bot" style="width:95%">
        				<ul class="ul-floatright">
					    	<li><a data-bind="click:Menu_Agregar" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Agregar</a></li>
				        </ul>
					</div>
        		</fieldset>
        		<fieldset class="styled-fieldset styled-fieldset-border">
				<legend>Men&uacute;es de Accesos</legend>
				<table border="0" cellpadding="0" cellspacing="0" class="table-m" style="width:100%">
    				<tr>
    					<th width="200">Nombre</th>
    					<th width="50">Acciones</th>
    				</tr>
					<tbody data-bind="foreach:menues">
							<tr>
								<td ><input type="text" data-bind="attr:{value:titulo, id:id}" class="transparente" onfocus="this.className='sti-m';this.style.width='90%';" onblur="this.className='transparente';this.style.width='auto';" style="width:auto;"/><span class="admin-acceso-directo" data-bind="click: $parent.focusInput">&nbsp;</span></td>
								<td><a href="#" data-bind="click: $parent.Menu_Editar" title="EDITAR LINKS"><img src="/Content/CSS/Back/icons/page_white_edit.png" width="16" height="16" /></a><a href="#" data-bind="click: $parent.Menu_Remove" title="ELIMINAR"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a></td>
							</tr>
						</tbody>			
    			</table>
    			</fieldset>
                <div class="tools-bot" style="width:99%">
	    	        <ul class="ul-floatright">
	        	        <li><a id="btnSubmit" onclick="$('#theForm').submit();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Guardar</a></li>
        		        <li><a onclick="PageCore.Ir('<%=Url.Action("List","Seccion")%>');" class="btn btn-red btn-img" style="background-image:url(/Content/CSS/Back/icons/delete.png);">Cancelar</a></li>
                    </ul>
		        </div>
                </div>
        	
            <div class="minicontainer-sub-m mcss-left" id="divLinks" style="display:none">
                <fieldset class="styled-fieldset styled-fieldset-border" style="padding-top:15px"><legend>Nuevo Acceso</legend>
        			<ul>
        				<li>
        				    <input type="radio" name="radioAcceso" id="radioAccesoUrl" /><label for="radioAccesoUrl" style="display:inline">URL Externa</label><br />
                            <input type="radio" name="radioAcceso" id="radioAccesoContenido" style="margin-top:15px"/><label for="radioAccesoContenido" style="display:inline">Contenido interno</label><br />
        				</li>
                        <li id="liAccesoUrl">
                            <label>Nombre</label><input style="display:inline" type="text" class="sti-l" id="txtAccesoURLNombre" /><br /><br />
                            <label>URL</label><input style="display:inline" type="text" class="sti-l" id="txtAccesoURL" />
                        </li>
                        <li id="liAccesoContenido" style="padding-left:5px">
                            <label style="display:inline" id="labelAccesoContenido"></label>
                            <span onclick="Search.Show();" class="btn btn-gray btn-img" style="background-image:url(/Content/CSS/Back/icons/page_white_add.png);">Seleccionar contenido</span>
                        </li>
        			</ul>
        			<div class="tools-bot" style="width:95%">
        				<ul class="ul-floatright">
					    	<li><a class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);" onclick="Links.Agregar()">Agregar</a></li>
				        </ul>
					</div>
        		</fieldset>
                <fieldset class="styled-fieldset styled-fieldset-border" style="margin-top:15px">
				<legend>Accesos del Men&uacute;</legend>
				<table border="0" cellpadding="0" cellspacing="0" class="table-m" style="width:100%;" id="tableLinks">
    				
    			</table>
    			</fieldset>
                <div class="tools-bot" style="width:99%">
	    	        <ul class="ul-floatright">
	        	        <li><a onclick="Links.Close();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Volver al Men&uacute;</a></li>
                    </ul>
		        </div>
            </div>
        
	</div>
	
    <div class="overlay o-filtros" id="ContenidoSearch" style="display:none;position:absolute;z-index:7;top:20%;left:50%;width:600px;margin-left:-300px;"  >
	<div class="overlay-tools">
  		<h3>Utilice los filtros para buscar contenidos</h3>
        <a onclick="Search.Close()" class="btn btn-red">Cancelar</a>
  		<a href="javascript:void(0);" class="btn btn-green btn-img floatright" onclick="Search.Search();" style="background-image:url(/Content/CSS/Back/icons/magnifier.png);">Buscar</a><div class="clearing"></div>
  		
    </div>
    <div class="overlay-content">
    	<fieldset class="styled-fieldset">
        	<ul>
				<li>
                  <label>Nombre</label><input type="text" class="sti-l" id="searchNombre" value="" /></li>
                <li>
                  <label>Tipo de Contenido</label>
                  <select class="styled-select" id="searchTipo" size="1" >
                    <option value="-1">Elija un tipo</option>
                    <option value="5">Secci&oacute;n/P&aacute;gina</option>
                    <option value="1">Documento/Archivo</option>
                    <option value="2">Noticia/Art&iacute;culo</option>
                    <option value="4">Curso</option>
                  </select></li>
                </ul>
        </fieldset>
        <fieldset class="styled-fieldset styled-fieldset-border">
        <legend>Resultados de b&uacute;squeda</legend>
        <table border="0" cellpadding="0" cellspacing="0" class="table-m" id="searchResultados" style="width:100%"><tbody></tbody>
        </table>
        </fieldset>
        <div class="tools-bot" style="width:99%" id="searchResultadosPaginator">
        </div>
    </div>
   
</div>

    </form>
</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/pagination.js"></script>
<script type="text/javascript">
var ViewModel = function(){
	var self = this;
    self.id = <%=((Camarco.Model.Seccion)ViewData["Seccion"]).SeccionID %>;
	self.menues = ko.observableArray([<% Html.RenderPartial("~/Areas/Adm/Views/Seccion/MenuesJSON.ascx", ViewData["Menues"]); %>]);
	self.save = function(){
		$('#btnSubmit').toggleClass('btn-waiting'); 
		PageCore.AjaxPost('<%=Url.Action("AccesoDirectoSave","Seccion")%>',ko.toJSON(self), function(obj){
			$('#btnSubmit').toggleClass('btn-waiting'); 
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			PageCore.Ir('<%=Url.Action("List","Seccion")%>');
		});
	};
	self.focusInput=function(i){
		$('#'+i.id).focus();
	};
    self.Menu_Agregar = function(){
        $('#nuevoTituloMensaje').hide();
        if(PageCore.IsEmpty($('#txtNuevoMenuTitulo').val()))
        {
            $('#nuevoTituloMensaje').show();
            return false;
        }
        var lastorden=-1;
	    for(var i=0;i<baseKOobj.menues().length;i++){
		    if(baseKOobj.menues()[i].orden>lastorden)
			    lastorden=baseKOobj.menues()[i].orden;
	    }
        self.menues.push({id:0, titulo:$('#txtNuevoMenuTitulo').val(), orden:++lastorden, links:[]});
        $('#txtNuevoMenuTitulo').val('');
    }
    self.Menu_EliminarIndex = function(i){
		var imagen=null;
		for(var i=0;i<self.menues().length;i++){
			if(self.menues()[i].orden>i)
				self.menues()[i].orden = self.menues()[i].orden-1;
		}
	};
    self.Menu_Remove = function(){
        if(this.id>0)
		{
			if(!confirm("Esta seguro que desea eliminar el menu de Accesos Directos? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("AccesoDirectoDelete","Seccion")%>?id='+this.id,'', function(obj){$('#ajaxLoading').hide();});
		}
		self.menues.remove(this);
		self.Menu_EliminarIndex(this.orden);
    }
    self.Menu_Editar = function(){
        Links.Show(this);
    }
};
var baseKOobj=null;
$(document).ready(function(){
    baseKOobj=new ViewModel();
	ko.applyBindings(baseKOobj);
    $('#radioAccesoUrl').on('click',Links.ToggleRadio);
    $('#radioAccesoContenido').on('click',Links.ToggleRadio);
});
var Links = {
    parentKO:null,
    Show:function(parent){
        this.parentKO=parent;
        this.Init();
        this.Redraw();
        $("#divMenues").fadeOut('fast', function(){$("#divLinks").animate({width:'toggle'},500);});
    },
    Add:function(link){
        this.parentKO.links.push(link);
    },
    Delete:function(i){
        var o = this.parentKO.links[i];
        if(o.id>0){
            if(!confirm("Esta seguro que desea eliminar el link? Esta accion no puede deshacerse."))return false;
			$('#ajaxLoading').show();
	        
			PageCore.AjaxPost('<%=Url.Action("AccesoDirectoLinkDelete","Seccion")%>?id='+o.id,'', function(obj){$('#ajaxLoading').hide();});
        }
        this.parentKO.links.splice(i,1);
        this.Redraw();
    },
    Redraw:function(){
        var html='<tr><th width="100">Tipo</th><th width="200">Nombre</th><th width="50">Acciones</th></tr>';
		for(var i=0,len=this.parentKO.links.length;i<len;i++){
            var r = this.parentKO.links[i];
            switch(r.resourcetype){
                case 0:rtype='Link Externo';break;
                case 1:rtype='Documento';break;
                case 2:rtype='Art&iacute;culo';break;
                case 3:rtype='Revista';break;
                case 4:rtype='Curso';break;
                case 5:rtype='Secci&oacute;n';break;
            }
            html+='<tr><td>'+rtype+'</td><td>'+r.titulo+'</td><td><a href="#" title="ELIMINAR LINK" onclick="Links.Delete('+i+')"><img src="/Content/CSS/Back/icons/cross.png" width="16" height="16" /></a></td></tr>'
        }
        $('#tableLinks').html(html);
    },
    ToggleRadio:function(){
        if($('#radioAccesoUrl').prop('checked')){
            $('#liAccesoUrl').show();
            $('#liAccesoContenido').hide();
        }
        else{
            $('#liAccesoUrl').hide();
            $('#liAccesoContenido').show();
        }
    },
    Init:function(){
        $('#liAccesoUrl').hide();
        $('#liAccesoContenido').hide();
        $('#radioAccesoUrl').attr('checked',false);
        $('#radioAccesoContenido').attr('checked',false);
        $('#txtAccesoURL').val('');
        $('#labelAccesoContenido').text('');
        $('#txtAccesoURLNombre').val('');
    },
    Close:function(){
        $("#divLinks").animate({width: 'toggle'},500,function(){$("#divMenues").fadeIn('fast')});
    },

    Agregar:function(){
        if($('#radioAccesoUrl').prop('checked')){
            if(PageCore.IsEmpty($('#txtAccesoURLNombre').val())){
                alert("Ingrese el nombre que desea mostrar para el link");
                $('#txtAccesoURLNombre').focus();
                return false;
            }
            if(PageCore.IsEmpty($('#txtAccesoURL').val())){
                alert("Ingrese la direccion URL que tendra el link");
                $('#txtAccesoURL').focus();
                return false;
            }
            var url = $('#txtAccesoURL').val().toLowerCase();
            if(url.indexOf("http")==-1 && url.indexOf("https")==-1)url="http://"+url;
            this.Add({id:0,resourceid:0, resourcetype:0, link:url, titulo:$('#txtAccesoURLNombre').val()});
            this.Redraw();
            this.Init();
        }
        else{
            alert("Utilice el boton Seleccionar Contenido para agregar links al menu.");
        }
    }
}
var Search={
    paginator:null,
    Show:function(){
        if(this.paginator==null){
             this.paginator= new Pagination($('#searchResultados>tbody'), 4, $('#searchResultadosPaginator'), "Search.paginator", null);
        }
        $('#searchResultados').html('');
        this.paginator.Redraw();
        $('#ContenidoSearch').show();
        PageCore.ShowLightBox($('#ContenidoSearch'));
        $('#searchTipo').val('-1');
        $('#searchNombre').val('');
    },
    Close:function(){
         $('#ContenidoSearch').hide();
            PageCore.CloseLightBox();
    },
    Search:function(){
        if($('#searchTipo').val()=='-1'){
            alert("Elija un Tipo de Contenido.");
            $('#searchTipo').focus();
            return false;
        }
        if(PageCore.IsEmpty($('#searchNombre').val())){
            alert("Debe ingresar parte del nombre para acotar la busqueda.");
            $('#searchNombre').focus();
            return false;
        }
        var self = this;
        $('#ajaxLoading').show()
        PageCore.AjaxPostHTML('<%=Url.Action("SimpleFilter","Resource")%>',$.toJSON({seccionid:-1,tipo:$('#searchTipo').val(),nombre:$('#searchNombre').val()}), function(data){
            $('#ajaxLoading').hide();
            if(data.length==0){
                data = '<tr class="transparente"><td class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png); width:500px;margin-top:5px;padding-left:40px;">No hay resultados que coincidan con su criterio de búsqueda.</td></tr>';
            }
            $('#searchResultados').html(data);
            self.paginator= new Pagination($('#searchResultados>tbody'), 5, $('#searchResultadosPaginator'), "Search.paginator", null);

            self.paginator.Redraw();
        });
    }
}
function SimpleHandlerOnClick(o, rid){
    Search.Close();
    Links.Add({id:0,resourceid:rid, resourcetype:Number($('#searchTipo').val()), link:'', titulo:$(o.parentElement).find('span').html()});
    Links.Redraw();
    Links.Init();
}
</script>
</asp:Content>
