package util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // À remplacer : compte Gmail expéditeur + mot de passe d'application (16 lettres, sans espaces)
    private static final String EXPEDITEUR = "henritolotraniaina@gmail.com";
    private static final String MOT_DE_PASSE = "fpmiimcwtrpbjdin ";

    public static void envoyerEmail(String destinataire, String sujet, String contenu)
            throws MessagingException {

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");
        properties.put("mail.smtp.writetimeout", "10000");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EXPEDITEUR, MOT_DE_PASSE);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EXPEDITEUR));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
        message.setSubject(sujet, "UTF-8");
        message.setText(contenu, "UTF-8");

        Transport.send(message);

        System.out.println("Email envoyé avec succès à : " + destinataire);
    }
}