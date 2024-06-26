<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.OrderBeans, com.example.model.PaymentMethod, com.example.model.DeliveryAddress, com.example.model.BillingAddress, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Order History</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/styles.css">
</head>
<body>
<h1>Admin Order History</h1>

<%
    ArrayList<OrderBeans> orders = (ArrayList<OrderBeans>)session.getAttribute("orders");
%>

<table>
    <thead>
    <tr>
        <th>Order ID</th>
        <th>User Code</th>
        <th>User Name</th>
        <th>User Email</th>
        <th>Total Cost</th>
        <th>Order Date</th>
        <th>Payment Method</th>
        <th>Delivery Address</th>
        <th>Billing Address</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (orders != null && !orders.isEmpty()) {
            for (OrderBeans order : orders) {
    %>
    <tr>
        <td><%= order.getOrderId() %></td>
        <td><%= order.getUserCode() %></td>
        <td><%= order.getUserName() %></td>
        <td><%= order.getUserEmail() %></td>
        <td><%= order.getTotalCost() %></td>
        <td><%= order.getOrderDate() %></td>
        <td><%= (order.getPaymentMethod() != null) ? order.getPaymentMethod().getCardNumber() : "N/A" %></td>
        <td>
            <%= (order.getDeliveryAddress() != null) ?
                    order.getDeliveryAddress().getStreet() + ", " +
                            order.getDeliveryAddress().getCity() + ", " +
                            order.getDeliveryAddress().getZip() + ", " +
                            order.getDeliveryAddress().getCountry() : "N/A" %>
        </td>
        <td>
            <%= (order.getBillingAddress() != null) ?
                    order.getBillingAddress().getStreet() + ", " +
                            order.getBillingAddress().getCity() + ", " +
                            order.getBillingAddress().getZip() + ", " +
                            order.getBillingAddress().getProvince() : "N/A" %>
        </td>
        <td>
            <a href="OrderDetails?orderId=<%= order.getOrderId() %>">View Details</a>
            <a href="<%=request.getContextPath()%>/Download?orderId=<%= order.getOrderId() %>">Scarica Fattura</a></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="10">No orders found.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>
