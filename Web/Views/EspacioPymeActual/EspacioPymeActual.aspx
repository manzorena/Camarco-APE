<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<% 
    int seccionid = Model.SeccionID;
    //List<Camarco.Model.Articulo> Leidas = Camarco.Model.Noticias.GetMasLeidas(seccionid);
    List<Camarco.Model.Articulo> Leidas = Camarco.Model.Noticias.GetMasLeidasSinEventos(seccionid);
    //No traer las que sean eventos (DescripcionCorta != "Evento" p.ej.).
    
    //List<Camarco.Model.Articulo> Recientes = Camarco.Model.Noticias.GetProximos5(seccionid);
    List<Camarco.Model.Articulo> Recientes = Camarco.Model.Noticias.GetUltimos5Eventos(seccionid);
    //Que sean eventos (DescripcionCorta = "Evento" p.ej.). Si se vencen mostrar igual.
    
    List<Camarco.Model.Articulo> Destacadas = Camarco.Model.Noticias.GetDestacados(seccionid);

    foreach (var d in Destacadas)
    {
        d.LoadImagenes();
    }

    Model.LoadDestacados();
    List<Camarco.Model.Articulo> SeccionDestacadosEnArticulos = Camarco.Model.SeccionDestacado.TransformarDesatacadosEnArticulos(Model.Destacados);
    foreach (var d in SeccionDestacadosEnArticulos)
    {
        d.LoadImagenes();
    }
    
    List<Camarco.Model.Articulo> DestacadasConImagen = new List<Camarco.Model.Articulo>();
    foreach (var d in Destacadas)
    {
        var imagen = d.Imagenes.FirstOrDefault();
        if (imagen != null)
        {
            DestacadasConImagen.Add(d);
        }
    }
    foreach (var d in SeccionDestacadosEnArticulos)
    {
        var imagen = d.Imagenes.FirstOrDefault();
        if (imagen != null)
        {
            DestacadasConImagen.Add(d);
        }
    }
    
    var videos = (List<Camarco.Model.VideoYoutubeModel>)ViewData["videos"];
%>



    <div class="wrapper">
    
        <%--Primer Sección Noticias slider--%>
        <div class="todo-ancho">
            <%if (DestacadasConImagen.Count > 0)
              {%>
            <div class="showcase cargando" id="slider" style="height:auto;margin:0;">
            <%
                bool first=true;
                foreach (Camarco.Model.Articulo d in DestacadasConImagen)
                {
                    var imagen = d.Imagenes.FirstOrDefault();
                    string dk;
                    if(d.Resource.Nombre == "ConLink") {
                        dk = d.Resource.Slug;
                    }
                    else if (d.Resource.Nombre == "SinLink")
                    {
                        dk = "#";
                    }
                    else 
                    {
                        dk = "/espacio-pyme/" + d.Resource.Slug; 
                    }
                                          
                    %>
                    <img src="/File/GetFile?id=<%=imagen.File.FileID%>" width="916" height="470" alt="<%=d.Titulo %>" <%=(!first?" style=\"display:none\"":"") %> data-key=<%=dk %>/>
                    <%
                    first = false;
                }
            %>
	            <div class="showcase-data">
                    <h2><%=Html.Encode(DestacadasConImagen[0].Titulo)%></h2>
                    <span></span>                    
                </div>
                <% int margen = 886 - ((DestacadasConImagen.Count - 1) * 31); %> <%--Cálculo para que los navigation se acomoden a la derecha abajo--%>
                <ul class="showcase-navigation" style="position: relative; bottom:35px;left:<%=margen%>px;">
                <%first = true;
                if (DestacadasConImagen.Count > 1)
                {
                    int Orden = 1;
                    foreach (Camarco.Model.Articulo sd in DestacadasConImagen)
                    {
                    %>
                    <li><a href="#" title="<%=Html.Encode(sd.Titulo) %>" <%=(first?"class=\"showcase-navigation-current\"":"") %>><%=Orden++%></a></li><%
                        first = false;
                        
                    }
                }
                %>
                </ul>
            </div>
            <%} %>
        </div>


        <%--Segunda Sección dos partes--%>

        <div class="todo-ancho borde-divisor">

            <%--Izquierda dos partesCaja de herramientas--%>
            <div class="columna-6">

                <%-- Arriba Noticias Pyme --%>
                <div class="caja-herramientas">
                    <h2>NOTICIAS PYME</h2>
                    <%if (Leidas.Count > 0)
                      {%>  
                    <ul>
                        <%foreach (var le in Leidas)
                          {%>
                            <li>
                                <a href="espacio-pyme/<%=(le.Resource.Slug)%>" title="<%=Html.Encode(le.Titulo) %>"> <%=(le.Titulo)%> </a>
                            </li>
                        <%}%>
                    </ul>
                    <%}
                      else 
                      {%> 
                    <p style="padding-top: 40px;padding-top: 40px;text-align:center;">No hay noticias recientes</p>   
                      <%}%>
                </div>

                <%-- Abajo Caja Herramientas --%>
                <div class="caja-herramientas">
                    <h2>CAJA DE HERRAMIENTAS</h2>
                    <ul>
                        <li><a>Gestión Ambiental en las Obras.</a></li>
                        <li><a>Condiciones y medio ambiente en el trabajo.</a></li>
                        <li><a>Cómputo y Presupuesto</a></li>
                        <li><a>Planificación y Control</a></li>
                        <li><a>Habilidades para la Dirección</a></li>
                    </ul>
                </div>

            </div>

            <%--Derecha Tutoriales--%>
            <div class="columna-6 tutoriales">
                <h2>Videos #EspacioPyme</h2>
                <ul> 
                    <%
                        if (videos.Count > 1)
                        {
                            for (int i = 0; i < 2; i++)
                            { %>
                        <li>
                            <a href="<%=(videos[i].UrlVideo)%>" target="_blank">
                                <div>
                                    <img src="<%=(videos[i].UrlImagen)%>" alt="<%=(videos[i].Titulo)%>" class="video-imagen"/>
                                </div>
                                <div class="video-informacion">
                                    <%=(videos[i].Titulo)%>
                                    <p class="video-descripcion"><%=(videos[i].Descripcion)%></p>
                                </div>
                            </a>
                        </li>
                    <% }
                        }
                        else
                        { %>
                           <li>No hay videos</li> 
                        <% }
                        %>
                </ul>
            </div>

        </div>

        <%--Tercer Sección dos partes--%>
        <div class="todo-ancho borde-divisor">
    
            <%--Izquierda dos partes--%>
            <div class="columna-6">
            
                <%-- Arriba Agenda --%>
                 <div class="caja-herramientas">
                    <h3>AGENDA</h3>
                    <%if (Recientes.Count > 0)
                      {%>
                    <ul>
                        <%foreach (var re in Recientes)
                          {%>
                            <li>
                                <a href="espacio-pyme/<%=(re.Resource.Slug)%>" title="<%=Html.Encode(re.Titulo) %>"> <span><%=(re.FechaPublicacion.Day)%> - <%=(re.FechaPublicacion.Month)%> </span> <%=(re.Titulo)%> </a>
                            </li>
                        <%}%>
                    </ul>
                    <%}
                      else
                      {%>
                     <p>No hay eventos próximos programados</p>
                      <%} %>
                </div>

                <%-- Abajo Envio mails --%>
                <div class="mas-informacion">
                    <h3>MÁS INFORMACIÓN</h3>
                    <form id="myForm">
                        <div class="mas-informacion-item">
                            <span> <input type="radio" name="mail" checked="checked" value="mailto:capacitacion@camarco.org.ar?subject=Quiero recibir el calendario de cursos"/> Recibir el calendario de cursos </span> <br />
                        </div>
                        <div class="mas-informacion-item">
                            <span> <input type="radio" name="mail" value="mailto:espaciopyme@camarco.com.ar?subject=Consulta Pyme"/> Realizar una consulta </span> <br />
                        </div>
                        <div class="mas-informacion-item">
                            <span> <input type="radio" name="mail" value="subscripcion"/> Suscripción al Newsletter </span> <br />
                        </div>
                        <div class="mas-informacion-item">
                            <a id="myEmail" href="mailto:capacitacion@camarco.org.ar?subject=Quiero recibir el calendario de cursos">ENVIAR</a>
                        </div>
                    </form>
                </div>

                <br />

                <div id="subscripcion" class="newsletter-form1 importante" style="display:none;     border-top: 7px solid #c00000; background: #ee3636 !important;">
    	            <h3>SUSCR&Iacute;BASE AL NEWSLETTER</h3>
                    <form>
        	            <input id="contactoN" type="text" placeholder="Nombre *">
                        <input id="contactoA" type="text" placeholder="Apellido *">
                        <input id="contactoEM" type="text" placeholder="Correo electrónico *">
                        <a href="#" id="contactoEnviar" class="system-btn" style="background-color: red; border: 1px solid black;">
                            SUSCRIBIRME
                            <div id="newsTooltip" class="tooltip-text">
                                <p><span id="newsTooltipText"></span></p>
                            </div>
                        </a>
                    </form>
                </div>

                <div class="popup small" id="listoSubs" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;">
	                <h2>&iexcl;LISTO!</h2>
	                <p>Se ha suscripto correctamente a nuestro sistema de newsletter, &iexcl;Espere noticias nuestras pronto!</p>
	                <a href="#" class="close-btn" onclick="SubscriptionClose()"></a>
	                <form>
		                <div class="btns"><a href="#" class="btn" onclick="SubscriptionClose()">VOLVER AL SITIO</a></div>
	                </form>
                </div>

            </div>

            <%--Derecha Tweets--%>
            <div  class="columna-6">
                <div class="tweets">

                    <%--Determino la altura de los tweets dependiendo de la cantidad de eventos que hay en agenda--%>
                    <%double altura = 200;
                      if (Recientes.Count > 0)
                      {
                          altura = (200 + (30 * (Recientes.Count)));
                      }
                      else 
                      {
                          altura = 240;
                      }%>  

                    <h3>TWEETS por <a href="https://twitter.com/CamarcoArg?ref_src=twsrc%5Etfw">@CamarcoArg</a></h3>
                    <a class="twitter-timeline" data-height="<%=altura%>px" href="https://twitter.com/CamarcoArg?ref_src=twsrc%5Etfw" data-chrome="noheader noborders nofooter noscrollbar transparent"></a>
                </div>
            </div>

        </div>

        <%--Cuarta Sección Botones--%>
        <div class="todo-ancho">
            <div class="esp-pyme-botones">
                <a href="mailto:espaciopyme@camarco.com.ar?subject=Contacto Espacio Pyme" class="esp-pyme-boton1"></a>
            </div>
            <div class="esp-pyme-botones">
                <a id="descargar-app-boton" class="esp-pyme-boton2"></a>
            </div>
            <div class="esp-pyme-botones">
                <a href="http://biblioteca.camarco.org.ar" class="esp-pyme-boton3"></a>
            </div>
            <div class="esp-pyme-botones">
                <a href="escuela-de-gestion" class="esp-pyme-boton4"></a>
            </div>
        </div>

        <div class="popup small popup-movil" id="android-ios" style="display:none;z-index:100;position:fixed;top:200px;left:50%;margin-left:-150px;">
            <ul>
                <li>
                    <a id="android" href="https://play.google.com/store/apps/details?id=com.camarco.indicadores&hl=es" target="_blank"><img src="../Content/CSS/Front/Imagenes/PlayStore.png"/></a>
                </li>
                <li>
                    <a id="ios" href="https://itunes.apple.com/ar/app/indicadores-camarco/id1234318868?mt=8" target="_blank"><img src="../Content/CSS/Front/Imagenes/AppStore.jpg"/></a>
                </li>
            </ul>
	        <form>
		        <div id="boton-cerrar" class="btns cerrar-app">
                    <p class="btn" style="display: inherit;background-color: black;cursor:pointer;">CERRAR</p>
                </div>
	        </form>
        </div>


    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>



<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript" src="/Scripts/slider.js"></script>

<script type="text/javascript">
    $('input[name=radioName]:checked', '#myForm').val();

    $('#myForm input').on('change', function () {
        alert($('input[name=mail]:checked', '#myForm').val());
    });
</script>

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<script type="text/javascript">
    $(function () {
        $('input[type="radio"]').click(function () {
            if ($(this).is(':checked')) {
                if ($(this).val() == "subscripcion") {
                    $('#subscripcion').show();
                    $("#myEmail").addClass("disable-link");
                }
                else {
                    $('#subscripcion').hide();
                    $("#myEmail").removeClass("disable-link");
                }
                var nuevo = $(this).val();
                $("#myEmail").attr('href', nuevo);
            }
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $('#descargar-app-boton').click(function () {
            $("#android-ios").show();
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $('#android').click(function () {
            $("#android-ios").hide();
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $('#ios').click(function () {
            $("#android-ios").hide();
        });
    });
</script>

<script type="text/javascript">
    $(function () {
        $('#boton-cerrar').click(function () {
            $("#android-ios").hide();
        });
    });
</script>

<script type="text/javascript">
    function SubscriptionClose(){
        $('#listoSubs').hide();
        $('#contactoN').val('');
        $('#contactoA').val('');
        $('#contactoEM').val('');
        PageCore.CloseLightBox();
    }
    $(document).ready(function ()
    {
        new Slider($('#slider'), false);
        $('#contactoEnviar').on('click', function (event)
        {
            
            <%if (Session["Subscripto_Institucional"] != null && (bool)Session["Subscripto_Institucional"] == false)
            {  %>
            $('#newsTooltipText').text("Su email ya se encuentra registrado. Si no está recibiendo nuestros envíos por favor revise en su correo basura y agregue la siguiente dirección contacto@camarco.org.ar en la libreta de direcciones de su correo para que los próximos envíos lleguen correctamente");
            $('#newsTooltip').show();
            setTimeout(3000, function ()
            {
                $('#newsTooltip').hide();
            });
            return;
            <%} %>
            var pass=true;
            event.preventDefault();
            if (PageCore.IsEmpty($('#contactoN').val()))
            {
                $('#contactoN').addClass('formError');
                pass = false;
            }
            else
                $('#contactoN').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoA').val()))
            {
                $('#contactoA').addClass('formError');
                pass = false;
            }
            else
                $('#contactoA').removeClass('formError');
            if (PageCore.IsEmpty($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else
                $('#contactoEM').removeClass('formError');
            var filter = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/igm
            //var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
            if (pass && !filter.test($('#contactoEM').val()))
            {
                $('#contactoEM').addClass('formError');
                pass = false;
            }
            else if (pass)
                $('#contactoEM').removeClass('formError');
            if (!pass)return false;
            $('#contactoEnviar').toggleClass("waiting");
            PageCore.AjaxPost('/Newsletter', $.toJSON({ t: 'institucional', n: $('#contactoN').val(), em: $('#contactoEM').val(), a: $('#contactoA').val() }), function ()
            {
                $('#contactoEnviar').toggleClass("waiting");
                $('#listoSubs').show();
                PageCore.ShowLightBox($('#listoSubs'));
            });
        });
        $('#capacitacionSearch').on('keydown', function (event)
        {
            if (event.which == 13)
            {
                event.preventDefault();
                if ($(this).val().split(' ').join('').length > 0)
                {
                    if ($(this).val().split(' ').join('').length < 5)
                    {
                        alert("Ingrese al menos 4 letras para la búsqueda.");
                        return false;
                    }
                    window.location = '/buscar-capacitacion/' + $(this).val() + '/1/1';
                }
            }
        });
        $('#capacitacionSearchBtn').on('click', function (event)
        {
            if ($('#capacitacionSearch').val().split(' ').join('').length > 0)
            {
                if ($('#capacitacionSearch').val().split(' ').join('').length < 5)
                {
                    alert("Ingrese al menos 4 letras para la búsqueda.");
                    return false;
                }
                window.location = '/buscar-capacitacion/' + $('#capacitacionSearch').val() + '/1/1';
            }
        });
    });
</script>



</asp:Content>
