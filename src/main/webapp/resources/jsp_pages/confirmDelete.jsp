<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conferma Eliminazione</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --border-color: #bdc3c7;
            --danger-color: #e74c3c;
            --success-color: #2ecc71;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }

        h2 {
            color: var(--secondary-color);
            margin-bottom: 20px;
            font-size: 24px;
        }

        p {
            margin-bottom: 30px;
            font-size: 16px;
            color: var(--text-color);
        }

        .btn-container {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 0;
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-transform: uppercase;
            width: 48%;
            text-align: center;
        }

        .btn-danger {
            background-color: var(--danger-color);
        }

        .btn-danger:hover {
            background-color: #c0392b;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: #34495e;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Conferma Eliminazione</h2>
    <p>Sei sicuro di voler eliminare questo prodotto?</p>
    <div class="btn-container">
        <form action="${pageContext.request.contextPath}/InsertProduct" method="post" style="width: 48%;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="code" value="${deleteCode}">
            <button type="submit" class="btn btn-danger">Elimina</button>
        </form>
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/DBInterface.jsp" class="btn btn-secondary">Annulla</a>
    </div>
</div>
</body>
</html>
