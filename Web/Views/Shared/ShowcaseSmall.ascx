<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<% if(Model.Destacados.Count>0){%>
<div class="content-showcase cargando" id="slider">
<% 
    bool first=true;
    foreach (Camarco.Model.SeccionDestacado sd in Model.Destacados)
    {
        
        %><img src="/File/GetFile?id=<%=sd.File.FileID%>" width="616" height="227" alt="<%=sd.Titulo %>" <%=(!first?"style=\"display:none\"":"") %> data-key="<%=Html.Encode(sd.Descripcion) %>"/><%
        first=false;
    }
%>
    <h2><%=Html.Encode(Model.Destacados[0].Titulo)%></h2>
    <ul>
       <%
        first = true;
        if (Model.Destacados.Count > 1)
        {
            int Orden = 1;
            foreach (Camarco.Model.SeccionDestacado sd in Model.Destacados)
            {
             
            %><li><a href="#" title="<%=Html.Encode(sd.Titulo) %>" <%=(first?"class=\"content-showcase-current\"":"") %>><%=Orden++%></a></li><%
                first = false;
            }
        }
       %>
    </ul>
</div>
<%} %>