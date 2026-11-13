package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hacher un mot de passe
    public static String hashPassword(String password) {

        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException(
                "Le mot de passe ne peut pas être vide."
            );
        }

        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    // Vérifier un mot de passe
    public static boolean checkPassword(
            String password, String hash) {

        if (password == null || hash == null) {
            return false;
        }

        try {
            return BCrypt.checkpw(password, hash);

        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}