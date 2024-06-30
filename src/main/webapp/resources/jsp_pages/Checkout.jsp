
<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");

    String userType= (String) request.getSession().getAttribute("userType");
    boolean log = userE != null && !userE.isEmpty();

    int userCode=0;
    ArrayList<ArrayList<String>> billingAddresses = null;
    ArrayList<ArrayList<String>> deliveryAddresses= null;
    ArrayList<ArrayList<String>> paymentMethods= null;

    if(log) {
        userCode = UtilDS.getUserCodebyEmail(userE);
        request.getSession().setAttribute("userCode",userCode);
        billingAddresses = UtilDS.showBillingAddress(userCode);
        deliveryAddresses = UtilDS.showDeliveryAddress(userCode);
        paymentMethods = UtilDS.showPaymentMethods(userCode);
    }

    Cart s = (Cart) request.getSession().getAttribute("cart");
    if (s == null) {
        System.out.println("carrello nullo");
        s = new Cart();
        request.getSession().setAttribute("s", s);
    }

    double cartTotal = s.getCartTotalPrice();
    request.getSession().setAttribute("cartTotal",cartTotal);
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --border-color: #bdc3c7;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
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
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
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

        #paypal-button-container {
            max-width: 250px;
            margin-top: 20px;
        }
    </style>
    <script src="https://www.paypal.com/sdk/js?client-id=AWlk6FZqd56NI4ZCsRLyt6cI_OBH48dkwWT_byq9uaKFDyoFxKcwvVRP5hFXIp7wilDvlTpAcvZ9cVAP&currency=EUR&components=buttons"></script>
</head>
<body>

<%if(!userType.equals("guest")){%>
<%@ include file="Header.jsp" %>
<%}%>
<div class="container">
    <h1>Checkout</h1>

    <% if (!log) { %>
    <div class="guest-area">
        <h2>Informazioni Obbligatorie</h2>
        <form id="guestForm" action="${pageContext.request.contextPath}/Guest" method="post" class="guest-form">
            <label for="email">Inserisci la tua email:</label>
            <input type="email" id="email" name="email" placeholder="Email" required onkeyup="checkEmail()">
            <div id="email-error" class="error-message" style="display: none;"></div>
            <button type="submit" id="submit-btn" class="btn">Conferma</button>
        </form>
    </div>
    <% } else { %>
    <form id="checkoutForm" action="${pageContext.request.contextPath}/Checkout" method="post" onsubmit="return validateForm()">
        <div class="section">
            <h2>Indirizzo di Fatturazione</h2>
            <% if (billingAddresses != null && !billingAddresses.isEmpty()) { %>
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
                    <th>Citt&agrave;</th>
                    <th>Provincia</th>
                    <th>CAP</th>
                </tr>
                </thead>
                <tbody>
                <% for (ArrayList<String> address : billingAddresses) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedAddressId" value="<%= address.get(0) %>"></td>
                    <td><%= address.get(2) %></td>
                    <td><%= address.get(3) %></td>
                    <td><%= address.get(4) %></td>
                    <td><%= address.get(5) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p class="no-data-message">Nessun indirizzo di fatturazione disponibile.</p>
            <a href="UserData.jsp?fromCheckout=true" class="add-info-link">Inserisci indirizzo di fatturazione</a>
            <% } %>
        </div>

        <div class="section">
            <h2>Indirizzo di Consegna</h2>
            <% if (deliveryAddresses != null && !deliveryAddresses.isEmpty()) { %>
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
                    <th>Citt&agrave;</th>
                    <th>Provincia</th>
                    <th>CAP</th>
                    <th>Paese</th>
                </tr>
                </thead>
                <tbody>
                <% for (ArrayList<String> address : deliveryAddresses) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedDeliveryAddressId" value="<%= address.get(0) %>"></td>
                    <td><%= address.get(5) %></td>
                    <td><%= address.get(4) %></td>
                    <td><%= address.get(6) %></td>
                    <td><%= address.get(3) %></td>
                    <td><%= address.get(2) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p class="no-data-message">Nessun indirizzo di consegna disponibile.</p>
            <a href="UserData.jsp?fromCheckout=true" class="add-info-link">Inserisci indirizzo di consegna</a>
            <% } %>
        </div>

        <div class="section">
            <h2>Metodo di Pagamento</h2>
            <% if (paymentMethods != null && !paymentMethods.isEmpty()) { %>
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Numero Carta</th>
                    <th>Scadenza</th>
                    <th>Nome Intestatario</th>
                </tr>
                </thead>
                <tbody>
                <% for (ArrayList<String> method : paymentMethods) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedPaymentMethodId" value="<%= method.get(0) %>"></td>
                    <td><%= method.get(2) %></td>
                    <td><%= method.get(3) %>/<%= method.get(4) %></td>
                    <td><%= method.get(6) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } else { %>
            <p class="no-data-message">Nessun metodo di pagamento disponibile.</p>
            <a href="UserData.jsp?fromCheckout=true" class="add-info-link">Inserisci metodo di pagamento</a>
            <% } %>
            <div id="paypal-button-container" class="btn-container"></div>
        </div>

        <div class="btn-container">
            <button id="conferma" type="submit" class="btn">Conferma Ordine</button>
        </div>

        <div class="btn-container">
            <a href="UserData.jsp?fromCheckout=true" class="btn btn-secondary">Inserisci Nuove Informazioni</a>
        </div>
    </form>
    <% } %>
</div>

<script>
    function checkEmail() {
        var email = document.getElementById("email").value;
        var errorDiv = document.getElementById("email-error");
        var submitBtn = document.getElementById("submit-btn");

        if (email) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/Check", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    if (response.exists) {
                        errorDiv.style.display = "block";
                        errorDiv.textContent = "Email gia registrata. Effettua il login o usa un'altra email.";
                        submitBtn.disabled = true;
                    } else {
                        errorDiv.style.display = "none";
                        submitBtn.disabled = false;
                    }
                }
            };
            xhr.send("email=" + encodeURIComponent(email));
        } else {
            errorDiv.style.display = "none";
            submitBtn.disabled = false;
        }
    }

    function validateForm() {
        var billingSelected = document.querySelector('input[name="selectedAddressId"]:checked');
        var deliverySelected = document.querySelector('input[name="selectedDeliveryAddressId"]:checked');
        var paymentSelected = document.querySelector('input[name="selectedPaymentMethodId"]:checked');

        if (!billingSelected || !deliverySelected || !paymentSelected) {
            alert("Seleziona almeno un'opzione per ogni sezione.");
            return false;
        }
        return true;
    }


    if (document.getElementById('paypal-button-container')) {
        paypal.Buttons({
            fundingSource: paypal.FUNDING.PAYPAL,
            createOrder: function(data, actions) {
                return actions.order.create({
                    purchase_units: [{
                        amount: {
                            value: '<%= cartTotal %>'
                        }
                    }]
                });
            },
            onApprove: function(data, actions) {
                return actions.order.capture().then(function(details) {
                    // Invia i dati del pagamento alla servlet
                    var form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/PayPal';

                    var userCode = document.createElement('input');
                    userCode.type = 'hidden';
                    userCode.name = 'userCode';
                    userCode.value = '<%= userCode %>';
                    form.appendChild(userCode);

                    var cardNumber = document.createElement('input');
                    cardNumber.type = 'hidden';
                    cardNumber.name = 'cardNumber';
                    cardNumber.value = details.purchase_units[0].payments.captures[0].id; // Utilizziamo l'ID della transazione come identificatore unico
                    form.appendChild(cardNumber);

                    var expiryMonth = document.createElement('input');
                    expiryMonth.type = 'hidden';
                    expiryMonth.name = 'expiryMonth';
                    expiryMonth.value = '11'
                    form.appendChild(expiryMonth);

                    var expiryYear = document.createElement('input');
                    expiryYear.type = 'hidden';
                    expiryYear.name = 'expiryYear';
                    expiryYear.value = '2030'; // Valore fittizio
                    form.appendChild(expiryYear);

                    var cardholderName = document.createElement('input');
                    cardholderName.type = 'hidden';
                    cardholderName.name = 'cardholderName';
                    cardholderName.value = details.payer.name.given_name + ' ' + details.payer.name.surname;
                    form.appendChild(cardholderName);

                    document.body.appendChild(form);
                    form.submit();
                });
            },
            onError: function(err) {
                console.error('PayPal error:', err);
                alert('An error occurred during the payment process: ' + err.message);
            }
        }).render('#paypal-button-container');

    }
</script>
</body>
</html>