<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClientePortal.aspx.cs" Inherits="ES_Eventos_Online.ClientePortal" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="AdministradorPortalCSS.css">
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Portal Cliente</title>
</head>
<body>
    <form id="ClientForm" runat="server" style="font-family:Bahnschrift">
        <div style="margin-bottom:50px;text-align:left">
            <asp:ImageButton ID="backBtn" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="backBtn_Click" />
            <asp:Label ID="clientLbl" runat="server" Text="Usuario:" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
        </div>
        <div style="text-align:center;margin-bottom:50px">
           <asp:Button ID="reservacionesBtn" runat="server" Text="Reservaciones" BorderStyle="Solid" style="margin-bottom:10px;" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" Width="603px" OnClick="reservarBtn_Click"/>
        </div>
        <div style="text-align:center">
            <asp:Label ID="reservacionesLbl" runat="server" Text="Reservaciones" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <br />
            <asp:Label ID="RecursoLbl" runat="server" HorizontalContentAlignment="Center" style="color:white;font-size:40px;margin-right:10px" Text="Nombre del recurso"></asp:Label>
            <asp:TextBox ID="inputNombreRecurso" runat="server" AutoCompleteType="Disabled" Height="36px" style="margin-right:20px"></asp:TextBox>
            <asp:Button ID="filterBtn" runat="server" Height="48px" Text="Filtrar" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="filterBtn_Click"/>
            <asp:GridView ID="gridViewReservaciones" runat="server" style="background-color:antiquewhite;width:auto;margin-left:auto;margin-right:auto;margin-top:30px"></asp:GridView>
           <asp:Label ID="historyLbl" runat="server" Text="Historial" style="height:auto;width:initial; margin-top:40px" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <br />
            <asp:GridView ID="historialGridView" runat="server" style="background-color:antiquewhite;width:auto;margin-left:auto;margin-right:auto"></asp:GridView>
        </div>
    </form>
</body>
</html>
