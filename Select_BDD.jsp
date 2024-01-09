<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion à MariaDB via JSP</title>
</head>
<body>
    <h1>Exemple de connexion à MariaDB avec JSP</h1>

    <%
    try {
        String url = "jdbc:mariadb://localhost:3306/films";
        String user = "mysql";
        String password = "mysql";

        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT idFilm, titre, année FROM Film WHERE année >= 2000 AND année < 2015";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        List<Map<String, String>> films = new ArrayList<>();
        while (rs.next()) {
            Map<String, String> film = new HashMap<>();
            film.put("id", rs.getString("idFilm"));
            film.put("titre", rs.getString("titre"));
            film.put("année", rs.getString("année"));
            films.add(film);
        }

        rs.close();
        pstmt.close();
        conn.close();
    %>

    <h2>Films entre 2000 et 2015</h2>
    <c:forEach var="film" items="${films}">
        <p>id : ${film.id}, titre : ${film.titre}, année : ${film.année}</p>
    </c:forEach>

    <%
    } catch (Exception e) {
        e.printStackTrace();
    }
    %>

    <!-- Autres exercices ici... -->

</body>
</html>
