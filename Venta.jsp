<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
// Procesar el formulario si se envió
if ("POST".equalsIgnoreCase(request.getMethod())) {
    Connection conn = null;
    PreparedStatement pstmt = null;
    CallableStatement cstmt = null;
    
    try {
        // Obtener parámetros del formulario
        String producto = request.getParameter("producto");
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        double precio = Double.parseDouble(request.getParameter("precio"));
        int tipoPago = Integer.parseInt(request.getParameter("tipo_pago"));
        
        // Obtener conexión
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC",
            "root",
            ""  // Cambia si tu MySQL tiene contraseña
        );
        
        // Obtener ID del empleado
        String correo = (String) session.getAttribute("correo");
        String sqlEmpleado = "SELECT ID_Empleado FROM Empleado WHERE Correo = ?";
        pstmt = conn.prepareStatement(sqlEmpleado);
        pstmt.setString(1, correo);
        ResultSet rs = pstmt.executeQuery();
        
        int idEmpleado = 0;
        if (rs.next()) {
            idEmpleado = rs.getInt("ID_Empleado");
        }
        
        // Obtener ID del producto
        String sqlProducto = "SELECT ID_Producto FROM Producto WHERE Nombre = ?";
        pstmt = conn.prepareStatement(sqlProducto);
        pstmt.setString(1, producto);
        rs = pstmt.executeQuery();
        
        int idProducto = 0;
        if (rs.next()) {
            idProducto = rs.getInt("ID_Producto");
        }
        
        // Llamar al procedimiento almacenado RegistrarVenta
        String callSP = "{call RegistrarVenta(?, ?, ?, ?, ?, ?)}";
        cstmt = conn.prepareCall(callSP);
        
        // Parámetros: (cliente, empleado, tipo pago, producto, cantidad, precio)
        cstmt.setNull(1, Types.INTEGER);  // ID Cliente (null para venta anónima)
        cstmt.setInt(2, idEmpleado);      // ID Empleado
        cstmt.setInt(3, tipoPago);        // Tipo de pago
        cstmt.setInt(4, idProducto);      // ID Producto
        cstmt.setInt(5, cantidad);        // Cantidad
        cstmt.setDouble(6, precio);       // Precio unitario
        
        cstmt.execute();
        
        out.println("<script>alert('Venta registrada exitosamente!');</script>");
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    } finally {
        // Cerrar recursos
        if (cstmt != null) cstmt.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registrar Venta - Empleado</title>
  <link rel="stylesheet" href="style.css">
  <style>
    .venta-container {
      display: flex;
      justify-content: center;
      padding: 30px;
    }
    
    .venta-box {
      width: 50%;
      max-width: 500px;
      background-color: #f8f8f8;
      border-radius: 10px;
      padding: 25px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .venta-title {
      text-align: center;
      margin-bottom: 25px;
      color: #333;
      font-size: 1.8rem;
    }
    
    .form-group {
      margin-bottom: 15px;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    
    .form-group select,
    .form-group input {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    
    .submit-btn {
      background-color: #8B4513;
      color: white;
      border: none;
      padding: 12px 20px;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
      font-size: 1.1rem;
      margin-top: 10px;
    }
    
    .submit-btn:hover {
      background-color: #A0522D;
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
        <li><a href="mis_horarios.jsp">Mis Horarios</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <div class="venta-container">
      <div class="venta-box">
        <h1 class="venta-title">Registrar Nueva Venta</h1>
        
        <form method="post">
          <div class="form-group">
            <label for="producto">Producto:</label>
            <select id="producto" name="producto" required>
              <%
              Connection conn = null;
              Statement stmt = null;
              ResultSet rs = null;
              
              try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  conn = DriverManager.getConnection(
                      "jdbc:mysql://localhost:3306/pawscoffee?useSSL=false&serverTimezone=UTC",
                      "root",
                      ""
                  );
                  
                  String sql = "SELECT Nombre FROM Producto";
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(sql);
                  
                  while (rs.next()) {
                      String nombre = rs.getString("Nombre");
              %>
                  <option value="<%= nombre %>"><%= nombre %></option>
              <%
                  }
              } catch (Exception e) {
                  out.println("<option value=''>Error al cargar productos</option>");
              } finally {
                  if (rs != null) rs.close();
                  if (stmt != null) stmt.close();
                  if (conn != null) conn.close();
              }
              %>
            </select>
          </div>
          
          <div class="form-group">
            <label for="cantidad">Cantidad:</label>
            <input type="number" id="cantidad" name="cantidad" min="1" value="1" required>
          </div>
          
          <div class="form-group">
            <label for="precio">Precio Unitario ($):</label>
            <input type="number" id="precio" name="precio" step="0.01" min="0.01" required>
          </div>
          
          <div class="form-group">
            <label for="tipo_pago">Tipo de Pago:</label>
            <select id="tipo_pago" name="tipo_pago" required>
              <option value="1">Efectivo</option>
              <option value="2">Tarjeta</option>
              <option value="3">Transferencia</option>
            </select>
          </div>
          
          <button type="submit" class="submit-btn">Registrar Venta</button>
        </form>
      </div>
    </div>
  </main>
</body>
</html>