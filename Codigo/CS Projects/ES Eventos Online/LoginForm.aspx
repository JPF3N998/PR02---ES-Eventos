<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="ES_Eventos_Online.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inicio sesion</title>
    <style type="text/css">
        .auto-style1 {
            width: 170px;
        }
    </style>
</head>
<body style="background-color: #34495e;height:auto;font-family: 'Roboto Medium'">
    <form id="LoginForm" runat="server" style="text-align:center">
        <div style="margin-top:60px;margin-bottom:50px">
            <h1 id="companyLbl" style=" font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;">E|S Eventos Online</h1>
            <h2 id="loginLbl" style=" font-size: 60px;color: #FFFFFF">Log in</h2>
            </div>
        <div">
            <asp:Label ID="usernameLbl" runat="server" Text="Nombre de usuario" style="margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
                <asp:TextBox ID="TextBox1" runat="server" Width="170px" Height="20px"></asp:TextBox>
            <br />
            <br />
             <asp:Label ID="passwordLbl" runat="server" Text="Contraseña" style="margin-bottom:10px; font-family:'Roboto Medium'; font-size: 40px;text-align:center ;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
                <input id="passwordInput" type="password" style="border:solid;border-width:1px;border-color:white;height:20px;margin-bottom:30px;width:170px" />
            <br />
                <asp:Button ID="loginBtn" runat="server" Text="Ingresar" BorderStyle="Solid" style="margin-bottom:30px;width:180px" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238"/>
            <br />
            <asp:HyperLink runat="server" ID="createAccountLink" Text="Crear cuenta" Font-Underline="True" Font-Size="20px" ForeColor="#2ECC71" NavigateUrl="~/RegisterForm.aspx"></asp:HyperLink>
        </div>
        <div id="testDiv">
            <asp:HyperLink runat="server" ID="clientePortal" Text="Portal cliente" Font-Underline="True" Font-Size="20px" ForeColor="#2ECC71" NavigateUrl="~/RegisterForm.aspx"></asp:HyperLink>
               <br />
            <asp:HyperLink runat="server" ID="adminPortal" Text="Porta administrador" Font-Underline="True" Font-Size="20px" ForeColor="#2ECC71" NavigateUrl="~/AdministradorPortal.aspx"></asp:HyperLink>
       
        </div>
    </form>
</body>
</html>
