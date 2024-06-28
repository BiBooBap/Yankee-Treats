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

	<div class="text-header-container">
		<div class="soda-text" id="sodaText">Vetrina</div>
	</div>



	<div class="input-wrapper">
		<form id="searchForm" onsubmit="return false;">
			<input type="text" placeholder="Oggi ho voglia di.." name="text" class="searchbar" id="searchbar">
			<button type="submit" class="search-button">&#128270;</button>
		</form>
		<div id="searchResults"></div>
	</div>

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







	const sodaText = document.getElementById('sodaText');
	const textWidth = sodaText.offsetWidth;
	const textHeight = sodaText.offsetHeight;

	function createBubble() {
		const bubble = document.createElement('div');
		bubble.classList.add('bubble');

		const size = Math.random() * 8 + 2; // Dimensione casuale tra 2px e 10px
		bubble.style.width = size + 'px';
		bubble.style.height = size + 'px';

		const startX = Math.random() * textWidth;
		const startY = textHeight;

		bubble.style.left = startX + 'px';
		bubble.style.bottom = '0px';

		sodaText.appendChild(bubble);

		animateBubble(bubble);
	}

	function animateBubble(bubble) {
		let position = 0;
		const random = Math.random() * 3 + 1; // Velocità casuale

		const animation = setInterval(function() {
			position += random;
			bubble.style.bottom = position + 'px';

			// Movimento ondulatorio orizzontale
			bubble.style.left = (parseFloat(bubble.style.left) + Math.sin(position / 10) * 0.5) + 'px';

			if (position > textHeight - 20) { // Inizia il fading 20px prima del bordo superiore
				let opacity = 1 - (position - (textHeight - 20)) / 20;
				bubble.style.opacity = opacity;
			}

			if (position > textHeight) {
				clearInterval(animation);
				bubble.remove();
			}
		}, 20);
	}

	// Crea nuove bollicine ad intervalli regolari
	setInterval(createBubble, 100);



</script>


</html>

