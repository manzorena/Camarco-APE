<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Inscripcion5
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Inscripcion5</h2>
    <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     E-mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="txt_mail_comprobar" id="txt_mail_comprobar" runat="server" />
           <asp:Button ID="btn_cmprbr" runat="server" text="Comprobar" onclick="btn_cmprbr_Click" /><br />
     Nombre&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="mail" id="txt_nombre" runat="server" /><br />
     Apellido&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="mail" id="txt_apellido" runat="server" /><br />
     Documento&nbsp;&nbsp;&nbsp; <input type="text" name="mail"  id="txt_dni" runat="server"/><br />
        <br />
&nbsp;  <asp:Button ID="btn_inscribir" runat="server" text="Inscribir" onclick="btn_inscribir_Click" />
    </div>
    </form>
</body>
</html>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
