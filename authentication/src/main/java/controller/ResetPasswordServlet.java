package controller;

import java.io.IOException;
import java.security.MessageDigest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import util.PasswordUtil;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MAX_TENTATIVES = 5;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // 1. Une demande de réinitialisation doit exister
        if (session == null || session.getAttribute("resetEmail") == null) {
            erreur(request, response, "mot-de-passe-oublie.jsp",
                   "Session expirée. Veuillez demander un nouveau code.");
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        String hashAttendu = (String) session.getAttribute("resetCodeHash");
        Long expiration = (Long) session.getAttribute("resetCodeExpiresAt");
        Integer tentatives = (Integer) session.getAttribute("resetAttempts");
        if (tentatives == null) tentatives = 0;

        // 2. Code expiré
        if (expiration == null || System.currentTimeMillis() > expiration) {
            nettoyer(session);
            erreur(request, response, "mot-de-passe-oublie.jsp",
                   "Le code a expiré. Veuillez en demander un nouveau.");
            return;
        }

        // 3. Trop de tentatives
        if (tentatives >= MAX_TENTATIVES) {
            nettoyer(session);
            erreur(request, response, "mot-de-passe-oublie.jsp",
                   "Trop de tentatives. Veuillez demander un nouveau code.");
            return;
        }

        String code = request.getParameter("code");
        String nouveau = request.getParameter("newPassword");
        String confirmation = request.getParameter("confirmPassword");

        // 4. Validation des champs
        if (code == null || nouveau == null || confirmation == null
                || code.trim().isEmpty() || nouveau.isEmpty()) {
            erreur(request, response, "verifier-code.jsp", "Veuillez remplir tous les champs.");
            return;
        }
        if (!nouveau.equals(confirmation)) {
            erreur(request, response, "verifier-code.jsp", "Les deux mots de passe ne correspondent pas.");
            return;
        }
        if (nouveau.length() < 8) {
            erreur(request, response, "verifier-code.jsp",
                   "Le mot de passe doit contenir au moins 8 caractères.");
            return;
        }

        try {
            // 5. Vérification du code (comparaison des hash SHA-256)
            byte[] empreinte = MessageDigest.getInstance("SHA-256")
                    .digest(code.trim().getBytes("UTF-8"));
            StringBuilder hashSaisi = new StringBuilder();
            for (byte b : empreinte) {
                hashSaisi.append(String.format("%02x", b));
            }

            boolean codeValide = MessageDigest.isEqual(
                    hashSaisi.toString().getBytes("UTF-8"),
                    hashAttendu.getBytes("UTF-8"));

            if (!codeValide) {
                session.setAttribute("resetAttempts", tentatives + 1);
                erreur(request, response, "verifier-code.jsp", "Code incorrect.");
                return;
            }

            // 6. Mise à jour du mot de passe
            String chemin = getServletContext().getRealPath("/WEB-INF/users.csv");
            UserDAO dao = new UserDAO(chemin);

            boolean modifie = dao.updatePassword(email, PasswordUtil.hashPassword(nouveau));

            if (!modifie) {
                erreur(request, response, "mot-de-passe-oublie.jsp", "Compte introuvable.");
                return;
            }

            // 7. Le code ne doit servir qu'une seule fois
            nettoyer(session);

            request.setAttribute("message",
                    "Mot de passe modifié avec succès. Vous pouvez vous connecter.");
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            getServletContext().log("Erreur pendant la réinitialisation", e);
            erreur(request, response, "verifier-code.jsp",
                   "Une erreur est survenue. Veuillez réessayer.");
        }
    }

    private void nettoyer(HttpSession session) {
        session.removeAttribute("resetEmail");
        session.removeAttribute("resetCodeHash");
        session.removeAttribute("resetCodeExpiresAt");
        session.removeAttribute("resetAttempts");
    }

    private void erreur(HttpServletRequest request, HttpServletResponse response,
                        String page, String message) throws ServletException, IOException {
        request.setAttribute("erreur", message);
        request.getRequestDispatcher(page).forward(request, response);
    }
}