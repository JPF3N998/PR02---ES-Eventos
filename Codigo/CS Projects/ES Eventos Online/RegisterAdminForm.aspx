<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterAdminForm.aspx.cs" Inherits="ES_Eventos_Online.RegisterAdminForm" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="AdministradorPortalCSS.css">
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro para Administradores</title>
    <style type="text/css">
        .auto-style1 {
            font-size: 40px;
            color: #FFFFFF;
        }
    </style>
</head>
<body style="background-color: #34495e;height:auto;font-family: 'Roboto Medium'">
    <form id="RegisterForm" runat="server" style="text-align:center">
        <div style="text-align:left; height:auto">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="ImageButton1_Click"/>
        </div>
        <div style="margin-top:30px;margin-bottom:50px">
            <h1 id="companyLbl" style=" font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;margin-bottom:50px">E|S Eventos Online</h1>
            <h2 id="registerLbl" style=" font-size: 60px;color: #FFFFFF">Registro de administrador</h2>
        </div>
        <div>
            <asp:Label ID="nombreLbl" runat="server" Text="Nombre" style="font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF"></asp:Label>
            <br/>
                <asp:TextBox ID="nombreInput" runat="server" Width="170px" Height="20px" style="margin-bottom:20px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
                <span class="auto-style1">Número de cédula</span><br />
                <asp:TextBox ID="NumCedulaInput" runat="server" Width="170px" Height="20px" style="margin-bottom:20px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
                <asp:Label ID="correoElectronicoLbl" runat="server" Text="E-mail" style="font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF"></asp:Label>
            <br />
                <asp:TextBox ID="correoElectronicoInput" runat="server" Width="170px" Height="20px" style="margin-bottom:20px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
                <asp:Label ID="UsernameLbl" runat="server" Text="Nombre de usuario" style="font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF"></asp:Label>
            <br />
                <asp:TextBox ID="UsernameInput" runat="server" Width="170px" Height="20px" style="margin-bottom:20px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
                <asp:Label ID="ContrasennaLbl" runat="server" Text="Contraseña" style="font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF"></asp:Label>
            <br />
                <asp:TextBox ID="ContrasennaInput" runat="server" Width="170px" Height="20px" style="margin-bottom:50px" AutoCompleteType="Disabled"></asp:TextBox>
            <br />
            <asp:Button ID="signupBtn" runat="server" Text="Registrar" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="signupBtn_Click"/>    
        </div>
    </form>
</body>
</html>
