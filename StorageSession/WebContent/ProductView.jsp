<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

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
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.model.ProductBean,it.unisa.model.Cart"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>Catalogo</title>
</head>

<body>


<h2>Products</h2>
<a href="product">List</a>
<table border="1">
	<tr>
		<th>Code <a href="product?sort=code">Sort</a></th>
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
		<td><%=bean.getName()%></td>
		<td><%=bean.getDescription()%></td>
		<td><a href="product?action=delete&id=<%=bean.getCode()%>">Delete</a><br>
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
<table border="1">
	<tr>
		<th>Code</th>
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
</body>
</html>