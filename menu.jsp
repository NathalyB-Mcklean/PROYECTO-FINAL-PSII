<%@ page import="java.util.*, javax.servlet.http.*" %>
<%@ page session="true" %>
<html>
<head><title>Menú de Productos</title></head>
<body>
<h2>Catálogo de Productos</h2>
<%
    class Producto {
        int id;
        String nombre;
        double precio;
        Producto(int id, String nombre, double precio) {
            this.id = id; this.nombre = nombre; this.precio = precio;
        }
    }

    // Simulación de productos (en producción, leer desde la BD)
    List<Producto> productos = new ArrayList<>();
    productos.add(new Producto(1, "Latte de Avena", 3.50));
    productos.add(new Producto(2, "Croissant", 2.00));
    productos.add(new Producto(3, "Taza Paws Coffee", 5.00));

    // Recuperar carrito desde sesión
    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
    if (carrito == null) {
        carrito = new ArrayList<>();
        session.setAttribute("carrito", carrito);
    }

    // Agregar producto al carrito si hay ID recibido
    String idProd = request.getParameter("id");
    if (idProd != null) {
        int idSeleccionado = Integer.parseInt(idProd);
        for (Producto p : productos) {
            if (p.id == idSeleccionado) {
                carrito.add(p);
                break;
            }
        }
    }
%>

<table border="1">
<tr><th>Nombre</th><th>Precio</th><th>Acción</th></tr>
<%
    for (Producto p : productos) {
%>
<tr>
    <td><%= p.nombre %></td>
    <td>$<%= p.precio %></td>
    <td><a href="menu.jsp?id=<%= p.id %>">Agregar al carrito</a></td>
</tr>
<%
    }
%>
</table>

<p><a href="compra.jsp">Ver carrito y pagar</a></p>
</body>
</html>
