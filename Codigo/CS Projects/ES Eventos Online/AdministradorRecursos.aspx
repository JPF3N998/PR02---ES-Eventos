<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministradorRecursos.aspx.cs" Inherits="ES_Eventos_Online.AdministradorRecursos" %>

<!DOCTYPE html>
<link rel="stylesheet" type="text/css" href="FormCSS.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resource Management</title>
</head>
    <!-- En esta seccion, los div de productos y el gridview van a estar inicialmente escondidos hasta que la busqueda de paquete sea exitosa-->
<body style="height:auto">
    <form id="AdministradorRecursos" runat="server" style="height:auto">
         <div style="margin-bottom:5px;text-align:left">
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Resources/sharp_arrow_back_white_36dp.png" ForeColor="White" OnClick="ImageButton1_Click"/>
            <h1 id="adminLbl" style="font-size: 72px;color: #FFFFFF; text-decoration: underline; font-weight: bolder;margin-left:20px">Administrador</h1> 
            <h2 id="recursosLbl" style="font-size: 50px;color: #FFFFFF; font-weight: bolder;margin-left:20px">Recursos</h2>
            <h3 id="searchLbl" style="font-size: 50px;color: #FFFFFF; font-weight: bolder;margin-left:20px">Buscar</h3> 
        </div>
        <div style="height:auto">
            <div id="resourcesSide" style="width:auto;;text-align:left;height:auto">     
            <asp:DropDownList CssClass="DropDownList" ID="recursosDropdown" runat="server" ToolTip="Resource type" style="margin-left:20px;margin-bottom:30px;margin-top:10px">
                <asp:ListItem Selected="True">Seleccione un tipo de recurso</asp:ListItem>
                <asp:ListItem>Local</asp:ListItem>
                <asp:ListItem>Catering</asp:ListItem>
                <asp:ListItem>Musica</asp:ListItem>
                <asp:ListItem>Decoracion</asp:ListItem>
            </asp:DropDownList>
            <br />
                <asp:Label ID="idLbl" runat="server" Text="ID de paquete" style="margin-left:20px;font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;"></asp:Label>
            <br />
                <asp:TextBox ID="numPaquete" runat="server" Width="256px" Height="20px" style="margin-left:20px;margin-bottom:10px;margin-top:20px"></asp:TextBox>
                <br />
                <asp:Label ID="warningLbl1" runat="server" Text="Paquete no existe en esta categoria" style="margin-left:20px;color:yellow" Visible="false"></asp:Label>
            <br />
                    <asp:Button ID="searchPaqueteBtn" runat="server" Text="Buscar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green" Width="267px"/>
                <asp:Label ID="warningLbl4" runat="server" Text="Elegir un paquete primero" style="margin-left:20px;color:yellow" Visible="false"></asp:Label>
                <br />
                <asp:Button ID="ModificarPaqueteBtn" runat="server" Text="Modificar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#0066ff"/> 
                <asp:Button ID="borrarPaqueteBtn" runat="server" Text="Eliminar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red"/> 
            </div>
            <div id="packagesSide" style="margin-top:20px;width:auto;text-align:left;height:auto" hidden="hidden">
                <asp:Label ID="numProducto" runat="server" Text="ID de producto" style="font-family: 'Roboto Medium'; font-size: 40px;color: #FFFFFF;margin-left:20px"></asp:Label>
                <br />
                <asp:TextBox ID="idProductoInput" runat="server" Width="240px" Height="20px" style="margin-bottom:20px;margin-top:20px;margin-left:20px"></asp:TextBox>
                <br />
                <asp:Label ID="warningLbl2" runat="server" Text="Producto no existe en este paquete" style="margin-left:20px;color:yellow" Visible="false"></asp:Label>
                <br />
                <asp:Button ID="buscarProductoBtn" runat="server" Text="Buscar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Green"/>  
                <asp:Label ID="warningLbl5" runat="server" Text="Elegir un producto primero" style="margin-left:20px;color:yellow" Visible="false"></asp:Label>
                <br />
                <asp:Button ID="modificarProductoBtn" runat="server" Text="Modificar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="#0066ff"/> 
                <asp:Button ID="eliminarProductoBtn" runat="server" Text="Eliminar" BorderStyle="Solid" style="margin-left:20px;margin-top:20px;margin-bottom:10px;width:auto" BorderWidth="3px" BorderColor="#2c3e50" Font-Bold="true" Font-Size="40px" ForeColor="#FFFFFF" BackColor="Red"/> 
            </div>
            <div id="productSide"style ="margin-top:20px;width:auto;text-align:left;height:auto" hidden="hidden">
                <asp:GridView ID="productGridView" runat="server" style="width:inherit;height:auto;margin:10px;background-color:antiquewhite" ForeColor="Black"></asp:GridView>
            </div>
    </div>
    </form>
</body>
</html>
