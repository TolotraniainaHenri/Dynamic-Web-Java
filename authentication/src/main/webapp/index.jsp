<%@ page import="java.io.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>

<%/*
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String erreur = "";

    if (session.getAttribute("email") != null) {
        response.sendRedirect("home.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean authentifie = false;

        String chemin = application.getRealPath("/WEB-INF/users.csv");

        try (BufferedReader br = new BufferedReader(
                new FileReader(chemin))) {

            String ligne;
            br.readLine(); // Ignorer l'en-tête

            while ((ligne = br.readLine()) != null) {

                String[] donnees = ligne.split(",", 2);

                if (donnees.length == 2) {

                    String emailCSV = donnees[0].trim();
                    String hashCSV = donnees[1].trim();

                    if (email != null && password != null
                            && email.trim().equalsIgnoreCase(emailCSV)
                            && BCrypt.checkpw(password, hashCSV)) {

                        authentifie = true;
                        break;
                    }
                }
            }

        } catch (Exception e) {
            application.log("Erreur de lecture du fichier CSV", e);
            erreur = "Erreur lors de la lecture du fichier CSV.";
        }

        if (authentifie) {

            session.invalidate();

            session = request.getSession(true);
            session.setAttribute("email", email.trim());

            response.sendRedirect("home.jsp");
            return;

        } else if (erreur.isEmpty()) {

            erreur = "Email ou mot de passe incorrect.";
        }
    }
*/%>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Connexion sécurisée</title>

    <link rel="stylesheet" href="css/style.css">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>

<body>

    <div class="container">

        <div class="login-icon">
            <i class="fa-solid fa-user-lock"></i>
        </div>

        <h2>Bienvenue !</h2>

        <p class="subtitle">
            Connectez-vous à votre compte
        </p>

        <!-- Message d'erreur -->
     	<%
		String erreur = (String) request.getAttribute("erreur");

			if (erreur != null && !erreur.isEmpty()) {
		%>

		<div class="error-message">
   		 <i class="fa-solid fa-circle-exclamation"></i>
   		 <%= erreur %>
		</div>

		<%
		}
		%>
        <!-- Message de succès -->
       <%
			String message = (String) request.getAttribute("message");
			if (message != null && !message.isEmpty()) {
		%>

     <div class="success-message">
        <%= message %>
    </div>

	<%}%>


        <!-- Formulaire de connexion -->
        <form action="LoginServlet" method="post">

            <div class="input-box">
                <i class="fa-solid fa-envelope"></i>

                <input
                    type="email"
                    name="email"
                    placeholder="Adresse email"
                    autocomplete="username"
                    required>
            </div>

            <div class="input-box password-box">

                <i class="fa-solid fa-lock"></i>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Mot de passe"
                    autocomplete="current-password"
                    required>

                <button
                    type="button"
                    class="toggle-password"
                    id="togglePassword"
                    aria-label="Afficher le mot de passe">

                    <i class="fa-solid fa-eye"></i>

                </button>

            </div>

            <div class="forgot-password">
                <a href="mot-de-passe-oublie.jsp">
                    Mot de passe oublié ?
                </a>
            </div>

            <button type="submit" class="login-button">
                Se connecter
                <i class="fa-solid fa-arrow-right"></i>
            </button>

        </form>

        <div class="register-link">
            Vous n'avez pas de compte ?
            <a href="inscription.jsp">Créer un compte</a>
        </div>

    </div>

    <script>

        const password = document.getElementById("password");
        const toggle = document.getElementById("togglePassword");

        toggle.addEventListener("click", function() {

            const visible = password.type === "password";

            password.type = visible ? "text" : "password";

            toggle.innerHTML = visible
                ? '<i class="fa-solid fa-eye-slash"></i>'
                : '<i class="fa-solid fa-eye"></i>';

            toggle.setAttribute(
                "aria-label",
                visible ? "Masquer le mot de passe" : "Afficher le mot de passe"
            );

        });

    </script>

</body>
</html>
