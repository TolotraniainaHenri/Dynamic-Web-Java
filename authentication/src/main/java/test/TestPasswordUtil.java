package test;

import util.PasswordUtil;

public class TestPasswordUtil {

    public static void main(String[] args) {

        String motDePasse = "Bonjour123";

        // Hachage
        String hash = PasswordUtil.hashPassword(motDePasse);

        System.out.println("Mot de passe : " + motDePasse);

        System.out.println("Hash BCrypt : " + hash);

        // Vérification correcte
        boolean resultat1 =
            PasswordUtil.checkPassword(motDePasse, hash);

        System.out.println("Bon mot de passe : " + resultat1);

        // Vérification incorrecte
        boolean resultat2 =
            PasswordUtil.checkPassword("Mauvais123", hash);

        System.out.println("Mauvais mot de passe : " + resultat2);
    }
}