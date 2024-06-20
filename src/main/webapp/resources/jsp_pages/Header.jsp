<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>



<meta name="viewport" content="width=device-width, initial-scale=1.0">



<%
    ProductBean product = (ProductBean) request.getAttribute("product");

    // Ottieni il carrello dalla sessione
    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    String user = (String) request.getSession().getAttribute("userEmail");
    boolean userLoggedIn = user != null && !user.isEmpty();
%>


<%
    request.getSession().setAttribute("cart", cart);
    cart = (Cart) request.getSession().getAttribute("cart");
    String userEmail = (String) request.getSession().getAttribute("userEmail");
%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Header.css" type="text/css"/>

<!--FONT AWESOME-->
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/all.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-thin.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-solid.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-regular.css">
<link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.5.2/css/sharp-light.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">




<html>
<body>



    <div id="header">
        <img id="logo" src="${pageContext.request.contextPath}/resources/images/logo.png" alt=""/>

        <span id="icons">
                <% if (userEmail != null && !userEmail.isEmpty()) { %>
                <div class="welcome-message">Benvenuto, <%= userEmail %></div>
                <div class="dropdown">
                    <button class="dropbtn"><i class="fa-solid fa-circle-user" style="font-size: 30px;"></i></button>
                    <div class="dropdown-content">
                        <a href="${pageContext.request.contextPath}/resources/jsp_pages/MiddleUserData.jsp">Dati personali</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/resources/jsp_pages/Login.jsp"><i class="fa-solid fa-circle-user" style="font-size: 30px;"></i></a>
                <% } %>
                <i class="fa-solid fa-cart-shopping" style="font-size: 30px;"></i>
                <span class="totalQuantity"><%=cart.getTotalItemCount()%></span>
            </span>

        <div class="cart" id="cart"> <!-- LASCIARE SIA CLASS CHE ID = CART -->

            <h2>CARRELLO</h2>

            <div class="listCart">

                <% for (CartItem item : cart.getCart()) { %>

                <div class="item">
                    <div class="content">
                        <div class="name"><%= item.getName() %></div>

                        <div class="price"><%= item.getTotalPrice() %><span>&euro;</span></div>

                        <div class="quantity">
                            <button><a href="cart?action=decrementC&id=<%=item.getId()%>">-</a></button>
                            <span class="value"><%= item.getQuantityCart() %></span>
                            <button><a href="cart?action=incrementC&id=<%=item.getId()%>">+</a></button>
                        </div>

                        <a href="cart?action=deleteC&id=<%=item.getId()%>"> Rimuovi </a>

                        <img src="${pageContext.request.contextPath}/images/product_<%= item.getId() %>.png" class="productimage" alt="">
                    </div>
                </div>
                <% } %>
            </div>



            <div class="buttons">
                <div class="total">Totale: <%= cart.getCartTotalPrice() %> &euro;</div>
                <div class="close" id="closeCart">CHIUDI</div>
                <div class="checkout">
                    <%
                        if (userLoggedIn) {
                    %>
                    <a href="${pageContext.request.contextPath}/resources/jsp_pages/Checkout.jsp">CHECKOUT</a>
                    <%
                    } else {
                    %>
                    <a href="${pageContext.request.contextPath}/resources/jsp_pages/Login.jsp?fromCart=true">CHECKOUT</a> <!-- Questo parametro serve a visualizzare in login.jsp la possibilità di effettuare un ordine anche senza registrarsi -->
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>






    <script>
        const cartIcon = document.querySelector('.fa-cart-shopping');
        cartIcon.addEventListener('click', toggleCart);

        const closeCartBtn = document.querySelector('.cart .buttons #closeCart');
        closeCartBtn.addEventListener('click', closeCart);

        function toggleCart() {
            const cart = document.querySelector('.cart');
            const container = document.querySelector('.body-container');

            if (cart.style.right === '-400px') {
                cart.style.right = '0'; // Mostra il carrello
                container.style.transform = 'translateX(-400px)'; // Sposta il contenitore a sinistra
            } else {
                cart.style.right = '-400px'; // Nascondi il carrello
                container.style.transform = 'translateX(0px)'; // Riporta il contenitore alla posizione originale
            }
        }

        function closeCart() {
            const cart = document.querySelector('.cart');
            const container = document.querySelector('.body-container');

            cart.style.right = '-400px'; // Nascondi il carrello
            container.style.transform = 'translateX(0px)'; // Riporta il contenitore alla posizione originale
        }
    </script>



    <script>
        window.onscroll = function() {myFunction()};

        let header = document.getElementById("header");
        let sticky = header.offsetTop;

        function myFunction() {
            if (window.scrollY > sticky) {
                header.classList.add("sticky");
            } else {
                header.classList.remove("sticky");
            }
        }
    </script>




</body>
</html>
