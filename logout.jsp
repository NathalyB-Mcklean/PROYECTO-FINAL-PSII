<%@ page session="true" %>
<%
    // Invalida la sesi�n actual
    session.invalidate();

    // Redirige al login
    response.sendRedirect("login.jsp");
%>
