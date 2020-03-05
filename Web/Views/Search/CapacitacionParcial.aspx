<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Resource>>" %>
<% 
    foreach (Camarco.Model.Resource r in ViewData.Model)
    {
        switch (r.Type)
        {
            case Camarco.Model.ResourceType.ARTICULO:
                Camarco.Model.Articulo a = Camarco.Model.ArticuloManager.GetByResource(r.ResourceID);
                string suba = (a.Subtitulo.Length <= 200 ? Html.Encode(a.Subtitulo) : Html.Encode(a.Subtitulo.Substring(0, 197)) + "...");
                string url = r.GetPublicUrl(0);
                %><li>
				    <div class="sub-data">
				    <div class="archivo-tipo"><h4>NOTICIA</h4> // <%=(a.FechaHora.Length > 0 ? Html.Encode(a.FechaHora) : a.FechaPublicacion.ToString("dd-MM-yyyy HH:mm") + " hs.")%></div>
					    <h3><a href="/<%=url %>"><%=Html.Encode(a.Titulo)%></a></h3>
					    <p><%=suba%> <a href="/<%=url %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
				    </div>
			    </li><%
                break;
            case Camarco.Model.ResourceType.CURSO:
                Camarco.Model.Curso c = Camarco.Model.Cursos.GetByResource(r.ResourceID);
                string sub = (c.Copete.Length <= 200 ? Html.Encode(c.Copete) : Html.Encode(c.Copete.Substring(0, 197)) + "...");
                string finalizado = (c.CronogramaFin.CompareTo(DateTime.Now) < 0 ? "// <em>FINALIZADO</em>" : "");
                
                %><li>
				    <div class="sub-data">
				    <div class="archivo-tipo"><h4>CURSO</h4> // INICIO <%=c.CronogramaInicio.ToString("dd-MM-yyyy") %> // DURACI&Oacute;N <%=c.Duracion %> <%=finalizado %></div>
					    <h3><a href="/Cursos/<%=c.CampaignID %>"><%=Html.Encode(c.Titulo) %></a></h3>
					    <p><%=sub%> <a href="/Cursos/<%=c.CampaignID %>" title="Leer texto completo" class="leer-mas"><span>Leer m&aacute;s</span></a></p>
				    </div>
			    </li><%
                break;
        }
    }
%>