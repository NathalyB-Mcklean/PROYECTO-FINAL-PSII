<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Paws Coffee</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<!-- HEADER DINÁMICO -->
<%
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
%>
    <!-- Header para visitante no autenticado -->
    <header>
        <nav class="container">
            <div class="logo">🐾 PAWS COFFEE</div>
            <ul class="nav-links">
                <li><a href="home.jsp">Inicio</a></li>
                <li><a href="servicios.html">Servicios</a></li>
                <li><a href="menu.html">Menú</a></li>
                <li><a href="reservas.html">Reservas</a></li>
                <li><a href="nosotros.html">Nosotros</a></li>
                <li><a href="login.jsp" class="admin-btn">Login</a></li>
            </ul>
        </nav>
    </header>
<%
    } else if ("Cliente".equalsIgnoreCase(rol)) {
%>
    <header>
        <nav class="container">
            <div class="logo">🐾 PAWS COFFEE</div>
            <ul class="nav-links">
                <li><a href="home.jsp">Inicio</a></li>
                <li><a href="menu.jsp">Producto</a></li>
                <li><a href="reservas.html">Mis Reservas</a></li>
                <li><a href="compra.html">Mi pedido</a>
                <li><a href="logout.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
<%
    } else if ("Empleado".equalsIgnoreCase(rol)) {
%>
    <header>
        <nav class="container">
            <div class="logo">🐾 PAWS COFFEE</div>
            <ul class="nav-links">
                <li><a href="home.jsp">Inicio</a></li>
                <li><a href="ventas.jsp">Registrar Venta</a></li>
                <li><a href="horarios.jsp">Mis Horarios</a></li>
                <li><a href="logout.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
<%
    } else if ("Supervisor".equalsIgnoreCase(rol)) {
%>
    <header>
        <nav class="container">
            <div class="logo">🐾 PAWS COFFEE</div>
            <ul class="nav-links">
                <li><a href="home.jsp">Inicio</a></li>
                <li><a href="ventas.jsp">Ventas</a></li>
                <li><a href="inventario.jsp">Inventario</a></li>
                <li><a href="reportes.jsp">Reportes</a></li>
                <li><a href="logout.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
<%
    } else if ("Gerente".equalsIgnoreCase(rol)) {
%>
    <header>
        <nav class="container">
            <div class="logo">🐾 PAWS COFFEE</div>
            <ul class="nav-links">
                <li><a href="home.jsp">Inicio</a></li>
                <li><a href="reportes_financieros.jsp">Reportes Financieros</a></li>
                <li><a href="gestion_empleados.jsp">Gestión de Empleados</a></li>
                <li><a href="logout.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
<%
    }
%>

<!-- CONTENIDO PRINCIPAL -->
<main class="container" style="margin-top: 100px;">
    <section>
        <h1>Últimas Noticias</h1>
        <ul>
            <li>
                <h3>Artículo: ¿El café es malo para los perros?</h3>
                <p>Descubre los riesgos del consumo de café en mascotas, incluyendo síntomas de intoxicación por cafeína.</p>
                <a href="https://www.masterclass.com/articles/is-coffee-bad-for-dogs" target="_blank">Leer más</a>
            </li>
            <li>
                <h3>Artículo: ¿Pueden los perros beber café?</h3>
                <p>Un análisis sobre cómo la cafeína afecta a los perros según expertos veterinarios.</p>
                <a href="https://www.petmd.com/dog/nutrition/can-dogs-drink-coffee" target="_blank">Leer artículo</a>
            </li>
            <li>
                <h3>Video: Tour por un café pet‑friendly en NYC</h3>
                <p>Acompáñanos en este recorrido por una cafetería que combina café y mascotas en Nueva York.</p>
                <a href="https://www.youtube.com/watch?v=--YlKR8QUnw" target="_blank">Ver video</a>
            </li>
        </ul>
    </section>
</main>

<!-- FOOTER -->
<footer>
    <div class="container">
        <p>🐾 Síguenos: @PawsCoffeePanama | 
            <a href="https://www.google.com/search?q=paws+coffee+panama" target="_blank">🔍 Buscar</a>
        </p>
        <nav>
            <a href="home.jsp">Inicio</a> |
            <a href="servicios.html">Servicios</a> |
            <a href="menu.html">Menú</a> |
            <a href="reservas.html">Reservas</a> |
            <a href="nosotros.html">Nosotros</a> |
            <a href="logout.jsp">Cerrar Sesión</a>
        </nav>
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
    </div>
</footer>

</body>
</html>
