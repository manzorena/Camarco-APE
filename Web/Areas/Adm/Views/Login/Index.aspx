<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Camarco - Administracion</title>
    <link href="<%=Url.Content("~/Content/CSS/Back/reset.css")%>" rel="stylesheet" type="text/css" />
    <link href="<%=Url.Content("~/Content/CSS/Back/admin.css")%>" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=Url.Content("~/Scripts/jquery-1.9.0.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(	function () { $("#txtUsuario").focus(); });
        function Submit() {$('#btnSubmit').toggleClass('btn-waiting');  document.getElementById('form').submit(); }
        $(document).keypress(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);

            if (keycode == 13)
            {
                switch ($(document.activeElement).attr("id"))
                {
                    case "txtUsuario": $("#txtPassword").focus(); break;
                    case "txtPassword": Submit(); break;
                }
            }
        });
</script>
</head>
<body>
<div style="margin-left:auto;margin-right:auto;margin-top:40px;width:280px;">
<img src="<%=Url.Content("~/Content/CSS/Back/logo-login.png")%>" width="280" height="87" alt="Logo"/>
</div>
				
<div id="login-container">

  <div class="minicontainer" style="width:194px; margin-top:10px;">
   	  <form id="form" action="" method="post">
    	<div class="minicontainer-sub-login">
        	
            	<fieldset class="styled-fieldset">
            	<ul>
                	<li><label>Usuario</label><input name="txtUsuario" id="txtUsuario" type="text" class="sti-m" /></li>
                    <li>
                      <label>Contrase&ntilde;a</label>
                      <input id="txtPassword" name="txtPassword" type="password" class="sti-m" /></li>
		<li style="color:red;text-align:center;"><%=ViewData["error"]%></li>
                </ul>
                </fieldset>
            
        </div>
        <div class="minicontainer-sub-login-tools">
        	<ul class="ul-floatright">
        		
            	<li><a onclick="Submit()" id="btnSubmit" class="btn btn-gray">Iniciar sesi&oacute;n</a></li>
        	</ul>
    	</div>
    </form>
    </div>
</div>
</body>
</html>
