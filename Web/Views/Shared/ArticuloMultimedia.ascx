<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Articulo>" %>
<% 
    if (Model.VideoURL != null && Model.VideoURL.Length > 0)
    {
    %><div class="multimedia"><iframe width="616" height="338" src="<%=Model.VideoURL.Replace("watch?v=","embed/") %>" frameborder="0" allowfullscreen></iframe></div><%
    }
    else
    {
        if (Model.Imagenes.Count > 0)
        {
            %><div class="multimedia"><%
            foreach (Camarco.Model.ArticuloImagen sd in Model.Imagenes)
            {
            %><img src="/File/GetFile?id=<%=sd.File.FileID %>" alt="<%=Model.Titulo %>"/><%
            }
            %></div><%
        }
        
    }
%>
