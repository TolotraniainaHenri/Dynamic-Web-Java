package test;

import model.User;

public class TestUser {

    public static void main(String[] args) {

        User utilisateur = new User("test@gmail.com","123456");

        System.out.println("Email : " + utilisateur.getEmail());
        System.out.println("Mot de passe : " + utilisateur.getPassword());
    }
}