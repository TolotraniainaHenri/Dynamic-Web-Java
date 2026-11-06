<%
    // Vérifier si l'utilisateur est connecté
    if (session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Empêcher le navigateur de conserver la page en cache
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Accueil sécurisé</title>
</head>
<body>

    <h1>Bienvenue !</h1>

    <p>Connecté en tant que :
        <%= session.getAttribute("email") %>
    </p>

    <form action="logout.jsp" method="post">
        <button type="submit">Se déconnecter</button>
    </form>

</body>
</html>