<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    int seccionid = ((Camarco.Model.Seccion)ViewData["seccion"]).SeccionID;
    List<Camarco.Model.AccesoDirecto> AccesosDirectos = Camarco.Model.Secciones.GetAccesosDirectos(seccionid);
%>
<div class="accesos-directos">
    <% 
    if (AccesosDirectos.Count > 0)
    {
        Camarco.Model.AccesoDirecto ad = AccesosDirectos[0];//el footer solo soporta 1 menu de acceso directo
        %>
        <h2><%=Html.Encode(ad.Titulo) %></h2>
        <ul>

        <%
        int index = 0, total = ad.Links.Count;
        foreach (Camarco.Model.AccesoDirectoLink l in ad.Links)
        {
            string url = (l.Link.Length == 0 ? l.Resource.GetPublicUrl(0) : l.Link);
            if (l.Link.Length == 0 && !url.StartsWith("/"))
                url = "/" + url;
            if (l.Link.Length == 0 && l.Resource.Type == Camarco.Model.ResourceType.SECCION && (Camarco.Model.Secciones.GetByResource(l.Resource.ResourceID).Template == 8))
                url = "/espaciopyme";
            %><li <%=(++index==total?"class=\"accesos-directos-lastitem\"":"") %>><a href="<%=url %>" title="<%=l.Titulo %>"><%=Html.Encode(l.Titulo) %></a></li><%
        }
        %></ul>
        </div>
            <%
    }
    %>
    