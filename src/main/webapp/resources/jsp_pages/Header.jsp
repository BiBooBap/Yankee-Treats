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

<div class="header">
    <a href="${pageContext.request.contextPath}/product"><img class="logo" src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""/></a>


    <div class="icons">
        <% if (isAdmin) { %>
        <span class="welcome-message">Benvenuto, Admin!</span>
        <% } else if (userLoggedIn) { %>
        <span class="welcome-message">Benvenuto, <%= username%>!</span>
        <% } %>
        <% if (userLoggedIn || isAdmin) { %>
        <div class="dropdown">
            <button class="dropbtn icon"><i class="fa-solid fa-circle-user custom-icon-size"></i></button>
            <div class="dropdown-content">
                <a href="${pageContext.request.contextPath}/resources/jsp_pages/MiddleUserData.jsp">Dati personali</a>
                <% if (!isAdmin) { %>
                <a href="${pageContext.request.contextPath}/ShowOrder">Storico ordini</a>
                <% }else{ %>
                <a href="${pageContext.request.contextPath}/resources/jsp_pages/DBInterface.jsp?refresh=<%=System.currentTimeMillis()%>">Gestisci prodotti</a>
                <a href="${pageContext.request.contextPath}/ShowOrderAdmin">Storico ordini</a>
                <% } %>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/Login.jsp" class="icon"><i class="fa-solid fa-circle-user custom-icon-size"></i></a>
        <% } %>

        <a href="${pageContext.request.contextPath}/resources/jsp_pages/Cart.jsp" class="icon"><i class="fa-solid fa-cart-shopping custom-icon-size"></i></a>
        <span class="totalQuantity"><%= cart.getTotalItemCount() %></span>
    </div>
</div>

<script>
    let header = document.querySelector(".header");
    let placeholder = document.createElement('div');
    placeholder.style.display = 'none';
    header.parentNode.insertBefore(placeholder, header);

    function updateStickyPosition() {
        return header.offsetTop + (placeholder.style.display === 'block' ? placeholder.offsetHeight : 0);
    }

    function myFunction() {
        let sticky = updateStickyPosition();

        if (window.scrollY > sticky) {
            if (!header.classList.contains("sticky")) {
                placeholder.style.display = 'flex';
                placeholder.style.height = header.offsetHeight + 'px';
                header.classList.add("sticky");
            }
        } else {
            if (header.classList.contains("sticky")) {
                header.classList.remove("sticky");
                placeholder.style.display = 'none';
            }
        }
    }

    // Debounce function to limit how often the scroll event fires
    function debounce(func, wait = 10, immediate = true) {
        let timeout;
        return function() {
            let context = this, args = arguments;
            let later = function() {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            let callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    }

    // Use the debounced version of myFunction for the scroll event
    window.addEventListener('scroll', debounce(myFunction));

    // Call myFunction on page load and resize
    window.addEventListener('load', myFunction);
    window.addEventListener('resize', debounce(myFunction));

    // Initial call to set correct state
    myFunction();




    let dropdown = document.querySelector(".dropdown");
    let dropdownContent = document.querySelector(".dropdown-content");

    dropdown.addEventListener("click", function() {
        dropdownContent.style.display = dropdownContent.style.display === 'block' ? 'none' : 'block';
    });


</script>
</body>
</html>

