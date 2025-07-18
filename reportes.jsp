<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reportes - Panel del Supervisor</title>
    <link rel="stylesheet" href="style.css">
</head>

<!-- Encabezado / Navegación -->
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

<body>
    <main class="container">
        <h1>📊 Reportes del Supervisor</h1>

        <!-- Reporte de Ventas -->
        <section class="reporte">
            <h2>📅 Ventas Mensuales</h2>
            <table>
                <thead>
                    <tr>
                        <th>Mes</th>
                        <th>Ventas Totales ($)</th>
                        <th>Transacciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Julio</td>
                        <td>2,350.00</td>
                        <td>157</td>
                    </tr>
                    <tr>
                        <td>Junio</td>
                        <td>1,980.00</td>
                        <td>138</td>
                    </tr>
                    <tr>
                        <td>Mayo</td>
                        <td>2,100.00</td>
                        <td>143</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <!-- Reporte de Inventario Bajo -->
        <section class="reporte">
            <h2>📦 Inventario Crítico</h2>
            <table>
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Categoría</th>
                        <th>Stock Disponible</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Café en grano Premium</td>
                        <td>Bebidas</td>
                        <td>5 unidades</td>
                    </tr>
                    <tr>
                        <td>Snacks para Mascotas</td>
                        <td>Mascotas</td>
                        <td>3 unidades</td>
                    </tr>
                </tbody>
            </table>
        </section>
    </main>
</body>

<!-- Pie de página -->
<footer>
    <div class="container">
        <p>🐾 Síguenos: @PawsCoffeePanama | <a href="https://www.google.com" target="_blank">🔍 Buscar</a></p>
        <nav>
            <a href="index.html">Inicio</a> |
            <a href="servicios.html">Servicios</a> |
            <a href="menu.html">Menú</a> |
            <a href="reservas.html">Reservas</a> |
            <a href="nosotros.html">Nosotros</a> |
            <a href="login.html">Logout</a>
        </nav>
        <p>&copy; 2025 Paws Coffee. Todos los derechos reservados.</p>
    </div>
</footer>
</html>
