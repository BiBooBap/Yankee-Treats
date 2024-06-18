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
    </style>
</head>
<body>
<div class="container">
    <div class="section address">
        <h2 class="section-title">Indirizzi di Consegna</h2>
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
                <% ArrayList<String[]> deliveryAddresses = null;
                    try {
                        deliveryAddresses = UtilDS.returnDeliveryAddress(userEmail);
                    } catch (NamingException | SQLException e) {
                        throw new RuntimeException(e);
                    }
                    for (String[] address : deliveryAddresses) { %>
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
            <button type="submit">Elimina</button>
        </form>
    </div>

    <div class="section billing-info">
        <h2 class="section-title">Informazioni di Fatturazione</h2>
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
                <% ArrayList<String[]> billingAddresses = null;
                    try {
                        billingAddresses = UtilDS.returnBillingAddress(userEmail);
                    } catch (NamingException | SQLException e) {
                        throw new RuntimeException(e);
                    }
                    for (String[] address : billingAddresses) { %>
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
            <button type="submit">Elimina</button>
        </form>
    </div>

    <div class="section payment-methods">
        <h2 class="section-title">Metodi di Pagamento</h2>
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
                <% ArrayList<String[]> paymentMethods = null;
                    try {
                        paymentMethods = UtilDS.returnPaymentMethod(userEmail);
                    } catch (NamingException | SQLException e) {
                        throw new RuntimeException(e);
                    }
                    for (String[] method : paymentMethods) { %>
                <tr>
                    <td><input type="radio" class="select-radio" name="selectedAddressId" value="<%= method[0] %>"></td>
                    <td><%= method[2] %></td>
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
            <button type="submit">Elimina</button>
        </form>
    </div>
</div>
</body>
</html>
