<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Utente</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --border-color: #bdc3c7;
            --hover-color: #2980b9;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            line-height: 1.6;
        }

        .container {
            text-align: center;
            background: #ffffff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
        }

        h1 {
            color: var(--secondary-color);
            margin-bottom: 30px;
        }

        .links {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .btn {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            font-size: 16px;
            text-decoration: none;
            color: #ffffff;
            background-color: var(--primary-color);
            border: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            width: 80%;
            max-width: 300px;
        }

        .btn:hover {
            background-color: var(--hover-color);
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: #34495e;
        }
    </style>
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