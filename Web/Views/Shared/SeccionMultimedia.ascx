<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<% 
    if (Model.Video != null && Model.Video.Length > 0)
    {
    %><div class="multimedia"><iframe width="616" height="338" src="<%=Model.Video.Replace("watch?v=","embed/") %>" frameborder="0" allowfullscreen></iframe></div><%
    }
    else
    {
        if (Model.Destacados.Count > 0)
        {
            %>
            <div class="multimedia">
      		    <img src="/File/GetFile?id=<%=Model.Destacados[0].File.FileID %>" width="616" height="227" alt="<%=Model.Nombre %>"/>
            </div>
            <%
        }
    }
%>
