<%@ page import="java.sql.*" %>
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
        </ul>
    </nav>
</header>

<main class="container" style="margin-top:100px;">
    <h1>Reporte Financiero</h1>

    <%
        String url = "jdbc:mysql://localhost:3306/tu_basedatos";
        String user = "root";
        String password = "tu_contraseña";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, password);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Vista_Resumen_Financiero");

            if (rs.next()) {
    %>
    <section>
        <h2>Resumen General</h2>
        <ul>
            <li><strong>Total Ventas:</strong> <%= rs.getInt("Total_Ventas") %></li>
            <li><strong>Ingresos Totales:</strong> $<%= rs.getDouble("Ingresos_Totales") %></li>
            <li><strong>Total Reservas:</strong> <%= rs.getInt("Total_Reservas") %></li>
            <li><strong>Clientes Activos:</strong> <%= rs.getInt("Clientes_Activos") %></li>
            <li><strong>Empleados Activos:</strong> <%= rs.getInt("Empleados_Activos") %></li>
        </ul>
    </section>
    <%
            }
            con.close();
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error al cargar datos financieros: " + e.getMessage() + "</p>");
        }
    %>
</main>
</body>
</html>
