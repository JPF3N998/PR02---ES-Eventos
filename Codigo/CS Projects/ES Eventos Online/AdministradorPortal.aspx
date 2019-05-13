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
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White"/>
            <h1 id="adminLbl" style="font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;margin-left:20px">Administrador</h1>
            <asp:HyperLink runat="server" ID="HyperLink1" Text="Resource MGMT" Font-Underline="True" Font-Size="20px" ForeColor="#2ECC71" NavigateUrl="~/AdministradorRecursos.aspx"></asp:HyperLink>
        </div>
        <div style="text-align:center;margin-bottom:50px">
           <asp:Button ID="resourcesBtn" runat="server" Text="Gestionar recursos" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238"/>
            <br />
           <asp:Label ID="historyLbl" runat="server" Text="Historial" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <asp:DropDownList CssClass="DropDownList" ID="recursosDropdown" runat="server" ToolTip="Resource type">
                <asp:ListItem Selected="True">Seleccione un tipo de recurso</asp:ListItem>
                <asp:ListItem>Local</asp:ListItem>
                <asp:ListItem>Catering</asp:ListItem>
                <asp:ListItem>Musica</asp:ListItem>
                <asp:ListItem>Decoracion</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div style="text-align:center">
            <asp:GridView ID="adminGridView" runat="server" style="background-color:antiquewhite;width:auto;margin-left:60px;margin-right:60px"></asp:GridView>
        </div>
    </form>
</body>
</html>
