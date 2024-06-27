<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    String fromCheckout = request.getParameter("fromCheckout");
    String guest = request.getParameter("guest");
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dati Personali</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --border-color: #bdc3c7;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h2 {
            color: var(--secondary-color);
            margin-bottom: 20px;
        }

        .section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: var(--secondary-color);
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 16px;
        }

        .btn {
            display: inline-block;
            background-color: var(--primary-color);
            color: #ffffff;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: var(--secondary-color);
        }

        .btn-secondary:hover {
            background-color: #34495e;
        }

        .form-buttons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Dati Personali</h1>

    <form id="mainForm" action="${pageContext.request.contextPath}/SaveAllUserData" method="post">
        <input type="hidden" name="action" id="formAction" value="">
        <input type="hidden" name="fromCheckout" value="${param.fromCheckout}">

        <div class="section">
            <h2>Indirizzo di Consegna</h2>
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
            <div class="form-buttons">
                <button type="button" class="btn" onclick="submitForm('saveDelivery')">Salva Indirizzo di Consegna</button>
            </div>
        </div>

        <div class="section">
            <h2>Metodo di Pagamento</h2>
            <div class="form-group">
                <label for="cardholder_name">Nome Titolare della Carta</label>
                <input type="text" id="cardholder_name" name="cardholder_name" maxlength="100" required>
            </div>
            <div class="form-group">
                <label for="card_number">Numero della Carta</label>
                <input type="text" id="card_number" name="card_number" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="expiry_month">Mese di Scadenza (1-12)</label>
                <input type="number" id="expiry_month" name="expiry_month" min="1" max="12" required>
            </div>
            <div class="form-group">
                <label for="expiry_year">Anno di Scadenza (YYYY)</label>
                <input type="number" id="expiry_year" name="expiry_year" min="2024" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" maxlength="3" required>
            </div>
            <div class="form-buttons">
                <button type="button" class="btn" onclick="submitForm('savePayment')">Salva Metodo di Pagamento</button>
            </div>
        </div>

        <div class="section">
            <h2>Indirizzo di Fatturazione</h2>
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
            <div class="form-buttons">
                <button type="button" class="btn" onclick="submitForm('saveBilling')">Salva Indirizzo di Fatturazione</button>
            </div>
        </div>

        <div class="form-buttons">
            <button type="button" class="btn" onclick="submitForm('saveAll')">Salva Tutte le Informazioni</button>
        </div>
    </form>

    <% if ("true".equals(fromCheckout)) { %>
    <form action="Checkout.jsp" method="get" style="margin-top: 20px;">
        <button type="submit" class="btn btn-secondary">Torna al checkout</button>
    </form>
    <% } %>

    <% if ("true".equals(guest)) { %>
    <form action="Checkout.jsp" method="get" style="margin-top: 20px;">
        <button type="submit" class="btn btn-secondary">Procedi con il checkout</button>
    </form>
    <% } %>
</div>

<script>
    function submitForm(action) {
        document.getElementById('formAction').value = action;
        document.getElementById('mainForm').submit();
    }
</script>

</body>
</html>