<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<% if(Model.Destacados.Count>0){%>
<div class="showcase cargando" id="slider">
<% 
    bool first=true;
    foreach (Camarco.Model.SeccionDestacado sd in Model.Destacados)
    {
        
        %><img src="/File/GetFile?id=<%=sd.File.FileID%>" width="616" height="315" alt="<%=sd.Titulo %>" <%=(!first?"style=\"display:none\"":"") %> data-key="<%=Html.Encode(sd.Descripcion) %>"/><%
        first=false;
    }
%>
	<div class="showcase-data">
        <h2><%=Html.Encode(Model.Destacados[0].Titulo)%></h2>
        <span></span>
        <p><%=Html.Encode(Model.Destacados[0].Descripcion)%></p>
    </div>
    <ul class="showcase-navigation">
       <%
        first = true;
        if (Model.Destacados.Count > 1)
        {
            int Orden = 1;
            foreach (Camarco.Model.SeccionDestacado sd in Model.Destacados)
            {
            %><li><a href="#" title="<%=Html.Encode(sd.Titulo) %>" <%=(first?"class=\"showcase-navigation-current\"":"") %>><%=Orden++%></a></li><%
                first = false;
            }
        }
       %>
    </ul>
</div>
<%} %>