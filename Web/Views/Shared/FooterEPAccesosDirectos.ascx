<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ OutputCache Duration="30" VaryByParam="None" %>
<% 
    int seccionid = Camarco.Model.Secciones.ListByTemplate(8)[0].SeccionID;
    List<Camarco.Model.AccesoDirecto> AccesosDirectos = Camarco.Model.Secciones.GetAccesosDirectos(seccionid);
%>
 <ul>
    <% 
        if (AccesosDirectos.Count > 0)
        {
            Camarco.Model.AccesoDirecto ad = AccesosDirectos[0];//el footer solo soporta 1 menu de acceso directo
            int index = 0;
            foreach (Camarco.Model.AccesoDirectoLink l in ad.Links)
            {
                %><li><a href="<%=(l.Link.Length>0?l.Link:l.Resource.GetPublicUrl(seccionid)) %>" title="<%=l.Titulo %>"><%=Html.Encode(l.Titulo) %></a></li><%
                if (++index % 3 == 0)
                { 
                    %></ul><ul><%
                }
            }
        }
    %>
    </ul>