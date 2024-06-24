<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    String fromCheckout = request.getParameter("fromCheckout");

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dati Personali</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="number"],
        .form-group input[type="date"],
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }


        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-secondary {
            background-color: #008CBA;
        }

        .btn:hover {
            background-color: #45a049;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .section {
            margin-bottom: 40px;
        }

    </style>
</head>
<body>
<div class="container">


    <div class="section">
        <h2>Indirizzo di Consegna</h2>
        <form action="${pageContext.request.contextPath}/Delivery?fromCheckout=${param.fromCheckout}" method="post">
            <div class="form-group">
                <label for="deliveryAddressCountry">Nazione</label>
                <input type="text" id="deliveryAddressCountry" name="deliveryAddressCountry" required>
            </div>
            <div class="form-group">
                <label for="deliveryAddressStreet">Via e numero civico</label>
                <input type="text" id="deliveryAddressStreet" name="deliveryAddressStreet" required>
            </div>
            <div class="form-group">
                <label for="deliveryAddressCity">Città</label>
                <input type="text" id="deliveryAddressCity" name="deliveryAddressCity" required>
            </div>
            <div class="form-group">
                <label for="deliveryAddressProvince">Provincia</label>
                <input type="text" id="deliveryAddressProvince" name="deliveryAddressProvince" required>
            </div>
            <div class="form-group">
                <label for="deliveryAddressZIP">CAP</label>
                <input type="text" id="deliveryAddressZIP" name="deliveryAddressZIP" required>
            </div>
            <button type="submit" class="btn">Salva Indirizzo di Consegna</button>
        </form>
    </div>

    <div class="section">
        <h2>Metodo di Pagamento</h2>
        <form action="${pageContext.request.contextPath}/Payment?fromCheckout=${param.fromCheckout}" method="post">
            <div class="form-group">
                <label for="cardholder_name">Nome Titolare della Carta</label>
                <input type="text" id="cardholder_name" name="cardholder_name" maxlength="100" required>
            </div>
            <div class="form-group">
                <label for="card_number">Numero della Carta</label>
                <input type="text" id="card_number" name="card_number" maxlength="20"  required>
            </div>
            <div class="form-group">
                <label for="expiry_month">Mese di Scadenza (1-12)</label>
                <input type="number" id="expiry_month" name="expiry_month" min="1" max="12"  required>
            </div>
            <div class="form-group">
                <label for="expiry_year">Anno di Scadenza (YYYY)</label>
                <input type="number" id="expiry_year" name="expiry_year" min="2024"  required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" maxlength="3" required>
            </div>
            <button type="submit" class="btn">Salva Metodo di Pagamento</button>
        </form>
    </div>

    <div class="section">
        <h2>Indirizzo di Fatturazione</h2>
        <form action="${pageContext.request.contextPath}/Billing?fromCheckout=${param.fromCheckout}" method="post">
            <div class="form-group">
                <label for="billingAddressStreet">Via e numero civico</label>
                <input type="text" id="billingAddressStreet" name="billingAddressStreet" required>
            </div>
            <div class="form-group">
                <label for="billingAddressCity">Città</label>
                <input type="text" id="billingAddressCity" name="billingAddressCity" required>
            </div>
            <div class="form-group">
                <label for="billingAddressProvince">Provincia</label>
                <input type="text" id="billingAddressProvince" name="billingAddressProvince" required>
            </div>
            <div class="form-group">
                <label for="billingAddressZIP">CAP</label>
                <input type="text" id="billingAddressZIP" name="billingAddressZIP" required>
            </div>
            <button type="submit" class="btn">Salva Indirizzo di Fatturazione</button>
        </form>
    </div>

</div>
<% if ("true".equals(fromCheckout)) { %>
<form action="Checkout.jsp" method="get">
    <button type="submit" class="btn btn-secondary">Torna al checkout</button>
</form>
<% } %>

</body>
</html>

