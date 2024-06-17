<%@ page language="java"%>

<%
    request.getSession().setAttribute("cart", cart);
    cart = (Cart) request.getSession().getAttribute("cart");
    String userEmail = (String) request.getSession().getAttribute("userEmail");

%>

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
            <% if (userEmail != null && !userEmail.isEmpty()) { %>
            <div class="welcome-message">Benvenuto: <%= userEmail %></div>
            <div class="dropdown">
                <button class="dropbtn"><i class="fa-solid fa-circle-user fa-2x"></i></button>
                <div class="dropdown-content">
                    <a href="">Dati personali</a>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </div>
            </div>
            <% } else { %>
            <a href="resources/jsp_pages/Login.jsp"><i class="fa-solid fa-circle-user fa-2x"></i></a>
            <% } %>
            <i class="fa-solid fa-cart-shopping fa-2x"></i>
            <span class="totalQuantity"><%=cart.getTotalItemCount()%></span>
        </span>
</div>
</body>
</html>
