<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    String userMail = request.getParameter("userEmail");
    if (userMail != null && !userMail.isEmpty()) {
        session.setAttribute("userEmail", userMail);
    } else {
        userMail = (String) session.getAttribute("userEmail");
    }

    List<ProductBean> products = (List<ProductBean>) request.getSession().getAttribute("products");

    if(products == null) {
        response.sendRedirect(request.getContextPath() + "/product");
        return;
    }

    String user_type=request.getParameter("userType");
    if (user_type != null && !user_type.isEmpty()) {
        session.setAttribute("userType", user_type);
    } else {
        user_type = (String) session.getAttribute("userType");
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/B2bStyle.css" rel="stylesheet" type="text/css">
    <title>B2B - Yankee Treats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>

<body>
<%@ include file="Header.jsp" %>

<section id="intro">
    <h1>Benvenuto al nostro programma B2B</h1>
    <p>Scopri la nostra vasta selezione di snack americani, perfetti per rivenditori, distributori e aziende che desiderano offrire il meglio ai propri clienti o dipendenti. Approfitta di prezzi competitivi, offerte speciali e un servizio clienti dedicato.</p>
    <p>I nostri prezzi all'ingrosso sono pensati per offrire il massimo vantaggio ai nostri clienti B2B. Offriamo prezzi speciali per ordini di grandi dimensioni.</p>
</section>

<div class="container">
        <% for (ProductBean bean : products) {
            if (bean.isB2B()) {%>
    <div class="card">
        <div class="card-img"><img src="${pageContext.request.contextPath}/resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
        <div class="card-title"><%=bean.getName()%></div>
        <div class="card-subtitle"><%=bean.getDescription()%></div>
        <hr class="card-divider">
        <div class="card-footer">
            <div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
            <button class="card-btn">
                <a href="cart?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
            </button>
        </div>
    </div>
        <% } } %>


</body>

