<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<% 
    if (HttpRuntime.Cache.Get("Menu") == null)
    {
        HttpRuntime.Cache.Insert(
                        "Menu",
                        Camarco.Model.Secciones.GetMenu(),
                        null,
                        DateTime.Now.AddMinutes(30),
                        System.Web.Caching.Cache.NoSlidingExpiration);
    }
    List<Camarco.Model.Seccion> Menu = (List < Camarco.Model.Seccion >)HttpRuntime.Cache.Get("Menu");
%>
<ul class="header-navigation"><% 
bool first = true;
Camarco.Model.Seccion sec = (Camarco.Model.Seccion)ViewData["seccion"];
int SeccionID = (ViewData["seccion"] == null ? -1 : (sec.MenuPrincipal ? sec.SeccionID : (sec.Parent != null?sec.Parent.SeccionID:sec.SeccionID)));
foreach (Camarco.Model.Seccion s in Menu)
{
    if (s.Resource.Slug == "biblioteca")
    {
    %><li class="<%=s.Color %> <%=(first?"first-item":"") %> <%=(s.SeccionID==SeccionID?"active":"") %>"><a href="http://biblioteca.camarco.org.ar/" title="<%=s.Nombre %>"><%=Html.Encode(s.Nombre.ToUpper())%></a></li><%
first = false;
    }
    else
    {
        %><li class="<%=s.Color %> <%=(first?"first-item":"") %> <%=(s.SeccionID==SeccionID?"active":"") %>"><a href="/<%=s.Resource.Slug %>" title="<%=s.Nombre %>"><%=Html.Encode(s.Nombre.ToUpper())%></a></li><%
first = false;
    }
}
%><li class="color09 <%=(Request.Url.AbsolutePath.ToLower().Contains("/contacto")?"active":"")%>" ><a href="/contacto" title="Contacto">CONTACTO</a></li><!--<li class="color10 last-item =(Request.Url.AbsolutePath.ToLower()=="/espaciopyme"?"active":"")%>"><a href="/espaciopyme" title="Espacio Pyme">ESPACIO PYME</a></li>--></ul>