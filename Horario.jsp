<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Mis Horarios - Empleado</title>
  <link rel="stylesheet" href="style.css">
  <style>
    .horario-container {
      display: flex;
      justify-content: center;
      padding: 30px;
    }
    
    .horario-box {
      width: 70%;
      max-width: 800px;
      background-color: #f8f8f8;
      border-radius: 10px;
      padding: 25px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .horario-title {
      text-align: center;
      margin-bottom: 25px;
      color: #333;
      font-size: 1.8rem;
    }
    
    .horario-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 1.1rem;
    }
    
    .horario-table th,
    .horario-table td {
      padding: 12px 15px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }
    
    .horario-table th {
      background-color: #8B4513;
      color: white;
      font-weight: bold;
    }
    
    .horario-table tr:nth-child(even) {
      background-color: #f2f2f2;
    }
    
    .horario-table tr:hover {
      background-color: #e9e9e9;
    }
  </style>
</head>
<body>
  <header>
    <nav class="container">
      <div class="logo">🐾 PAWS COFFEE</div>
      <ul class="nav-links">
        <li><a href="home.jsp">Inicio</a></li>
        <li><a href="empleado.jsp">Panel</a></li>
        <li><a href="registrar_venta.jsp">Registrar Venta</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <div class="horario-container">
      <div class="horario-box">
        <h1 class="horario-title">Mi Horario de Trabajo</h1>
        
        <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            // Obtener conexión
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC",
                "root",
                ""  // Cambia si tu MySQL tiene contraseña
            );
            
            // Obtener correo del empleado de la sesión
            String correo = (String) session.getAttribute("correo");
            
            // Consulta para obtener el horario del empleado
            String sql = "SELECT h.Dia, h.Hora_Inicio, h.Hora_Fin " +
                         "FROM Empleado e " +
                         "JOIN EmpleadoHorario eh ON e.ID_Empleado = eh.ID_Empleado " +
                         "JOIN Horario h ON eh.ID_Horario = h.ID_Horario " +
                         "WHERE e.Correo = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, correo);
            rs = pstmt.executeQuery();
        %>
        
        <table class="horario-table">
          <thead>
            <tr>
              <th>Día</th>
              <th>Hora Inicio</th>
              <th>Hora Fin</th>
            </tr>
          </thead>
          <tbody>
            <% while (rs != null && rs.next()) { %>
                <tr>
                  <td><%= rs.getString("Dia") %></td>
                  <td><%= rs.getTime("Hora_Inicio") %></td>
                  <td><%= rs.getTime("Hora_Fin") %></td>
                </tr>
            <% } %>
          </tbody>
        </table>
        
        <%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red; text-align:center;'>Error al cargar horarios: " + e.getMessage() + "</p>");
        } finally {
            // Cerrar recursos
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        %>
      </div>
    </div>
  </main>
</body>
</html>