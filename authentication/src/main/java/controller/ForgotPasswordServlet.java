package controller;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.SecureRandom;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import util.EmailUtil;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final SecureRandom RANDOM = new SecureRandom();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("erreur", "Veuillez saisir votre adresse email.");
            request.getRequestDispatcher("mot-de-passe-oublie.jsp").forward(request, response);
            return;
        }

        email = email.trim();

        try {
            String chemin = getServletContext().getRealPath("/WEB-INF/users.csv");
            UserDAO dao = new UserDAO(chemin);
            User utilisateur = dao.findByEmail(email);

            if (utilisateur == null) {
                request.setAttribute("message",
                    "Si cette adresse existe, un code de vérification sera envoyé.");
                request.getRequestDispatcher("mot-de-passe-oublie.jsp").forward(request, response);
                return;
            }

            String code = String.valueOf(100000 + RANDOM.nextInt(900000));

            byte[] empreinte = MessageDigest.getInstance("SHA-256")
                    .digest(code.getBytes("UTF-8"));
            StringBuilder codeHash = new StringBuilder();
            for (byte b : empreinte) {
                codeHash.append(String.format("%02x", b));
            }

            String sujet = "Réinitialisation de votre mot de passe";
            String contenu =
                    "Bonjour,\n\n"
                    + "Voici votre code de vérification : " + code + "\n\n"
                    + "Ce code expire dans 10 minutes.\n"
                    + "Si vous n'avez pas demandé cette réinitialisation, ignorez cet email.";

            EmailUtil.envoyerEmail(email, sujet, contenu);

            HttpSession session = request.getSession(true);
            session.setAttribute("resetEmail", email);
            session.setAttribute("resetCodeHash", codeHash.toString());
            session.setAttribute("resetCodeExpiresAt", System.currentTimeMillis() + 10 * 60 * 1000);
            session.setAttribute("resetAttempts", 0);

        
            
            request.setAttribute("message",
                    "Un code de vérification a été envoyé à votre adresse email Bro!.");
            request.getRequestDispatcher("verifier-code.jsp").forward(request, response);

        } catch (Exception e) {

            getServletContext().log("Erreur pendant la récupération du mot de passe", e);

            // DEBUG : à remplacer plus tard par "Impossible d'envoyer le code. Veuillez réessayer."
            request.setAttribute("erreur", "Erreur : " + e);

            request.getRequestDispatcher("mot-de-passe-oublie.jsp").forward(request, response);
        }
    }
}