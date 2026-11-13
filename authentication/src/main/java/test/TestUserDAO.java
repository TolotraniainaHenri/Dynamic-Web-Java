package test;

import java.io.File;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

public class TestUserDAO {

    public static void main(String[] args) {

        File fichierTest = null;

        try {

            // Créer un CSV temporaire pour le test
            fichierTest = File.createTempFile(
                "users-test", ".csv"
            );

            String cheminTest = fichierTest.getAbsolutePath();

            UserDAO dao = new UserDAO(cheminTest);

            // Préparer un utilisateur
            String hash = PasswordUtil.hashPassword("Bonjour123");

            User utilisateur = new User(
                "test@gmail.com",
                hash
            );

            // TEST 1 : Ajouter
            boolean ajout = dao.addUser(utilisateur);

            System.out.println("Ajout : " + ajout);

            // TEST 2 : Rechercher
            User resultat = dao.findByEmail("test@gmail.com");

            System.out.println(
                "Utilisateur trouvé : " + (resultat != null)
            );

            // TEST 3 : Vérifier le mot de passe
            boolean verification = PasswordUtil.checkPassword(
                "Bonjour123",
                resultat.getPassword()
            );

            System.out.println(
                "Mot de passe correct : " + verification
            );

            // TEST 4 : Empêcher les doublons
            boolean doublon = dao.addUser(utilisateur);

            System.out.println(
                "Deuxième ajout accepté : " + doublon
            );

            // TEST 5 : Modifier le mot de passe
            String nouveauHash =
                PasswordUtil.hashPassword("Nouveau123");

            boolean modification = dao.updatePassword(
                "test@gmail.com",
                nouveauHash
            );

            System.out.println(
                "Modification : " + modification
            );

            // TEST 6 : Vérifier le nouveau mot de passe
            User utilisateurModifie =
                dao.findByEmail("test@gmail.com");

            boolean nouveauMotDePasse = PasswordUtil.checkPassword(
                "Nouveau123",
                utilisateurModifie.getPassword()
            );

            System.out.println(
                "Nouveau mot de passe correct : "
                + nouveauMotDePasse
            );

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            if (fichierTest != null) {
                fichierTest.delete();

                // Supprimer aussi le fichier temporaire éventuel
                new File(
                    fichierTest.getAbsolutePath() + ".tmp"
                ).delete();
            }
        }
    }
}