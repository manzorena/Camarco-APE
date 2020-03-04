<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Articulo>>" %>

<ul id="ulResultados">
<% 
    foreach (Camarco.Model.Articulo a in Model)
    {
        Camarco.Model.Resource r = a.Resource;
        a.LoadImagenes();
        string imagen = (a.Imagenes.Count > 0 ? "/File/GetFile?id=" + (a.Imagenes[0].FileThumb != null ? a.Imagenes[0].FileThumb.FileID.ToString() : a.Imagenes[0].File.FileID.ToString()) : "/Content/CSS/Front/imagenes/articulo_sinthumb.png");
        %>
        <li style="display:none">
			<div class="img"><a href="<%=r.GetPublicUrl(0) %>" title="Leer texto completo" ><img src="<%=imagen %>" alt="<%=r.Nombre %>" title="<%=r.Nombre %>"/></a>
			</div>
			<div class="data">
				<div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
				<h3><a href="#"><%=Html.Encode(a.Titulo)%></a></h3>
				<p><%=Html.Encode(a.Subtitulo)%> <a href="<%=r.GetPublicUrl(0) %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
                <ul class="tematicas-resultado"><li>TEM&Aacute;TICAS RELACIONADAS:</li>
                <% 
        foreach (string s in r.Tags.Split(','))
        {
                        %><li><a href="#" onclick="Categorias.filterTematica('<%=s %>')"><%=s%></a></li> <%    
        }
                %></ul>
			</div>
		</li><%
    }
%>
</ul>