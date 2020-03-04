<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	pruebaPay
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>pruebaPay</h2>
    <form action="/respuestaPayU">
        <input type="text" id="reference_sale" name="reference_sale" value="FE3B8329-E318-E511-AE0D-00155D327B03"/>
        <input type="text" id="state_pol" name="state_pol" value="4" />
        <input type="text" id="payment_method_name" name="payment_method_name" value="VISS"/>
        <input type="text" id="transaction_id" name="transaction_id" value="444"/>
        <input type="text" id="payment_method_id" name="payment_method_id" value="7"/>
        <input type="text" id="installments_number" name="installments_number" value="10"/>
         <input type="text" id="value" name="value" value="69"/>
         <input type="submit" value="aver"/>
    </form>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
