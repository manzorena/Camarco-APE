<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
        
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Transparencia
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/CSS/Front/css/Transparencia_styles.css" rel="stylesheet" type="text/css"/>
<link href="../../Content/CSS/Front/css/camarco-screen.css" rel="stylesheet" type="text/css"/>

    <div class="wrapper">

      <img style="width:100%;" class="fullcontent" src=""/>
      <!--../../Content/CSS/Front/imagenes/banner-calidad.jpg-->

        <div class="cont_parrafos fullcontent">

        <div class="row">
		<div class="span6">

<h3>Instructivo para consultas y denuncias de nuestro programa de integridad</h3>

<br>

<h3 class="underlined">Consultas y Denuncias</h3>

<h5>Canal de Consultas Éticas</h5>

<p>La Cámara ha establecido un canal de consultas y denuncias sobre temas de Ética y Transparencia, cuyo propósito es permitir a las Empresas Asociadas, sus representantes, los Directivos, Delegaciones, Empleados de la Cámara y terceros relacionados, resolver dudas de interpretación y comunicar posibles incumplimientos al Código. </p>

<p>A tal fin se ha instalado en la web de la entidad: <a href="www.camarco.org.ar/Transparencia">www.camarco.org.ar/Transparencia</a> un formulario de Consultas y Denuncias, que resulta absolutamente confidencial. Asimismo, durante el horario habitual de funcionamiento de la Cámara se podrán efectuar comunicaciones personales al teléfono: 011 4361-8778 o vía mail a la Ingeniera Cecilia Cavedo, Coordinadora del área, a <a style="">consultasydenuncias@camarco.org.ar</a></p>
<br />
<h5>¿Cómo reportar?</h5>

<p>El reporte debe ser formulado de manera clara, brindando todos los datos que estén dentro de su conocimiento y que sean relevantes para el caso, así como la indicación de otras personas o instituciones que pudieran contar con datos de interés para el análisis de la cuestión.
Por ejemplo: los datos de los posibles infractores, fecha y lugar del hecho reportado, otras personas, empresas u organismos que puedan tener vinculación o relación con las circunstancias reportadas.
</p>

<p>En caso de que el reporte no sea anónimo, deberán incluirse datos que permitan contactar al denunciante (tales como nombre y apellido, correo electrónico y número de teléfono), en la medida en que sea necesario ampliar información o efectuar consultas con respecto a alguna circunstancia o documento del caso.</p>
<br />
<h5>Tratamiento de las Consultas</h5>

<p>Según el tenor y alcance de la presentación recibida, la Institución, a través de su Coordinador del área, responderá las consultas recibidas, procurando aclarar si el hecho planteado resulta potencialmente violatorio de las normas del Código. 
En ese proceso, se informará al presentante sobre las normas aplicables y sobre los derechos y responsabilidades de quien realice la presentación.
</p>

<p>En caso de considerarlo necesario, el Coordinador de Compliance podrá solicitar la
asistencia del responsable del área legal de Camarco, como así también de asesores
externos, para validar sus conclusiones.</p>

<p>La Cámara no investigará cuestiones internas de Empresas Asociadas, limitando su rol a recabar información sobre las estructuras de cumplimiento de cada una de ellas, así como sobre los procedimientos previstos para la indagación de los hechos denunciados.</p>

<p>Si la información se relacionase con alguna Empresa Asociada a la que se le adjudica alguna conducta indebida, la Coordinadora del área con previa comunicación al Consejo Asesor de Integridad, dará intervención formal al Área de Cumplimiento de dicha empresa para su descargo o eventual explicación, siempre en orden a determinar la estructura de funcionamiento de esa área y su capacidad de respuesta oportuna. La finalidad será la de aclarar la situación y/o en su caso, adoptar las medidas disciplinarias correspondientes en el ámbito de las facultades propias de la Cámara.</p>

<p>De tratarse de acciones de Directivos, Delegaciones o representantes de Empresas Asociadas que cumplan funciones en esta institución y que pudieran incumplir las obligaciones que les son atribuidas en el presente Código, la Coordinadora referida dará intervención al Consejo Asesor de Integridad a efectos de que formule recomendaciones al Sr. Presidente de la Cámara y en su caso, ejecute las directivas que imparta el órgano de gobierno de la entidad.</p>

<p>En el supuesto de tratarse de situaciones que involucren a Empleados de la propia organización, tomará intervención directamente la Coordinadora del área, quien a los mismos fines, podrá requerir asesoramiento del Consejo Asesor ya mencionado.</p>

<p>Finalmente, en caso de que el hecho sobre la posible inconducta ética fuera denunciado por una de las Empresa Asociadas y se dirigiera en contra de otra Empresa Asociada - y sin perjuicio de las facultades disciplinarias propias de la Cámara - se deberá aplicar  procedimiento previsto en el art. 9 del Reglamento del Tribunal Arbitral de la institución dictado de conformidad con el art. 20 del Estatuto vigente. Es decir que, la Coordinadora del área con previo conocimiento del Consejo Asesor de Integridad, deberá elevar el caso a consideración del Consejo Ejecutivo quien resolverá en votación por mayoría  de 2/3 de los presentes sobre la constitución del Tribunal Arbitral. En su caso y oportunamente, el Tribunal resolverá la contienda conforme las disposiciones vigentes.</p>


		</div>
		<div class="span4">

			<div class="well">
				<h4>Medios de contacto para denuncias y consultas:</h4>
                <br />
				<p>Email: <a href="mailto:consultasydenuncias@camarco.org.ar">consultasydenuncias@camarco.org.ar</a><br />
				Teléfono: <a>4118-5240</a></p>
			</div>

			<br>

			<h3 class="underlined">Formulario para consultas y denuncias</h3>

			<p>Motivo de su mensaje</p>

		    <div class="btn-group">
				<button id="btn_consulta" class="btn active" data-tab="consulta" onclick="mostrar_consulta();">Plantea inquietud</button>
				<button id="btn_denuncia" class="btn" data-tab="denuncia" onclick="mostrar_denuncia();">Denuncia</button>
			</div>


			<hr>



            <script>

                function mostrar_denuncia() 
                {
                    $('#consulta').hide();
                    $('#denuncia').show();
                    $('#btn_consulta').attr('class', 'btn');
                    $('#btn_denuncia').attr('class', 'btn active');
                    $('#ContactDenunciaResumen').attr('required', true);
                    $('#ContactConsultaMessage').attr('required', false);
                    $('#ContactSelectedForm').attr('value', 'denuncia');


                }

                function mostrar_consulta() 
                {
                    $('#consulta').show();
                    $('#denuncia').hide();
                    $('#btn_consulta').attr('class', 'btn active');
                    $('#btn_denuncia').attr('class', 'btn');
                    $('#ContactDenunciaResumen').attr('required', false);
                    $('#ContactConsultaMessage').attr('required', true);
                    $('#ContactSelectedForm').attr('value', 'consulta');
                }


                function hide_anon() {
                    if ($('#ContactDenunciaIsAnonymous')[0].checked == true) {
                        $('#contenedor_datos_anonimos')[0].style.display = "none"
                        $('#ContactDenunciaIsAnonymous')[0].value = "true";


                        $('#ContactDenunciaNames')[0].value = "";
                        $('#ContactDenunciaNationality')[0].value = "";
                        $('#ContactDenunciaDni')[0].value = "";
                        $('#ContactDenunciaPhone')[0].value = "";

                    }
                    else {
                        $('#contenedor_datos_anonimos')[0].style.display = "block"
                        $('#ContactDenunciaIsAnonymous')[0].value = "false";

                    }


                }

                

                function getBase64(file) {
                    var reader = new FileReader();
                    reader.readAsDataURL(file);
                    reader.onload = function () {
                        debugger;
                        $('#ContactDenunciaAttachment').attr('value' ,reader.result);
                    };
                    reader.onerror = function (error) {
                        console.log('Error: ', error);
                    };
                }
   
            </script>

            <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script> 

            <script  src="https://code.jquery.com/jquery-3.2.1.min.js"></script>  
 
            <script type="text/javascript">
                var your_site_key = '6Lf4fKgUAAAAADIW5b15wHnsuNs6WBHARl_uSW-A';
                var renderRecaptcha = function () {
                    grecaptcha.render('ReCaptchContainer', {
                        'sitekey': your_site_key,
                        'callback': reCaptchaCallback,
                        theme: 'light', //light or dark    
                        type: 'image', // image or audio    
                        size: 'normal'//normal or compact    
                    });
                };

                if (ViewData["Errors"] != null) {
                    alert(ViewData["Errors"])
                }

                var reCaptchaCallback = function (response) {
                    if (response !== '') {
                        jQuery('#lblMessage').css('color', 'green').html('Success');
                    }
                };

                function changeFileInput(e) {
                    var file = document.querySelector('#ContactDenunciaAttachment').files[0];
                    this.getBase64(file);
                }

                function validate(e) {
                    var validacion = true;

                    if (typeof (grecaptcha) != 'undefined')
                    {
                        var response = grecaptcha.getResponse();

                        //validación del captcha
                        if (response.length === 0)
                            {
                                validacion = false;
                                jQuery('#lblMessage').css('color', 'red').html('Debe completar el captcha');
                            }
                            else  
                            {
                                
                            };

                        //validación de politicas
                           if ($('#ContactTosAccepted')[0].checked == true) { $('#lblMessage')[0].style.borderColor = "black" }
                           else {
                               validacion = false
                               jQuery('#lblMessage').css('color', 'red').html('Debe aceptar las politicas de privacidad y confidencialidad antes de continuar');
                               $('#ContactTosAccepted')[0].style.borderColor = "red"
                           } 

                    }
                    return validacion;
                };  
  
            </script> 

        <form action="/transparencia" onsubmit="return validate();" class="form form-vertical" id="ContactTransparencyForm" runat="server" enctype="multipart/form-data" method="POST" accept-charset="utf-8">

            <div style="display:none;">
            <input type="hidden" name="_method" value="POST">
            </div>

			<input style="display: none;" name="selected_form" value="consulta" id="ContactSelectedForm"/>
			
            <div id="consulta" class="tab" style="">

				<h4>Inquietud o consulta</h4>
				<div class="control-group">
                    <label for="ContactConsultaMessage" class="control-label">Mensaje (requerido)</label>
                    <div class="controls"><textarea name="consulta_mensaje" class="span4" rows="8" cols="30" id="ContactConsultaMessage" required></textarea></div>
                </div>
				<h4>Datos para contacto</h4>

				<p>Ingrese sus datos. Toda la información es opcional y será tratada bajo estricta confidencialidad.</p>

				<div class="control-group"><label for="ContactConsultaFirstName" class="control-label">Nombre</label><div class="controls"><input name="consulta_nombre" class="span4" type="text" id="ContactConsultaFirstName"></div></div>				
                <div class="control-group"><label for="ContactConsultaLastName" class="control-label">Apellido</label><div class="controls"><input name="consulta_apellido" class="span4" type="text" id="ContactConsultaLastName"></div></div>				
                <div class="control-group"><label for="ContactConsultaNationality" class="control-label">Nacionalidad</label><div class="controls"><input name="consulta_nacionalidad" class="span4" type="text" id="ContactConsultaNationality"></div></div>				
                <div class="control-group"><label for="ContactConsultaDni" class="control-label">DNI</label><div class="controls"><input name="consulta_dni" class="span4" type="text" id="ContactConsultaDni"></div></div>				
                <div class="control-group"><label for="ContactConsultaEmail" class="control-label">Email</label><div class="controls"><input name="consulta_email" class="span4" type="email" id="ContactConsultaEmail"></div></div>				
                <div class="control-group"><label for="ContactConsultaPhone" class="control-label">Teléfono</label><div class="controls"><input name="consulta_telefono" class="span4" type="text" id="ContactConsultaPhone"></div></div>			
                
            </div>
			
            
            <div id="denuncia" class="tab" style="display:none;">
				<h4>Denunciado</h4>
				<div class="control-group"><label for="ContactDenunciaArea" class="control-label">Nombre/s y Apellido/s o Área involucrada</label><div class="controls"><input name="denuncia_area" class="span4" type="text" id="ContactDenunciaArea"></div></div><div class="control-group"><label for="ContactDenunciaOccupation" class="control-label">Cargo u ocupación</label><div class="controls"><input name="denuncia_ocupacion" class="span4" type="text" id="ContactDenunciaOccupation"></div></div><div class="control-group"><label for="ContactDenunciaCompany" class="control-label">Empresa</label><div class="controls"><input name="denuncia_empresa" class="span4 disabled" disabled="disabled" value="Camarco SA" type="text" id="ContactDenunciaCompany"></div></div><div class="control-group"><label for="ContactDenunciaResumen" class="control-label">Resumen (requerido)</label><div class="controls"><textarea name="denuncia_resumen" class="span4" rows="8" cols="30" id="ContactDenunciaResumen"></textarea></div></div>	         	
                <div class="control-group"><label for="ContactDenunciaAttachment" class="control-label">Adjuntar archivo (documentos, cartas, evidencias)</label><div class="controls">
                <input type="file"  name="file" class="span4" id="ContactDenunciaAttachment" accept=".pdf, .xls, .xlsx, .doc, .docx, .ppt, .pptx, .jpg, .bmp, .avi, .mov, .gif, .ppt, .3gp, .zip, .rar, .txt, .mp3, .mp4, .mpg, .mpeg, .eml, .tar, .7zip, .png"></div></div>
                <span id="file_alert" class="span4" style="color:Red; display: none ;">El archivo no debe superar los 10 MB</span>
                <p class="muted">
	         		Puede subir archivos pdf, xls, xlsx, doc, docx, ppt, pptx, jpg, bmp, avi, mov, gif, ppt, 3gp, zip, rar, txt, mp3, mp4, mpg, mpeg, eml, tar, 7zip, png de hasta 10MB
	         	</p>
	         	<br/>


                <script>

                    $('#ContactDenunciaAttachment').bind('change', function () {

                        //this.files[0].size gets the size of your file.
                        if (this.files[0].size >= 10250938) {
                            $('#file_alert')[0].style.display = "block";
                            $('#ContactDenunciaAttachment')[0].value = "";

                        }
                        else 
                        {
                            $('#file_alert')[0].style.display = "none";
                        }


                    });
                
                </script>


	         	<h4>Datos del denunciante</h4>	
				<div class="control-group">
                    <label for="ContactDenunciaRelationship" class="control-label">Relación del denunciante con la empresa</label>
                    <div class="controls">
                        <select name="denuncia_relacion" class="span4" id="ContactDenunciaRelationship">
                            <option value="Cliente">Cliente</option>
                            <option value="Empleado">Empleado</option>
                            <option value="Proveedor">Proveedor</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                </div>
                <div class="control-group"><div class="controls"><label for="ContactDenunciaIsAnonymous" class="checkbox"><input type="hidden" name="data[Contact][denuncia_is_anonymous]" id="ContactDenunciaIsAnonymous_" value="0"><input type="checkbox" onchange="javascript:hide_anon()" name="denuncia_anonima" value="true" id="ContactDenunciaIsAnonymous"> Desea permanecer anónimo</label></div></div>				<br>
				<div class="anonymous-fields">
                <div id="contenedor_datos_anonimos">
				    <div class="control-group"><label for="ContactDenunciaNames" class="control-label">Nombre/s y Apellido/s</label><div class="controls"><input name="denuncia_nombreyapell" class="span4" type="text" id="ContactDenunciaNames"></div></div><div class="control-group"><label for="ContactDenunciaNationality" class="control-label">Nacionalidad</label><div class="controls"><input name="denuncia_nacionalidad" class="span4" type="text" id="ContactDenunciaNationality"></div></div><div class="control-group"><label for="ContactDenunciaDni" class="control-label">DNI</label><div class="controls"><input name="denuncia_dni" class="span4" type="text" id="ContactDenunciaDni"></div></div><div class="control-group"><label for="ContactDenunciaPhone" class="control-label">Teléfono</label><div class="controls"><input name="denuncia_telefono" class="span4" type="text" id="ContactDenunciaPhone"></div></div>				</div>
				    <div class="control-group"><label for="ContactDenunciaEmail" class="control-label">Email</label><div class="controls"><input name="denuncia_email" class="span4" type="email" id="ContactDenunciaEmail"></div></div>			</div>
			    </div>
            <br/>
			<h4>Política de privacidad y confidencialidad</h4>	

			<div class="terms" style="height: 180px; overflow-y: scroll; margin-bottom: 12px; padding: 12px; font-size: 90%; background-color: #f4f4f4;">
				<p>El envío de información personal es de carácter optativo, es decir que Ud. no tiene ninguna obligación de identificarse o identificar a alguna persona denunciada. Si eventualmente lo hiciera, los mismos serán gestionados de conformidad con la legalidad vigente en materia de protección de datos personales.</p>
				<p>En cualquier momento puede ejercer sus derechos de acceso, rectificación, cancelación y oposición en los términos establecidos legalmente.</p>
				<p>De esta manera, no emplearemos la información para ningún motivo que no sea la entrega de la misma a los responsables de nuestra organización de gestión de las denuncias.</p>
				<p>Le informamos que sus datos son tratados confidencialmente y son utilizados exclusivamente de manera interna y para las finalidades indicadas. Por lo tanto, no cedemos ni comunicamos a ningún tercero sus datos, excepto en los casos legalmennte previstos, o que el usuario nos lo autorice expresamente.</p>
			</div>

  			<div class="control-group"><div class="controls"><label for="ContactTosAccepted" class="checkbox"><input type="hidden" name="data[Contact][tos_accepted]" id="ContactTosAccepted_" value="0"><input type="checkbox" name="privacidad" value="1" id="ContactTosAccepted"> Acepto la política de privacidad y confidencialidad</label></div></div>  			<br>

			<div class="control-group">
          		<div class="controls">
	             	
            <div id="ReCaptchContainer"></div>  
            <label id="lblMessage" runat="server" clientidmode="static"></label>  


	          </div>
	        </div>

			<input id="btn_enviar"  class="btn btn-large btn-success btn" type="submit" value="Enviar"></input>
        </form>
		</div>
	</div>

        </div>

    <hr />

    <h4>Ver también</h4>
    <h5>Programa de integridad</h5>
    <p>Incluye el código de conducta, el plan de capacitación e información sobre nuestro <em>Comité de compliance</em>.</p>
    <p><a href="/transparencia/programa-de-integridad">Ir al programa de integridad</a></p>
    <br>
    <h5>Adhesión al programa</h5>
    <p>Es fundamental que nuestros Socios, Proveedores y Clientes compartan nuestro compromiso por hacer negocios con integridad y de alli que deban adherir al contenido de nuestro Código.</p>
    <p><a href="/transparencia/adhesion-al-programa">Ir a adhesión al programa</a></p>
    <br /><br />


        </div>

<%--    <div id="contenedor">

        <h1 class="titulo">transparencia</h1>
        <ul class="breadcrumb" style="color: #5dc2a5">
            <li ></li>  
            <li class="active">LEYES Y CONVENIOS</li>
        </ul>
        <img class="banner-calidad" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>
    
    </div>--%>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>


