<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Utente</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/MiddleUserData.css" type="text/css"/>
</head>
<body>

<div class="container">
    <h1>Benvenuto nella tua pagina utente</h1>
    <div class="links">
        <a href="UserData.jsp" class="btn">Inserisci dati personali</a>
        <a href="ViewUserData.jsp" class="btn">Visualizza ed elimina dati</a>
        <a href="${pageContext.request.contextPath}/ProductView.jsp" class="btn btn-secondary">Torna alla Home</a>
    </div>
</div>

</body>
</html>