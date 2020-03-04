<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
<div class="toolbox">
    <!-- BUSQUEDA -->
    <mvc:SearchAll runat="server" />
	<!-- FIN BUSQUEDA -->
</div>
<div id="sinresultados" class="sin-resultados" style="clear:both">
<h3>Lo sentimos, el contenido que intenta acceder no existe</h3>
<p>Por favor utilice la B&uacute;squeda para encontrar lo que necesite.</p>
</div>

</div>
</asp:Content>
