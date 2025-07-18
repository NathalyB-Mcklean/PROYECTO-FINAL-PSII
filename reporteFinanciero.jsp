<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reporte Financiero - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header>
    <nav class="container">
        <div class="logo">🐾 PAWS COFFEE</div>
        <ul class="nav-links">
            <li><a href="home.html">Inicio</a></li>
            <li><a href="servicios.html">Servicios</a></li>
            <li><a href="menu.html">Menú</a></li>
            <li><a href="reservas.html">Reservas</a></li>
            <li><a href="nosotros.html">Nosotros</a></li>
            <li><a href="gerente.html">Volver al Panel</a></li>
        </ul>
    </nav>
</header>

<main style="margin-top: 100px;">
    <section class="container">
        <div class="modal-content">
            <h2 style="margin-bottom: 2rem; color: #8B4513; text-align: center;">Reporte Financiero</h2>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC",
            "root",
            "" // Coloca tu contraseña si tienes
        );

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Vista_Resumen_Financiero");

        if (rs.next()) {
%>
            <ul style="list-style: none; padding: 0; font-size: 1.2rem;">
                <li><b>Total Ventas:</b> <%= rs.getInt("Total_Ventas") %></li>
                <li><b>Ingresos Totales:</b> $<%= rs.getDouble("Ingresos_Totales") %></li>
                <li><b>Total Reservas:</b> <%= rs.getInt("Total_Reservas") %></li>
                <li><b>Clientes Activos:</b> <%= rs.getInt("Clientes_Activos") %></li>
                <li><b>Empleados Activos:</b> <%= rs.getInt("Empleados_Activos") %></li>
            </ul>
<%
        } else {
%>
            <p style="color:red;">No se encontraron datos financieros.</p>
<%
        }

        conn.close();
    } catch(Exception e) {
%>
        <p style="color:red;">Error al conectar a la base de datos: <%= e.getMessage() %></p>
<%
    }
%>

            <div style="margin-top: 2rem; text-align: center;">
                <a href="gerente.html" class="cta-button">Volver al Panel del Gerente</a>
            </div>
        </div>
    </section>
</main>

<footer>
    <div class="container">
        <nav>
            <a href="home.html">Inicio</a> |
            <a href="servicios.html">Servicios</a> |
            <a href="menu.html">Menú</a> |
            <a href="reservas.html">Reservas</a> |
            <a href="nosotros.html">Nosotros</a> |
            <a href="logout.jsp">Cerrar Sesión</a>
        </nav>
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
    </div>
</footer>

</body>
</html>
