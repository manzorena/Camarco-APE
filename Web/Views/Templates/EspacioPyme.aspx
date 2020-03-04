<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteEP.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>
<%@ Register Src="~/Views/Shared/EspacioPymeSecciones.ascx" TagPrefix="mvc" TagName="EspacioPymeSecciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
<script type="text/javascript" src="/Scripts/jit-yc.js"></script>
<script type="text/javascript">
    (function ()
    {
        var ua = navigator.userAgent,
      iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i),
      typeOfCanvas = typeof HTMLCanvasElement,
      nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'),
      textSupport = nativeCanvasSupport
        && (typeof document.createElement('canvas').getContext('2d').fillText == 'function');
        //I'm setting this based on the fact that ExCanvas provides text support for IE
        //and that as of today iPhone/iPad current text support is lame
        labelType = (!nativeCanvasSupport || (textSupport && !iStuff)) ? 'Native' : 'HTML';
        nativeTextSupport = labelType == 'Native';
        useGradients = nativeCanvasSupport;
        animate = !(iStuff || !nativeCanvasSupport);
    })();
   
    
var tm = null;
$(function ()
{ //DOM Ready
    $(':checkbox').on('click', function ()
    {
        LoadJSON();
    });
    $(':radio').on('change', function ()
    {
        LoadJSON();
    });
    tm = new $jit.TM.Squarified({
        //where to inject the visualization  
        injectInto: 'infovis',
        //parent box title heights  
        titleHeight: 0,
        //enable animations  
        animate: animate,
        //box offsets  
        offset: 1,
        duration: 1000,
        width:935,
        height:550,
        //Enable tips  
        Tips: {
            enable: true,
            //add positioning offsets  
            offsetX: 20,
            offsetY: 20,
            //implement the onShow method to  
            //add content to the tooltip when a node  
            //is hovered  
            onShow: function (tip, node, isLeaf, domElement)
            {
                var html = '<div class="espacio-pyme-hover">';
                var data = node.data;
                if(data.extra)
                {
                html += '<div class="tip-sub"><h4>'+data.extra+'</h4></div>';
                }
                if (data.image)
                {
                    html += '<div class="tip-text"><a href="' + data.url + '"><img src="' + data.image + '" width="240" height="143"></a></div>';
                }
                html += '<div class="tip-title">' + node.name + '</div></div>';
                tip.innerHTML = html;

            }
        },
        //Add the name of the node in the coreponding label  
        //This method is called once, on label creation.  
        onCreateLabel: function (c, b)
        {

            var d = "";
            if (b != null && b.data != null && b.data.url != null)
                d = b.data.url;
            c.innerHTML = '<p><a href="' + d + '">' + b.name + "</a></p>";
            c.onclick=function(){window.location=d};
            var a = c.style;
            a.display = "";r

            c.className = 'node '+b.data.theme;
            a.border = "1px solid transparent";

        },
        onPlaceLabel: function (i, c)
        {
            var g = $('#' + c.id);
            if(Number(g.width())>Number(g.height())+10)
                var w = Math.floor(Number(g.height()) / 8);
            else
                var w = Math.floor(Number(g.width()) / 8);
            g.css('fontSize', w + "px");
            g.css('lineHeight', w + "px");

        }
    });
    Redraw();
});
var json = <%=ViewData["JSON"] %>;
function LoadJSON()
{
    var s = new Array();
     $(':checkbox').each(function(c){
        if($(this).prop("checked"))
            s.push(Number($(this).attr("id").replace("checkbox","")));
     });
    PageCore.AjaxPost('/Search/EspacioPyme', $.toJSON({ tipo:($('#radioLeido').prop('checked')?1:($('#radioDescargado').prop('checked')?2:3)), secciones:s }), function (data)
    {
        json=data;
        Redraw();
    });
    
}
function Redraw()
{
    if(json.children.length>0){
        $('#infovis').show();
        $('#sinresultados').hide();
    }
    else{
        $('#infovis').hide();
        $('#sinresultados').show();
    }
   tm.loadJSON(json);
   tm.refresh();
}
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
    <!-- CONTENT -->
<div class="espacio-pyme content color09">
	<h2 class="title">CAJA DE HERRAMIENTAS</h2>
    <!-- FILTROS -->
    <form class="search">
        <ul class="search-filters">
        <li><input id="radioLeido" type="radio" name="radio" value="1" checked="checked"/><label for="radioLeido">Lo m&aacute;s le&iacute;do</label></li>
        <li><input id="radioDescargado" type="radio" name="radio" value="2"/><label for="radioDescargado">Lo m&aacute;s descargado</label></li>
        <li><input id="radioCursos" type="radio" name="radio" value="3"/><label for="radioCursos">Pr&oacute;ximos cursos</label></li>
    </ul>
</form>
<!-- FIN FILTROS -->
</div>

<div class="espacio-pyme toolbox color03">
    <!-- BUSQUEDA -->
    <mvc:SearchAll runat="server" />
	<!-- FIN BUSQUEDA -->
</div>

<div id="infovis" class="panal preloader" style="clear:both;z-index:97; " ></div>
<div id="sinresultados" class="sin-resultados" style="clear:both">
<h3>Lo sentimos, no hay informaci&oacute;n disponible para las categor&iacute;as seleccionadas</h3>
<p>Por favor pruebe con otra combinaci&oacute;n.</p>
</div>
<div class="secciones" style="margin-top:20px">
<ul class="search-filters">
	<mvc:EspacioPymeSecciones runat="server" />
</ul>
</div>


</div>
</asp:Content>
