<%
    // Détruire complètement la session
    session.invalidate();

    // Empêcher la mise en cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Retour à la connexion
    response.sendRedirect("login.jsp");
%>