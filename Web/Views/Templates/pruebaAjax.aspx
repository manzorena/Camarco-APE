<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Camarco.Model.EspacioPymeModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    -<div class="wrapper">
    
        <%--Primer Sección Noticias slider--%>
        <div class="todo-ancho">
            <%if(Model.ArticulosSlider.Count>0){%>
            <div class="cargando showcase" id="slider" style="height:auto;margin:0;">
            <% 
                bool first=true;
                foreach (Camarco.Model.ArticuloModel ar in Model.ArticulosSlider)
                {
        
                    %>
                    <%--<a href="agenda-del-sector/<%=(ar.Ruta)%>">--%>
                        <img src="/File/GetFile?id=<%=ar.Id%>" width="916" height="470" alt="<%=ar.Titulo %>" <%=(!first?" style=\"display:none\"":"") %>"/>
                    <%--</a>--%>
                    <%first = false;
                }
            %>
	            <div class="showcase-data">
                    <h2><%=Html.Encode(Model.ArticulosSlider[0].Titulo)%></h2>
                    <span></span>
                </div>
                <ul class="showcase-navigation" style="position: relative; right:0px;bottom:35px;left:760px">
                <%
                first = true;
                if (Model.ArticulosSlider.Count > 1)
                {
                    int Orden = 1;
                    foreach (Camarco.Model.ArticuloModel art in Model.ArticulosSlider)
                    {
                    %><li><a href="#" title="<%=Html.Encode(art.Titulo) %>" <%=(first?"class=\"showcase-navigation-current\"":"") %>><%=Orden++%></a></li><%
                        first = false;
                    }
                }
                %>
                </ul>
                </div>
            <%} %>
        </div>