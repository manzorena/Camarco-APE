<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    if (Session["UserID"] == null)
    {
        %><div class="header-login"><a href="#" title="Ingreso para socios" class="header-login-loggedout" onclick="Session.ShowLogin(true)">INGRESO SOCIOS</a><a href="/institucional/beneficios-de-asociarse" title="Por qué ser socio de la CÁMARA" class="header-porquesersocio">&iquest;POR QU&Eacute; SER SOCIO DE LA C&Aacute;MARA?</a></div>
        <div id="loginForm" class="popup small" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;">
	        <h2 id="loginForm_TitleLogin">IDENTIFICACI&Oacute;N SOCIOS</h2>
            <h2 id="loginForm_TitleContenidoExclusivo">CONTENIDO EXCLUSIVO</h2>
            <p id="loginForm_TitleContenidoExclusivoP">Para acceder a este contenido es requisito ser socio de la C&aacute;mara</p>
            <a href="#" class="close-btn" onclick="Session.CloseLogin()"></a>
	        <form>
		        <ul>
			        <li><input id="sessionLoginName" type="text" placeholder="Usuario">
                    <div class="popup-tooltip rojo" id="sessionLoginError" style="display:none">
		      			<h4>ATENCI&Oacute;N</h4>
		      			<p><span id="sessionLoginErrorMessage"></span></p>
					</div></li>
			        <li><input id="sessionLoginPassword" type="password" placeholder="Contraseña"></li>
		        </ul>
		        <div class="btns"><a href="#" class="system-btn" onclick="document.getElementById('sessionLoginName').value = document.getElementById('sessionLoginName').value.replace('CAMARCO\\','').replace('camarco\\','');Session.DoLogin()" id="loginFormB">INGRESAR</a><a href="#" class="textlink" onclick="Session.CloseLogin()">Cancelar</a></div>
	        </form>
	        <ul class="ayuda">
		        <li><a href="#" onclick="Session.RecoverShow()">&iquest;Olvid&oacute; su usuario o contrase&ntilde;a?</a></li>
		        <li><a href="/contacto">&iquest;No es socio de la C&aacute;mara y desea asociarse?</a></li>
	        </ul>
        </div>
        <div id="downloadForm" class="popup small" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;">
	        <h2>BIENVENIDO</h2>
	        <p>Ya est&aacute; listo para acceder a &nbsp;los contenidos solicitados</p>
	        <a href="#" class="close-btn"></a>
	        <form>
		        <div class="btns"><a href="#" class="btn">DESCARGAR</a></div>
	        </form>
        </div>
        <div class="popup small" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;" id="recoverPass" >
	        <h2>RECUPERAR USUARIO Y/O CONTRASE&Ntilde;A</h2>
            <p>Por favor, prov&eacute;anos de la siguiente informaci&oacute;n para que podamos enviarle sus datos de acceso.</p>
	        <a href="#" onclick="Session.CloseLogin();" class="close-btn"></a>
	        <form>
		        <ul>
			        <li><input id="recoverName" type="text" placeholder="Nombre y apellido *"/></li>
			        <li><input id="recoverEmpresa" type="text" placeholder="Empresa *"/></li>
                    <li><input id="recoverEmail" type="text" placeholder="Correo electrónico *"/></li>
		        </ul>
		        <div class="btns"><a href="#" onclick="Session.Recover()" class="system-btn" id="recoverPassB">INGRESAR</a><a href="#" onclick="Session.CloseLogin()" class="textlink">Cancelar</a></div>
              <span>* Todos los datos son obligatorios</span>
	        </form>
	        <ul class="ayuda">
		        <li>011 4361-8778 (l&iacute;neas rotativas)</li>
		        <li><a href="mailto:socios@camarco.org.ar" target="_blank">socios@camarco.org.ar</a></li>
	        </ul>
        </div>
        <div class="popup small" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;" id="recoverPassOk">
	        <h2>&iexcl;LISTO!</h2>
	        <p>Pronto nos pondremos en contacto con usted para enviarle instrucciones para acceder al sistema.</p>
	        <a href="#" onclick="Session.CloseLogin()" class="close-btn"></a>
	        <form>
		        <div class="btns"><a href="#" class="btn" onclick="Session.CloseLogin()">VOLVER AL SITIO</a></div>
	        </form>
        </div>
        <div id="loginDownloadForm" style="display:none"><iframe ></iframe></div>
        <%
    }
    else
    {
        %><div class="header-login"><span class="header-login-bienvenida">BIENVENIDO</span><span class="header-login-usuario"><%=Html.Encode(Session["UserName"]) %></span><a href="<%=Url.Action("Logout","Session") %>" class="header-login-btn-logout" title="Salir del sistema">Salir del sistema</a></div><%
    }
%>