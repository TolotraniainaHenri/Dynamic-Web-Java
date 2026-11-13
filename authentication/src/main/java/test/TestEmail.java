package test;

import util.EmailUtil;

public class TestEmail {

    public static void main(String[] args) {

        try {

            String destinataire = "henritolotraniaina@gmail.com";

            EmailUtil.envoyerEmail(
                destinataire,
                "Test Gmail SMTP",
                "Bonjour ! Notre application Java fonctionne avec Gmail SMTP."
            );

            System.out.println("TEST REUSSI !");

        } catch (Exception e) {

            System.out.println("ECHEC DE L'ENVOI !");
            e.printStackTrace();
        }
    }
}