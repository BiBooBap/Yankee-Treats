<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Errore del server</title>
</head>
<body>
<h1>Errore del server</h1>
<p>Si &eacute; verificato un errore imprevisto. Per favore riprova più tardi.</p>
<p>Dettagli dell'errore: ${errorMessage}</p>
<button onclick="window.location.href='${pageContext.request.contextPath}/ProductView.jsp'">Torna alla Home</button>
</body>
</html>

