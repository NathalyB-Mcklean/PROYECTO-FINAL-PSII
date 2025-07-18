<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Supervisor - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>
<!-- Navegación -->
<header>
    <nav class="container">
        <div class="logo">🐾 PAWS COFFEE</div>
        <ul class="nav-links">
            <li><a href="home.html">Inicio</a></li>
            <li><a href="servicios.html">Servicios</a></li>
            <li><a href="menu.html">Menú</a></li>
            <li><a href="reservas.html">Reservas</a></li>
            <li><a href="nosotros.html">Nosotros</a></li>
        </ul>
    </nav>
</header>
<body>

<h1>Panel de Ventas</h1>

<%
    String url = "jdbc:mysql://localhost:3306/tu_basedatos";
    String user = "root";
    String password = "tu_contraseña";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
%>

<!-- =================== DETALLE DE VENTAS =================== -->
<h2>Detalle de Ventas</h2>
<table>
    <tr>
        <th>ID Venta</th>
        <th>Fecha</th>
        <th>Total</th>
        <th>Tipo de Pago</th>
        <th>ID Producto</th>
        <th>Producto</th>
        <th>Cantidad</th>
        <th>Precio Unitario</th>
        <th>Impuesto</th>
    </tr>
<%
        rs = stmt.executeQuery("SELECT * FROM VistaDetalleVentas");
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("ID_Venta") %></td>
        <td><%= rs.getDate("Fecha") %></td>
        <td>$<%= rs.getDouble("Total") %></td>
        <td><%= rs.getString("TipoPago") %></td>
        <td><%= rs.getInt("ID_Producto") %></td>
        <td><%= rs.getString("Producto") %></td>
        <td><%= rs.getInt("Cantidad") %></td>
        <td>$<%= rs.getDouble("Precio_Unitario") %></td>
        <td>$<%= rs.getDouble("Impuesto") %></td>
    </tr>
<%
        }
        rs.close();
%>
</table>

<!-- =================== VENTAS POR CATEGORÍA =================== -->
<h2>Ventas por Categoría</h2>
<table>
    <tr>
        <th>Categoría</th>
        <th>Total Recaudado</th>
    </tr>
<%
        rs = stmt.executeQuery("SELECT * FROM VistaVentasPorCategoria");
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("Categoria") %></td>
        <td>$<%= rs.getDouble("TotalRecaudado") %></td>
    </tr>
<%
        }
        rs.close();
%>
</table>

<!-- =================== VENTAS POR DÍA =================== -->
<h2>Ventas por Día</h2>
<table>
    <tr>
        <th>Fecha</th>
        <th>Cantidad de Ventas</th>
        <th>Total Recaudado</th>
    </tr>
<%
        rs = stmt.executeQuery("SELECT * FROM VistaVentasPorDia");
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("Dia") %></td>
        <td><%= rs.getInt("CantidadVentas") %></td>
        <td>$<%= rs.getDouble("TotalRecaudado") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
</table>
<footer>
        <div class="container">
            <p>🐾 Síguenos: @PawsCoffeePanama | <a href="https://www.google.com" target="_blank">🔍 Buscar</a></p>
            <nav>
                <a href="index.html">Inicio</a> |
                <a href="servicios.html">Servicios</a> |
                <a href="menu.html">Menú</a> |
                <a href="reservas.html">Reservas</a> |
                <a href="nosotros.html">Nosotros</a> |
                <a href="login.html">Logout</a>
            </nav>
            <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
        </div>
    </footer>
</body>
</html>
