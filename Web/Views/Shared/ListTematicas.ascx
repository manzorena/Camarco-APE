<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>

<ul>
<% 
    if (HttpRuntime.Cache.Get("Tematicas" + Model.SeccionID) == null)
    {
       

        HttpRuntime.Cache.Insert(
                        "Tematicas" + Model.SeccionID,
                        Camarco.Model.Tematicas.GetBySeccion(Model.SeccionID),
                        null,
                        DateTime.Now.AddDays(1),
                        System.Web.Caching.Cache.NoSlidingExpiration);
    }
    foreach (string t in (List<string>)HttpRuntime.Cache.Get("Tematicas" + Model.SeccionID))
    {
        %><li><a href="#" onclick="Categorias.filterChange(-1,-1,'<%=t %>','<%=t %>')"><%=t %></a></li> <%
    }
%>
</ul>