<%@ page language="java"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Subheader.css" type="text/css"/>
    <style>
        body {
            font-family: 'Varela Round', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f1f1;
        }

        .container {
            margin: 100px auto;
            width: 400px;
            background-color: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input[type="email"],
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 20px);
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .register-button {
            display: block;
            text-align: center;
            margin-top: 20px;
        }

        .register-button a {
            color: #4CAF50;
            text-decoration: none;
        }

        .error-message {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #a94442;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Login</h2>
    <form action="${pageContext.request.contextPath}/LoginControl" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Accedi">
    </form>
    <div class="register-button">
        <a href="Registration.jsp">Non hai un account? Registrati qui</a>
    </div>
    <% if (request.getParameter("fromProductView") != null && request.getParameter("fromProductView").equals("true")) { %>
    <div class="checkout-no-account">
        <a href="Checkout.jsp">Premi qui per ordinare senza creare un account</a>
    </div>
    <% } %>
</div>


<% String error = request.getParameter("error");
    if (error != null && error.equals("invalidCredentials")) { %>
<div class="error-message">Credenziali non valide. Controlla e riprova.</div>
<% } %>

</body>
</html>
