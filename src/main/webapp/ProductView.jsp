<%@ page language="java"%>

<%
	List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect(request.getContextPath() + "/product");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<body>
<div class="body-container">
	<div class="text-container">
		<span class="moving-text">Spedizione gratuita per gli ordini superiori a 50 euro!!&#127752;</span>
	</div>

<%@ include file="resources/jsp_pages/Header.jsp" %>
	<%@ include file="resources/jsp_pages/Subheader.jsp" %>



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

	<%@ include file="resources/jsp_pages/Footer.jsp" %>
</body>
</html>

