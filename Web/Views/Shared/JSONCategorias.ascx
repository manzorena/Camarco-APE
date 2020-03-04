<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Camarco.Model.Seccion>" %>
<% 
    if (HttpRuntime.Cache.Get("Categorias" + Model.SeccionID) == null)
    {
        List<string> retval = new List<string>();
        retval.Add("{id:0,nombre:'Todas',subs:[]}");
        foreach (Camarco.Model.DocumentoCategoria c in Camarco.Model.DocumentoManager.GetCategoriasParentsBySeccion(Model.SeccionID))
        {
            retval.Add("{id:" + c.DocumentoCategoriaID + ",nombre:'" + c.Nombre + "',subs:[");
            foreach (Camarco.Model.DocumentoCategoria s in c.GetSubs())
            {
                retval.Add("{id:" + s.DocumentoCategoriaID + ",nombre:'" + s.Nombre + "'},");
            }
            retval.Add("]}");
        }
        
        HttpRuntime.Cache.Insert(
                        "Categorias" + Model.SeccionID,
                        string.Join(",", retval.ToArray()),
                        null,
                        DateTime.Now.AddDays(1),
                        System.Web.Caching.Cache.NoSlidingExpiration);
    }
    %><%=(string)HttpRuntime.Cache.Get("Categorias" + Model.SeccionID)%><%
    %>