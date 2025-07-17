<%@ page session="true" %>
<%
    // Invalida la sesión
    session.invalidate();

    // Redirige al login
    response.sendRedirect("login.jsp");
%>
