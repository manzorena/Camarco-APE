<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = "la concha de la lora";
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Inscripcion10</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    
    </form>
</body>
</html>
