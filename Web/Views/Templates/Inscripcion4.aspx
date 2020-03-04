<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
