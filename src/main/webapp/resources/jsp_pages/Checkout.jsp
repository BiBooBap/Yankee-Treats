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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Checkout.css" type="text/css"/>
    <script src="https://www.paypal.com/sdk/js?client-id=AWlk6FZqd56NI4ZCsRLyt6cI_OBH48dkwWT_byq9uaKFDyoFxKcwvVRP5hFXIp7wilDvlTpAcvZ9cVAP&currency=EUR&components=buttons"></script>
    <script src="${pageContext.request.contextPath}/resources/scripts/Checkout.js"></script>
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
            <button type="submit" id="submit-btn" class="btn" style="margin-top: 15px;">Conferma</button>
        </form>
    </div>
    <% } else { %>
    <form id="checkoutForm" action="${pageContext.request.contextPath}/Checkout" method="post" onsubmit="return validateForm()">

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
                    <td>**** **** **** <%= method.get(2).substring(12, 16) %></td>
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

</body>
</html>