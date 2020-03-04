<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Transparencia
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Content/CSS/Front/css/Transparencia_styles.css" rel="stylesheet"
        type="text/css" />
    <link href="../../Content/CSS/Front/css/camarco-screen.css" rel="stylesheet" type="text/css" />
    <div class="wrapper">
        <div class="content busqueda <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %> barra-superior">
            <h1>
                <%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
            <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        </div>

        <img style="width: 100%; margin-bottom: 17px;" class="fullcontent" src="" />
        <!--../../Content/CSS/Front/imagenes/banner-calidad.jpg-->
        <div class="cont_parrafos content" style="margin-left: 60px;">
            <div class="span6">
                <h3 class="underlined">
                    Adhesión al programa de integridad</h3>
                <p>
                    Es fundamental que la Empresa Asociada, su representante, Directivo, Delegación o Empleado de la Cámara, 
                    compartan nuestro compromiso por hacer negocios  con integridad y de allí que deban adherir al contenido de nuestro Código de Ética.</p>
                <br>
                <h4>
                    Cómo adherirse</h4>
                <ol>
                    <li>Asegúrese de haber leído, comprendido y estar de acuerdo con nuestro Código de Ética.  
                        Puede consultarlo en la sección: <a href="/transparencia/programa-de-integridad">Programa de integridad</a> </li>
                    <li>Descargar la nota de adhesión:
                        <br/>

                        <a class="btn btn-success" style="margin-top: 9px; display: inline-block;" href="<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionDocumentos[0].ResourceURL%>">
                            Descargar nota de adhesión al programa</a> </li>
                    <li>Imprima y firme la nota, adjunte copia escaneada en el siguiente formulario:</li>
                </ol>
                <h5>
                    Formulario de adhesión al programa de integridad</h5>
                <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit"
                    async defer></script>
                <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
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

                        if (typeof (grecaptcha) != 'undefined') {
                            var response = grecaptcha.getResponse();
                        }

                        if (response.length === 0) {
                            validacion = false;
                            jQuery('#lblMessage').css('color', 'red').html('Debe completar el captcha');
                        }


                        if ($('#ContactAttachment')[0].value) 
                        {
                            $('#ContactAttachment')[0].style.borderColor = "black" 
                        }

                        else {
                            validacion = false;
                            jQuery('#lblMessage').css('color', 'red').html('adjuntar nota de adhesión es obligatoria');
                        }


                        if (validacion == true) {
                            jQuery('#lblMessage').css('color', 'green').html('CUMPLE TODAS LAS CONDICIONES');
                        }

                        return validacion;

                    };  
  
                </script>



                <form action="/transparencia/adhesion" onsubmit="return validate();" runat="server" class="form form-vertical" id="ContactAdherenceForm" enctype="multipart/form-data" method="POST" accept-charset="utf-8">
                <div style="display: none;">
                    <input type="hidden" name="_method" value="POST"></div>

                <div class="control-group">
                    <label for="ContactNames" class="control-label">Nombre/s y Apellido/s</label>
                    <div class="controls">
                        <input name="adhesion_name" class="span4" type="text" id="ContactNames" required="required">
                    </div>
                </div>

                <div class="control-group">
                    <label for="ContactCompany" class="control-label">Empresa</label>
                    <div class="controls">
                        <input name="adhesion_empresa" class="span4" maxlength="200" type="text" id="ContactCompany" required="required">
                    </div>
                </div>

                <div class="control-group">
                    <label for="ContactOccupation" class="control-label">Cargo</label>
                    <div class="controls">
                           <input name="adhesion_cargo" class="span4" type="text" id="ContactOccupation" required="required"/>
                    </div>
                </div>

                <div class="control-group">
                    <label for="ContactAttachment" class="control-label">Adjuntar nota de adhesión</label>
                    <div class="controls">
                            <input type="file" name="file" class="span4" id="ContactAttachment">
                    </div>
                </div>
                <span id="file_alert" class="span4" style="color:Red; display: none ;">El archivo no debe superar los 10 MB</span>
                <p class="muted">
                    Puede subir archivos pdf, jpg, jpeg, o png de hasta 10MB
                </p>
                <br/>

                <script>

                    $('#ContactAttachment').bind('change', function () {

                            //this.files[0].size gets the size of your file.
                            if (this.files[0].size >= 10250938) {
                                $('#file_alert')[0].style.display = "block";
                                $('#ContactAttachment')[0].value = "";

                            }
                            else 
                            {
                                $('#file_alert')[0].style.display = "none";
                            }


                    });
                
                </script>


                <div class="control-group">
                    <div class="controls">
                        <div id="ReCaptchContainer">
                        </div>
                        <label id="lblMessage" runat="server" clientidmode="static">
                        </label>
                    </div>
                </div>
                <input id="btn_enviar" class="btn btn-large btn-success btn" value="Enviar" type="submit" />
                </form>




                <hr>
                <h4>
                    Ver también</h4>
                <h5>
                    Programa de integridad</h5>
                <p>
                    Incluye el código de conducta, el plan de capacitación e información sobre nuestro
                    <em>Comité de compliance</em>.</p>
                <p>
                    <a href="/transparencia/programa-de-integridad">Ir al programa de integridad</a>
                </p>
                <br>
                <h5>
                    Consultas y denuncias</h5>
                <p>
                    Acceda al instructivo para consultas y denuncias de nuestro programa de integridad
                    y los distintos medios de contacto para denuncias y consultas —incluyendo el formulario
                    para denuncias.</p>
                <p>
                    <a href="/transparencia/consultas">Ir a consultas y denuncias</a></p>
                <br>
                <br>
            </div>
        </div>
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
