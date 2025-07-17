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
<main class="container" style="margin-top: 100px;">
    <h1>Registro de Cliente</h1>
    <form method="post">
        <label>Correo electrónico:</label>
        <input type="email" name="correo" required>

        <label>Contraseña:</label>
        <input type="password" name="contrasena" required>

        <button type="submit">Registrar</button>
    </form>
</main>

<%
    String correo = request.getParameter("correo");
    String contrasena = request.getParameter("contrasena");

    if (correo != null && contrasena != null) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "PAWS", "1234"
            );

            // Verificar si el correo ya existe
            PreparedStatement psCheck = conn.prepareStatement(
                "SELECT * FROM Usuario WHERE Correo = ?"
            );
            psCheck.setString(1, correo);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                out.println("<p style='color:red;'>Ya existe un usuario con ese correo.</p>");
            } else {
                // Insertar nuevo cliente
                PreparedStatement psInsert = conn.prepareStatement(
                    "INSERT INTO Usuario (ID_Usuario, Correo, Contrasena, Rol) VALUES (seq_usuario.NEXTVAL, ?, ?, 'cliente')"
                );
                psInsert.setString(1, correo);
                psInsert.setString(2, contrasena);
                psInsert.executeUpdate();
                out.println("<p style='color:green;'>¡Registro exitoso! Puedes iniciar sesión.</p>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>

</body>
</html>
