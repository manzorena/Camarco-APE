<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>

<ul>
<% 
    if (HttpRuntime.Cache.Get("TematicasApe" + Model.SeccionID) == null)
    {
       

        HttpRuntime.Cache.Insert(
                        "TematicasApe" + Model.SeccionID,
                        Camarco.Model.TematicasApe.GetBySeccion(Model.SeccionID),
                        null,
                        DateTime.Now.AddDays(1),
                        System.Web.Caching.Cache.NoSlidingExpiration);
    }
    foreach (string t in (List<string>)HttpRuntime.Cache.Get("TematicasApe" + Model.SeccionID))
    {
        %><li><a href="#" onclick="Categorias.filterChange(-1,-1,'<%=t %>','<%=t %>')"><%=t %></a></li> <%
    }
%>
</ul>