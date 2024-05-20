<%@ page language="java"%>

<% request.setAttribute("cart", cart); %>

<link rel="stylesheet" href="resources/css/Header.css" type="text/css"/>

<!--FONT AWESOME-->
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/all.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-thin.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-solid.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-regular.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-light.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">


<html>
<body>

<div id="header">
    <img id="logo" src="resources/images/logo.png" alt=""/>

        <span id="icons">
            <a href="resources/jsp_pages/Login.jsp"><i class="fa-solid fa-circle-user fa-2x"></i></a>
            <i class="fa-solid fa-cart-shopping fa-2x"></i>
            <span class="totalQuantity"><%=cart.getTotalItemCount()%></span>
        </span>
</div>
</body>
</html>