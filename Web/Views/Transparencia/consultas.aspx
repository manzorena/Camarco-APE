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
        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %> barra-superior">
            <h1>
                <%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
            <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        </div>

        <img style="width:100%;" class="fullcontent" src="../../Content/CSS/Front/imagenes/banner-calidad.jpg"/>

        <div class="cont_parrafos fullcontent">

        <div class="row">
		<div class="span6">

<h3>Instructivo para consultas y denuncias de nuestro programa de integridad</h3>

<br>

<h3 class="underlined">Consultas</h3>

<h5>¿Qué puedo consultar?</h5>

<p>Todo aquello que se encuentre vinculado con el presente Código de Conducta y
cualquier otra normativa aplicable a la Empresa.</p>

<p>A modo enunciativo, las consultas podrán referirse a:</p>

<ul>
	<li>La posible violación de los principios plasmados en el Código de Conducta, como en cualquier otra ley, regulación o normativa aplicable a Camarco</li>
	<li>Posibles conflictos de intereses</li>
	<li>Situaciones en las que se interactúe con Funcionarios Públicos</li>
	<li>La calificación de determinada información como confidencial y la posibilidad de divulgarla</li>
	<li>La aceptación o entrega de “regalos de cortesía”, etc.</li>
</ul>


<h5>¿Cómo hago una consulta?</h5>

<p>Teniendo en cuenta que el Código de Conducta no puede prever cada situación con la
que pueden llegar a enfrentarse los Empleados, Camarco confía en que cada Empleado
realizará las consultas necesarias para evacuar las dudas que tenga respecto de si dicha
situación se ajusta (o no) a los lineamientos éticos de la Empresa.</p>

<p>Para ello, el Coordinador de Compliance será el encargado de recibir las consultas que
los Empleados de la Empresa realicen ante cualquier duda vinculada con la aplicación
de este Código para Empleados.</p>

<h5>¿Qué ocurre luego de mi consulta?</h5>

<p>El Coordinador de Compliance deberá analizar la consulta realizada y elaborar su
respuesta.</p>

<p>En caso de considerarlo necesario, el Coordinador de Compliance podrá solicitar la
asistencia del responsable del área legal de Camarco, como así también de asesores
externos, para validar sus conclusiones.</p>

<h3 class="underlined">Denuncias</h3>

<h5>¿Qué puedo denunciar?</h5>

<p>Todo aquello que se encuentre vinculado con el presente Código de Conducta y
cualquier otra normativa aplicable a la Empresa.</p>

<p>A modo enunciativo, las denuncias podrán referirse a:</p>

<ul>
	<li>La posible violación de los
	principios plasmados en el Código de Conducta, como en cualquier otra ley, regulación
	o normativa aplicable a Camarco, como por ejemplo, las previsiones contenidas en el
	Código Penal de la Nación o en la Ley de Responsabilidad Penal Empresaria N° 27.401</li>
	<li>Posibles conflictos de intereses</li>
	<li>Situaciones en las que se interactúe inapropiadamente con Funcionarios Públicos</li>
	<li>La realización de prácticas anticompetitivas, etc.</li>
</ul>

<p>La mera sospecha de una violación al presente Código de Conducta como a cualquier
otra normativa aplicable es suficiente para denunciar.</p>

<h5>¿Cómo hago una denuncia?</h5>

<p>Todos los Empleados de la Empresa deben denunciar cualquier violación, o potencial
violación, cometida o sospechada, al Código de Conducta o a la normativa aplicable a
Camarco.</p>

<p>Para ello, deberán ponerse en contacto con su superior jerárquico en forma inmediata —
salvo que este esté alcanzado por la denuncia efectuada— el cual deberá notificar al
Coordinador de Compliance, quien trabajará en esclarecer la cuestión.</p>

<p>Si el empleado no se siente cómodo presentando una denuncia ante su superior
jerárquico, o si este está alcanzado por los hechos denunciados, o si habiendo
denunciado el hecho a su superior no obtuvo una respuesta satisfactoria de parte de éste,
podrá notificar directamente al Coordinador de Compliance de la Empresa. En este
caso, el Coordinador de Compliance evaluará si corresponde o no dar participación al
superior jerárquico del Empleado, siempre considerando como objetivo principal la
efectiva protección de éste último.</p>

<p>Las denuncias también podrán ser presentadas mediante el formulario online en esta página.</p>

<h5>Llamadas telefónicas a la “línea de denuncia”</h5>

<p>Este medio de presentación de denuncias se encuentra habilitado para el uso de los
Empleados de la Empresa, como de terceros, asegurándose en todo momento el
anonimato del denunciante, el cual no deberá indicar su identidad, a menos que prefiera
hacerlo.</p>

<h5>¿Qué ocurre luego de mi denuncia?</h5>

<p>La Empresa se compromete a investigar todas las denuncias de manera rápida y
minuciosa, con la mayor confidencialidad y discreción posible. El Coordinador de
Compliance, quien liderará la investigación, y la Empresa, protegerán la
confidencialidad de conformidad con las leyes aplicables y las necesidades de la
Empresa a fin de investigar el asunto objeto de la denuncia.</p>

<p>Los Empleados de la Empresa deben cooperar en las investigaciones desarrolladas por
el Coordinador de Compliance.</p>

<p>En caso de que en el curso de la investigación sea necesario dar intervención a otro
Empleado, el Coordinador de Compliance notificará a éste último el momento y lugar
en el cual deberán reunirse para conversar sobre el objeto de la denuncia.</p>

<p>Una vez que el Coordinador de Compliance haya obtenido información suficiente sobre
el objeto de la denuncia, notificará al Empleado denunciado a los fines de que brinde su
versión de los hechos bajo análisis y produzca las pruebas que considere pertinentes
para su defensa.</p>

<p>Realizado ello, el Coordinador de Compliance deberá producir un reporte (en adelante,
el “Reporte de Compliance”) en el cual detalle de forma sucinta los extremos de la
denuncia, la defensa del denunciado, la información aportada por otros Empleados o
terceros (en caso de existir) y el curso de acción recomendado.</p>

<p>En caso de que el Coordinador de Compliance llegue a la convicción de que el
Empleado denunciado no violó ninguna de las previsiones contenidas en el presente,
como en cualquier otra norma aplicable a la Empresa, el Reporte de Compliance deberá
recomendar el archivo de la investigación. Ahora bien, si considera que el Empleado
denunciado violó cualquiera de las previsiones contenidas en el presente, como en
cualquier otra norma aplicable a la Empresa, el Reporte de Compliance deberá incluir
recomendaciones en torno a las sanciones a aplicar.</p>

<p>El Coordinador de Compliance deberá remitir el Reporte de Compliance al Directorio
de Camarco, quien deberá validar el curso de acción propuesto, incluyendo cualquier
modificación en caso que sea necesario.</p>

<p>En caso de considerarlo necesario, se podrá solicitar la asistencia de asesores externos
para validar las recomendaciones incluidas en el Reporte de Compliance.</p>

<p>Todos los informes generados en virtud de las denuncias ingresadas por los Empleados
(o por los terceros) serán tratados con la mayor confidencialidad y discreción posible. El
Responsable de Compliance y la Empresa protegerán la confidencialidad de
conformidad con las leyes aplicables y las necesidades de la Empresa a fin de investigar
el asunto objeto de la denuncia. Todo documento o comunicación que se genere como
consecuencia de la denuncia deberá incluir la palabra “CONFIDENCIAL”.</p>

<p>En el caso en el cual el Empleado de la Empresa desee tomar conocimiento del estado
de su denuncia, deberá contactarse con el Coordinador de Compliance a los fines de que
se le brinde la información solicitada. Camarco asegurará que los Empleados de la
Empresa que realicen denuncias puedan realizar el seguimiento de aquellas y conocer
los resultados de su tratamiento si así lo desean. El Coordinador de Compliance sólo
podrá negarse a brindar información si dicho proceder pudiera entorpecer la
investigación.</p>

		</div>
		<div class="span4">

			<div class="well">
				<h4>Medios de contacto para denuncias y consultas:</h4>
                <br />
				<p>Email: transparencia@camarco.com <br />
				Teléfono: <a href="tel:223-4176549">223-4176549</a></p>
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


                }

                function mostrar_consulta() 
                {
                    $('#consulta').show();
                    $('#denuncia').hide();
                    $('#btn_consulta').attr('class', 'btn active');
                    $('#btn_denuncia').attr('class', 'btn');
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

                var reCaptchaCallback = function (response) {
                    if (response !== '') {
                        jQuery('#lblMessage').css('color', 'green').html('Success');
                    }
                };

                function validate(e) {
                    var validacion = true;
                    var message = 'Please check the checkbox';

                    if (typeof (grecaptcha) != 'undefined') 
                    {
                        var response = grecaptcha.getResponse();

                        //validación del captcha
                        if (response.length === 0) {
                            message = 'Captcha verification failed';
                            validacion = false;
                        }
                        else  {
                            message = 'Success!'
                        };

                        
                        //validacion de consulta
                        if ($('#btn_consulta')[0].className == 'btn active')
                        {
                            

                        }
                        //validacion de denuncia
                        else {

                        }

                    }
                    jQuery('#lblMessage').html(message);
                    jQuery('#lblMessage').css('color', (message.toLowerCase() == 'success!') ? "green" : "red");
                };  
  
            </script> 

        <form  class="form form-vertical" id="ContactTransparencyForm" runat="server" enctype="multipart/form-data" method="post" accept-charset="utf-8">

            <div style="display:none;">
            <input type="hidden" name="_method" value="POST">
            </div>

			<input type="hidden" name="data[Contact][selected_form]" value="consulta" id="ContactSelectedForm">
			
            <div id="consulta" class="tab" style="">
				<h4>Inquietud o consulta</h4>
				<div class="control-group"><label for="ContactConsultaMessage" class="control-label">Mensaje (requerido)</label><div class="controls"><textarea name="data[Contact][consulta_message]" class="span4" rows="8" cols="30" id="ContactConsultaMessage"></textarea></div></div>
				<h4>Datos para contacto</h4>

				<p>Ingrese sus datos. Toda la información es opcional y será tratada bajo estricta confidencialidad.</p>

				<div class="control-group"><label for="ContactConsultaFirstName" class="control-label">Nombre</label><div class="controls"><input name="data[Contact][consulta_first_name]" class="span4" type="text" id="ContactConsultaFirstName"></div></div>				<div class="control-group"><label for="ContactConsultaLastName" class="control-label">Apellido</label><div class="controls"><input name="data[Contact][consulta_last_name]" class="span4" type="text" id="ContactConsultaLastName"></div></div>				<div class="control-group"><label for="ContactConsultaNationality" class="control-label">Nacionalidad</label><div class="controls"><input name="data[Contact][consulta_nationality]" class="span4" type="text" id="ContactConsultaNationality"></div></div>				<div class="control-group"><label for="ContactConsultaDni" class="control-label">DNI</label><div class="controls"><input name="data[Contact][consulta_dni]" class="span4" type="text" id="ContactConsultaDni"></div></div>				<div class="control-group"><label for="ContactConsultaEmail" class="control-label">Email</label><div class="controls"><input name="data[Contact][consulta_email]" class="span4" type="email" id="ContactConsultaEmail"></div></div>				<div class="control-group"><label for="ContactConsultaPhone" class="control-label">Teléfono</label><div class="controls"><input name="data[Contact][consulta_phone]" class="span4" type="text" id="ContactConsultaPhone"></div></div>			</div>
			
            
            <div id="denuncia" class="tab" style="display:none;">
				<h4>Denunciado</h4>
				<div class="control-group"><label for="ContactDenunciaArea" class="control-label">Nombre/s y Apellido/s o Área involucrada</label><div class="controls"><input name="data[Contact][denuncia_area]" class="span4" type="text" id="ContactDenunciaArea"></div></div><div class="control-group"><label for="ContactDenunciaOccupation" class="control-label">Cargo u ocupación</label><div class="controls"><input name="data[Contact][denuncia_occupation]" class="span4" type="text" id="ContactDenunciaOccupation"></div></div><div class="control-group"><label for="ContactDenunciaCompany" class="control-label">Empresa</label><div class="controls"><input name="data[Contact][denuncia_company]" class="span4 disabled" disabled="disabled" value="Camarco SA" type="text" id="ContactDenunciaCompany"></div></div><div class="control-group"><label for="ContactDenunciaResumen" class="control-label">Resumen (requerido)</label><div class="controls"><textarea name="data[Contact][denuncia_resumen]" class="span4" rows="8" cols="30" id="ContactDenunciaResumen"></textarea></div></div>	         	<div class="control-group"><label for="ContactDenunciaAttachment" class="control-label">Adjuntar archivo (documentos, cartas, evidencias)</label><div class="controls"><input type="file" name="data[Contact][denuncia_attachment]" class="span4" id="ContactDenunciaAttachment"></div></div>	         	<p class="muted">
	         		Puede subir archivos pdf, xls, xlsx, doc, docx, ppt, pptx, jpg, bmp, avi, mov, gif, ppt, 3gp, zip, rar, txt, mp3, mp4, mpg, mpeg, eml, tar, 7zip, png de hasta 10MB
	         	</p>
	         	<br/>

	         	<h4>Datos del denunciante</h4>	
				<div class="control-group">
                    <label for="ContactDenunciaRelationship" class="control-label">Relación del denunciante con la empresa</label>
                    <div class="controls">
                        <select name="data[Contact][denuncia_relationship]" class="span4" id="ContactDenunciaRelationship">
                            <option value="Cliente">Cliente</option>
                            <option value="Empleado">Empleado</option>
                            <option value="Proveedor">Proveedor</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                </div>
                <div class="control-group"><div class="controls"><label for="ContactDenunciaIsAnonymous" class="checkbox"><input type="hidden" name="data[Contact][denuncia_is_anonymous]" id="ContactDenunciaIsAnonymous_" value="0"><input type="checkbox" name="data[Contact][denuncia_is_anonymous]" value="1" id="ContactDenunciaIsAnonymous"> Desea permanecer anónimo</label></div></div>				<br>
				<div class="anonymous-fields">
				<div class="control-group"><label for="ContactDenunciaNames" class="control-label">Nombre/s y Apellido/s</label><div class="controls"><input name="data[Contact][denuncia_names]" class="span4" type="text" id="ContactDenunciaNames"></div></div><div class="control-group"><label for="ContactDenunciaNationality" class="control-label">Nacionalidad</label><div class="controls"><input name="data[Contact][denuncia_nationality]" class="span4" type="text" id="ContactDenunciaNationality"></div></div><div class="control-group"><label for="ContactDenunciaDni" class="control-label">DNI</label><div class="controls"><input name="data[Contact][denuncia_dni]" class="span4" type="text" id="ContactDenunciaDni"></div></div><div class="control-group"><label for="ContactDenunciaPhone" class="control-label">Teléfono</label><div class="controls"><input name="data[Contact][denuncia_phone]" class="span4" type="text" id="ContactDenunciaPhone"></div></div>				</div>
				<div class="control-group"><label for="ContactDenunciaEmail" class="control-label">Email</label><div class="controls"><input name="data[Contact][denuncia_email]" class="span4" type="email" id="ContactDenunciaEmail"></div></div>			</div>
			<br/>
			<h4>Política de privacidad y confidencialidad</h4>	

			<div class="terms" style="height: 180px; overflow-y: scroll; margin-bottom: 12px; padding: 12px; font-size: 90%; background-color: #f4f4f4;">
				<p>El envío de información personal es de carácter optativo, es decir que Ud. no tiene ninguna obligación de identificarse o identificar a alguna persona denunciada. Si eventualmente lo hiciera, los mismos serán gestionados de conformidad con la legalidad vigente en materia de protección de datos personales.</p>
				<p>En cualquier momento puede ejercer sus derechos de acceso, rectificación, cancelación y oposición en los términos establecidos legalmente.</p>
				<p>De esta manera, no emplearemos la información para ningún motivo que no sea la entrega de la misma a los responsables de nuestra organización de gestión de las denuncias.</p>
				<p>Le informamos que sus datos son tratados confidencialmente y son utilizados exclusivamente de manera interna y para las finalidades indicadas. Por lo tanto, no cedemos ni comunicamos a ningún tercero sus datos, excepto en los casos legalmennte previstos, o que el usuario nos lo autorice expresamente.</p>
			</div>

  			<div class="control-group"><div class="controls"><label for="ContactTosAccepted" class="checkbox"><input type="hidden" name="data[Contact][tos_accepted]" id="ContactTosAccepted_" value="0"><input type="checkbox" name="data[Contact][tos_accepted]" value="1" id="ContactTosAccepted"> Acepto la política de privacidad y confidencialidad</label></div></div>  			<br>

			<div class="control-group">
          		<div class="controls">
	             	
            <div id="ReCaptchContainer"></div>  
            <label id="lblMessage" runat="server" clientidmode="static"></label>  


	          </div>
	        </div>

			<button id="btn_enviar" onclick="validate();" class="btn btn-large btn-success btn" type="submit">Enviar</button>
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


