<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<%@ OutputCache Duration="60" VaryByParam="None" %>
<% 
    int seccionid = Model.SeccionID;
    List<Camarco.Model.Seccion> subs = Camarco.Model.Secciones.GetSubsecciones(seccionid);
    if (subs.Count > 0)
        seccionid = subs[0].SeccionID;
    List<Camarco.Model.Articulo> Destacadas = Camarco.Model.Noticias.GetDestacados(seccionid);
    //List<Camarco.Model.Articulo> Recientes = Camarco.Model.Noticias.GetRecientes(seccionid);
    List<Camarco.Model.Articulo> Leidas = Camarco.Model.Noticias.GetMasLeidas(seccionid);
    //filtrar articulos asociados a la seccion si es una subseccion o a todas las subsecciones si es una seccion
%>

<div class="home-noticias <%=subs[0].Color %> clearfix">
   	  <h2>NOTICIAS DE LA C&Aacute;MARA</h2>
        <ul class="destacadas">
            <% 
                foreach (Camarco.Model.Articulo a in Destacadas)
                {
                    a.LoadImagenes();
                    string imagen = (a.Imagenes.Count > 0 ? "/File/GetFile?id=" + a.Imagenes[0].File.FileID.ToString() : "/Content/CSS/Front/imagenes/articulo_sinthumb.png");
                    string titulo = Html.Encode(a.Titulo);
                    string url = a.Resource.GetPublicUrl(seccionid);
                    string sub = (a.Subtitulo.Length<=120?Html.Encode(a.Subtitulo):Html.Encode(a.Subtitulo.Substring(0,117))+"...");
                    %><li><a href="<%=url %>" title="<%=Html.Encode(a.Titulo) %>"><img src="<%=imagen %>" width="54" height="58" alt="<%=titulo %>"/></a>
                    <div class="texto">
                    <h3><a href="<%=url %>" title="<%=Html.Encode(a.Titulo) %>"><%=titulo%></a></h3>
                    <p><%=sub%></p>
                    </div>
                    </li><%
                }
            %>
		</ul>
        <div class="masleidas">
            <span>M&Aacute;S LE&Iacute;DAS</span>
            <ul>
                <% 
                foreach (Camarco.Model.Articulo a in Leidas)
                {
                    %><li><h3><a href="<%=a.Resource.GetPublicUrl(seccionid) %>" title="<%=Html.Encode(a.Titulo)%>"><%=Html.Encode(a.Titulo) %></a></h3></li><%
                }
            %>
            </ul>
        </div>
        <div class="masresultados"><a href="/<%=subs[0].Resource.Slug %>">ver todas las noticias &raquo;</a></div>
        </div>
