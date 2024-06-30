<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Map, com.example.model.OrderBeans, com.example.model.OrderItem, com.example.model.UtilDS" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Order History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/OrderHistoryStyle.css" type="text/css"/>
</head>
<body>
<%@ include file="Header.jsp" %>

<h1>Storico ordini utenti</h1>
<%
    ArrayList<OrderBeans> orders = (ArrayList<OrderBeans>) session.getAttribute("orders");
    if (orders != null && !orders.isEmpty()) {
        for (OrderBeans order : orders) {
            List<OrderItem> orderItems = UtilDS.getOrderItems(order.getOrderId());
%>
<div class="order">
    <h2>ID dell'ordine: <%= order.getOrderId() %></h2>
    <p>Codice utente: <%= order.getUserCode() %></p>
    <% if(order.getUserName() != null) { %>
    <p>Username: <%= order.getUserName() %></p>
    <% } else  %>
    <p>Utente non registrato</p>
    <p>Email: <%= order.getUserEmail() %></p>
    <p>Data: <%= order.getOrderDate() %></p>
    <p>Costo totale: $<%= String.format("%.2f", order.getTotalCost()) %></p>
    <p>Indirizzo di consegna: <%= order.getDeliveryAddress().getStreet() %>, <%= order.getDeliveryAddress().getCity() %>, <%= order.getDeliveryAddress().getZip() %>, <%= order.getDeliveryAddress().getCountry() %></p>
    <p>Metodo di pagamento: **** **** **** <%= order.getPaymentMethod().getCardNumber().substring(order.getPaymentMethod().getCardNumber().length() - 4) %></p>
    <p>Indirizzo di fatturazione: <%= order.getBillingAddress().getStreet() %>, <%= order.getBillingAddress().getCity() %>, <%= order.getBillingAddress().getZip() %>, <%= order.getBillingAddress().getProvince() %></p>

    <p><a href="<%=request.getContextPath()%>/Download?orderId=<%= order.getOrderId() %>&t=<%= System.currentTimeMillis() %>" class="download-button">Scarica fattura</a></p>

    <h3>Prodotti ordinati:</h3>
    <table>
        <tr>
            <th>Codice prodotto</th>
            <th>Nome</th>
            <th>Quantita'</th>
            <th>Prezzo</th>
        </tr>
        <%
            if (orderItems != null) {
                for (OrderItem item : orderItems) {
        %>
        <tr>
            <td><%= item.getProductCode() %></td>
            <td><%= item.getProductName() %></td>
            <td><%= item.getQuantity()+1 %></td>
            <td>$<%= String.format("%.2f", item.getPrice()) %></td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>
<%
    }
} else {
%>
<p class="no-orders">No orders found.</p>
<%
    }
%>
</body>
</html>