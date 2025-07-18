<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Horario de Empleado</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header>
    <nav class="container">
        <div class="logo">🐾 PAWS COFFEE</div>
        <ul class="nav-links">
            <li><a href="home.html">Inicio</a></li>
            <li><a href="gerente.html">Panel Gerente</a></li>
        </ul>
    </nav>
</header>

<main style="margin-top: 100px;">
    <section class="container">
        <div class="modal-content">
            <h2 style="text-align: center; color: #8B4513;">Gestionar Horario de Empleado</h2>

            <form method="post" action="gestionarHorario.jsp">

                <label for="idEmpleado">Seleccione Empleado:</label>
                <select id="idEmpleado" name="idEmpleado" required>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rsEmpleados = stmt.executeQuery("SELECT ID_Empleado, Nombre FROM Empleado");

                            while (rsEmpleados.next()) {
                                int id = rsEmpleados.getInt("ID_Empleado");
                                String nombre = rsEmpleados.getString("Nombre");
                    %>
                                <option value="<%= id %>"><%= nombre %> (ID: <%= id %>)</option>
                    <%
                            }
                            rsEmpleados.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<option disabled>Error al cargar empleados</option>");
                        }
                    %>
                </select>

                <label for="idHorarioAntiguo">Horario Actual:</label>
                <select id="idHorarioAntiguo" name="idHorarioAntiguo" required>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rsHorarios = stmt.executeQuery("SELECT ID_Horario, Descripcion FROM Horario");

                            while (rsHorarios.next()) {
                                int idHorario = rsHorarios.getInt("ID_Horario");
                                String desc = rsHorarios.getString("Descripcion");
                    %>
                                <option value="<%= idHorario %>"><%= desc %></option>
                    <%
                            }
                            rsHorarios.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<option disabled>Error al cargar horarios</option>");
                        }
                    %>
                </select>

                <label for="idHorarioNuevo">Nuevo Horario:</label>
                <select id="idHorarioNuevo" name="idHorarioNuevo" required>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rsHorarios = stmt.executeQuery("SELECT ID_Horario, Descripcion FROM Horario");

                            while (rsHorarios.next()) {
                                int idHorario = rsHorarios.getInt("ID_Horario");
                                String desc = rsHorarios.getString("Descripcion");
                    %>
                                <option value="<%= idHorario %>"><%= desc %></option>
                    <%
                            }
                            rsHorarios.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            out.println("<option disabled>Error al cargar horarios</option>");
                        }
                    %>
                </select>

                <button type="submit" class="cta-button">Actualizar Horario</button>
            </form>

<%
    String idEmpleadoStr = request.getParameter("idEmpleado");
    String idHorarioAntiguoStr = request.getParameter("idHorarioAntiguo");
    String idHorarioNuevoStr = request.getParameter("idHorarioNuevo");

    if (idEmpleadoStr != null && idHorarioAntiguoStr != null && idHorarioNuevoStr != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC", "root", "");

            CallableStatement cs = conn.prepareCall("{CALL CambiarHorarioEmpleado(?, ?, ?)}");
            cs.setInt(1, Integer.parseInt(idEmpleadoStr));
            cs.setInt(2, Integer.parseInt(idHorarioAntiguoStr));
            cs.setInt(3, Integer.parseInt(idHorarioNuevoStr));

            boolean hasResult = cs.execute();

            if (hasResult) {
                ResultSet result = cs.getResultSet();
                if (result.next()) {
%>
                    <p style="color:green; text-align:center; margin-top:1rem;">
                        <%= result.getString("mensaje") %>
                    </p>
<%
                }
                result.close();
            } else {
%>
                <p style="color:green; text-align:center; margin-top:1rem;">Horario actualizado correctamente.</p>
<%
            }
            cs.close();
            conn.close();
        } catch (Exception e) {
%>
            <p style="color:red; text-align:center; margin-top:1rem;">Error: <%= e.getMessage() %></p>
<%
        }
    }
%>

        </div>
    </section>
</main>

<footer>
    <div class="container">
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
    </div>
</footer>

</body>
</html>
