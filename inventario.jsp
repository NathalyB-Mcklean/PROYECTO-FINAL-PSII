<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inventario - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>

<!-- ========== HEADER NAV ========== -->
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
    <div class="container">
        <h1>📦 Inventario de Productos</h1>

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

        <!-- ========== VistaProductosConCategoria ========== -->
        <h2>Inventario General</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Inventario</th>
            </tr>
        <%
            rs = stmt.executeQuery("SELECT * FROM VistaProductosConCategoria");
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("ID_Producto") %></td>
                <td><%= rs.getString("Nombre") %></td>
                <td><%= rs.getString("Categoria") %></td>
                <td>$<%= rs.getDouble("Precio") %></td>
                <td><%= rs.getInt("Inventario") %></td>
            </tr>
        <%
            }
            rs.close();
        %>
        </table>

        <!-- ========== Vista_Inventario_Critico ========== -->
        <h2>⚠ Productos con Inventario Crítico</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Producto</th>
                <th>Categoría</th>
                <th>Inventario</th>
                <th>Estado</th>
                <th>Valor</th>
            </tr>
        <%
            rs = stmt.executeQuery("SELECT * FROM Vista_Inventario_Critico WHERE Estado_Stock IN ('CRÍTICO', 'AGOTADO')");
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("ID_Producto") %></td>
                <td><%= rs.getString("Nombre") %></td>
                <td><%= rs.getString("Categoria") %></td>
                <td><%= rs.getInt("Inventario") %></td>
                <td><%= rs.getString("Estado_Stock") %></td>
                <td>$<%= rs.getDouble("Valor_Inventario") %></td>
            </tr>
        <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error al cargar el inventario: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        %>
        </table>
    </div>
</body>

<!-- ========== FOOTER ========== -->
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

</html>