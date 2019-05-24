<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClienteReservacionForm.aspx.cs" Inherits="ES_Eventos_Online.ClienteReservacionForm" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="AdministradorPortalCSS.css">
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reservacion</title>
</head>
<body>
    <form id="clienteReservacion" runat="server" style="font-family:Bahnschrift;color:White">
        <div style="margin-bottom:50px;text-align:left">
            <asp:ImageButton ID="backBtn" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="backBtn_Click" />
            <asp:Label ID="clientLbl" runat="server" Text="Usuario" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
        </div>
        <div style="text-align:center">
            <asp:Label ID="reserverLbl" runat="server" Text="Reservacion de paquete" style="height:auto;width:initial; margin-top:40px" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <asp:Label ID="idPaquete" runat="server" style="font-size:40px;margin-right:20px;margin-top:30px" Text="ID del paquete"></asp:Label>
            <asp:TextBox ID="idPaqueteInput" runat="server" AutoCompleteType="Disabled" Height="25px" style="margin-top:30px"></asp:TextBox>
            <br/>
            <asp:Label ID="fechaLbl" runat="server" style="font-size:40px;margin-right:20px" Text="Fecha"></asp:Label>
            <asp:TextBox ID="inputFecha" runat="server" AutoCompleteType="Disabled" Height="25px"></asp:TextBox>
            <br/>
            <asp:Label ID="horaInicioLbl" runat="server" style="font-size:40px;margin-right:20px" Text="Hora de inicio"></asp:Label>
            <asp:TextBox ID="inputHoraInicio" runat="server" AutoCompleteType="Disabled" Height="25px" ></asp:TextBox>
            <br/>
            <asp:Label ID="horaFinLbl" runat="server" style="font-size:40px;margin-right:20px" Text="Hora de fin"></asp:Label>
            <asp:TextBox ID="horaFinInput" runat="server" AutoCompleteType="Disabled" Height="25px"></asp:TextBox>
            <br/>
            <asp:Button ID="reservarBtn" runat="server" Height="48px" Text="Reservar" style="margin-top:30px;margin-bottom:30px" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="reservarBtn_Click"/>
        </div>
        <div style="text-align:center">
            <asp:Label ID="reservacionesLbl" runat="server" Text="Reservaciones" style="height:auto;width:initial" Font-Bold="true" Font-Size="72px" ForeColor="#FFFFFF"/>
            <br />
            <br />
            <asp:Label ID="RecursoLbl" runat="server" HorizontalContentAlignment="Center" style="color:white;font-size:40px;margin-right:10px" Text="Nombre del recurso"></asp:Label>
            <asp:TextBox ID="filterTextBox" runat="server" AutoCompleteType="Disabled" Height="36px" style="margin-right:20px"></asp:TextBox>
            <asp:Button ID="filterBtn" runat="server" Height="48px" Text="Filtrar" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="filterBtn_Click"/>
            <asp:GridView ID="gridViewReservaciones" runat="server" style="margin-top:30px;color:Black;background-color:antiquewhite;width:auto;margin-left:auto;margin-right:auto;margin-top:30px"></asp:GridView>
         </div>
    </form>
</body>
</html>
