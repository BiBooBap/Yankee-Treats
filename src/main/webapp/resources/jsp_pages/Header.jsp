<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%
    ProductBean product = (ProductBean) request.getAttribute("product");

    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    String user = (String) request.getSession().getAttribute("userEmail");
    String user_ty =(String) request.getSession().getAttribute("userType");
    boolean userLoggedIn = user != null && !user.isEmpty();
    boolean isAdmin = (user_ty != null && user_ty.equals("admin"));
    boolean isVenditoreOrPrivato = (user_ty != null && (user_ty.equals("venditore") || user_ty.equals("privato")));

    String username= (String) request.getSession().getAttribute("userName");

    request.getSession().setAttribute("cart", cart);
    cart = (Cart) request.getSession().getAttribute("cart");
%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/HeaderStyle.css" type="text/css"/>
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
    <a href="${pageContext.request.contextPath}/product"><img id="logo" src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""/></a>

    <div class="input-wrapper">
        <input type="text" placeholder="Oggi ho voglia di.." name="text" class="searchbar"></input>
        <button type="submit" class="search-button">&#128270;</button>
    </div>

    <span id="icons">
    <% if (isAdmin) { %>
    <div class="welcome-message">Benvenuto, admin</div>
    <% } else if (userLoggedIn) { %>
    <div class="welcome-message">Benvenuto, <%= username %></div>
    <% } %>

    <% if (userLoggedIn) { %>
    <div class="dropdown">
        <button class="dropbtn"><i class="fa-solid fa-circle-user"></i></button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/resources/jsp_pages/MiddleUserData.jsp">Dati personali</a>
            <% if (!isAdmin) { %>
            <a href="${pageContext.request.contextPath}/ShowOrder">Storico ordini</a>
            <% }else{ %>
            <a href="${pageContext.request.contextPath}/resources/jsp_pages/InsertProduct.jsp">Gestisci prodotti</a>
            <a href="${pageContext.request.contextPath}/ShowOrderAdmin">Storico ordini</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
    <% } else { %>
    <a href="${pageContext.request.contextPath}/resources/jsp_pages/Login.jsp"><i class="fa-solid fa-circle-user"></i></a>
    <% } %>

    <a href="${pageContext.request.contextPath}/resources/jsp_pages/Cart.jsp"><i class="fa-solid fa-cart-shopping"></i></a>
    <span class="totalQuantity"><%= cart.getTotalItemCount() %></span>
    </span>
    </div>

<script>
    window.onscroll = function() { myFunction() };

    let header = document.getElementById("header");
    let sticky = header.offsetTop;

    function myFunction() {
        if (window.scrollY > sticky) {
            header.classList.add("sticky");
        } else {
            header.classList.remove("sticky");
        }
    }

    // Array di emoji snack
    const snackEmojis = ['&#127871', '&#127851;', '&#127850;', '&#x1F968;', '&#127829;', '&#127839;', '&#x1F964;', '&#127846;', '&#127849;', '&#x1F95C;'];

    let emojiInterval;
    let currentEmojiIndex = 0;

    let searchButton = document.querySelector(".search-button");
    let inputbar = document.querySelector(".searchbar");
    inputbar.addEventListener("focus", function() {
        searchButton.style.border = "2px solid #0563df";
        searchButton.style.backgroundColor = "#83a4d2";

        // Cambia l'emoji immediatamente
        changeEmoji();
        // Imposta l'intervallo per cambiare l'emoji ogni secondo
        emojiInterval = setInterval(changeEmoji, 1000);
    });
    inputbar.addEventListener("blur", function() {
        searchButton.style.border = "none";
        searchButton.style.backgroundColor = "rgba(128, 128, 128, 0.13)";
        searchButton.innerHTML = "&#128270;";

        // Ferma il cambiamento dell'emoji
        clearInterval(emojiInterval);
        // Ripristina l'emoji originale
        searchButton.innerHTML = '&#128270;';
        // Resetta l'indice dell'emoji
        currentEmojiIndex = 0;
    });

    // Funzione per cambiare l'emoji
    function changeEmoji() {
        searchButton.innerHTML = snackEmojis[currentEmojiIndex];
        currentEmojiIndex = (currentEmojiIndex + 1) % snackEmojis.length;
    }
</script>
</body>
</html>

