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
            <asp:Button ID="newRecursoBtn" runat="server" Text="Nuevo Recurso" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="325px" OnClick="newRecursoBtn_Click"/>
            <asp:Button ID="editRecursoBtn" runat="server" Text="Modificar Recurso" BorderStyle="Solid" style="margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#FF9900" Width="400px" OnClick="editRecursoBtn_Click"/>
       
            <asp:Button ID="deleteRecursoBtn" runat="server" Text="Borrar Recurso" BorderStyle="Solid" style="margin-left:30px; margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="325px" OnClick="deleteRecursoBtn_Click"/>
       
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
            <asp:Button ID="addRecursoBtn" runat="server" Text="Agregar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="addRecursoBtn_Click"/>
        </div>
        <div id="editRecursoPart" runat="server" visible="false">
            <br />
            <asp:Label ID="editRecursoLabel" runat="server" Text="Indique el ID del Recurso a modificar y luego llene los campos que desee cambiar" style="margin-top:20px;margin-bottom:30px;font-family: 'Roboto Medium'; font-size: 28px;color: #FF9900;display:inline-block" Width="925px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="idRecursoEditLabel" runat="server" Text="ID del Recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="recursoIDEditInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="nameRecursoEditLabel" runat="server" Text="Nombre del recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="recursoNombreEditInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="correoRecursoEditLabel" runat="server" Text="Correo" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="recursoCorreoEditInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="telefonoLbl0" runat="server" Text="Telefono" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="telefonoEditInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Label ID="provinciaEditLbl" runat="server" Text="Provincia" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="provinciaEditInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Button ID="modifRercursoBtn" runat="server" Text="Modificar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="modifRecursoBtn_Click"/>
        </div>
        <div id="deleteRecursoPart" runat="server" visible="false">
            <asp:Label ID="nameRecursoDelete" runat="server" Text="Nombre del recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="recursoInputBorrar" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
             <asp:Button ID="borrarRecursoBtn" runat="server" Text="Borrar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="borrarRecursoBtn_Click"/>
        </div>
        <div id="PaqueteButtonSection">
            <asp:Button ID="nuevoPaqueteBtn" runat="server" Text="Nuevo Paquete" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="325px" OnClick="nuevoPaqueteBtn_Click" />
       
            <asp:Button ID="borrarPaqueteBtn" runat="server" Text="Borrar Paquete" BorderStyle="Solid" style="margin-left:30px;margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="325px" OnClick="borrarPaqueteBtn_Click"/>
        </div>
        <div id="agregarPaquetePart" runat="server" visible="false">
            <asp:Label ID="recursoNameLabel" runat="server" Text="Nombre del Recurso" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="inputRecursoName" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
            <br />
            <asp:Button ID="addPaqueteBtn" runat="server" Text="Agregar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="addPaqueteBtn_Click"/>
        </div>
        <div id="borrarPaquetePart" runat="server" visible="false">
            <asp:Label ID="idPaqueteDeleteLbl" runat="server" Text="ID de paquete" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
            <br />
            <asp:TextBox ID="idPaqueteInputDelete" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
            <br />
             <asp:Button ID="deletePaqueteBtn" runat="server" Text="Borrar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="deletePaqueteBtn_Click"/>
        </div>
        <div id="ProductoButtonSection">
            <asp:Button ID="openProductoSectionBtn" runat="server" Text="Nuevo Producto" BorderStyle="Solid" style="margin-right:30px; margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="325px" OnClick="openProductoSectionBtn_Click" />
            <asp:Button ID="editProductoBtn" runat="server" Text="Modificar Producto" BorderStyle="Solid" style="margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#FF9900" Width="400px" OnClick="editProductoBtn_Click"/>
       
            <asp:Button ID="openProductoDeleteSectionBtn" runat="server" Text="Borrar Producto" BorderStyle="Solid" style="margin-left:30px;margin-bottom:30px;" BorderWidth="3px" BorderColor="Black" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red" Width="325px" OnClick="openProductoDeleteSectionBtn_Click"/>
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
        <div id="editProductoPart" runat="server" visible="false">
            <asp:Label ID="editProductoLabel" runat="server" Text="Indique el ID del Producto a modificar y luego llene los campos que desee cambiar" style="margin-top:20px;margin-bottom:30px;font-family: 'Roboto Medium'; font-size: 28px;color: #FF9900;display:inline-block" Width="925px"></asp:Label>
             <br />
            <asp:Label ID="idProducto" runat="server" Text="ID de producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
             <br />
            <asp:TextBox ID="productoEditIdInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
             <br />
            <asp:Label ID="idPaqueteLbl0" runat="server" Text="ID de paquete" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
             <br />
            <asp:TextBox ID="productoEditPaqueteInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
             <br />
            <asp:Label ID="nombreProducto0" runat="server" Text="Nombre del producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
             <br />
            <asp:TextBox ID="productoEditNombreInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px"></asp:TextBox>
             <br />
            <asp:Label ID="precioProductoLbl0" runat="server" Text="Precio del producto" style="margin-top:20px;margin-bottom:10px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;display:inline-block"></asp:Label>
             <br />
            <asp:TextBox ID="productoEditPrecioInput" runat="server" Width="200px" Height="20px" AutoCompleteType="Disabled" style="margin-top:20px;margin-bottom:20px" TextMode="Number"></asp:TextBox>
            <br />
             <asp:Button ID="modifProductoBtn" runat="server" Text="Modificar" BorderStyle="Solid" style="margin-bottom:30px;margin-top:30px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#263238" OnClick="modifProductoBtn_Click" />
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
