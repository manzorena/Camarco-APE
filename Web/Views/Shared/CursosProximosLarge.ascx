<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<%
    int nroPagina = 1;
    if (Request.QueryString["pagina"] != null) nroPagina = Convert.ToInt32(Request.QueryString["pagina"].ToString());
    List<Camarco.Model.Curso> cursos = Camarco.Model.Cursos.GetProximos(nroPagina);
    System.Globalization.CultureInfo provider = new System.Globalization.CultureInfo("es-AR");
%>
<h2 class="title">pr&oacute;ximos cursos</h2>
<div class="resultados">
<ul>
<% 
    int numero = 0;
    string mostrar = "";
    foreach (Camarco.Model.Curso c in cursos) 
    {
        numero = numero + 1;
        if (numero > 5) mostrar = "none";
        string tipoEvento = c.TipoEvento;
        string sub = (c.Copete.Length <= 200 ? Html.Encode(c.Copete) : Html.Encode(c.Copete.Substring(0, 197)) + "...");
        string nombre = c.Titulo;
        string fecha = c.CronogramaInicio.ToString("dd-MM-yyyy");
        string diasHorarios = c.DiasSemanaCantidad + " de " + c.CronogramaStringHorarioInicio + " a " + c.CronogramaStringHorarioFin + " hs.";
        string horarios = c.CronogramaStringHorarioInicio + " a " + c.CronogramaStringHorarioFin + " hs.";
        string duracion = c.Duracion;
        string Imagen = c.urlImagen;
        string url = "href='/Cursos/" + c.CampaignID + "'";
        if (c.ImagenID > 0) 
            Imagen = "/File/GetFile?id=" + c.ImagenID;
        
        %>
        <li style="height:215px; display:<%=mostrar %>" id="Curso<%=numero %>" >
        <%
        if (tipoEvento == "Entrenamiento" || tipoEvento == "Demostración")
        {
            
        %>
        
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
                <img src="<%=Imagen %>" width="142" height="115" alt="<%=nombre %>" title="<%=nombre %>" />
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>CURSO</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Inicia:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Días y Horarios:</strong> <%=diasHorarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
        <% } 
        else if (tipoEvento == "Conferencia")
        { 
        %>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
			    <img src="<%=Imagen %>" width="142" height="115" alt="<%=nombre %>" title="<%=nombre %>" />
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>CONFERENCIA</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Fecha:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Horarios:</strong> <%=horarios %></p>
            </div>
        <%
        }
        
        else if (tipoEvento == "WebCast")
        { 
        %>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
			    <img src="<%=Imagen %>" width="142" height="115" alt="<%=nombre %>" title="<%=nombre %>" />
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>PLATAFORMA ONLINE</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
               <p class="curso-data"><strong>Inicia:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Días y Horarios:</strong> <%=diasHorarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
        <%
        }
        else
        { 
        %>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
                <img src="<%=Imagen %>" width="142" height="115" alt="<%=nombre %>" title="<%=nombre %>" />
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>EVENTO</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Inicio:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Horario:</strong> <%=horarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
	    
        <%
        }
        %>
        </li>
    <%
    }
%>
</ul>
</div>