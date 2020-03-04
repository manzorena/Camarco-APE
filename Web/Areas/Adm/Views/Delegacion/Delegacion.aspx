<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Delegacion>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="navigation">
    	<% Html.RenderPartial("~/Areas/Adm/Views/Shared/Menu.ascx"); %>
        <ul class="navigation-secondary">
        	<li><a href="<%=Url.Action("List","Delegacion") %>" style="background-image:url(/Content/CSS/Back/icons/page_white.png);">Listado</a></li>
        </ul>
        <div class="clearing"></div>
    </div>
<div id="container">
	<form data-bind="submit:save" id="theForm">
	<div class="minicontainer mc-l">
		<h1 style="background-image:url(/Content/CSS/Back/icons/tag_blue_add.png);">
		<%
		if(ViewData.Model.DelegacionID==0){
			%>Nueva<%
		}else{
			%>Editar<%
		}
		%> Delegac&oacute;n</h1>
        <div class="minicontainer-sub-m" >
        	<div class="minicontainer-sub-s mcss-left">
        		<fieldset class="styled-fieldset">
                	<ul>
                        <li><label>Nombre *</label>
                        <input type="text" class="sti-l" data-bind="value:nombre" id="txtNombre" maxlength="200"/>
                        <span class="mensaje-negativo" style="display:none" associatedControl="txtNombre">Error: Por favor ingrese el Nombre.</span>
                		</li>
                        <li><label>Tel&eacute;fono de Contacto *</label>
                        <input type="text" class="sti-l" data-bind="value:contacto" id="txtContacto" maxlength="200"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtContacto">Error: Por favor especifique el tel&eacute;fono de contacto.</span>
                		</li>
                         <li><label>Fax</label>
                        <input type="text" class="sti-l" data-bind="value:fax" id="txtFax" maxlength="100"/>
                		
                		</li>
                        <li><label>Email *</label>
                        <div class="alerta-azul" style="background-image:url(/Content/CSS/Back/icons/information.png);width:400px; ">Puede ingresar una lista de direcciones separadas por punto y coma (;)</div>
                        <input type="text" class="sti-l" data-bind="value:email" id="txtEmail" maxlength="200"/>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtEmail">Error: Por favor especifique el email.</span>
                		</li>
                        <li><label>Domicilio *</label>
                        <textarea rows="2" class="sti-l" data-bind="value:domicilio" id="txtDomicilio"></textarea>
                		<span class="mensaje-negativo" style="display:none" associatedControl="txtDomicilio">Error: Por favor especifique el domicilio.</span>
                		</li>
                	</ul>
                    
                </fieldset>
        	</div>
            <div class="minicontainer-sub-s">
                <fieldset class="styled-fieldset">
                	<ul>
                        <li><label>Provincia *</label>
                        <select id="selectProvincia" size="1" data-bind="value:provincia,foreach: provincias" style="width:400px;" class="styled-select">
                        <option data-bind="value:id, text:nombre"></option>
						</select>
                		<span class="mensaje-negativo" style="display:none" associatedControl="selectProvincia">Error: Por favor seleccione la Provincia.</span>
                		</li>
                        <li><label>Presidente</label>
                        <input type="text" class="sti-l" data-bind="value:presidente" id="txtPresidente" maxlength="200"/>
                		
                		</li>
                    </ul>
                </fieldset>
            </div>
    </div>
	<div class="tools-bot">
	    	<ul class="ul-floatright">
	        	<li><a id="btnSubmit" onclick="$('#theForm').submit();" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/icons/accept.png);">Guardar</a></li>
        		<li><a onclick="PageCore.Ir('<%=Url.Action("List","Delegacion")%>');" class="btn btn-red btn-img" style="background-image:url(/Content/CSS/Back/icons/delete.png);">Cancelar</a></li>
            </ul>
		</div>
        </div>
    </form>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript">
var GlobalToken = null;
var ViewModel = function(){
	var self = this;
	self.id = <%=ViewData.Model.DelegacionID%>;
    self.nombre = ko.observable('<%=ViewData.Model.Nombre%>');
	self.domicilio = ko.observable('<%=ViewData.Model.Domicilio%>');
    self.email = ko.observable('<%=ViewData.Model.Email%>');
    self.contacto = ko.observable('<%=ViewData.Model.Contacto%>');
    self.fax = ko.observable('<%=ViewData.Model.Fax%>');
    self.presidente = ko.observable('<%=ViewData.Model.Presidente%>');
    self.provincia = ko.observable(<%=(ViewData.Model.Provincia!=null?ViewData.Model.Provincia.ProvinciaID:0)%>);
	self.provincias =ko.observableArray( [{id:0,nombre:'Elija una Provincia'},<% Html.RenderPartial("~/Areas/Adm/Views/Delegacion/ProvinciasJSON.ascx"); %>]);
    self.save = function(){
		PageCore.HideErrorMessages();
		if(!PageCore.TestErrorMessages()){
			return false;
		}
    	$('#btnSubmit').toggleClass('btn-waiting'); 
		PageCore.AjaxPost('<%=Url.Action("Save","Delegacion")%>',ko.toJSON(self), function(obj){
			$('#btnSubmit').toggleClass('btn-waiting'); 
			if(obj.status=="error")
            {
                alert(Utils.GetErrors(obj));
                return;
            }
			PageCore.Ir('<%=Url.Action("List","Delegacion")%>');
		});
	};
};
var baseKOobj=null;
$(document).ready(function(){
	baseKOobj=new ViewModel();
	ko.applyBindings(baseKOobj);

});

</script>
</asp:Content>
