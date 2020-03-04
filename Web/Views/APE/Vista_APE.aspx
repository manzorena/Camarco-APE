<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.Seccion>" %>
<%@ Register Src="~/Views/Shared/ListTematicasApe.ascx" TagPrefix="mvc" TagName="Tematicas" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript" src="/Scripts/bootstrap.js"></script>
<script type="text/javascript" src="/Scripts/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/Scripts/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/Scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="/Scripts/masresultados.js"></script>
<script type="text/javascript">
    var Categorias = {
        list:[<% Html.RenderPartial("~/Views/Shared/JSONCategorias.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>],
        redrawCategorias:function(){
            var html='';
            for(var i=0,len=this.list.length;i<len;i++){
                if(this.list[i]==null || this.list[i].id==null)continue;
                html+='<li><a href="#" onclick="Categorias.filterChange('+this.list[i].id+',-1,\'\',\''+this.list[i].nombre+'\');">'+this.list[i].nombre+'</a></li>';
            }
            $('#dropdownCategorias ul').html(html);
        },
        redrawSubCategorias:function(id){
            var html='';
            
            for(var i=0,len=this.list.length;i<len;i++){
                if(this.list[i]==null || this.list[i].id==null || this.list[i].id!=id)continue;
                for(var j=0,len2=this.list[i].subs.length;j<len2;j++){
                    if(this.list[i].subs[j]==null)continue;
                    html+='<li><a href="#" onclick="Categorias.filterChange(-1,'+this.list[i].subs[j].id+', \'\',\''+this.list[i].nombre+' > '+this.list[i].subs[j].nombre+'\');">'+this.list[i].subs[j].nombre+'</a></li>';
                }    
                break;
            }
            if(html.length>0)$('#divsubs').show();
            else
                $('#divsubs').hide();
            $('#dropdownSubcategorias ul').html('<li><a href="#" onclick="Categorias.filterChange('+id+',-1, \'\',\''+this.list[i].nombre+'\');">Todas</a></li>'+html);
            $('#dropdownSubcategoriasSpan').text('Todas');

        },
        filterChange:function (cat,sub,tag,n){
            if(cat>-1){
                this.redrawSubCategorias(cat);
                if(cat>0)
                    $('#searchText').text('Descargables en '+n+':');
                else
                    $('#searchText').text('');
                $('#dropdownCategoriasSpan').text(n);
                return this.filter(cat,sub);
            }
            if(sub>-1){
                if(sub>0){
                    $('#searchText').text('Descargables en '+n+':');
                    $('#dropdownCategoriasSpan').text(n.substring(0, n.indexOf('>')));
                    $('#dropdownSubcategoriasSpan').text(n.substring(n.indexOf('>')+1));
                }else{
                     $('#searchText').text('Descargables en '+n.substring(0, n.indexOf('>'))+':');
                     $('#dropdownCategoriasSpan').text(n.substring(0, n.indexOf('>')));
                $('#dropdownSubcategoriasSpan').text("Todas");
                     }
                
                return this.filter(cat,sub);
            }
            if(tag.length==''){
                $('#searchText').text('');
            }
            else{
            $('#searchText').text('Descargables en tematica '+n+':');
            $('#dropdownCategoriasSpan').text('Todas');
            $('#dropdownSubcategoriasSpan').text('Todas');
            return this.filterTematica(tag);
            }
        },
        filter:function(cat,sub){
            if(cat==0)cat=-2;
            if(sub==0)sub=-1;
            $('#ulResultados').html('<div class="preloader"></div>');
            $.get("/Search/BibliotecaFilterDocumentos?seccionid=<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID %>&categoria="+cat+"&subcategoria="+sub+"&tag=",function(h){
                $('#ulResultados').html(h);
                MasResultados.Init($('#ulResultados'),10, $('.masresultados'));
                MasResultados.Redraw();;
            });
        },
        filterTematica:function(tem){
            $('#ulResultados').html('<div class="preloader"></div>');
            $.get("/Search/BibliotecaFilterDocumentos?seccionid=<%=((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID %>&categoria=-1&subcategoria=-1&tag="+tem,function(h){
                $('#ulResultados').html(h);
                MasResultados.Init($('#ulResultados'),10, $('.masresultados'));
                MasResultados.Redraw();
            });
        }
    };


    function DropDown(el)
    {
        this.sddwn = el;
        this.initEvents();
    }
    DropDown.prototype = {
        initEvents: function ()
        {
            var obj = this;

            obj.sddwn.on('click', function (event)
            {
                $(this).toggleClass('active');
                event.stopPropagation();
            });
        }
    }
    $(function ()
    {
        MasResultados.Init($('#ulResultados'),10, $('.masresultados'));
        MasResultados.Redraw();
        new DropDown($('#dropdownCategorias'));
        new DropDown($('#dropdownSubcategorias'));
        Categorias.redrawCategorias();
    });

		</script>
<script type="text/javascript">
    var Categorias = {
        list:[<% Html.RenderPartial("~/Views/Shared/JSONCategorias.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>],
        redrawCategorias:function(){
            var html='';
            for(var i=0,len=this.list.length;i<len;i++){
                if(this.list[i]==null || this.list[i].id==null)continue;
                html+='<li><a href="#" onclick="Categorias.filterChange('+this.list[i].id+',-1,\'\',\''+this.list[i].nombre+'\');">'+this.list[i].nombre+'</a></li>';
            }
            $('#dropdownCategorias ul').html(html);
        },
        redrawSubCategorias:function(id){
            var html='';
            
            for(var i=0,len=this.list.length;i<len;i++){
                if(this.list[i]==null || this.list[i].id==null || this.list[i].id!=id)continue;
                for(var j=0,len2=this.list[i].subs.length;j<len2;j++){
                    if(this.list[i].subs[j]==null)continue;
                    html+='<li><a href="#" onclick="Categorias.filterChange(-1,'+this.list[i].subs[j].id+', \'\',\''+this.list[i].nombre+' > '+this.list[i].subs[j].nombre+'\');">'+this.list[i].subs[j].nombre+'</a></li>';
                }    
                break;
            }
            if(html.length>0)$('#divsubs').show();
            else
                $('#divsubs').hide();
            $('#dropdownSubcategorias ul').html('<li><a href="#" onclick="Categorias.filterChange('+id+',-1, \'\',\''+this.list[i].nombre+'\');">Todas</a></li>'+html);
            $('#dropdownSubcategoriasSpan').text('Todas');

        },
        filterChange:function (cat,sub,tag,n){
            if(cat>-1){
                this.redrawSubCategorias(cat);
                if(cat>0)
                    $('#searchText').text('Descargables en '+n+':');
                else
                    $('#searchText').text('');
                $('#dropdownCategoriasSpan').text(n);
                return this.filter(cat,sub);
            }
            if(sub>-1){
                if(sub>0){
                    $('#searchText').text('Descargables en '+n+':');
                    $('#dropdownCategoriasSpan').text(n.substring(0, n.indexOf('>')));
                    $('#dropdownSubcategoriasSpan').text(n.substring(n.indexOf('>')+1));
                }else{
                     $('#searchText').text('Descargables en '+n.substring(0, n.indexOf('>'))+':');
                     $('#dropdownCategoriasSpan').text(n.substring(0, n.indexOf('>')));
                $('#dropdownSubcategoriasSpan').text("Todas");
                     }
                
                return this.filter(cat,sub);
            }
            if(tag.length==''){
                $('#searchText').text('');
            }
            else{
            $('#searchText').text('Descargables en tematica '+n+':');
            $('#dropdownCategoriasSpan').text('Todas');
            $('#dropdownSubcategoriasSpan').text('Todas');
            return this.filterTematica(tag);
            }
        };


		</script>
<%
    
    var videos = (List<Camarco.Model.VideoYoutubeModel>)ViewData["videos"];
     %>

<div class="wrapper">
 <div class="content">      


      
        <div class="content biblioteca color07">
    	<h1>Área de Pensamiento Estratégico</h1>
        <ul class="breadcrumb"><li><a href="/">INICIO</a></li><li class="active">ÁREA DE PENSAMIENTO ESTRATÉGICO</li></ul>
         
        
          
          <div class="showcase cargando" id="slider">
          <% Html.RenderPartial("~/Views/Shared/Showcase.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>

      </div>

     
         <div class="notas" id="logo">
             <span class="separador"></span>
             <h2 class="title" style="color: #905da3; font-family: 'Roboto Condensed', sans-serif;font-size: 26px; line-height: 28px; display: block; text-transform: uppercase;font-weight: normal;">
                Notas</h2>
             <ul>
             <% int seccionActual = ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID;
                if (seccionActual == 86) {
                   foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager1.Capacitacion_List(seccionActual, 1)){
                      switch (r.Type){
                         case Camarco.Model.ResourceType.ARTICULO:Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
              %>
                <li style="border-top-style: dashed; border-top-width: thin; color: Gray">
                <br />
                <div class="sub-data">
				    <div class="archivo-tipo">
                        <h4>NOTA</h4> 
                        // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")
                           %>
                    </div>
					<h3><a style="color: inherit;text-decoration: none;font-family:'Trebuchet MS', Arial, Helvetica, sans-serif;font-size: 18px;color: #565656; font-weight: normal;display: block;text-transform: uppercase;margin-bottom: 5px;display: block;" href="/<%=r.GetPublicUrl(seccionActual) %>"><%=Html.Encode(a.Titulo)%></a></h3>
				    <p style="font-family:'Trebuchet MS', Arial, Helvetica, sans-serif;font-size: 13px;color: #565656;line-height: 17px;margin-bottom: 4px;" class="resultados sub-data"><%=Html.Encode(a.Subtitulo)%> <a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" class="leer-mas"><span>Leer más</span></a></p>
		        </div>
			    <br />
                </li>
                 <%  break;
                        }
                    }
                }
      
                  %>
            </ul>
            
      </div>

     <div class="resultados" id="otrosResultados">
        	<ul >
               <% seccionActual = ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID;
                    if (seccionActual != 86) {
                      foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager1.Capacitacion_List(seccionActual, 1))
                          {
                         switch (r.Type)
                             {
                             case Camarco.Model.ResourceType.ARTICULO:
                                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                %>
                <li>
				    <div class="sub-data">
				      <div class="archivo-tipo">
                         <h4>NOTA</h4> 
                         //<%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%>
                      </div>
					       <h3><a href="/<%=r.GetPublicUrl(seccionActual) %>"><%=Html.Encode(a.Titulo)%></a></h3>
					       <p><%=Html.Encode(a.Subtitulo)%> <a href="/<%=r.GetPublicUrl(seccionActual) %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                     </div>
	           </li>
               <%  break;
                        }
                    }
                }       
            %>
          </ul>
      </div>


        <div class="masresultados"><a style="cursor:pointer" onclick="LoadMore()"></a></div>
        </div>


     
         <div>
           <h3 style="color: #FB7C1B;font-size:18px;font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;">VIDEOS <a href="https://twitter.com/hashtag/camarco" id="hola">#ÁREADEPENSAMIENTOESTRATÉGICO</a></h3>
           
           <ul> 
            <%
            if (videos.Count > 0) {
               for (int i = 0; i < 1; i++){ 
            %>
                        
               <li> <a href="<%=(videos[i].UrlVideo)%>" target="_blank">
               <div>
                   <img src="<%=(videos[i].UrlImagen)%>" alt="<%=(videos[i].Titulo)%>" class="video-imagen"/>
               </div>
               <div class="video-informacion">
                <%=(videos[i].Titulo)%>
                <p class="video-descripcion"><%=(videos[i].Descripcion)%>
                 <%if (videos[i].Descripcion.Length > 39) {%> 
                 ... <% }%> 
                <span class="leer-mas ver-mas-video">Ver más</span>              
                </p>
               </div>
               </a>
               </li>
              <% }
                    }
                else{ %>
                 <li>No hay videos</li> 
                <% }
                %>
         </ul>
                  
            <%--<iframe src="https://www.youtube.com/embed/PVjiKRfKpPI" width="320" height="180" >
            </iframe>
             <p>Este es el video del segmento Área de pensamiento estratégico. 
             </P>
             <P>BREVE DESCRIPCIÓN DEL VIDEO.</p>--%>
     </div>
     <BR />
     <BR />
     <BR />

        <%-- <% Html.RenderPartial("~/Views/Shared/Showcase.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>--%>
   
 <%--    <div id="myCarousel" class="carousel slide">
  
  <div class="carousel-inner">
    <div class="item active">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/bbbbbb/fff&amp;text=1" class="img-responsive"></a></div>
    </div>
    <div class="item">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/CCCCCC&amp;text=2" class="img-responsive"></a></div>
    </div>
    <div class="item">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/eeeeee&amp;text=3" class="img-responsive"></a></div>
    </div>
    <div class="item">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/f4f4f4&amp;text=4" class="img-responsive"></a></div>
    </div>
    <div class="item">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/fcfcfc/333&amp;text=5" class="img-responsive"></a></div>
    </div>
    <div class="item">
      <div class="col-xs-4"><a href="#"><img src="http://placehold.it/500/f477f4/fff&amp;text=6" class="img-responsive"></a></div>
    </div>
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>
    <span class="sr-only"></span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
    <span class="sr-only"></span>
  </a>
</div>--%>
<h2 class="title" style="color: #905da3; font-family: 'Roboto Condensed', sans-serif;font-size: 26px; line-height: 28px; display: block; text-transform: uppercase;font-weight: normal;">
                Estudios en proceso</h2>
<div class="archivos" style="height:480px;width:580px;overflow:auto;border:none solid #905da3;padding:2%">
<ul class="archivos-list" id="ulResultados">
            <% 
              foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.ListBySeccionType3(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID, (int)Camarco.Model.ResourceType.DOCUMENTO, 100))
                {
                    Camarco.Model.Documento d = Camarco.Model.DocumentoManager.GetByResource(r.ResourceID);
                    
	               string url=(r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID));
                   var dire = r.URL;
                    %><li style="display:none">
					    <a href="<%=url %>" title="Descargar PDF" class="pdf-btn"></a>
            		    <div class="archivo-tipo"><h4>DESCARGABLE</h4>
                         // Actualizado <%=d.FechaModificacion.ToString("dd-MM-yyyy")%></div>
					    <h3><a href="<%=url %>" title="Descargar PDF"><%=Html.Encode(d.Titulo) %></a></h3>
					    <p><%=d.Descripcion %></p>
                        <% if (url.Length > 0) {%>
					    <a href="<%=url %>" title="Descargar archivo PDF" class="leer-mas"><span>Descargar PDF</span></a>
                        <%} %>
					    
				    </li><%
                }
            %>
            </ul>
                    <!-- PAGINADO -->
        <div class="masresultados"><a style="cursor:pointer;" onclick="MasResultados.Mas()">ver m&aacute;s resultados &raquo;</a></div>
        <!-- FIN PAGINADO -->
            </div>


</div>


      <div class="toolbox" >
        <center><img src="../../Content/CSS/Front/imagenes/logo.png" align="middle" width="200" height="200" /></center>
        <div class="toolbox busqueda">
    	<mvc:SearchAll ID="SearchAll1" runat="server" />
       
       <div class="tag-cloud">
        	<h3>TEM&Aacute;TICAS</h3>
            <mvc:Tematicas ID="Tematicas" runat="server" ViewDataKey="seccion" />
          </div>    
        
        <% Html.RenderPartial("~/Views/Shared/NoticiasResumenApe.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        

        

        </div>

      </div>
     
</div>  

</asp:Content>






<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>






<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">

<script type="text/javascript" src="/Scripts/slider.js"></script>
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
            if (!pass) return false;
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
    <script type="text/javascript">

        $('#myCarousel').carousel({
            interval: 10000
        })

$('.carousel .item').each(function(){
  var next = $(this).next();
  if (!next.length) {
    next = $(this).siblings(':first');
  }
  next.children(':first-child').clone().appendTo($(this));
  
  if (next.next().length>0) {
    next.next().children(':first-child').clone().appendTo($(this));
  }
  else {
  	$(this).siblings(':first').children(':first-child').clone().appendTo($(this));
  }
});
    
    </script>


</asp:Content>
