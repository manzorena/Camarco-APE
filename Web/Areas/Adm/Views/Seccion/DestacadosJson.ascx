<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<Camarco.Model.SeccionDestacado>>" %>
<%
    List<string> retval = new List<string>();
    foreach (Camarco.Model.SeccionDestacado s in Model)
    {
        retval.Add("{orden:" + s.Orden + ",id:" + s.Id + ", img:'" + s.File.Filename + "', ext:'" + s.File.Extension + "',thumb:'/File/GetFile?id=" + s.File.FileID + "', titulo:'" + s.Titulo + "', descripcion:'" + s.Descripcion + "', showdescription:true}");
        
    }
    %><%=string.Join(",",retval.ToArray()) %><%
%>