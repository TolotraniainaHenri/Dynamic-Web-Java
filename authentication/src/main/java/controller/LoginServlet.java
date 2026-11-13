package controller;

import java.io.IOException;

/*import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
SATRIA VERSION 10.0.27 
*/
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.UserDAO;
import model.User;
import util.PasswordUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setHeader(
            "Cache-Control",
            "no-cache, no-store, must-revalidate"
        );

        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty()
                || password.isEmpty()) {

            request.setAttribute(
                "erreur",
                "Veuillez remplir tous les champs."
            );

            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);

            return;
        }

        String chemin = getServletContext()
                .getRealPath("/WEB-INF/users.csv");

        UserDAO dao = new UserDAO(chemin);

        try {

            User utilisateur = dao.findByEmail(email);

            if (utilisateur != null
                    && PasswordUtil.checkPassword(
                        password,
                        utilisateur.getPassword())) {

                HttpSession ancienneSession =
                        request.getSession(false);

                if (ancienneSession != null) {
                    ancienneSession.invalidate();
                }

                HttpSession session =
                        request.getSession(true);

                session.setAttribute(
                    "email",
                    utilisateur.getEmail()
                );

                response.sendRedirect("dashboard.jsp");

                return;

            } else {

                request.setAttribute(
                    "erreur",
                    "Email ou mot de passe incorrect."
                );

                request.getRequestDispatcher("index.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {

            getServletContext().log(
                "Erreur pendant la connexion",
                e
            );

            request.setAttribute(
                "erreur",
                "Une erreur est survenue pendant la connexion."
            );

            request.getRequestDispatcher("index.jsp")
                   .forward(request, response);
        }
    }
}