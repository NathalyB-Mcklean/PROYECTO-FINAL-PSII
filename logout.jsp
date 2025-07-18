<%@ page session="true" %>
<%
    // Invalida la sesión actual
    session.invalidate();

    // Redirige al login
    response.sendRedirect("login.jsp");
%>
