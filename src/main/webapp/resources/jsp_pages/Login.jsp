<%@ page language="java"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Login.css" type="text/css"/>
</head>
<body>

<%@ include file="Header.jsp" %>

<div class="container">
    <h2>Login</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
    <input type="hidden" name="fromCart" value="${param.fromCart}" />
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="submit" value="Accedi">
    </form>


    <div class="register-button">
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/Registration.jsp">Non hai un account? Registrati qui</a>
    </div>
    <% if (request.getParameter("fromCart") != null && request.getParameter("fromCart").equals("true")) { %>
    <div class="checkout-no-account">
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/Checkout.jsp">Premi qui per ordinare senza creare un account</a>
    </div>
    <% } %>
</div>


<% String error = request.getParameter("error");
    if (error != null && error.equals("invalidCredentials")) { %>
<div class="error-message">Credenziali non valide. Controlla e riprova.</div>
<% } %>





</body>
</html>
