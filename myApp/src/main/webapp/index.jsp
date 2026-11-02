
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulaire d'inscription</title>
</head>
<body>

    <h2>Formulaire d'inscription</h2>

    <form action="resultat.jsp" method="post">

        <label>Nom :</label>
        <input type="text" name="nom" required>
        <br><br>

        <label>Prénom :</label>
        <input type="text" name="prenom" required>
        <br><br>

        <label>Email :</label>
        <input type="email" name="email" required>
        <br><br>


        <label>Sexe :</label>
        <select name="sexe">
            <option value="Masculin">Masculin</option>
            <option value="Féminin">Féminin</option>
        </select>
        <br><br>

        <button type="submit">Envoyer</button>

    </form>

</body>
</html>
