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
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            color: var(--secondary-color);
            margin-bottom: 20px;
        }

        .section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background-color: var(--secondary-color);
            color: #ffffff;
        }

        .select-radio {
            margin-right: 10px;
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

        .nav-buttons {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<%@ include file="Header.jsp" %>

<div class="container">

    <div class="nav-buttons">
        <a href="MiddleUserData.jsp" class="btn btn-secondary">Torna indietro</a>
    </div>

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
            <button type="submit" class="btn">Elimina</button>
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
            <button type="submit" class="btn" >Elimina</button>
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
            <button type="submit" class="btn">Elimina</button>
        </form>
    </div>
</div>

</body>
</html>
