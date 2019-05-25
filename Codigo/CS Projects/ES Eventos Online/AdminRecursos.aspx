<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminRecursos.aspx.cs" Inherits="ES_Eventos_Online.AdminRecursos" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="AdministradorPortalCSS.css">
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administrador: Recursos</title>
    <style type="text/css">
        .auto-style1 {
            margin-top: 0px;
        }
    </style>
</head>
<body>
    <form id="adminRecursos" runat="server" style="text-align:center">
        <div style="margin-bottom:50px;text-align:left">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="ImageButton1_Click"/>
            <h1 id="adminLbl" style="font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;margin-left:20px">Administrador</h1>
        </div>
        <div id="ButtonSection">
            <asp:Button ID="newRecursoBtn" runat="server" Text="Nuevo Recurso" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="" OnClick="newRecursoBtn_Click"/>
            <asp:Button ID="deleteRecursoBtn" runat="server" Text="Borrar Recurso" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="300px" OnClick="deleteRecursoBtn_Click"/>
       
        </div>
        <div id="newRecursoPart" visible="false" runat="server" class="auto-style1">
            <asp:Label ID="nombreRecursoLbl" runat="server" Text="Nombre del recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="nombreInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="correoLbl" runat="server" Text="Correo" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="correoInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="telefonoLbl" runat="server" Text="Telefono" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="telefonoInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="provinciaLbl" runat="server" Text="Provincia" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="provinciaInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Button ID="addRercursoBtn" runat="server" Text="Agregar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="addRercursoBtn_Click"/>
        </div>
        <div id="deleteRecursoPart" runat="server" visible="false">
            <asp:Label ID="nameRecursoDelete" runat="server" Text="Nombre del recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="recursoInputBorrar" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
             <asp:Button ID="borrarRecursoBtn" runat="server" Text="Borrar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="borrarRecursoBtn_Click"/>
        
        </div>
    </form>
</body>
</html>
