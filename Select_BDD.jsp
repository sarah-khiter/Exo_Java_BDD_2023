<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>

    <!-- Exercice 1 -->
    <h2>Réponse de l'exercice 1 : Les films entre 2000 et 2015</h2>
    <% 
    String url = "jdbc:mariadb://localhost:3306/films";
    String user = "mysql";
    String password = "mysql";

    // Charger le pilote JDBC (pilote disponible dans WEB-INF/lib)
    Class.forName("org.mariadb.jdbc.Driver");

    // Établir la connexion
    Connection conn = DriverManager.getConnection(url, user, password);

    // Exemple de requête SQL pour l'exercice 1
    String sqlExercice1 = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 AND année < 2015";
    PreparedStatement pstmtExercice1 = conn.prepareStatement(sqlExercice1);
    ResultSet rsExercice1 = pstmtExercice1.executeQuery();

    // Afficher les résultats de l'exercice 1
    while (rsExercice1.next()) {
        String colonne1 = rsExercice1.getString("idFilm");
        String colonne2 = rsExercice1.getString("titre");
        String colonne3 = rsExercice1.getString("année");
        out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
    }

    // Fermer les ressources de l'exercice 1
    rsExercice1.close();
    pstmtExercice1.close();
    %>

    <!-- Exercice 2 -->
    <h2>Exercice 2 : Année de recherche</h2>
    <form method="post" action="">
        <label for="anneeRecherche">Saisir une année :</label>
        <input type="text" id="anneeRecherche" name="anneeRecherche">
        <input type="submit" value="Rechercher">
    </form>
    <%
    // Traitement de la saisie de l'utilisateur pour l'exercice 2
    String anneeRecherche = request.getParameter("anneeRecherche");
    if (anneeRecherche != null && !anneeRecherche.isEmpty()) {
        try {
            int annee = Integer.parseInt(anneeRecherche);
            String sqlExercice2 = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
            PreparedStatement pstmtExercice2 = conn.prepareStatement(sqlExercice2);
            pstmtExercice2.setInt(1, annee);
            ResultSet rsExercice2 = pstmtExercice2.executeQuery();

            // Afficher les résultats de l'exercice 2
            out.println("<h3>Résultats de la recherche pour l'année " + anneeRecherche + " :</h3>");
            while (rsExercice2.next()) {
                String colonne1 = rsExercice2.getString("idFilm");
                String colonne2 = rsExercice2.getString("titre");
                String colonne3 = rsExercice2.getString("année");
                out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
            }

            // Fermer les ressources de l'exercice 2
            rsExercice2.close();
            pstmtExercice2.close();
        } catch (NumberFormatException e) {
            out.println("<p>Erreur : Veuillez saisir une année valide.</p>");
        } catch (SQLException e) {
            // Ajouter des informations sur l'erreur SQL
            out.println("<p>Erreur SQL : " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
    %>

    <!-- Exercice 3 -->
    <h2>Exercice 3 : Modification du titre du film</h2>
    <form method="post" action="">
        <label for="idFilm">ID du film à modifier :</label>
        <input type="text" id="idFilm" name="idFilm" required>
        <label for="nouveauTitre">Nouveau titre :</label>
        <input type="text" id="nouveauTitre" name="nouveauTitre" required>
        <input type="submit" value="Modifier">
    </form>
    <%
    // Traitement de la saisie de l'utilisateur pour l'exercice 3
    String idFilm = request.getParameter("idFilm");
    String nouveauTitre = request.getParameter("nouveauTitre");
    if (idFilm != null && nouveauTitre != null && !idFilm.isEmpty() && !nouveauTitre.isEmpty()) {
        try {
            int filmID = Integer.parseInt(idFilm);
            String sqlExercice3 = "UPDATE Film SET titre = ? WHERE idFilm = ?";
            PreparedStatement pstmtExercice3 = conn.prepareStatement(sqlExercice3);
            pstmtExercice3.setString(1, nouveauTitre);
            pstmtExercice3.setInt(2, filmID);
            int rowsAffected = pstmtExercice3.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>Le titre du film avec l'ID " + filmID + " a été modifié avec succès.</p>");

                               // Rafraîchir la liste des films après la modification
                String sqlExercice1Refreshed = "SELECT idFilm, titre, année FROM Film WHERE année > 2000 AND année < 2015";
                PreparedStatement pstmtExercice1Refreshed = conn.prepareStatement(sqlExercice1Refreshed);
                ResultSet rsExercice1Refreshed = pstmtExercice1Refreshed.executeQuery();

                // Afficher les résultats de l'exercice 1 mis à jour
                out.println("<h3>Liste des films mise à jour :</h3>");
                while (rsExercice1Refreshed.next()) {
                    String colonne1 = rsExercice1Refreshed.getString("idFilm");
                    String colonne2 = rsExercice1Refreshed.getString("titre");
                    String colonne3 = rsExercice1Refreshed.getString("année");
                    out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "</br>");
                }

                // Fermer les ressources de la requête de rafraîchissement
                rsExercice1Refreshed.close();
                pstmtExercice1Refreshed.close();
            } else {
                out.println("<p>Aucun film trouvé avec l'ID " + filmID + ".</p>");
            }

            // Fermer les ressources de l'exercice 3
            pstmtExercice3.close();
        } catch (NumberFormatException e) {
            out.println("<p>Erreur : Veuillez saisir un ID valide.</p>");
        } catch (SQLException e) {
            // Ajouter des informations sur l'erreur SQL
            out.println("<p>Erreur SQL : " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
    %>

</body>
</html>
