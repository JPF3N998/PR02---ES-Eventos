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
        <div id="RecursoButtonSection">
            <asp:Button ID="newRecursoBtn" runat="server" Text="Nuevo recurso" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="" OnClick="newRecursoBtn_Click"/>
            <asp:Button ID="deleteRecursoBtn" runat="server" Text="Borrar recurso" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="300px" OnClick="deleteRecursoBtn_Click"/>
       
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
        <div id="PaqueteButtonSection">
            <asp:Button ID="nuevoPaqueteBtn" runat="server" Text="Nuevo paquete" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="" OnClick="nuevoPaqueteBtn_Click" />
            <asp:Button ID="borrarPaqueteBtn" runat="server" Text="Borrar paquete" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="300px" OnClick="borrarPaqueteBtn_Click"/>
        </div>
        <div id="agregarPaquetePart" runat="server" visible="false">
            <asp:Label ID="Label1" runat="server" Text="Nombre del recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="inputRecursoName" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Button ID="addPaqueteBtn" runat="server" Text="Nuevo paquete" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="addPaqueteBtn_Click"/>
        </div>
        <div id="borrarPaquetePart" runat="server" visible="false">
            <asp:Label ID="idPaqueteDeleteLbl" runat="server" Text="ID de paquete" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="idPaqueteInputDelete" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
            <br />
             <asp:Button ID="deletePaqueteBtn" runat="server" Text="Borrar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="deletePaqueteBtn_Click"/>
        </div>
        <div id="ProductoButtonSection">
            <asp:Button ID="openProductoSectionBtn" runat="server" Text="Nuevo producto" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="" OnClick="openProductoSectionBtn_Click" />
            <asp:Button ID="openProductoDeleteSectionBtn" runat="server" Text="Borrar producto" BorderStyle="Solid" style="margin-bottom:30px;width:auto" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="300px" OnClick="openProductoDeleteSectionBtn_Click"/>
        </div>
        <div id="agregarProductoPart" runat="server" visible="false">
            <asp:Label ID="idPaqueteLbl" runat="server" Text="ID de paquete" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="idPaqueteInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
            <br />
            <asp:Label ID="nombreProducto" runat="server" Text="Nombre del producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="nombreProductoInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="precioProductoLbl" runat="server" Text="Precio del producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="precioProductoInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
            <br />
            <asp:Button ID="addProductoBtn" runat="server" Text="Agregar producto" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="addProductoBtn_Click"/>
        
        </div>
        <div id="borrarProductoPart" runat="server" visible="false">
             <asp:Label ID="idPreoductoLbl3" runat="server" Text="Nombre del producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="idProductoInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" ></asp:TextBox>
            <br />
             <asp:Button ID="borrarProductoBtn" runat="server" Text="Borrar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="borrarProductoBtn_Click" />
        
        </div>
    </form>
</body>
</html>
