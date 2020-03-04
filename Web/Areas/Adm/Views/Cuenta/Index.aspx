<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Back.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div id="container">
	<div class="minicontainer mc-l">
		<h1>CAMBIO DE PASSWORD</h1>
		 <div class="minicontainer-sub-m">
			<form method="post" id="theForm">
			<div class="minicontainer-sub-s ">
			<fieldset class="styled-fieldset">
			<ul>
			<li>
			<label>Password Actual</label>
                    	  <input id="txtActual" name="txtActual" type="password" class="sti-m" /></li>		
			<li>
			<label>Nuevo Password</label>
                    	  <input id="txtNuevo" name="txtNuevo" type="password" class="sti-m" /></li>		
			<li style="color:red;text-align:center;"><%=ViewData["error"] %></li>
			<li style="color:green;text-align:center;"><%=ViewData["mensaje"] %></li>
			</ul>
			</fieldset>
            </div>
			</form>
			
		</div>
		<div class="tools-bot">
        	<ul class="ul-floatright">
            	<li><a id="btnSubmit" onclick="Form_Submit()" class="btn btn-green btn-img" style="background-image:url(/Content/CSS/Back/imagenes/icons/accept.png);">Cambiar Password</a></li>
                <li><a onclick="Form_Clear()" class="btn btn-gray">Limpiar</a></li>
            </ul>
	</div>
</div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript">
    function Form_Submit()
    {
        $('#btnSubmit').toggleClass('btn-waiting'); 
        if (!Form_CheckValues()) return false;
        $('#theForm').submit();
    }
    function Form_CheckValues()
    {
        if ($('#txtActual').val() == "" || $('#txtNuevo').val() == "")
        {
            alert("Debe completar ambos campos.");
            $('#txtNuevo').focus();
            return;
        }
        return true;
    }
    function Form_Clear()
    {
        $('#txtNuevo').val("");
        $('#txtActual').val("");
    }


</script>
</asp:Content>
