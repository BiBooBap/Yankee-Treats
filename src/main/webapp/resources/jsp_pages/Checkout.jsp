<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    String userType= (String) request.getSession().getAttribute("userType");
    boolean userLoggedIn = userE != null && !userE.isEmpty();

    int userCode;
    ArrayList<ArrayList<String>> billingAddresses = null;
    ArrayList<ArrayList<String>> deliveryAddresses= null;
    ArrayList<ArrayList<String>> paymentMethods= null;

    if(userLoggedIn) {
        userCode = UtilDS.getUserCodebyEmail(userE);
        request.getSession().setAttribute("userCode",userCode);
        billingAddresses = UtilDS.showBillingAddress(userCode);
        deliveryAddresses = UtilDS.showDeliveryAddress(userCode);
        paymentMethods = UtilDS.showPaymentMethods(userCode);
    }

    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }


    double cartTotal = cart.getCartTotalPrice();
    request.getSession().setAttribute("cartTotal",cartTotal);
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
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
        }

        .section {
            margin-bottom: 40px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .address, .billing-info, .payment-methods {
            background-color: #f4f4f4;
            padding: 20px;
            border-radius: 8px;
        }

        .section-title {
            margin-bottom: 10px;
        }

        .hidden {
            display: none;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-secondary {
            background-color: #008CBA;
        }

        .btn-container {
            margin-top: 20px;
        }

        .guest-area {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        .section-title {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        .guest-form {
            max-width: 400px;
            margin: auto;
        }

        .guest-form label {
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }

        .guest-form input[type="email"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border-color 0.3s ease;
        }

        .guest-form input[type="email"]:focus {
            outline: none;
            border-color: #4CAF50;
        }

        .guest-form .btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .guest-form .btn:hover {
            background-color: #45a049;
        }
    </style>
    <script>
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
    </script>
</head>
<body>

<% if (!userLoggedIn) { %>
<div class="container">
    <div class="guest-area">
        <h2 class="section-title">Informazioni Obbligatorie</h2>
        <form id="guestForm" action="${pageContext.request.contextPath}/Guest" method="post" class="guest-form">
            <label for="email">Inserisci la tua email:</label>
            <input type="email" id="email" name="email" placeholder="Email" required onkeyup="checkEmail()">
            <div id="email-error" class="error-message" style="display: none;"></div>
            <button type="submit" id="submit-btn" class="btn btn-primary">Conferma</button>
        </form>
    </div>
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
</script>
<% }else{%>
<div class="container">
    <div class="section billing-info">
        <h2 class="section-title">Informazioni Personali</h2>

        <form id="checkoutForm" action="${pageContext.request.contextPath}/Checkout" method="post" onsubmit="return validateForm()">
            <h3>Indirizzo di Fatturazione</h3>
            <%if (billingAddresses!=null&&!billingAddresses.isEmpty()) {%>
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
            <% } else{%>
            <p>Nessun indirizzo di fatturazione disponibile. Usare il bottone a fondo pagina per inserirne uno.</p>
            <%}%>
            <h3>Indirizzo di Consegna</h3>
            <%if (deliveryAddresses!=null&&!deliveryAddresses.isEmpty()) {%>
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
            <% } else{%>
            <p>Nessun indirizzo di spedizione disponibile. Usare il bottone a fondo pagina per inserirne uno.</p>
            <%}%>
            <h3>Metodo di Pagamento</h3>
            <%if (paymentMethods!=null&&!paymentMethods.isEmpty()) {%>
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
            <% } else{%>
            <p>Nessun metodo di pagamento disponibile. Usare il bottone a fondo pagina per inserirne</p>
            <%}%>
            <div class="btn-container">
                <button type="submit" class="btn">Conferma Ordine</button>
                <a href="UserData.jsp?fromCheckout=true" class="btn btn-secondary">Inserisci Informazioni Personali</a>
            </div>
        </form>
    </div>
</div>
<% } %>
</body>
</html>
