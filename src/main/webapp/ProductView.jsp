<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
	String userMail = request.getParameter("userEmail");
	if (userMail != null && !userMail.isEmpty()) {
		session.setAttribute("userEmail", userMail);
	} else {
		userMail = (String) session.getAttribute("userEmail");
	}

	List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
	request.getSession().setAttribute("products", products);

	if(products == null) {
		response.sendRedirect(request.getContextPath() + "/product");
		return;
	}

	String user_type= (String) request.getSession().getAttribute("userType");
	if (user_type != null && !user_type.isEmpty()) {
		session.setAttribute("userType", user_type);
	} else {
		user_type = "guest";
		session.setAttribute("userType", user_type);
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

	<%@ include file="resources/jsp_pages/Offers.jsp" %>
	<%@ include file="resources/jsp_pages/Header.jsp" %>
	<%@ include file="resources/jsp_pages/Subheader.jsp" %>

	<br>

	<h1 class="animated-header">
		<span>V</span><span>e</span><span>t</span><span>r</span><span>i</span><span>n</span><span>a</span>
	</h1>

	<div class="container">
		<% for (ProductBean bean : products) {
			if (!bean.isB2B()) {%>
		<a href="${pageContext.request.contextPath}/resources/jsp_pages/ProductDetail.jsp?code=<%=bean.getCode()%>" class="product-card-link">
		<div class="product-card" data-price="<%=bean.getPrice()%>">
			<div class="card-img">
				<img src="${pageContext.request.contextPath}/resources/images/product_<%=bean.getCode()%>.png" alt="<%=bean.getName()%>" class="product-image">
				<% if(bean.isNovita()) { %>
				<div class="new">Nuovo!</div>
				<% } %>
				<% if (bean.isOfferta()) { %>
				<div class="offer">Offerta!</div>
				<% } %>
			</div>
			<div class="product-info">
				<h3 class="product-name"><%=bean.getName()%></h3>
				<p class="product-description"><%=bean.getDescription()%></p>
				<p class="product-price">&#8364;<span class="price-value"></span></p>
			</div>
			<a href="cart?action=addC&id=<%=bean.getCode()%>"><button class="add-to-cart">Aggiungi al Carrello</button></a>
		</div>
		<% } } %>
	</div>

	<%@ include file="resources/jsp_pages/Footer.jsp" %>
</body>


<script>
	document.addEventListener('DOMContentLoaded', () => {
		const cards = document.querySelectorAll('.product-card');

		cards.forEach(card => {
			// Price animation
			const priceElement = card.querySelector('.price-value');
			const originalPrice = parseFloat(card.dataset.price);
			let currentPrice = 0;

			const animatePrice = () => {
				if (currentPrice < originalPrice) {
					currentPrice += 0.01;
					priceElement.textContent = currentPrice.toFixed(2);
					requestAnimationFrame(animatePrice);
				} else {
					priceElement.textContent = originalPrice.toFixed(2);
				}
			};

			animatePrice();
		});
	});

	function updateProductView(products) {
		console.log("Updating product view with:", products);
		let container = document.querySelector('.container');
		if (!container) {
			console.error("Container not found");
			return;
		}
		container.innerHTML = '';

		if (products.length === 0) {
			container.innerHTML = '<p>Nessun prodotto trovato.</p>';
		} else {
			products.forEach(product => {
				if (!product.b2b) {
					let productCard = createProductCard(product);
					container.appendChild(productCard);
				}
			});
		}
	}

	function createProductCard(product) {
		console.log("Creating card for product:", product);
		let card = document.createElement('div');
		card.className = 'product-card';
		card.dataset.price = product.price;

		card.innerHTML = `
            <div class="card-img">
                <img src="${pageContext.request.contextPath}/resources/images/product_${product.code}.png" alt="${product.getName()}" class="product-image">
                ${product.novita ? '<div class="new">Nuovo!</div>' : ''}
                ${product.offerta ? '<div class="offer">Offerta!</div>' : ''}
            </div>
            <div class="product-info">
                <h3 class="product-name">${product.name}</h3>
                <p class="product-description">${product.description}</p>
                <p class="product-price">&#8364;<span class="price-value">${product.price.toFixed(2)}</span></p>
            </div>
        </a>
        <a href="cart?action=addC&id=${product.code}"><button class="add-to-cart">Aggiungi al Carrello</button></a>
    `;

		return card;
	}
</script>


</html>

