<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ListTematicas.ascx" TagPrefix="mvc" TagName="Tematicas" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
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
            if(cat==0)cat=-1;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
	<!-- NIVEL 2 - CONTENT -->
    <div class="content biblioteca <%=((Camarco.Model.Seccion)ViewData["seccion"]).Color %>">
    	<h1><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).Descripcion) %></h1>
        <% Html.RenderPartial("~/Views/Shared/BreadCrumb.ascx", ((Camarco.Model.Seccion)ViewData["seccion"])); %>
        <!-- NIVEL 3 - AGENDA Y NOVEDADES -->
        <h2 class="title"><%=Html.Encode(((Camarco.Model.Seccion)ViewData["seccion"]).TituloPagina.ToUpper()) %></h2>
        <!-- SELECTS -->
      <form class="selectcat">
        	<ul class="categorias">
            	<li><label>CATEGOR&Iacute;A</label>
                	<div class="wrapper-dropdown sddwn" id="dropdownCategorias" style="heigth:auto"><span id="dropdownCategoriasSpan">Todas</span>
						<ul class="dropdown" >
						</ul>
					</div>
                </li>
                <li style="display:none" id="divsubs"><label>SUBCATEGOR&Iacute;A</label>
                <div class="wrapper-dropdown sddwn" id="dropdownSubcategorias"><span id="dropdownSubcategoriasSpan">Todas</span>
						<ul class="dropdown" >
						</ul>
					</div>
                </li>
            </ul>
            
      </form>
        <!-- FIN SELECTS -->
        <!-- ARCHIVOS RELACIONADOS -->
       	<div class="archivos">
            <span class="pdf-warning"><a title="Descargar Adobe Reader" target="_blank" href="http://get.adobe.com/es/reader/"><img width="16" height="16" alt="Descargar Adobe Reader" src="/Content/CSS/Front/imagenes/pdficon_small.png"></img></a>
                   Para visualizar los descargables en formato PDF es necesario el complemento Adobe Reader, puede 
                <a title="Descargar Adobe Reader" target="_blank" href="http://get.adobe.com/es/reader/">
                  descargarlo aquí
                </a></span>
        	<h2 id="searchText"></h2>
            <ul class="archivos-list" id="ulResultados">
            <% 
                bool LoggedIn = Session["UserID"] != null;
                //ACA CREO QUE CARGA LOS DOCUMENTOS - ANOTACIONES LOGO
                //Array collection;
                foreach (Camarco.Model.Resource r in Camarco.Model.ResourceManager.ListBySeccionType3(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID, (int)Camarco.Model.ResourceType.DOCUMENTO, 100))
                {
                    Camarco.Model.Documento d = Camarco.Model.DocumentoManager.GetByResource(r.ResourceID);
                    
	               string url=(!d.Publico && !LoggedIn?"\" onclick=\"Session.ShowLogin(false,"+d.FileID+");return false;\"":r.GetPublicUrl(((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID));
                    %><li style="display:none">
					    <a href="<%=url %>" title="Descargar PDF" class="pdf-btn"></a>
					    <div class="archivo-tipo"><h4>DESCARGABLE</h4>
                        <%
                        if(!d.Publico && !LoggedIn) {
                        %> // <a href="#" class="tooltip"><span>Requiere ser socio</span><div class="tooltip-text"><h4>Este archivo sólo se encuentra disponible para socios de la Cámara.</h4><p>Haga click para descubrir los beneficios de ser socio.</p></div></a> <%
                        }%><!--ACA CARGA ULTIMA VEZ ACTUALIZADO - ANOTACIONES LOGO-->
                        // Actualizado <%=d.FechaModificacion.ToString("dd-MM-yyyy")%></div>
					    <h3><a href="<%=url %>" title="Descargar PDF"><%=Html.Encode(d.Titulo) %></a></h3>
					    <p><%=d.Descripcion %></p>
                        <% if (url.Length > 0) {%>
					    <a href="<%=url %>" title="Descargar archivo PDF" class="leer-mas"><span>Descargar PDF</span></a>
                        <%} %>
					    <ul class="tematicas-resultado">
							    <li>TEM&Aacute;TICAS RELACIONADAS:</li>
							    <% 
                                foreach(string s in r.Tags.Split(','))
                                {
                                    %><li><a href="#" onclick="Categorias.filterChange(-1,-1,'<%=s %>','<%=s %>')"><%=s %></a></li> <%    
                                }
                            %>
						    </ul>
				    </li><%
                }
            %>
            </ul>
        </div>
        <!-- FIN ARCHIVOS RELACIONADOS -->
        <!-- PAGINADO -->
        <div class="masresultados"><a style="cursor:pointer;" onclick="MasResultados.Mas()">ver m&aacute;s resultados &raquo;</a></div>
        <!-- FIN PAGINADO -->
        <!-- NIVEL 3 - FIN AGENDA Y NOVEDADES -->
  </div>
    <!-- NIVEL 2 - FIN CONTENT -->
    <!-- NIVEL 2 - TOOLBOX -->
    <div class="toolbox biblioteca">
    	<!-- NIVEL 3 - BUSQUEDA -->
    	<mvc:SearchAll runat="server" />
        <!-- NIVEL 3 - FIN BUSQUEDA -->
        <!-- INFORMACIÓN IMPORTANTE -->
        <div class="importante">
        	<h2>INFORMACI&Oacute;N IMPORTANTE</h2>
            <p>Algunos indicadores son de descarga exclusiva para socios. Si Ud. es socio, cuando el sistema le solicite sus credenciales ingr&eacute;selas para descargar el indicador. Si no es socio, puede <a href="/institucional/beneficios-de-asociarse">consultar sobre los beneficios de asociarse aqu&iacute;</a>.</p>
        </div>
        <!-- FIN INFORMACIÓN IMPORTANTE -->
        <!-- INDICADORES -->
        <div class="tag-cloud">
        	<h3>TEM&Aacute;TICAS</h3>
            <mvc:Tematicas runat="server" ViewDataKey="seccion" />
        </div>
        <!-- FIN INDICADORES -->
        
    </div>
    <!-- NIVEL 2 - FIN TOOLBOX -->
</div>
</asp:Content>
