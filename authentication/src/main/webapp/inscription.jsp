<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>

    <!-- Lien vers votre même fichier CSS sombre -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<body>

    <div class="container">

        <div class="login-icon">
            <i class="fa-solid fa-user-plus"></i>
        </div>

        <h2>Créer un compte</h2>

        <p class="subtitle">
            Rejoignez-nous en quelques secondes
        </p>

        <!-- Message d'erreur -->
        <% if (request.getAttribute("erreur") != null) { %>
            <div class="error-message">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= request.getAttribute("erreur") %></span>
            </div>
        <% } %>

        <!-- Formulaire d'inscription -->
        <form action="RegisterServlet" method="post">

            <div class="input-box">
                <i class="fa-solid fa-envelope"></i>
                <input
                    type="email"
                    name="email"
                    placeholder="Votre adresse email"
                    autocomplete="email"
                    required>
            </div>

            <div class="input-box password-box">
                <i class="fa-solid fa-lock"></i>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Votre mot de passe (8 car. min)"
                    autocomplete="new-password"
                    required
                    minlength="8">

                <button
                    type="button"
                    class="toggle-password"
                    data-target="password"
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
                    placeholder="Confirmez votre mot de passe"
                    autocomplete="new-password"
                    required
                    minlength="8">

                <button
                    type="button"
                    class="toggle-password"
                    data-target="confirmPassword"
                    aria-label="Afficher la confirmation">
                    <i class="fa-solid fa-eye"></i>
                </button>
            </div>

            <button type="submit" class="login-button">
                S'inscrire
                <i class="fa-solid fa-user-check"></i>
            </button>

        </form>

        <div class="register-link">
            Déjà un compte ?
            <a href="index.jsp">Se connecter</a>
        </div>

    </div>

    <!-- Script pour afficher/masquer les 2 mots de passe -->
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