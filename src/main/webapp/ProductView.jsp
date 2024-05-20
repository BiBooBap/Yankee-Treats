<%@ page language="java"%>

<%
	List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");
		return;
	}

	ProductBean product = (ProductBean) request.getAttribute("product");
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<%@ page import="java.util.*,com.example.model.ProductBean,com.example.model.Cart"%>

<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link href="resources/css/ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<html>
<body>
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
				<a href="product?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
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
				<a href="product?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
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
				<a href="product?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
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
				<a href="product?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
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
				<a href="product?action=addC&id=<%=bean.getCode()%>"> <i class="fa-solid fa-cart-circle-plus fa-lg"></i></a>
			</button>
		</div>
	</div>
	<%
			}}
	%>
</div>

<% if (products.isEmpty()) { %>
<p>Nessun prodotto disponibile</p>
<% } %>



<%@ include file="resources/jsp_pages/Footer.jsp" %>
</body>
</html>