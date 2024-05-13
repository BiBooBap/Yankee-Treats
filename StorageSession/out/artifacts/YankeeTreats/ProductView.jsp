<%@ page language="java"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");
		return;
	}

	ProductBean product = (ProductBean) request.getAttribute("product");

	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.unisa.model.ProductBean,it.unisa.model.Cart"%>

<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<body>
<%@ include file="resources/jsp_pages/Header.jsp" %>
<%@ include file="resources/jsp_pages/Subheader.jsp" %>

<div class="white-container">
<div class="card">
	<div class="card-img"><div class="img"></div></div>
	<div class="card-title">Product title</div>
	<div class="card-subtitle">Product description. Lorem ipsum dolor sit amet, consectetur adipisicing elit.</div>
	<hr class="card-divider">
	<div class="card-footer">
		<div class="card-price"><span>$</span> 123.45</div>
		<button class="card-btn">
			<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="m397.78 316h-205.13a15 15 0 0 1 -14.65-11.67l-34.54-150.48a15 15 0 0 1 14.62-18.36h274.27a15 15 0 0 1 14.65 18.36l-34.6 150.48a15 15 0 0 1 -14.62 11.67zm-193.19-30h181.25l27.67-120.48h-236.6z"></path><path d="m222 450a57.48 57.48 0 1 1 57.48-57.48 57.54 57.54 0 0 1 -57.48 57.48zm0-84.95a27.48 27.48 0 1 0 27.48 27.47 27.5 27.5 0 0 0 -27.48-27.47z"></path><path d="m368.42 450a57.48 57.48 0 1 1 57.48-57.48 57.54 57.54 0 0 1 -57.48 57.48zm0-84.95a27.48 27.48 0 1 0 27.48 27.47 27.5 27.5 0 0 0 -27.48-27.47z"></path><path d="m158.08 165.49a15 15 0 0 1 -14.23-10.26l-25.71-77.23h-47.44a15 15 0 1 1 0-30h58.3a15 15 0 0 1 14.23 10.26l29.13 87.49a15 15 0 0 1 -14.23 19.74z"></path></svg>
		</button>
	</div>
</div>
</div>

<div class="white-container">
	Products
	<table>
		<tr>
			<th>Code <a href="product?sort=code">Sort</a></th>
			<th>Image</th>
			<th>Name <a href="product?sort=name">Sort</a></th>
			<th>Description <a href="product?sort=description">Sort</a></th>
			<th>Action</th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
		<tr>
			<td><%=bean.getCode()%></td>
			<td>
				<img src="./resources/images/product_<%=bean.getCode()%>.png" id="product-image">
			</td>
			<td><%=bean.getName()%></td>
			<td><%=bean.getDescription()%></td>
			<td>
				<a href="product?action=read&id=<%=bean.getCode()%>">Details</a><br>
				<a href="product?action=addC&id=<%=bean.getCode()%>">Add to cart</a>
			</td>
		</tr>
		<%
			}
		} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		if (product != null) {
	%>
	<table>
		<tr>
			<th>Code</th>
			<th>Image</th>
			<th>Name</th>
			<th>Description</th>
			<th>Price</th>
			<th>Quantity</th>
		</tr>
		<tr>
			<td><%=product.getCode()%></td>
			<td><%=product.getName()%></td>
			<td><%=product.getDescription()%></td>
			<td><%=product.getPrice()%></td>
			<td><%=product.getQuantity()%></td>
		</tr>
	</table>
	<%
		}
	%>
</div>


<%@ include file="resources/jsp_pages/Footer.jsp" %>


</body>


</html>