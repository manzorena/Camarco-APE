<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Documento>>" %>
<% 
    bool LoggedIn = Session["UserID"] != null;
    foreach (Camarco.Model.Documento d in Model)
    {
        d.LoadResource();
        string url = (!d.Publico && !LoggedIn ? "\" onclick=\"Session.ShowLogin(false," + d.FileID + ");return false;\"" : d.Resource.GetPublicUrl(0));
        %><li><a href="<%=url %>" title="Descargar PDF" class="pdf-btn"></a>
			<div class="archivo-tipo"><h4>DESCARGABLE</h4>
            <%
            if(!d.Publico && !LoggedIn) {
            %> // <a href="#" class="tooltip"><span>Requiere ser socio</span><div class="tooltip-text"><h4>Este archivo sólo se encuentra disponible para socios de la Cámara.</h4><p>Haga click para descubrir los beneficios de ser socio.</p></div></a> <%
            }%>
            // Actualizado <%=d.FechaModificacion.ToString("dd-MM-yyyy") %></div>
			<h3><a href="<%=url %>" title="Descargar PDF"><%=Html.Encode(d.Titulo) %></a></h3>
			<p><%=d.Descripcion %></p>
			<a href="<%=url %>" title="Descargar archivo PDF" class="leer-mas"><span>Descargar PDF</span></a>
			<ul class="tematicas-resultado">
					<li>TEM&Aacute;TICAS RELACIONADAS:</li>
					<% 
                    foreach(string s in d.Resource.Tags.Split(','))
                    {
                        %><li><a href="#" onclick="Categorias.filterChange(-1,-1,'<%=s %>','<%=s %>')"><%=s %></a></li> <%    
                    }
                %>
				</ul>
		</li><%
    }
%>