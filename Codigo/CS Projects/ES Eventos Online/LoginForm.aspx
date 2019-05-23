<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="ES_Eventos_Online.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inicio sesion</title>
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
                <asp:TextBox ID="userNameInput" runat="server" Width="170px" Height="20px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
            <br />
             <asp:Label ID="passwordLbl" runat="server" Text="Contraseña" style="margin-bottom:10px; font-family:'Roboto Medium'; font-size: 40px;text-align:center ;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
                <asp:TextBox ID="passwordInput" TextMode="Password" runat="server" Width="166px"></asp:TextBox>
&nbsp;<br />
                <asp:Button ID="loginBtn" runat="server" Text="Ingresar" BorderStyle="Solid" style="margin-bottom:30px;width:180px" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="loginBtn_Click"/>
            <br />
            <asp:HyperLink runat="server" ID="createAccountLink" Text="Crear cuenta" Font-Underline="True" Font-Size="20px" ForeColor="#2ECC71" NavigateUrl="~/RegisterForm.aspx"></asp:HyperLink>
        </div>
        <div id="testDiv">
               <br />
       
        </div>
    </form>
</body>
</html>
