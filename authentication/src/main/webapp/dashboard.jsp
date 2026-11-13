<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Vérifier si l'utilisateur est connecté
    if (session.getAttribute("email") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Empêcher le navigateur de conserver la page en cache[cite: 3]
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil sécurisé</title>

    <!-- Lien vers votre fichier CSS global -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <!-- Font Awesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <!-- Style additionnel pour l'animation des étoiles en arrière-plan -->
    <style>
        body {
            position: relative;
            overflow: hidden;
            background: #09090b !important;
        }

        /* Génération des étoiles scintillantes en arrière-plan */
        .stars-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            pointer-events: none;
            z-index: 0;
            background: linear-gradient(135deg, #09090b 0%, #18181b 50%, #27060a 100%);
        }

        .star {
            position: absolute;
            background: #ffffff;
            border-radius: 50%;
            animation: twinkle var(--duration) infinite ease-in-out, drift var(--drift-duration) infinite linear;
            opacity: 0.3;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.2; transform: scale(0.8); }
            50% { opacity: 1; transform: scale(1.2); }
        }

        @keyframes drift {
            0% { transform: translateY(0) translateX(0); }
            100% { transform: translateY(-100vh) translateX(20px); }
        }

        /* S'assurer que le contenu reste au-dessus des étoiles */
        .container {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body>

    <!-- Conteneur des étoiles mouvementées -->
    <div class="stars-container" id="starsContainer"></div>

    <div class="container">

        <div class="login-icon">
            <i class="fa-solid fa-user-shield"></i>
        </div>

        <h2>Bienvenue !</h2>

        <p class="subtitle" style="word-break: break-all;">
            Connecté en tant que : <br>
            <strong style="color: #f87171;"><%= session.getAttribute("email") %></strong>[cite: 3]
        </p>

        <form action="logout.jsp" method="post">
            <button type="submit" class="login-button">
                Se déconnecter
                <i class="fa-solid fa-right-from-bracket"></i>
            </button>
        </form>

    </div>

    <!-- Script JavaScript pour générer dynamiquement les étoiles filantes/mouvementées -->
    <script>
        const container = document.getElementById('starsContainer');
        const numStars = 40; // Nombre d'étoiles

        for (let i = 0; i < numStars; i++) {
            const star = document.createElement('div');
            star.classList.add('star');
            
            // Position aléatoire
            star.style.left = Math.random() * 100 + 'vw';
            star.style.top = Math.random() * 100 + 'vh';
            
            // Taille aléatoire (entre 1px et 3px)
            const size = Math.random() * 2 + 1;
            star.style.width = size + 'px';
            star.style.height = size + 'px';
            
            // Durées d'animation aléatoires pour un effet naturel
            star.style.setProperty('--duration', (Math.random() * 3 + 2) + 's');
            star.style.setProperty('--drift-duration', (Math.random() * 15 + 10) + 's');
            
            container.appendChild(star);
        }
    </script>

</body>
</html>