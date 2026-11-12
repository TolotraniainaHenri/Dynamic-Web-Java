# Configuration de l'envoi d'e-mails avec Gmail (SMTP)

## 1. Paramétrer le compte Google

Avant de commencer, il faut configurer le compte Google qui sera utilisé pour envoyer les e-mails.

- Ouvrir les paramètres du compte Google.
- Accéder à la rubrique **Sécurité**.
- Activer la **Validation en deux étapes**.

## 2. Créer un mot de passe d'application

Après avoir activé la validation en deux étapes :

- Accéder au lien suivant :
  https://myaccount.google.com/apppasswords
- Créer un nouveau mot de passe d'application.
- Donner un nom à l'application (exemple : Eclipse JSP).
- Copier le mot de passe généré.

**Important :**
- Le mot de passe d'application est différent du mot de passe Gmail habituel.
- Il permet à l'application Java de s'authentifier auprès du serveur SMTP de Google.
- Il doit rester confidentiel.
- Il est préférable de générer un mot de passe distinct pour chaque application ou projet.

## 3. Ajouter les bibliothèques nécessaires (JAR)

Les bibliothèques suivantes sont indispensables pour utiliser SMTP avec JavaMail :

- `javax.mail.jar`
- `activation-1.1.1.jar`

### Emplacement des fichiers

Copier les deux fichiers `.jar` dans le dossier :

```text
EnvoiEmail
   └── main
       └── webapp
           └── WEB-INF
               └── lib
                   ├── javax.mail.jar
                   └── activation-1.1.1.jar
```

## 4. Configuration SMTP Gmail

Voici les paramètres nécessaires :

| Paramètre | Valeur |
|---|---|
| Serveur SMTP | smtp.gmail.com |
| Port | 587 |
| Authentification | Activée |
| Sécurité | STARTTLS |
| Identifiant | Adresse Gmail |
| Mot de passe | Mot de passe d'application( fpmi imcw trpb jdin ) |

## 5. Résultat attendu

Une fois la configuration terminée, l'application Java/JSP peut utiliser le serveur SMTP de Gmail pour envoyer des e-mails.
