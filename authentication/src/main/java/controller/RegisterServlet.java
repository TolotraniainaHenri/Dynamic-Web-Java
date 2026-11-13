package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import util.PasswordUtil;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Vérification des champs
        if (email == null || password == null
                || email.trim().isEmpty() || password.isEmpty()) {

            request.setAttribute("erreur", "Veuillez remplir tous les champs.");
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("erreur", "Les deux mots de passe ne correspondent pas.");
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
            return;
        }

        try {
            // Hachage du mot de passe
            String hash = PasswordUtil.hashPassword(password);

            // Création de l'utilisateur
            User utilisateur = new User(email.trim(), hash);

            // Chemin CSV : on ne le change pas
            String chemin = getServletContext().getRealPath("/WEB-INF/users.csv");

            UserDAO dao = new UserDAO(chemin);

            // Enregistrement
            boolean ajoute = dao.addUser(utilisateur);

            if (ajoute) {
                request.setAttribute("message", "Inscription réussie ! Vous pouvez vous connecter.");
                request.getRequestDispatcher("index.jsp").forward(request, response);

            } else {
                request.setAttribute("erreur", "Cette adresse email existe déjà.");
                request.getRequestDispatcher("inscription.jsp").forward(request, response);
            }

        } catch (Exception e) {

            getServletContext().log("Erreur pendant l'inscription", e);

            request.setAttribute("erreur", "Une erreur est survenue pendant l'inscription.");
            request.getRequestDispatcher("inscription.jsp").forward(request, response);
        }
    }
}