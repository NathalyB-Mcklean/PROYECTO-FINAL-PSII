<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio de Sesión - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header>
    <nav class="container">
        <div class="logo">🐾 PAWS COFFEE</div>
        <ul class="nav-links">
            <li><a href="index.html">Inicio</a></li>
            <li><a href="servicios.html">Servicios</a></li>
            <li><a href="menu.html">Menú</a></li>
            <li><a href="reservas.html">Reservas</a></li>
            <li><a href="nosotros.html">Nosotros</a></li>
        </ul>
    </nav>
</header>

<main style="margin-top: 100px;">
    <section class="container">
        <div class="modal-content">
            <h2 style="margin-bottom: 2rem; color: #8B4513; text-align: center;">Acceso al Sistema</h2>
            <form method="post" action="login.jsp">
                <div class="form-group">
                    <label for="correo">Correo:</label>
                    <input type="email" id="correo" name="correo" required>
                </div>
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required>
                </div>
                <button type="submit" class="cta-button">Iniciar Sesión</button>
            </form>

<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    if (correo != null && contrasena != null) {
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Conexión a MySQL (ajusta usuario y contraseña según tu configuración)
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", 
                "root", 
                ""  // ← Pon tu contraseña si tiene
            );

            String sql = "SELECT Rol FROM Usuario WHERE Correo = ? AND Contrasena_hash = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, correo);
            stmt.setString(2, contrasena);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String rol = rs.getString("Rol");
                session.setAttribute("correo", correo);
                session.setAttribute("rol", rol);

                if ("Cliente".equalsIgnoreCase(rol)) {
                    response.sendRedirect("cliente.html");
                } else if ("Empleado".equalsIgnoreCase(rol)) {
                    response.sendRedirect("empleado.html");
                } else if ("Supervisor".equalsIgnoreCase(rol)) {
                    response.sendRedirect("supervisor.html");
                } else if ("Gerente".equalsIgnoreCase(rol)) {
                    response.sendRedirect("gerente.html");
                }
            } else {
                out.println("<p style='color:red;'>Credenciales inválidas</p>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
%>

        </div>
    </section>
</main>

<footer>
    <div class="footer-content">
        <ul class="footer-nav">
            <li><a href="index.html">Inicio</a></li>
            <li><a href="servicios.html">Servicios</a></li>
            <li><a href="menu.html">Menú</a></li>
            <li><a href="reservas.html">Reservas</a></li>
            <li><a href="nosotros.html">Nosotros</a></li>
        </ul>
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
        <a href="logout.jsp">Cerrar Sesión</a>
    </div>
</footer>

</body>
</html>
