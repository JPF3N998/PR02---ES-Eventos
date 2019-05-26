<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministradorPortal.aspx.cs" Inherits="ES_Eventos_Online.AdministradorPortalForm" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="AdministradorPortalCSS.css">
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Portal del administrador</title>
</head>
<body">
    <form id="AdminPortal" runat="server">
        <div style="margin-bottom:50px;text-align:left">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="ImageButton1_Click"/>
            <h1 id="adminLbl" style="font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;margin-left:20px">Administrador</h1>
        </div>
        <div style="text-align:center;margin-bottom:50px">
           <asp:Button ID="resourcesBtn" runat="server" Text="Gestionar recursos" BorderStyle="Solid" style="margin-bottom:30px;" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" Width="866px" OnClick="resourcesBtn_Click"/>
            <br />
            <asp:Button ID="registerAdminBtn" runat="server" Text="Registrar nuevo administrador" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="registerAdminBtn_Click"/>
            <br />
        </div>
        <div style="text-align:center;margin-bottom:50px">
           <asp:Label ID="reservacionesLbl" runat="server" Text="Reservaciones" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br/>
            <asp:Label ID="Label1" runat="server" Text="Nombre" HorizontalContentAlignment="Center" style="color:white;font-size:25px;margin-right:10px"></asp:Label><asp:TextBox ID="filterReservacionesTextBox" runat="server" style="margin-right:20px" Height="23px" AutoCompleteType="Disabled"></asp:TextBox><asp:Button ID="filterBtn" runat="server" Text="Filtrar" Height="25px" OnClick="filterBtn_Click" />
            <asp:GridView ID="reservacionesGridView" runat="server" style="background-color:antiquewhite;width:auto;margin-top:30px;margin-left:auto;margin-right:auto"></asp:GridView>
        </div>
        <div style="text-align:center;margin-bottom:50px">
           <asp:Label ID="historyLbl" runat="server" Text="Historial" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <asp:GridView ID="historialGridView" runat="server" style="background-color:antiquewhite;width:auto;margin-top:20px;margin-left:auto;margin-right:auto"></asp:GridView>
        </div>
    </form>
</body>
</html>
