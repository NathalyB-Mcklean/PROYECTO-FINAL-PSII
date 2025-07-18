<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 2rem;
        }

        .producto-card {
            background-color: #f8f8f8;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            border: 1px solid #ddd;
            transition: transform 0.2s, background-color 0.3s;
        }

        .producto-card:hover {
            background-color: #eaeaea;
            transform: scale(1.02);
        }

        .producto-card h3 {
            color: #8B4513;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<header>
    <nav class="container">
        <div class="logo">🐾 PAWS COFFEE</div>
        <ul class="nav-links">
            <li><a href="home.jsp">Inicio</a></li>
            <li><a href="servicios.html">Servicios</a></li>
            <li><a href="menu.jsp">Producto</a></li>
            <li><a href="reservas.html">Reservas</a></li>
            <li><a href="nosotros.html">Nosotros</a></li>
            <li><a href="login.jsp" class="admin-btn">Login</a></li>
        </ul>
    </nav>
</header>

<main class="container" style="margin-top: 100px;">
    <section>
        <h1>Menú de Productos</h1>
        <div class="menu-grid">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", 
                    "root", 
                    ""
                );

                String sql = "SELECT p.Nombre AS Producto, p.Precio, c.Nombre AS Categoria " +
                             "FROM Producto p JOIN Categoria c ON p.ID_Categoria = c.ID_Categoria";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    String nombre = rs.getString("Producto");
                    double precio = rs.getDouble("Precio");
                    String categoria = rs.getString("Categoria");
        %>
            <div class="producto-card">
                <h3><%= nombre %></h3>
                <p>Categoría: <%= categoria %></p>
                <p>Precio: $<%= precio %></p>
            </div>
        <%
                }

                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error al cargar productos: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    </section>
</main>

<footer>
    <div class="container">
        <p>🐾 Síguenos: @PawsCoffeePanama | <a href="https://www.google.com" target="_blank">🔍 Buscar</a></p>
        <nav>
            <a href="home.jsp">Inicio</a> |
            <a href="servicios.html">Servicios</a> |
            <a href="menu.jsp">Menú</a> |
            <a href="reservas.html">Reservas</a> |
            <a href="nosotros.html">Nosotros</a> |
            <a href="logout.jsp">Cerrar Sesión</a>
        </nav>
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
    </div>
</footer>

</body>
</html>
