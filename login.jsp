<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio de Sesión - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
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

    <!-- Formulario -->
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

                <%-- Lógica de validación --%>
                <%
                    String correo = request.getParameter("correo");
                    String contrasena = request.getParameter("contrasena");

                    if (correo != null && contrasena != null) {
                        try {
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            Connection conn = DriverManager.getConnection(
                                "jdbc:oracle:thin:@localhost:1521:xe", "PAWS", "1234"
                            );

                            PreparedStatement ps = conn.prepareStatement(
                                "SELECT Rol FROM Usuario WHERE Correo = ? AND Contrasena = ?"
                            );
                            ps.setString(1, correo);
                            ps.setString(2, contrasena);

                            ResultSet rs = ps.executeQuery();

                            if (rs.next()) {
                                String rol = rs.getString("Rol");
                                session.setAttribute("correo", correo);
                                session.setAttribute("rol", rol);

                                switch (rol.toLowerCase()) {
                                    case "cliente":
                                        response.sendRedirect("cliente.html");
                                        break;
                                    case "empleado":
                                        response.sendRedirect("empleado.html");
                                        break;
                                    case "supervisor":
                                        response.sendRedirect("supervisor.html");
                                        break;
                                    case "gerente":
                                        response.sendRedirect("gerente.html");
                                        break;
                                    default:
                                        out.println("<p style='color:red;'>Rol no reconocido.</p>");
                                }
                            } else {
                                out.println("<p style='color:red;'>Correo o contraseña incorrectos.</p>");
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
</body>
</html>