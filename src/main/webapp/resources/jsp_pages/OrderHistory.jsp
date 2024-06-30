<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Map, com.example.model.OrderBeans, com.example.model.OrderItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/OrderHistoryStyle.css" type="text/css"/>

</head>
<body>
<%@ include file="Header.jsp" %>

<h1>Storico ordini</h1>
<%
    request.getSession().setAttribute("lastOrder", null);
    ArrayList<OrderBeans> orders = (ArrayList<OrderBeans>) request.getAttribute("orders");
    Map<Integer, List<OrderItem>> orderItemsMap = (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");
    if (orders != null && !orders.isEmpty()) {
        for (OrderBeans order : orders) {

%>
<div class="order">
    <h2>ID dell'ordine: <%= order.getOrderId() %></h2>
    <p>Data: <%= order.getOrderDate() %></p>
    <p>Costo totale: $<%= String.format("%.2f", order.getTotalCost()) %></p>
    <p>Indirizzo di consegna: <%= order.getDeliveryAddress().getStreet() %>, <%= order.getDeliveryAddress().getCity() %></p>
    <p>Metodo di Pagamento: **** **** **** <%= order.getPaymentMethod().getCardNumber().substring(order.getPaymentMethod().getCardNumber().length() - 4) %></p>
    <p>Indirizzo di fatturazione: <%= order.getBillingAddress().getStreet() %>, <%= order.getBillingAddress().getCity() %></p>

    <p><a href="<%=request.getContextPath()%>/Download?orderId=<%= order.getOrderId() %>&t=<%= System.currentTimeMillis() %>" class="download-button">Scarica Fattura</a></p>

    <h3>Prodotti Ordinati:</h3>
    <table>
        <tr>
            <th>Nome</th>
            <th>Quantita'</th>
            <th>Prezzo</th>
        </tr>
        <%
            List<OrderItem> orderItems = orderItemsMap.get(order.getOrderId());
            if (orderItems != null) {
                for (OrderItem item : orderItems) {
        %>
        <tr>
            <td><%= item.getProductName() %></td>
            <td><%= item.getQuantity() +1 %></td>
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
<p>Nessun ordine trovato.</p>
<%
    }
%>
</body>
</html>
