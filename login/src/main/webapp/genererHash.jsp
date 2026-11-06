<%@ page import="org.mindrot.jbcrypt.BCrypt" %>

<%
    String hash = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String password = request.getParameter("password");

        if (password != null && !password.isEmpty()) {
            hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Générateur BCrypt</title>
</head>
<body>

    <h2>Générer un hash BCrypt</h2>

    <form method="post" action="genererHash.jsp">
        <input type="password" name="password"
               placeholder="Mot de passe" required>
        <button type="submit">Générer</button>
    </form>

    <% if (hash != null) { %>
        <h3>Hash généré :</h3>
        <textarea rows="3" cols="70" readonly><%= hash %></textarea>
    <% } %>

</body>
</html>