<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*" %>
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

<h1>Bienvenido, Supervisor</h1>

<%
    String url = "jdbc:mysql://localhost:3306/tu_basedatos";
    String user = "root";
    String pass = "tu_contraseña";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();
%>

<!-- ========== SECCIÓN: VENTAS ========= -->
<h2>Resumen de Ventas por Día</h2>
<table>
    <tr>
        <th>Día</th>
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
%>
</table>

<!-- ========== SECCIÓN: INVENTARIO ========= -->
<h2>Inventario Crítico</h2>
<table>
    <tr>
        <th>ID Producto</th>
        <th>Nombre</th>
        <th>Categoría</th>
        <th>Inventario</th>
        <th>Estado</th>
    </tr>
<%
        rs = stmt.executeQuery("SELECT * FROM Vista_Inventario_Critico");
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("ID_Producto") %></td>
        <td><%= rs.getString("Nombre") %></td>
        <td><%= rs.getString("Categoria") %></td>
        <td><%= rs.getInt("Inventario") %></td>
        <td><%= rs.getString("Estado_Stock") %></td>
    </tr>
<%
        }
%>
</table>

<!-- ========== SECCIÓN: REPORTES ========= -->
<h2>Top Clientes del Mes</h2>
<table>
    <tr>
        <th>ID Cliente</th>
        <th>Cliente</th>
        <th>Compras del Mes</th>
        <th>Monto Total</th>
    </tr>
<%
        rs = stmt.executeQuery("SELECT * FROM Vista_Top_Clientes_Mes");
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("ID_Cliente") %></td>
        <td><%= rs.getString("Cliente") %></td>
        <td><%= rs.getInt("Compras_Mes") %></td>
        <td>$<%= rs.getDouble("Monto_Total") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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