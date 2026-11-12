<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>

<%
    //String email = request.getParameter("email");
    //String password = request.getParameter("password");
    //String destinataire = request.getParameter("destinataire");
    
    String email = "henritolotraniaina@gmail.com";
    String password = "fpmiimcwtrpbjdin";
    String destinataire = "henritolotraniaina@gmail.com";

    try {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(email, password);
                }
            });

        Message message = new MimeMessage(mailSession);

        message.setFrom(new InternetAddress(email));

        message.setRecipients(
            Message.RecipientType.TO,
            InternetAddress.parse(destinataire)
        );

        message.setSubject("Test SMTP");

        message.setText("Bonjour ! Je suis tres content maintent pour mon premier projet SMPT.");

        Transport.send(message);

        out.println("<h2>Email envoyé avec succès !</h2>");

    } catch (Exception e) {

        out.println("<h2>Erreur lors de l'envoi</h2>");
        out.println(e.getMessage());

    }
%>