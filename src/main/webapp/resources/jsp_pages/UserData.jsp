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
        @import url('https://fonts.googleapis.com/css2?family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Playwrite+GB+S:ital,wght@0,100..400;1,100..400&display=swap');
        @import url("https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900");

        body {
            font-family: "Varela Round", sans-serif;
            background-color: white;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background: linear-gradient(145deg, #ffffff, #f0f0f0);
            box-shadow: 10px 10px 20px #d1d1d1, -10px -10px 20px #ffffff;
            border-radius: 20px;
        }

        h1, h2 {
            color: #2ba8fb;
            font-family: 'Poppins', sans-serif;
            margin-bottom: 20px;
        }

        .section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: rgba(128, 128, 128, 0.13);
            border-radius: 10px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            background-color: rgba(128, 128, 128, 0.13);
        }

        .btn {
            display: inline-block;
            background-color: #4caf50;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #45a049;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }

        .btn-secondary {
            background-color: #2ba8fb;
        }

        .btn-secondary:hover {
            background-color: #1c8ad9;
        }

        .form-buttons {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Dati Personali</h1>

    <form id="deliveryForm" action="${pageContext.request.contextPath}/SaveAllUserData" method="post">
        <input type="hidden" name="action" value="saveDelivery">
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
                <button type="submit" class="btn">Salva Indirizzo di Consegna</button>
            </div>
        </div>
    </form>

    <form id="paymentForm" action="${pageContext.request.contextPath}/SaveAllUserData" method="post">
        <input type="hidden" name="action" value="savePayment">
        <input type="hidden" name="fromCheckout" value="${param.fromCheckout}">

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
                <button type="submit" class="btn">Salva Metodo di Pagamento</button>
            </div>
        </div>
    </form>

    <form id="methodForm" action="${pageContext.request.contextPath}/SaveAllUserData" method="post">
    <input type="hidden" name="action" value="saveBilling">
    <input type="hidden" name="fromCheckout" value="${param.fromCheckout}">

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
            <button type="submit" class="btn">Salva Indirizzo di Fatturazione</button>
        </div>
    </div>
    </form>

    <% if ("true".equals(fromCheckout)) { %>
    <form action="Checkout.jsp" method="get" style="margin-top: 20px;">
        <button type="submit" class="btn btn-secondary">Torna al Checkout</button>
    </form>
    <% } %>

    <% if ("true".equals(guest)) { %>
    <form action="Checkout.jsp" method="get" style="margin-top: 20px;">
        <button type="submit" class="btn btn-secondary">Procedi con il checkout</button>
    </form>
    <% } %>
</div>

</body>
</html>