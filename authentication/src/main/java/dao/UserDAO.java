package dao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;

import java.nio.charset.StandardCharsets;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.StandardOpenOption;

import model.User;

public class UserDAO {

    private final String chemin;

    public UserDAO(String chemin) {
        this.chemin = chemin;
    }

    // Empêche de casser le format CSV
    private boolean emailSansCaracteresInterdits(String email) {
        return email.indexOf(',') < 0
                && email.indexOf('\n') < 0
                && email.indexOf('\r') < 0;
    }

    // 1. Rechercher un utilisateur par email
    public synchronized User findByEmail(String email) throws IOException {

        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        Path fichier = Paths.get(chemin);

        if (!Files.exists(fichier)) {
            return null;
        }

        try (BufferedReader br = Files.newBufferedReader(fichier, StandardCharsets.UTF_8)) {

            String ligne;
            br.readLine(); // Ignorer l'en-tête

            while ((ligne = br.readLine()) != null) {

                String[] donnees = ligne.split(",", 2);

                if (donnees.length == 2) {
                    String emailCSV = donnees[0].trim();
                    String hashCSV = donnees[1].trim();

                    if (email.trim().equalsIgnoreCase(emailCSV)) {
                        return new User(emailCSV, hashCSV);
                    }
                }
            }
        }

        return null;
    }

    // 2. Ajouter un nouvel utilisateur
    public synchronized boolean addUser(User user) throws IOException {

        if (user == null
                || user.getEmail() == null
                || user.getPassword() == null
                || user.getEmail().trim().isEmpty()
                || user.getPassword().trim().isEmpty()
                || !emailSansCaracteresInterdits(user.getEmail())) {
            return false;
        }

        File fichier = new File(chemin);
        File dossier = fichier.getParentFile();

        if (dossier != null && !dossier.exists()) {
            dossier.mkdirs();
        }

        // Empêcher les doublons
        if (findByEmail(user.getEmail()) != null) {
            return false;
        }

        boolean ajouterEntete = !fichier.exists() || fichier.length() == 0;

        try (BufferedWriter bw = Files.newBufferedWriter(
                fichier.toPath(),
                StandardCharsets.UTF_8,
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND)) {

            if (ajouterEntete) {
                bw.write("email,password");
                bw.newLine();
            }

            bw.write(user.getEmail().trim());
            bw.write(",");
            bw.write(user.getPassword());
            bw.newLine();
        }

        return true;
    }

    // 3. Modifier le mot de passe d'un utilisateur
    public synchronized boolean updatePassword(String email, String nouveauHash)
            throws IOException {

        if (email == null || nouveauHash == null
                || email.trim().isEmpty()
                || nouveauHash.trim().isEmpty()) {
            return false;
        }

        Path fichierOriginal = Paths.get(chemin);

        if (!Files.exists(fichierOriginal)) {
            return false;
        }

        Path fichierTemporaire = Paths.get(chemin + ".tmp");
        boolean utilisateurTrouve = false;

        try {
            try (BufferedReader br = Files.newBufferedReader(fichierOriginal, StandardCharsets.UTF_8);
                 BufferedWriter bw = Files.newBufferedWriter(fichierTemporaire, StandardCharsets.UTF_8)) {

                String ligne;

                while ((ligne = br.readLine()) != null) {

                    String[] donnees = ligne.split(",", 2);

                    if (donnees.length == 2
                            && donnees[0].trim().equalsIgnoreCase(email.trim())) {

                        bw.write(donnees[0].trim() + "," + nouveauHash);
                        utilisateurTrouve = true;

                    } else {
                        bw.write(ligne);
                    }

                    bw.newLine();
                }
            }

            if (!utilisateurTrouve) {
                return false;
            }

            try {
                Files.move(fichierTemporaire, fichierOriginal,
                        StandardCopyOption.REPLACE_EXISTING,
                        StandardCopyOption.ATOMIC_MOVE);

            } catch (AtomicMoveNotSupportedException e) {
                Files.move(fichierTemporaire, fichierOriginal,
                        StandardCopyOption.REPLACE_EXISTING);
            }

            return true;

        } finally {
            // Si le .tmp existe encore (erreur ou utilisateur non trouvé), on le supprime
            Files.deleteIfExists(fichierTemporaire);
        }
    }
}