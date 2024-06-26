<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    ProductBean product = (ProductBean) request.getAttribute("product");

    Cart cart = (Cart) request.getSession().getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        request.getSession().setAttribute("cart", cart);
    }

    String user = (String) request.getSession().getAttribute("userEmail");
    boolean userLoggedIn = user != null && !user.isEmpty();

    String username= (String) request.getSession().getAttribute("userName");

    request.getSession().setAttribute("cart", cart);
    cart = (Cart) request.getSession().getAttribute("cart");
%>

<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/CartStyle.css" type="text/css"/>
    <title>Carrello</title>
</head>
<body>



<div class="cart" id="cart"> <!-- LASCIARE SIA CLASS CHE ID = CART -->
    <div class="listCart">
        <% for (CartItem item : cart.getCart()) { %>
        <div class="item">
            <div class="content">
                <div class="name"><%= item.getName() %></div>
                <img src="${pageContext.request.contextPath}/resources/images/product_<%= item.getId() %>.png" class="productimage" alt="">
                <div class="price"><%= item.getTotalPrice() %><span>&euro;</span></div>
                <div class="quantity">
                    <form action="${pageContext.request.contextPath}/cart" method="get">
                        <%
                        if (item.getQuantityCart() == 1) { %>
                            <input type="hidden" name="action" value="deleteC">
                            <input type="hidden" name="id" value="<%=item.getId()%>">
                            <button type="submit" class="remove">-</button>
                        <% } else { %>
                        <input type="hidden" name="action" value="decrementC">
                        <input type="hidden" name="id" value="<%=item.getId()%>">
                        <button type="submit" class="remove">-</button>
                        <% } %>
                    </form>
                    <span class="value"><%= item.getQuantityCart() %></span>
                    <form action="${pageContext.request.contextPath}/cart" method="get">
                        <input type="hidden" name="action" value="incrementC">
                        <input type="hidden" name="id" value="<%=item.getId()%>">
                        <button type="submit" class="add">+</button>
                    </form>
                </div>
                <form action="${pageContext.request.contextPath}/cart" method="get">
                    <input type="hidden" name="action" value="deleteC">
                    <input type="hidden" name="id" value="<%=item.getId()%>">
                    <button type="submit" class="remove">Rimuovi</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>

    <div class="buttons">
        <div class="total">Totale: <%= cart.getCartTotalPrice() %> &euro;</div>


        <a href="${pageContext.request.contextPath}/ProductView.jsp"><button>
            CHIUDI
        </button></a>


        <% if (userLoggedIn)
        { %>
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/Checkout.jsp">
                <% }
                else
                { %>
                    <a href="${pageContext.request.contextPath}/resources/jsp_pages/Login.jsp?fromCart=true">
                <% } %><button>
                    CHECKOUT
        </button></a>
    </div>
</div>

</body>
</html>

