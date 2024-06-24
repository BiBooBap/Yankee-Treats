<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    boolean userLoggedIn = userE != null && !userE.isEmpty();

    int userCode = (int) request.getSession().getAttribute("userCode");

    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    ArrayList<ArrayList<String>> billingAddresses = UtilDS.showBillingAddress(userCode);
    ArrayList<ArrayList<String>> deliveryAddresses = UtilDS.showDeliveryAddress(userCode);
    ArrayList<ArrayList<String>> paymentMethods = UtilDS.showPaymentMethods(userCode);

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
<div class="container">
    <div class="section billing-info">
        <h2 class="section-title">Informazioni di Fatturazione</h2>
        <form id="checkoutForm" action="${pageContext.request.contextPath}/Checkout" method="post" onsubmit="return validateForm()">

            <h3>Indirizzo di Fatturazione</h3>
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
<<<<<<< HEAD
                    <th>Citt&agrave;</th>
=======
                    <th>Citta</th>
>>>>>>> 13e3b11 (Fixing some buttons)
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

            <h3>Indirizzo di Consegna</h3>
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
<<<<<<< HEAD
                    <th>Citt&agrave;</th>
=======
                    <th>Citta</th>
>>>>>>> 13e3b11 (Fixing some buttons)
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

            <h3>Metodo di Pagamento</h3>
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

            <div class="btn-container">
                <button type="submit" class="btn">Conferma Ordine</button>
                <a href="UserData.jsp?fromCheckout=true" class="btn btn-secondary">Inserisci Informazioni Personali</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
