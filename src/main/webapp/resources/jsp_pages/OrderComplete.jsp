<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordine Completato con Successo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Ordine Completato con Successo!</h1>
    <% if (!request.getSession().getAttribute("userType").equals("guest")){%>
    <p>Grazie per il tuo acquisto. Il tuo ordine numero: ORDRN<%= request.getSession().getAttribute("lastOrder") %> è stato completato con successo. Puoi visionare tutti i tuoi ordine nella sezione dedicata. Premi qui per scaricare la fattura, oppure controlla la mail</p>
    <a href="${pageContext.request.contextPath}/ProductView.jsp" class="btn">Torna alla Homepage</a>
    <a href="${pageContext.request.contextPath}/Download" class="btn btn-download">Scarica Fattura</a>
    <% } else { %>
    <p>Grazie per il tuo acquisto. Il tuo ordine numero: ORDRN<%= request.getSession().getAttribute("lastOrder") %> è stato completato con successo. Premi qui per scaricare la fattura, oppure controlla la mail scelta precedentemente</p>
    <a href="${pageContext.request.contextPath}/logout" class="btn">Torna alla Homepage</a>
    <a href="${pageContext.request.contextPath}/Download" class="btn btn-download">Scarica Fattura</a>
    <% } %>
</div>
</body>
</html>
