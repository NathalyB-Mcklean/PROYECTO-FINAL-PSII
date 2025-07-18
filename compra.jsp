<%@ page import="java.util.*" %>
<%@ page session="true" %>
<html>
<head><title>Mi carrito</title></head>
<body>
<h2>Tu carrito de compras</h2>
<%
    class Producto {
        int id;
        String nombre;
        double precio;
        Producto(int id, String nombre, double precio) {
            this.id = id; this.nombre = nombre; this.precio = precio;
        }
    }

    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
    if (carrito == null || carrito.size() == 0) {
%>
        <p>No has agregado productos.</p>
<%
    } else {
        double total = 0;
%>
        <table border="1">
        <tr><th>Producto</th><th>Precio</th></tr>
<%
        for (Producto p : carrito) {
            total += p.precio;
%>
        <tr>
            <td><%= p.nombre %></td>
            <td>$<%= p.precio %></td>
        </tr>
<%
        }
%>
        </table>
        <p><strong>Total: $<%= total %></strong></p>

        <h3>Seleccione el tipo de pago</h3>
        <form action="compra.jsp" method="post">
            <select name="tipoPago">
                <option value="1">Efectivo</option>
                <option value="2">Tarjeta</option>
                <option value="3">Transferencia</option>
            </select>
            <input type="submit" value="Pagar">
        </form>
<%
        if (request.getMethod().equals("POST")) {
            // Simulación de proceso de pago
            int tipoPago = Integer.parseInt(request.getParameter("tipoPago"));
            String metodo = (tipoPago == 1) ? "Efectivo" : (tipoPago == 2) ? "Tarjeta" : "Transferencia";
%>
            <p style="color:green"><strong>Compra realizada exitosamente. Método: <%= metodo %></strong></p>
<%
            carrito.clear(); // Limpiar carrito
        }
    }
%>
<p><a href="menu.jsp">Volver al menú</a></p>
</body>
</html>
