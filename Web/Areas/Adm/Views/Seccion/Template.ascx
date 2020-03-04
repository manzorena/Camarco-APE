<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<int>" %>
<% 
    switch (Model)
    {
        case 1: 
            %>Home - Inicio<%
            break;
        case 2: 
            %>Agenda de Art&iacute;culos/Noticias<%
            break;
           case 3: 
            %>Biblioteca de Documentos<%
            break;
            case 4: 
            %>Capacitaci&oacute;n<%
            break;
            case 5: 
            %>Institucional / P&aacute;gina simple<%
            break;
            case 6: 
            %>Gu&iacute;as Pr&aacute;cticas (art&iacute;culos)<%
            break;
            case 7: 
            %>Delegaciones<%
            break;
            case 8: 
            %>Espacio Pyme<%
            break;
    }
%>