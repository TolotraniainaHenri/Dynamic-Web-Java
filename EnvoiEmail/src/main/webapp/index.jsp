<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Authentification Email</title>
</head>
<body>

    <h2>Authentification SMTP</h2>

    <form action="envoyer.jsp" method="post">

        Email :
        <input type="email" name="email" required>
        <br><br>

        Mot de passe d'application :
        <input type="password" name="password" required>
        <br><br>

        Destinataire :
        <input type="email" name="destinataire" required>
        <br><br>

        <button type="submit">Envoyer Bonjour</button>

    </form>

</body>
</html>