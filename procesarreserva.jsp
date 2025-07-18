<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Datos del formulario
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String telefono = request.getParameter("telefono");
    String mascota = request.getParameter("mascota");
    String fecha = request.getParameter("fecha");
    String hora = request.getParameter("hora");
    String cantidad = request.getParameter("cantidad");
    String evento = request.getParameter("evento");
    String solicitudes = request.getParameter("solicitudes");

    // Conexión a MySQL (ajusta usuario/clave si cambiaste)
    String url = "jdbc:mysql://localhost:3306/pawscoffee";
    String user = "root";
    String password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, user, password);

        // Preparar detalles combinados
        String detalles = "Mascota: " + mascota + ", Personas: " + cantidad + ", Evento: " + evento + ", Solicitudes: " + solicitudes;

        // Insertar en la tabla Reserva (ajusta según tu modelo si necesitas ID_Cliente)
        PreparedStatement ps = con.prepareStatement("INSERT INTO Reserva (Fecha, Detalles, ID_Cliente) VALUES (?, ?, NULL)");
        ps.setString(1, fecha);
        ps.setString(2, detalles);

        int filas = ps.executeUpdate();

        if (filas > 0) {
%>
            <h2>✅ ¡Reserva enviada con éxito!</h2>
            <p><a href="home.jsp">Volver al inicio</a></p>
<%
        } else {
%>
            <h2>❌ Ocurrió un error al guardar tu reserva.</h2>
<%
        }

        con.close();
    } catch (Exception e) {
%>
        <h2>❌ Error: <%= e.getMessage() %></h2>
<%
    }
%>
