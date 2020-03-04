<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<%@ OutputCache Duration="60" VaryByParam="None" %>
<% 
    int seccionid = Camarco.Model.Secciones.ListByTemplate(1)[0].SeccionID;
    List<Camarco.Model.Seccion> subs = Camarco.Model.Secciones.GetSubsecciones(seccionid);
    if (subs.Count > 0)
        seccionid = subs[0].SeccionID;
    List<Camarco.Model.Articulo> Destacadas = Camarco.Model.Noticias.GetDestacados(seccionid);
    //filtrar articulos asociados a la seccion si es una subseccion o a todas las subsecciones si es una seccion
%>

<div class="novedades">
    <h3>NOVEDADES</h3>
    <ul>
        <% 
            int index = 1;
            foreach (Camarco.Model.Articulo a in Destacadas)
            {
                a.LoadImagenes();
                string imagen = (a.Imagenes.Count > 0 ? "/File/GetFile?id=" + a.Imagenes[0].File.FileID.ToString() : "/Content/CSS/Front/imagenes/articulo_sinthumb.png");
                string titulo = Html.Encode(a.Titulo);
                string url = a.Resource.GetPublicUrl(seccionid);
                string sub = (a.Subtitulo.Length <= 120 ? Html.Encode(a.Subtitulo) : Html.Encode(a.Subtitulo.Substring(0, 117)) + "...");
                    
                %><li>
            <a href="<%=url %>" title="<%=titulo %>"><img src="<%=imagen %>" width="79" height="55" alt="<%=titulo %>"></a>
            <div class="texto">
                <h3><a href="<%=url %>" title="<%=titulo %>"><%=titulo %></a></h3>
                <p><%=sub %></p>
            </div>
		</li>
                <%
                if (index++ % 2 == 0)
                { 
                    %></ul><ul><%
                }
            }    
            
        %>
    </ul>
		
</div>