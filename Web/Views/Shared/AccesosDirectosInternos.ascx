<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    int seccionid = (((Camarco.Model.Seccion)ViewData["seccion"]).Parent!=null?((Camarco.Model.Seccion)ViewData["seccion"]).Parent.SeccionID:((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID);
    List<Camarco.Model.AccesoDirecto> AccesosDirectos = Camarco.Model.Secciones.GetAccesosDirectos(seccionid);
%>
    <% 
        int index = 0, total = 0;
        foreach (Camarco.Model.AccesoDirecto ad in AccesosDirectos)
        {
            index = 0; total = ad.Links.Count;
        %><ul class="accesos-directos-internos">
            <li><%=ad.Titulo %></li><%
            foreach (Camarco.Model.AccesoDirectoLink l in ad.Links)
            {
                string url = (l.Link.Length == 0 ? l.Resource.GetPublicUrl(0) : l.Link);
                if (l.Link.Length == 0 && !url.StartsWith("/"))
                    url = "/" + url;
                if (l.Link.Length == 0 && l.Resource.Type == Camarco.Model.ResourceType.SECCION && (Camarco.Model.Secciones.GetByResource(l.Resource.ResourceID).Template == 8))
                    url = "/espaciopyme";
                %><li <%=(++index==total?"class=\"last\"":"") %>><a href="<%=url %>" title="<%=l.Titulo %>"><%=Html.Encode(l.Titulo) %></a></li><%
            }
          %></ul>
          <%  
        }
    %>