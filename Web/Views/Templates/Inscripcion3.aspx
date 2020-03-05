<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inscripcion3.aspx.cs" Inherits="Camarco.Web.Views.Templates.Inscripcion3" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="Microsoft.Crm.Sdk" %>
<%@ Import Namespace="Microsoft.Crm.SdkTypeProxy" %>
<%@ Import Namespace="Microsoft.Crm.Sdk.Query" %>
<%@ Import Namespace="Microsoft.Crm.Sdk.Utility" %>


<html>
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

     E-mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="txt_mail_comprobar" id="txt_mail_comprobar" runat="server" />
           <asp:Button ID="btn_cmprbr" runat="server" text="Comprobar"  /><br />

     Nombre&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="mail" id="txt_nombre" runat="server" /><br />
     Apellido&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" name="mail" id="txt_apellido" runat="server" /><br />
     Documento&nbsp;&nbsp;&nbsp; <input type="text" name="mail"  id="txt_dni" runat="server"/><br />
        <br />
        }
&nbsp;  <asp:Button ID="btn_inscribir" runat="server" text="Inscribir" onclick="btn_inscribir_Click" />
    </div>
   
       
    </form>
</body>
</html>
