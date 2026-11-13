package model;

public class User {

    private String email;
    private String password;

    // Constructeur vide
    public User() {
    }

    // Constructeur avec paramètres
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // Récupérer email
    public String getEmail() {
        return email;
    }

    // Modifier email
    public void setEmail(String email) {
        this.email = email;
    }

    // Récupérer password
    public String getPassword() {
        return password;
    }

    // Modifier password
    public void setPassword(String password) {
        this.password = password;
    }
}