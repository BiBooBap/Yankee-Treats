<%@ page language="java"%>

<%
	List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");
		return;
	}

	ProductBean product = (ProductBean) request.getAttribute("product");


	// Ottieni il carrello dalla sessione
	Cart cart = (Cart) request.getSession().getAttribute("cart");
	if (cart == null) {
		cart = new Cart();
	}

%>

<!DOCTYPE html>
<%@ page import="java.util.*,com.example.model.*,com.example.control.*"%>

<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link href="resources/css/ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<html>
<body>

<div class="cart" id="cart"> <!-- LASCIARE SIA CLASS CHE ID = CART -->
	<h2>CARRELLO</h2>
	<div class="listCart">
		<% for (CartItem item : cart.getCart()) { %>
		<div class="item">
			<div class="content">
				<div class="name"><%= item.getName() %></div>
				<div class="price"><%= item.getTotalPrice() %><span>&euro;</span></div>
				<div class="quantity">
					<button><a href="add-to-cart?action=decrementC&id=<%=item.getId()%>&page=ProductView.jsp">-</a></button>
					<span class="value"><%= item.getQuantityCart() %></span>
					<button><a href="add-to-cart?action=decrementC&id=<%=item.getId()%>&page=ProductView.jsp">+</a></button>
				</div>
				<a href="add-to-cart?action=deleteC&id=<%=item.getId()%>&page=ProductView.jsp"> Rimuovi </a>
			<img src="./resources/images/product_<%= item.getId() %>.png" class="productimage" alt="">
		<% } %>
	</div>
	<div class="buttons">
		<div class="close" id="closeCart">CHIUDI</div>
		<div class="checkout">
			<a href="checkout.html">CHECKOUT</a>
		</div>
	</div>
</div>

<div class="body-container">
<div class="text-container">
	<span class="moving-text">Spedizione gratuita per gli ordini di 50 euro</span>
	<!-- Aggiungi più frasi qui -->
</div>
<%@ include file="resources/jsp_pages/Header.jsp" %>
<%@ include file="resources/jsp_pages/Subheader.jsp" %>
<h2>Bestsellers</h2>
<div class="container">
	<% for (ProductBean bean : products) {
		if (bean.isBestseller()) { %>
	<div class="card">
		<div  class="card-img"><img src="./resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
		<div class="card-title"><%=bean.getName()%></div>
		<div class="card-subtitle"><%=bean.getDescription()%></div>
		<hr class="card-divider">
		<div class="card-footer">
			<div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
			<button class="card-btn">
				<a href="add-to-cart?action=addC&id=<%=bean.getCode()%>&page=ProductView.jsp"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
		}}
	%>
</div>

<h2>Dolci</h2>
<div class="container">
	<% for (ProductBean bean : products) {
		if (bean.isDolce()) { %>
	<div class="card">
		<div  class="card-img"><img src="./resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
		<div class="card-title"><%=bean.getName()%></div>
		<div class="card-subtitle"><%=bean.getDescription()%></div>
		<hr class="card-divider">
		<div class="card-footer">
			<div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
			<button class="card-btn">
				<a href="add-to-cart?action=addC&id=<%=bean.getCode()%>&page=ProductView.jsp"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
			}}
	%>
	</div>

<h2>Salati</h2>
<div class="container">
	<% for (ProductBean bean : products) {
		if (bean.isSalato()) { %>
	<div class="card">
		<div  class="card-img"><img src="./resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
		<div class="card-title"><%=bean.getName()%></div>
		<div class="card-subtitle"><%=bean.getDescription()%></div>
		<hr class="card-divider">
		<div class="card-footer">
			<div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
			<button class="card-btn">
				<a href="add-to-cart?action=addC&id=<%=bean.getCode()%>&page=ProductView.jsp"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
			}}
	%>
	</div>

<h2>Bevande</h2>
<div class="container">
	<% for (ProductBean bean : products) {
		if (bean.isBevanda()) { %>
	<div class="card">
		<div  class="card-img"><img src="./resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
		<div class="card-title"><%=bean.getName()%></div>
		<div class="card-subtitle"><%=bean.getDescription()%></div>
		<hr class="card-divider">
		<div class="card-footer">
			<div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
			<button class="card-btn">
				<a href="add-to-cart?action=addC&id=<%=bean.getCode()%>&page=ProductView.jsp"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
			}}
	%>
	</div>

<h2>Bundles</h2>
<div class="container">
	<% for (ProductBean bean : products) {
		if (bean.isBundle()) { %>
	<div class="card">
		<div  class="card-img"><img src="./resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt=""></div>
		<div class="card-title"><%=bean.getName()%></div>
		<div class="card-subtitle"><%=bean.getDescription()%></div>
		<hr class="card-divider">
		<div class="card-footer">
			<div class="card-price"><%=bean.getPrice()%><span>&euro;</span></div>
			<button class="card-btn">
				<a href="add-to-cart?action=addC&id=<%=bean.getCode()%>&page=ProductView.jsp"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
			}}
	%>
</div>

<%@ include file="resources/jsp_pages/Footer.jsp" %>
</div>

<script>
	const cartIcon = document.querySelector('#header #icons .fa-cart-shopping');
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
		const movingTexts = document.querySelectorAll('.moving-text');

		function startMarquee() {
		movingTexts.forEach(text => {
			text.style.animation = 'marquee 10s linear infinite';
		});
		}

		function stopMarquee() {
		movingTexts.forEach(text => {
			text.style.animation = 'none';
		});
		}
</script>
</body>
</html>
