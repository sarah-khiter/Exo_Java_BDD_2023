<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>

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

    // Fermer la connexion
    conn.close();
    %>

    <h2>Exercice 2 : Année de recherche</h2>
    <p>Créer un champ de saisie permettant à l'utilisateur de choisir l'année de sa recherche.</p>

    <h2>Exercice 3 : Modification du titre du film</h2>
    <p>Créer un fichier permettant de modifier le titre d'un film sur la base de son ID (ID choisi par l'utilisateur)</p>

    <h2>Exercice 4 : La valeur maximum</h2>
    <p>Créer un formulaire pour saisir un nouveau film dans la base de données</p>

</body>
</html>
