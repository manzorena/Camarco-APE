<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Curso>" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>



<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>
<asp:Content ContentPlaceHolderID="MetaContent" runat="server">

<meta property="og:title" content="<%=Model.Titulo %>"/>
<meta property="og:type" content="website"/>
<meta property="og:description" content="<%=Model.Copete %>"/>
<!--<meta property="og:url" content="www.camarco.org.ar/Cursos/<=Model.Resource.Slug %>"/>-->
<meta property="og:image" content="http://www.camarco.org.ar/Content/CSS/Front/imagenes/Curso-Empty.jpg"/>
<meta property="twitter:card" content="summary"/>
<!--<meta property="twitter:url" content="www.camarco.org.ar/Cursos/<=Model.Resource.Slug %>"/>-->
<meta property="twitter:title" content="<%=Model.Titulo %>"/>
<meta property="twitter:description" content="<%=Model.Copete %>"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


<script type="text/javascript">
    function Inscripcion(boton) {
        document.getElementById(boton).style.display = "none";
        document.getElementById("divInscripcion").style.display = "";
    }

    function Registracion(div) {
        
        
        document.getElementById(div).style.display = "none";
        document.getElementById("divDatos").style.display = "";
        document.getElementById("divDatos").style.display = "";
    }

    function justNumbers(e) {
        var keynum = window.event ? window.event.keyCode : e.which;
        if (keynum == 8) return true;

        return /\d/.test(String.fromCharCode(keynum)); 
    }
</script>

<div class="wrapper">
    <input id="version" type="text" value="version 20151019" style="display:none" />
	<!-- NIVEL 2 - CONTENT -->
    <div class="content color03">
    	<h1>Cursos de perfeccionamiento para mejorar los resultados </h1>
        <ul class="breadcrumb">
       	  <li><a href="/">INICIO</a></li>
          <li><a href="/Escuela-de-gestion">CAPACITACIÓN</a></li>
          <li class="active"><%=(Model.Titulo.Length>60?Html.Encode(Model.Titulo.Substring(0,60)+"..."):Html.Encode(Model.Titulo)) %></li>
      </ul>
      <!-- REDES SOCIALES -->
      <ul class="redes-sociales">
      	<li><!--<a target="_blank" href="http://twitter.com/share?url=http%3A%2F%2Fwww.camarco.org.ar%2FCursos%2F<=Model.Resource.Slug %>&text=<=Model.Titulo.Replace(" ","%20") %>" class="twitter" title="Twittear">TWITTEAR</a>--></li>
        <li><a href="http://www.linkedin.com/shareArticle?mini=true&url=http://www.camarco.org.ar/Cursos/<=Model.Resource.Slug %>&title=<=Model.Titulo %>&summary=<=Model.Copete %>&source=www.camarco.org.ar" target="_blank" class="linkedin" title="Compartir en LinkedIn">COMPARTIR</a></li>
        <li><a target="_blank" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;p[url]=http://camarco.org.ar/Cursos/<%=Model.CampaignID %>&p[images][0]=http://www.camarco.org.ar/Content/CSS/Front/imagenes/header-camara-argentina-construccion-logo.png" class="facebook" title="Me gusta">ME GUSTA</a></li>
      </ul>
      <!-- FIN REDES SOCIALES -->
      <div class="separador"></div>
      <div class="curso">
			    <div class="img">
                    <% 
                string Imagen = Model.urlImagen;
                if (Model.ImagenID > 0)
                    Imagen = "/File/GetFile?id=" + Model.ImagenID;    
                    %>
				    <span><%=Model.CronogramaInicio.ToString("MMMM yyyy")%></span>
				    <img src="<%=Imagen %>" width="142" height="115" alt="<%=Model.Titulo %>" title="<%=Model.Titulo %>">
			    </div>
                <div class="data">
      <!-- CURSO: Demostración o Entrenamiento -->
        <% 
            string tipoEvento = Model.TipoEvento;
            if (tipoEvento == "Entrenamiento" || tipoEvento == "Demostración")
           { %>
		    
                    <h1>CURSO</h1>
            	    <h1><%=Html.Encode(Model.Titulo)%></h1>
                    <p><%=Html.Encode(Model.Copete)%></p>
                    <ul class="informacion-adicional">
              	    <li><strong>Docentes:</strong> <%=Html.Encode(Model.Docentes)%></li>
                    <li><strong>Modalidad:</strong> <%=Html.Encode(Model.Modalidad)%></li>
                    <li><strong>Dirigido a:</strong> <%=Html.Encode(Model.DirigidoA)%></li>
                    <li><strong>Actualmente disponible en:</strong> <%=Html.Encode(Model.DisponibleEn) %></li>
                  </ul>
                    <%if (Model.Arancel != 0) { %>
                    <div class="aranceles">
               	      <h3>ARANCELES</h3>
                        <ul>
                    	    <li><strong>SOCIOS Presencial</strong><span><%=Model.CostoSocioBsAs.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>SOCIOS Videoconferencia</strong><span><%=Model.CostoSocioInterior.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>NO SOCIOS</strong><span><%=Model.CostoNoSocio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                        </ul>
                        <ul>
                            <li><strong>Colegio Profesional</strong><span><%=Model.CostoColegio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>Estudiante Universitario</strong><span><%=Model.CostoEstudiante.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                        </ul>
                        <%if(DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True") {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionCursoPago" onclick="javascript:Inscripcion('btnInscripcionCursoPago')">INSCRIBIRME</a>
                        <%} %>
                        <span class="medios-pago tooltip">Formas de pago<div class="tooltip-text"><h4>FORMAS DE PAGO DISPONIBLES</h4><p>- Dineromail (tarjetas de crédito, Pagofácil, Rapipago, etc.)</p><p>- Transferencia bancaria</p><p>- Cheque</p></div></span>
                  </div>
                  <%} %>
                  <% else { %>
                    <p><strong>Actividad gratuita, que requiere inscripción previa</strong></p>
                    <%if (DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True")
                      {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionCursoGratis" onclick="javascript:Inscripcion('btnInscripcionCursoGratis')">INSCRIBIRME</a>
                    <%} %>
                  <%} %>
		  
         <%}
            else if (tipoEvento == "Conferencia")
            { %>
                    <h1>CONFERENCIA</h1>
            	    <h1><%=Html.Encode(Model.Titulo)%></h1>
                    <p><%=Html.Encode(Model.Copete)%></p>
                    <ul class="informacion-adicional">
              	    <li><strong>Expositor:</strong> <%=Html.Encode(Model.Docentes)%></li>
                    <li><strong>Modalidad:</strong> <%=Html.Encode(Model.Modalidad)%></li>
                    <li><strong>Dirigido a:</strong> <%=Html.Encode(Model.DirigidoA)%></li>
                    <li><strong>Actualmente disponible en:</strong> <%=Html.Encode(Model.DisponibleEn)%></li>
                  </ul>
                    <%if (Model.Arancel != 0)
                      { %>
                    <div class="aranceles">
               	      <h3>ARANCELES</h3>
                        <ul>
                    	    <li><strong>SOCIOS Presencial</strong><span><%=Model.CostoSocioBsAs.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>SOCIOS Videoconferencia</strong><span><%=Model.CostoSocioInterior.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>NO SOCIOS</strong><span><%=Model.CostoNoSocio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>Colegio Profesional</strong><span><%=Model.CostoColegio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>Estudiante Universitario</strong><span><%=Model.CostoEstudiante.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                        </ul>
                        <%if (DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True")
                          {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionConferenciaPago" onclick="javascript:Inscripcion('btnInscripcionConferenciaPago')">INSCRIBIRME</a>
                        <%}%>
                        <span class="medios-pago tooltip">Formas de pago<div class="tooltip-text"><h4>FORMAS DE PAGO DISPONIBLES</h4><p>- Dineromail (tarjetas de crédito, Pagofácil, Rapipago, etc.)</p><p>- Transferencia bancaria</p><p>- Cheque</p></div></span>
                  </div>
                  <%} %>
                  <% else
{ %>
                    <p><strong>Actividad gratuita, que requiere inscripción previa</strong></p>
                    <%if (DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True")
                      {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionConferenciaGratis" onclick="javascript:Inscripcion('btnInscripcionConferenciaGratis')">INSCRIBIRME</a>
                    <%}%>
                  <%}
            }
            else if (tipoEvento == "WebCast")
            { %>
		    
                    <h1>PLATAFORMA ONLINE</h1>
            	    <h1><%=Html.Encode(Model.Titulo)%></h1>
                    <p><%=Html.Encode(Model.Copete)%></p>
                    <ul class="informacion-adicional">
              	    <li><strong>Expositor:</strong> <%=Html.Encode(Model.Docentes)%></li>
                    <li><strong>Modalidad:</strong> <%=Html.Encode(Model.Modalidad)%></li>
                    <li><strong>Dirigido a:</strong> <%=Html.Encode(Model.DirigidoA)%></li>
                    <!--<li><strong>Actualmente disponible en:</strong> <=Html.Encode(Model.DisponibleEn)%></li>-->
                  </ul>
                    <%if (Model.Arancel != 0)
                      { %>
                    <div class="aranceles">
               	      <h3>ARANCELES</h3>
                        <ul>
                    	    <li><strong>SOCIOS BUENOS AIRES</strong><span><%=Model.CostoSocioBsAs.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <!--<li><strong>SOCIOS Videoconferencia</strong><span><=Model.CostoSocioInterior.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>-->
                            <li><strong>NO SOCIOS</strong><span><%=Model.CostoNoSocio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <!--<li><strong>Colegio Profesional</strong><span><=Model.CostoColegio.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>
                            <li><strong>Estudiante Universitario</strong><span><=Model.CostoEstudiante.ToString("#####", new System.Globalization.CultureInfo("es-AR"))%></span></li>-->
                        </ul>
                        
                        <%if (DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True")
                          {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionWebCastPago" onclick="javascript:Inscripcion('btnInscripcionWebCastPago')">INSCRIBIRME</a>
                        <%} %>
                        <span class="medios-pago tooltip">Formas de pago<div class="tooltip-text"><h4>FORMAS DE PAGO DISPONIBLES</h4><p>- Dineromail (tarjetas de crédito, Pagofácil, Rapipago, etc.)</p><p>- Transferencia bancaria</p><p>- Cheque</p></div></span>
                  </div>
                  <p><strong>Descargue las instrucciones para asistir a la actividad online <a target="_blank" href="/Content/INDICACIONES PARA LAS CONFERENCIAS y CURSOS ONLINE.pdf" >aquí</a></strong></p>
                  <%} %>
                  <% else
{ %>
                    <p><strong>Actividad gratuita, que requiere inscripción previa</strong></p>
                    <p><strong>Descargue las instrucciones para asistir a la actividad online <a target="_blank" href="/Content/INDICACIONES PARA LAS CONFERENCIAS y CURSOS ONLINE.pdf" >aquí</a></strong></p>
                    <%if (DateTime.Today < Model.CronogramaInicio.AddDays(1) && Model.PermiteInscripcion == "True")
                      {  %><a href="javascript:void()" class="system-color-btn" id="btnInscripcionWebCastGratis" onclick="javascript:Inscripcion('btnInscripcionWebCastGratis')">INSCRIBIRME</a>
                    <%} %>
                  <%} 
                  }
            else { } %>
            <br />
                    <br />
                       <%Html.RenderPartial("~/Views/Shared/HolaLogo.ascx");
                          
                         %>                 
                                                
       
                <div class="aranceles consultas-form" id="divInscripcion" style="display:none">
                     <p>Para continuar con la inscripción, ingrese D.N.I. del participante.</p>
                        <h3>Documento Nacional de Identidad</h3>
                            <form action="/Inscripcion" method="post">
                                <input type="hidden" id="campaignId" name="campaignId" value="<%=Model.CampaignID%>" />
                                <input id="inscripcionDNI" name="inscripcionDNI" onkeypress="return justNumbers(event)" type="text" placeholder="Ingrese su D.N.I. para continuar con la inscripción al curso *" class="halfWidth" style="width:100%" />
                                <input id="btnSubmit" type="submit" class="system-color-btn" value="IR A INSCRIPCION" />
                            </form>
                  </div>
			    <!-- MODULO CONSULTAS -->
                <div class="consultas-form" id="divConsulta">
                    <h3>CONSULTAR SOBRE EL CURSO</h3>
                    <form>
                        <input id="contactoNA" type="text" placeholder="Nombre y apellido *" class="halfWidth"/>
                        <input id="contactoEM" type="text" placeholder="Correo electrónico *" class="halfWidth"/><br />
                        <textarea id="contactoM" cols="" rows="" placeholder="Escriba aquí su consulta"></textarea>
                        <ul class="search-filters">
                            <li><input id="contactoSub" type="checkbox" name="checkbox" value="1"/><label for="contactoSub">Deseo suscribirme al newsletter de CAPACITACI&Oacute;N</label></li>
                        </ul>
                        <a href="#" id="btnEnviar" class="system-btn">ENVIAR
                        <div class="tooltip-text" id="envioOk"><h4>ENVÍO REALIZADO CON ÉXITO</h4><p>Nos pondremos en contacto con usted en breve a través de la dirección de correo electrónico provista.</div></a>
                    </form>
                </div>
            <!-- FIN MODULO CONSULTAS -->
        </div>
		</div>
</div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox color03">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- MODULO CRONOGRAMA -->
        <div class="cronograma">
        	<h3>PROGRAMA</h3>
        	<ul>
                <% 
                    if (Model.TipoEvento == "Entrenamiento" || Model.TipoEvento == "Demostración" || Model.TipoEvento == "WebCast")
                    { 
                %>
        	  <li><strong>Inicio:</strong> <%=Model.CronogramaInicio.ToString("dddd dd \\de MMMM \\de yyyy")%></li>
        	  <li><strong>Fin:</strong> <%=Model.CronogramaFin.ToString("dddd dd \\de MMMM \\de yyyy")%></li>
        	  <li><strong>D&iacute;as:</strong><%=Model.DiasSemanaCantidad %></li>
        	  <li><strong>Horario:</strong> <%=Model.CronogramaStringHorarioInicio%> a <%=Model.CronogramaStringHorarioFin%> hs.</li>
        	  <li><strong>Duraci&oacute;n:</strong> <%=Model.Duracion%></li>
              <%}
                    else
                    {  %>
                    <li><strong>Fecha:</strong> <%=Model.CronogramaInicio.ToString("dddd dd \\de MMMM \\de yyyy")%></li>
                    <li><strong>D&iacute;as:</strong> <%=Model.DiasSemanaCantidad %></li>
                    <li><strong>Horario:</strong> <%=Model.CronogramaStringHorarioInicio%> a <%=Model.CronogramaStringHorarioFin%> hs.</li>
                    <%} %>
            </ul>
            <% if (Model.BrochureUrl != null && Model.BrochureUrl.Length > 0)
               {  %>
            <a target="_blank" href="<%=Model.BrochureUrl %>" title="Descargar el programa completo del curso en formato PDF" class="pdf"><span>Descargar programa completo »</span></a>
            <% } %>
        </div>
        <!-- FIN MODULO CRONOGRAMA -->
        <!-- INFORMACIÓN IMPORTANTE -->
        <div class="importante consultas" onclick="PageCore.Ir('/Contacto')">
        	
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
        <% Html.RenderPartial("~/Views/Shared/Banners/BannerSepyme.ascx"); %>
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>


 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptContent" runat="server">
    <script type="text/javascript" src="/Scripts/jqueryJSON.js"></script>
<script type="text/javascript">
    $(document).ready(function ()
    {
        $('.redes-sociales > li > a').on('click',function(e){
           e.preventDefault();
           window.open($(this).attr("href"), 'share', 'width=600, height=400,location=no,status=yes,resizable=yes,scrollbars=no, menubar=yes');
        });
        $('#btnEnviar').on('click', function (e)
        {
            e.preventDefault();
            var pass = true;
            if (PageCore.IsEmpty($('#contactoNA').val()))
            {
                $('#contactoNA').addClass('formError');
                pass = false;
            }
            else
                $('#contactoNA').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoEM').removeClass('formError');
            var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
            if (pass && !filter.test($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else if (pass)
                $('#contactoEM').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoM').val()))
            {
                $('#contactoM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoM').removeClass('formError');
            if (pass)
            {
                dataLayer.push({ 'event': 'formCompleted' });
                $('#btnEnviar').toggleClass("waiting");
                PageCore.AjaxPost('/CursosMail', $.toJSON({ id:<%=Model.CursoID %>,na: $('#contactoNA').val(), em: $('#contactoEM').val(), m: $('#contactoM').val(), s: $('#contactoSub').is(":checked")
                }), function ()
                {
                    $('#btnEnviar').toggleClass("waiting");
                    $('#envioOk').show();
                    $('#contactoNA').val('');
                    $('#contactoEM').val('');
                    $('#contactoM').val('');
                    setTimeout(function(){$('#envioOk').hide();},3000);
                });
            }
        });
    });
</script>

</asp:Content>
