<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.sql.SQLException" %>
<% String userEmail = (String) request.getSession().getAttribute("userEmail");
    int userCode = UtilDS.getUserCodebyEmail(userEmail); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettagli Ordine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ViewUserData.css" type="text/css"/>
</head>
<body>
<%@ include file="Header.jsp" %>

<div class="container">

    <div class="nav-buttons">
        <a href="MiddleUserData.jsp" class="btn btn-secondary">Torna indietro</a>
    </div>

    <div class="section address">
        <h2 class="section-title">Indirizzi di Consegna</h2>
        <%
            ArrayList<String[]> deliveryAddresses = null;
            try {
                deliveryAddresses = UtilDS.returnDeliveryAddress(userEmail);
            } catch (NamingException | SQLException e) {
                throw new RuntimeException(e);
            }
            if (deliveryAddresses != null && !deliveryAddresses.isEmpty()) {
        %>
        <form action="${pageContext.request.contextPath}/Delete" method="post">
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
                    <th>Città</th>
                    <th>Provincia</th>
                    <th>CAP</th>
                    <th>Paese</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] address : deliveryAddresses) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedAddressId" value="<%= address[0] %>"></td>
                    <td><%= address[5] %></td>
                    <td><%= address[4] %></td>
                    <td><%= address[6] %></td>
                    <td><%= address[3] %></td>
                    <td><%= address[2] %></td>
                    <td class="hidden"><input type="hidden" name="userCode" value="<%= userCode %>"></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <input type="hidden" name="code" value="1">
            <button type="submit" class="btn">Elimina</button>
        </form>
        <% } else { %>
        <p>Nessun indirizzo di consegna disponibile.</p>
        <% } %>
    </div>

    <div class="section billing-info">
        <h2 class="section-title">Indirizzi di Fatturazione</h2>
        <%
            ArrayList<String[]> billingAddresses = null;
            try {
                billingAddresses = UtilDS.returnBillingAddress(userEmail);
            } catch (NamingException | SQLException e) {
                throw new RuntimeException(e);
            }
            if (billingAddresses != null && !billingAddresses.isEmpty()) {
        %>
        <form action="${pageContext.request.contextPath}/Delete" method="post">
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Via</th>
                    <th>Città</th>
                    <th>Provincia</th>
                    <th>CAP</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] address : billingAddresses) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedAddressId" value="<%= address[0] %>"></td>
                    <td><%= address[2] %></td>
                    <td><%= address[3] %></td>
                    <td><%= address[4] %></td>
                    <td><%= address[5] %></td>
                    <td class="hidden"><input type="hidden" name="userCode" value="<%= userCode %>"></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <input type="hidden" name="code" value="2">
            <button type="submit" class="btn">Elimina</button>
        </form>
        <% } else { %>
        <p>Nessun indirizzo di fatturazione disponibile.</p>
        <% } %>
    </div>

    <div class="section payment-methods">
        <h2 class="section-title">Metodi di Pagamento</h2>
        <%
            ArrayList<String[]> paymentMethods = null;
            try {
                paymentMethods = UtilDS.returnPaymentMethod(userEmail);
            } catch (NamingException | SQLException e) {
                throw new RuntimeException(e);
            }
            if (paymentMethods != null && !paymentMethods.isEmpty()) {
        %>
        <form action="${pageContext.request.contextPath}/Delete" method="post">
            <table>
                <thead>
                <tr>
                    <th></th>
                    <th>Numero Carta</th>
                    <th>Mese Scadenza</th>
                    <th>Anno Scadenza</th>
                    <th>CVV</th>
                    <th>Intestatario</th>
                </tr>
                </thead>
                <tbody>
                <% for (String[] method : paymentMethods) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedAddressId" value="<%= method[0] %>"></td>
                    <td><%= method[2]%></td>
                    <td><%= method[3] %></td>
                    <td><%= method[4].substring(0, 4) %></td>
                    <td><%= method[5] %></td>
                    <td><%= method[6] %></td>
                    <td class="hidden"><input type="hidden" name="userCode" value="<%= userCode %>"></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <input type="hidden" name="code" value="3">
            <button type="submit" class="btn">Elimina</button>
        </form>
        <% } else { %>
        <p>Nessun metodo di pagamento disponibile.</p>
        <% } %>
    </div>
</div>

</body>
</html>