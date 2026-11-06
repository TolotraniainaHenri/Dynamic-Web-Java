<%@ page import="java.io.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>

<%
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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion sécurisée</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>

    <div class="container">

        <h2>Connexion</h2>

        <% if (!erreur.isEmpty()) { %>
            <p style="color:red;"><%= erreur %></p>
        <% } %>

        <form method="post" action="login.jsp">

            <input type="email" name="email"
                   placeholder="Adresse email" required>

           <div class="password-box">
    <input type="password"
           id="password"
           name="password"
           placeholder="Mot de passe"
           required>

         <i class="fa-solid fa-eye toggle-password"
             id="eye"
           onclick="togglePassword()"></i>
    </div>

            <button type="submit">Se connecter</button>

        </form>

    </div>

</body>
<script>
function togglePassword() {
    const password = document.getElementById("password");
    const eye = document.getElementById("eye");

    if (password.type === "password") {
        password.type = "text";
        eye.classList.remove("fa-eye");
        eye.classList.add("fa-eye-slash");
    } else {
        password.type = "password";
        eye.classList.remove("fa-eye-slash");
        eye.classList.add("fa-eye");
    }
}
</script>
</html>