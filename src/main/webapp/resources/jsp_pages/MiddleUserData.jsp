<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina Utente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            text-align: center;
            background: #fff;
            border: 2px solid #1e90ff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #1e90ff;
        }

        .links {
            margin-top: 20px;
        }

        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            color: #fff;
            background-color: #1e90ff;
            border: 2px solid #1e90ff;
            border-radius: 5px;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .btn:hover {
            background-color: #ff4500;
            border-color: #ff4500;
        }

        .btn:active {
            background-color: #ff6347;
            border-color: #ff6347;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Benvenuto nella tua pagina utente</h1>
    <div class="links">
        <a href="UserData.jsp" class="btn">Inserisci dati personali</a>
        <a href="ViewUserData.jsp" class="btn">Visualizza ed elimina dati</a>
    </div>
</div>
</body>
</html>
