<%@ page language="java"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<body>
<<<<<<< HEAD
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
				<img src="./resources/images/product_<%= item.getId() %>.png" class="productimage" alt="">
			</div>
		</div>
		<% } %>
	</div>
	<div class="buttons">
		<div class="total">Totale: <%= cart.getCartTotalPrice() %> &euro;</div>
		<div class="close" id="closeCart">CHIUDI</div>
		<div class="checkout">
			<%
				// Controlla se l'utente è autenticato
				if (userLoggedIn) {
			%>
			<a href="resources/jsp_pages/Checkout.jsp">CHECKOUT</a>
			<%
			} else {
			%>
			<a href="resources/jsp_pages/Login.jsp?fromCart=true">CHECKOUT</a> <!-- Questo parametro serve a visualizzare in login.jsp la possibilità di effettuare un ordine anche senza registrarsi -->
			<%
				}
			%>
		</div>
	</div>
</div>

<div class="body-container">
	<div class="text-container">
		<span class="moving-text">Spedizione gratuita per gli ordini superiori a 50 euro!!&#127752;</span>
	</div>
=======




>>>>>>> a0017e3 (Restructured pages, Header now is sticky, Offers.jsp page implemented (differenced to Header.jsp), created proper CSS files for some of the pages, made relative references for most of the implementations)
	<%@ include file="resources/jsp_pages/Header.jsp" %>


	<%
		List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
		if(products == null) {
			response.sendRedirect(request.getContextPath() + "/product");
			return;
		}
	%>






	<h2>Vetrina prodotti</h2>

	<nav id="filtro-prodotti">
		<ul>
			<li><a href="product?sort=bestseller">Bestsellers</a></li>
			<li><a href="product?sort=bevanda">Bevande</a></li>
			<li><a href="product?sort=dolce">Dolce</a></li>
			<li><a href="product?sort=salato">Salato</a></li>
		</ul>
	</nav>

	<div class="container">
		<% for (ProductBean bean : products) {%>
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
		<% } %>
	</div>
<<<<<<< HEAD
=======

	<h2>Dolci</h2>
	<div class="container">
		<% for (ProductBean bean : products) {
			if (bean.isDolce()) { %>
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
	</div>

	<h2>Salati</h2>
	<div class="container">
		<% for (ProductBean bean : products) {
			if (bean.isSalato()) { %>
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
	</div>

	<h2>Bevande</h2>
	<div class="container">
		<% for (ProductBean bean : products) {
			if (bean.isBevanda()) { %>
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
	</div>

	<h2>Bundles</h2>
	<div class="container">
		<% for (ProductBean bean : products) {
			if (bean.isBundle()) { %>
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
	</div>





>>>>>>> a0017e3 (Restructured pages, Header now is sticky, Offers.jsp page implemented (differenced to Header.jsp), created proper CSS files for some of the pages, made relative references for most of the implementations)
	<%@ include file="resources/jsp_pages/Footer.jsp" %>



</body>
</html>

