<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Accesso negato</title>
</head>
<body>
<h1>403 - Accesso negato</h1>
<p>Non hai i permessi per accedere a questa risorsa.</p>
<p>Se hai tentato di accedere alla pagina B2B da privato, aggiorna il tuo profilo a venditore</p>
<button onclick="window.location.href='${pageContext.request.contextPath}/ProductView.jsp'">Torna alla Home</button>
</body>
</html>

