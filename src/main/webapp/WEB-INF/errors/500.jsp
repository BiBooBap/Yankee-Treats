<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Errore del server</title>
</head>
<body>
<h1>Errore del server</h1>
<p>Si è verificato un errore imprevisto. Per favore riprova più tardi.</p>
<p>Dettagli dell'errore: ${errorMessage}</p>
<button onclick="window.location.href='/ProductView.jsp'">Torna alla Home</button>
</body>
</html>

