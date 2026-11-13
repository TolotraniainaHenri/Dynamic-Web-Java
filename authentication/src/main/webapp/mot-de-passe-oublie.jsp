<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mot de passe oublié</title>

    <!-- Lien vers votre fichier CSS sombre transparent -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<body>

    <div class="container">

        <div class="login-icon">
            <i class="fa-solid fa-key"></i>
        </div>

        <h2>Mot de passe oublié ?</h2>

        <p class="subtitle">
            Entrez votre adresse email pour recevoir un code de vérification.
        </p>

        <!-- Message de succès -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null && !message.isEmpty()) {
        %>
            <div class="success-message">
                <i class="fa-solid fa-circle-check"></i>
                <span><%= message %></span>
            </div>
        <% } %>

        <!-- Message d'erreur -->
        <%
            String erreur = (String) request.getAttribute("erreur");
            if (erreur != null && !erreur.isEmpty()) {
        %>
            <div class="error-message">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= erreur %></span>
            </div>
        <% } %>

        <!-- Formulaire -->
        <form action="ForgotPasswordServlet" method="post">

            <div class="input-box">
                <i class="fa-solid fa-envelope"></i>
                <input
                    type="email"
                    name="email"
                    placeholder="Votre adresse email"
                    autocomplete="email"
                    required>
            </div>

            <button type="submit" class="login-button">
                Envoyer le code
                <i class="fa-solid fa-paper-plane"></i>
            </button>

        </form>

        <div class="register-link">
            <a href="index.jsp">
                <i class="fa-solid fa-arrow-left"></i> Retour à la connexion
            </a>
        </div>

    </div>

</body>
</html>