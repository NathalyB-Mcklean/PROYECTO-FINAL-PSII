<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Paws Coffee</title>
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
            <h2 style="margin-bottom: 2rem; color: #8B4513; text-align: center;">Registro de Cliente</h2>
            <form method="post" action="registro.jsp">
                <div class="form-group">
                    <label for="correo">Correo electrónico:</label>
                    <input type="email" id="correo" name="correo" required>
                </div>
                <div class="form-group">
                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required>
                </div>
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" required>
                </div>
                <div class="form-group">
                    <label for="apellido">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" required>
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" required>
                </div>
                <button type="submit" class="cta-button">Registrar</button>
            </form>

            <div style="margin-top: 1rem; text-align: center;">
                <p>¿Ya tienes cuenta? 
                    <a href="login.jsp" style="color: #8B4513; font-weight: bold;">Inicia sesión aquí</a>
                </p>
            </div>

<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String telefono = request.getParameter("telefono");

    if (correo != null && contrasena != null && nombre != null && apellido != null && telefono != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", 
                "root", 
                "" // ← cambia por tu contraseña si tiene
            );

            PreparedStatement psCheck = conn.prepareStatement(
                "SELECT * FROM Usuario WHERE Correo = ?"
            );
            psCheck.setString(1, correo);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                out.println("<p style='color:red;'>Ya existe un usuario con ese correo.</p>");
            } else {
                PreparedStatement psUsuario = conn.prepareStatement(
                    "INSERT INTO Usuario (Correo, Contrasena_hash, Rol) VALUES (?, ?, 'Cliente')",
                    Statement.RETURN_GENERATED_KEYS
                );
                psUsuario.setString(1, correo);
                psUsuario.setString(2, contrasena);
                psUsuario.executeUpdate();

                ResultSet generatedKeys = psUsuario.getGeneratedKeys();
                int idUsuario = -1;
                if (generatedKeys.next()) {
                    idUsuario = generatedKeys.getInt(1);
                }

                if (idUsuario != -1) {
                    PreparedStatement psCliente = conn.prepareStatement(
                        "INSERT INTO Cliente (ID_Usuario, Nombre, Apellido, Telefono, Correo) VALUES (?, ?, ?, ?, ?)"
                    );
                    psCliente.setInt(1, idUsuario);
                    psCliente.setString(2, nombre);
                    psCliente.setString(3, apellido);
                    psCliente.setString(4, telefono);
                    psCliente.setString(5, correo);
                    psCliente.executeUpdate();

                    out.println("<p style='color:green;'>¡Registro exitoso! Puedes iniciar sesión.</p>");
                } else {
                    out.println("<p style='color:red;'>Error al registrar usuario.</p>");
                }
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
