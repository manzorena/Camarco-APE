<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<List<Camarco.Model.Resource>>" %>
<% 
    List<Camarco.Model.Curso> cursos = Camarco.Model.Cursos.GetProximos(1);
    foreach (Camarco.Model.Curso c in cursos) 
    {
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
        
        if (tipoEvento == "Entrenamiento" || tipoEvento == "Demostración")
        {
            
        %>
        <li>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>CURSO</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Inicia:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Días y Horarios:</strong> <%=diasHorarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
	    </li>
        <% } 
        else if (tipoEvento == "Conferencia")
        { 
        %>
        <li>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
			    
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>CONFERENCIA</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Fecha:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Horarios:</strong> <%=horarios %></p>
            </div>
	    </li>
        <%
        }
        
        else if (tipoEvento == "WebCast")
        { 
        %>
        <li>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
			    
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>PLATAFORMA ONLINE</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Inicia:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Días y Horarios:</strong> <%=diasHorarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
	    </li>
        <%
        }
        else
        { 
        %>
        <li>
		    <div class="img">
			    <span><%=c.CronogramaInicio.ToString("MMMM yyyy", provider)%></span>
		    </div>
		    <div class="data">
			    <div class="archivo-tipo"><h4>EVENTO</h4></div>
			    <h3><a <%=url %>><%=Html.Encode(nombre)%></a></h3>
			    <p><%=sub%> </p>
                <p class="curso-data"><strong>Inicio:</strong> <%=fecha%></p>
                <p class="curso-data"><strong>Horario:</strong> <%=horarios%></p>
                <p class="curso-data"><strong>Duraci&oacute;n:</strong> <%=duracion%></p>
            </div>
	    </li>
        <%
        }
    }
%>