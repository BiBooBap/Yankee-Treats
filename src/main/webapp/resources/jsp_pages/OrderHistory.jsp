<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.example.model.OrderBeans" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order History</title>
</head>
<body>
<h1>Order History</h1>
<%
    ArrayList<OrderBeans> orders = (ArrayList<OrderBeans>) request.getAttribute("orders");
    if (orders != null && !orders.isEmpty()) {
        for (OrderBeans order : orders) {
%>
<div class="order">
    <h2>Order ID: <%= order.getOrderId() %></h2>
    <p>Date: <%= order.getOrderDate() %></p>
    <p>Total Cost: $<%= String.format("%.2f", order.getTotalCost()) %></p>
    <p>Delivery Address: <%= order.getDeliveryAddress().getStreet() %>, <%= order.getDeliveryAddress().getCity() %></p>
    <p>Payment Method: **** **** **** <%= order.getPaymentMethod().getCardNumber().substring(order.getPaymentMethod().getCardNumber().length() - 4) %></p>
</div>
<%
    }
} else {
%>
<p>No orders found.</p>
<%
    }
%>
</body>
</html>