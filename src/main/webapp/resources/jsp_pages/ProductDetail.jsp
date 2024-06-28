<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="java.sql.SQLException" %>

<%
    String productCode = request.getParameter("code");
    ProductBean prod = null;
    if (productCode != null && !productCode.isEmpty()) {
        ProductModelDM productModel = new ProductModelDM();
        try {
            prod = productModel.doRetrieveByKey(Integer.parseInt(productCode));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    if (prod == null) {
        response.sendRedirect(request.getContextPath() + "/prod");
        return;
    }

    Cart c = (Cart) session.getAttribute("cart");
    boolean isInCart = false;
    if (c != null) {
        CartItem cartItem = c.getCartItem(Integer.parseInt(productCode));
        if (cartItem != null && cartItem.getQuantityCart() > 0) {
            isInCart = true;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/ProductDetailStyle.css" rel="stylesheet" type="text/css">
    <title><%=prod.getName()%> - Dettagli Prodotto</title>
</head>
<body>
<%@ include file="Header.jsp" %>
<%@ include file="Subheader.jsp" %>

<div class="container">
    <div class="prod-card">
        <div class="card-img">
            <img src="${pageContext.request.contextPath}/resources/images/product_<%=prod.getCode()%>.png" class="prod-image" alt="<%=prod.getName()%>">
            <% if(prod.isNovita()) { %>
            <div class="new">Nuovo!</div>
            <% } %>
            <% if (prod.isOfferta()) { %>
            <div class="offer">Offerta!</div>
            <% } %>
        </div>
        <div class="prod-info">
            <h1 class="prod-name"><%=prod.getName()%></h1>
            <p class="prod-description"><%=prod.getDescription()%></p>
            <p class="prod-price">&#8364;<%=prod.getPrice()%></p>
            <div class="prod-details">
                <% if(prod.isBestseller()) { %>
                <p><strong>Bestseller</strong></p>
                <% } %>
                <% if(prod.isTrend()) { %>
                <p><strong>Prodotto di tendenza</strong></p>
                <% } %>
                <p>
                    Categoria:
                    <% if(prod.isDolce()) { %>Dolce<% }
                else if(prod.isSalato()) { %>Salato<% }
                else if(prod.isBevanda()) { %>Bevanda<% } %>
                </p>
                <% if(prod.isBundle()) { %>
                <p><strong>Prodotto in bundle</strong></p>
                <% } %>
                <div class="cart-actions">
                    <% if (isInCart) { %>
                    <a href="${pageContext.request.contextPath}/cart?action=decrementC&id=<%=prod.getCode()%>&fromProduct=true" class="cart-button remove-from-cart">Rimuovi dal Carrello</a>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/cart?action=addC&id=<%=prod.getCode()%>&fromProduct=true" class="cart-button add-to-cart">Aggiungi al Carrello</a>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="Footer.jsp" %>

</body>
</html>
