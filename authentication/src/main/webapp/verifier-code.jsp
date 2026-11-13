<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau mot de passe</title>

    <!-- Lien vers votre fichier CSS global -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<body>

<div class="container">

    <div class="login-icon">
        <i class="fa-solid fa-lock-open"></i>
    </div>

    <h2>Nouveau mot de passe</h2>

    <p class="subtitle">
        Saisissez le code reçu par email, puis choisissez votre nouveau mot de passe.
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
    <form action="ResetPasswordServlet" method="post">

        <div class="input-box">
            <i class="fa-solid fa-shield-keyhole"></i>
            <input 
                type="text" 
                name="code" 
                placeholder="Code à 6 chiffres"
                pattern="[0-9]{6}" 
                maxlength="6" 
                inputmode="numeric" 
                required>
        </div>

        <div class="input-box password-box">
            <i class="fa-solid fa-lock"></i>
            <input 
                type="password" 
                id="newPassword"
                name="newPassword"
                placeholder="Nouveau mot de passe (8 car. min)" 
                minlength="8" 
                required>
            <button
                type="button"
                class="toggle-password"
                data-target="newPassword"
                aria-label="Afficher le mot de passe">
                <i class="fa-solid fa-eye"></i>
            </button>
        </div>

        <div class="input-box password-box">
            <i class="fa-solid fa-shield-halved"></i>
            <input 
                type="password" 
                id="confirmPassword"
                name="confirmPassword"
                placeholder="Confirmer le mot de passe" 
                minlength="8" 
                required>
            <button
                type="button"
                class="toggle-password"
                data-target="confirmPassword"
                aria-label="Afficher la confirmation">
                <i class="fa-solid fa-eye"></i>
            </button>
        </div>

        <button type="submit" class="login-button">
            Changer le mot de passe
            <i class="fa-solid fa-check"></i>
        </button>

    </form>

    <div class="register-link">
        <a href="mot-de-passe-oublie.jsp">Renvoyer un code</a> • 
        <a href="index.jsp">Connexion</a>
    </div>

</div>

<!-- Script pour afficher / masquer les mots de passe -->
<script>
    document.querySelectorAll(".toggle-password").forEach(button => {
        button.addEventListener("click", function () {
            const targetId = this.getAttribute("data-target");
            const input = document.getElementById(targetId);
            const isPassword = input.type === "password";

            input.type = isPassword ? "text" : "password";
            this.innerHTML = isPassword
                ? '<i class="fa-solid fa-eye-slash"></i>'
                : '<i class="fa-solid fa-eye"></i>';
        });
    });
</script>

</body>
</html>