<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    boolean userLoggedIn = userE != null && !userE.isEmpty();

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 50%;
            margin: auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Checkout</h2>
    <form action="${pageContext.request.contextPath}/checkout" method="post">
        <% if (!userLoggedIn) { %>
        <div class="form-group">
            <label for="firstName">Nome</label>
            <input type="text" id="firstName" name="firstName" required>
        </div>
        <div class="form-group">
            <label for="lastName">Cognome</label>
            <input type="text" id="lastName" name="lastName" required>
        </div>
        <div class="form-group">
            <label for="birthDate">Data di nascita</label>
            <input type="date" id="birthDate" name="birthDate" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="phoneNumber">Numero di telefono</label>
            <input type="tel" id="phoneNumber" name="phoneNumber" required>
        </div>
        <% } %>
        <h3>Indirizzo di fatturazione</h3>
        <div class="form-group">
            <label for="billingAddressStreet">Via</label>
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
        <h3>Indirizzo di consegna</h3>
        <div class="form-group">
            <label for="deliveryAddressStreet">Via</label>
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
        <input type="hidden" id="paymentIntentId" name="payment_intent_id">
        <h3> Dati di pagamento</h3>
        <div id="payment-form">
            <input type="text" id="card-number" placeholder="Numero carta">
            <input type="text" id="expiry" placeholder="Scadenza MM/AA">
            <input type="text" id="cvc" placeholder="CVC">
            <button id="pay-button">Paga</button>
        </div>
        <button type="submit" class="btn">Procedi con il pagamento</button>
    </form>
</div>

<script src="https://js.stripe.com/v3/"></script>
<script>
        var sessionId = "<%= request.getParameter("sessionId") %>";
        var stripe = Stripe('pk_live_51PUSgWRtccnKjfP4hgvMCBJpSxJntuNgMixOVMOTEl0ruFBu20Sik6vY3UiC7CE7nkiGqzdDFGzGmbhNSznYqumk00cJlukrTh'); // Imposta la tua chiave pubblica di Stripe
        stripe.redirectToCheckout({
        sessionId: sessionId
    }).then(function (result) {
        // Gestisci eventuali errori durante il redirect
        console.log(result.error.message);
    });
</script>
</body>
</html>




