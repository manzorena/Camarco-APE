<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Register Src="~/Views/Shared/ToolSearchAll.ascx" TagPrefix="mvc" TagName="SearchAll" %>

<asp:Content ID="errorTitle" ContentPlaceHolderID="TitleContent" runat="server">
	CAMARCO - Cámara Argentina de la Construcción
</asp:Content>

<asp:Content ID="errorContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="wrapper">
<div class="toolbox">
    <!-- BUSQUEDA -->
    <mvc:SearchAll runat="server" />
	<!-- FIN BUSQUEDA -->
</div>
<div id="sinresultados" class="sin-resultados" style="clear:both">
<h3>Lo sentimos, ha ocurrido un error procesando su pedido</h3>
<p>Hemos registrado el problema y lo solucionaremos a la brevedad</p>
</div>

</div>
</asp:Content>
