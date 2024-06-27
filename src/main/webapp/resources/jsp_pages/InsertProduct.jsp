<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    List<ProductBean> products = (List<ProductBean>) request.getSession().getAttribute("products");
    request.getSession().setAttribute("products", products);

    String message = (String) request.getSession().getAttribute("message");
    request.getSession().removeAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inserimento dei prodotti</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        form {
            margin-bottom: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        form input[type="text"],
        form input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }

        form button[type="submit"],
        form button[type="button"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        form button[type="submit"]:hover,
        form button[type="button"]:hover {
            background-color: #45a049;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group input[type="number"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 10px;
        }

        .checkbox-group div {
            display: flex;
            align-items: center;
        }

        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background-color: #45a049;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .section {
            margin-bottom: 40px;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .product-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
        }

        .product-info {
            flex: 1;
        }

        .product-info h3 {
            margin-bottom: 5px;
        }

        .product-info p {
            margin: 0;
        }

        .product-actions {
            display: flex;
        }

        .product-actions button {
            margin-right: 10px;
        }

        .btn-quantity, .btn-delete, .btn-edit {
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-quantity:hover, .btn-delete:hover, .btn-edit:hover {
            background-color: #eee;
        }

        .btn-delete {
            background-color: #f00;
            color: #fff;
        }

        .btn-edit {
            background-color: #007bff;
            color: #fff;
        }

        #messageBox {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #333;
            color: #fff;
            padding: 20px;
            border-radius: 8px;
            display: none;
        }

        .popup-form {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            z-index: 1000;
            display: none;
        }

        .popup-form button[type="button"] {
            background-color: #f00;
        }

        #alert {
            /* Style the alert text */
            color: #d9534f; /* Red or your preferred alert color */
            font-weight: bold;

            /* Style the container for better visual distinction */
            background-color: rgba(255, 221, 221, 0.8); /* Light red background */
            padding: 3px 5px;
            border-radius: 3px; /* Rounded corners */
            margin-left: 5px; /* Add spacing for better readability */
        }

        .btn-home {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-bottom: 20px;
        }

        .btn-home:hover {
            background-color: #45a049;
        }

        .btn-home:active {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
<div class="container">
    <% if (message != null) { %>
        <div id="messageBox"><%= message %></div>
    <% } %>
    <div class="section">
        <a href="${pageContext.request.contextPath}/product" class="btn-home">Torna alla Home</a>
        <h2>Inserisci prodotto</h2>
        <form action="${pageContext.request.contextPath}/InsertProduct?action=addP" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Nome Prodotto</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Descrizione</label>
                <textarea id="productDescription" name="productDescription" rows="4" required></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">Prezzo</label>
                <input type="number" id="productPrice" name="productPrice" required>
            </div>
            <div class="form-group">
                <label for="productQuantity">Quantità</label>
                <input type="number" id="productQuantity" name="productQuantity" required>
            </div>

            <div class="form-group">
                <label>Caratteristiche:</label>
                <div class="checkbox-group">
                    <div>
                        <input type="checkbox" id="productBestseller" name="productBestseller" value="1">
                        <label for="productBestseller">Bestseller</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productDolce" name="productDolce" value="1">
                        <label for="productDolce">Dolce</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productSalato" name="productSalato" value="1">
                        <label for="productSalato">Salato</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productBevanda" name="productBevanda" value="1">
                        <label for="productBevanda">Bevanda</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productTrend" name="productTrend" value="1">
                        <label for="productTrend">Trend</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productNovita" name="productNovita" value="1">
                        <label for="productNovita">Novità</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productOfferta" name="productOfferta" value="1">
                        <label for="productOfferta">Offerta</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productBundle" name="productBundle" value="1">
                        <label for="productBundle">Bundle</label>
                    </div>
                    <div>
                        <input type="checkbox" id="productB2B" name="productB2B" value="1">
                        <label for="productB2B">B2B</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="productImage">Immagine del Prodotto (PNG)</label>
                <input type="file" id="productImage" name="productImage" accept=".png" required>
            </div>
            <button type="submit" class="btn">Inserisci Prodotto</button>
        </form>
    </div>
    <div class="display">
        <h2> Prodotti presenti in magazzino </h2>
        <% for (ProductBean bean : products) { %>
        <div class="product-item">
            <img src="${pageContext.request.contextPath}/resources/images/product_<%=bean.getCode()%>.png" class="product-image" alt="<%=bean.getName()%>">
            <div class="product-info">
                <h3><%= bean.getName() %></h3>
                <% if (bean.getQuantity() == 0) { %>
                <span>Quantità: <span id="product-quantity-<%= bean.getCode() %>"><%= bean.getQuantity() %></span> <span id="alert">Da rifornire!</span> </span>
                <% } else { %>
                <p>Quantità: <span id="product-quantity-<%= bean.getCode() %>"><%= bean.getQuantity() %></span>
                        <% }  %>
            </div>
            <div class="product-actions">
                <button class="btn btn-quantity" onclick="toggleForm('quantityForm_<%= bean.getCode() %>')">Modifica Quantità</button>
                <button class="btn btn-edit" onclick="toggleForm('nameForm_<%= bean.getCode() %>')">Modifica Nome</button>
                <button class="btn btn-edit" onclick="toggleForm('descriptionForm_<%= bean.getCode() %>')">Modifica Descrizione</button>
                <button class="btn btn-edit" onclick="toggleForm('priceForm_<%= bean.getCode() %>')">Modifica Prezzo</button>
                <a href="${pageContext.request.contextPath}/ProductDelete?code=<%=bean.getCode()%>&fromInsertProduct=true"> <button class="btn btn-delete">Elimina</button> </a>

                <!-- Form per modificare la quantità -->
                <form id="quantityForm_<%= bean.getCode() %>" class="popup-form" method="post" action="${pageContext.request.contextPath}/InsertProduct">
                    <input type="hidden" name="action" value="updateqP">
                    <input type="hidden" name="id" value="<%=bean.getCode()%>">
                    <label for="newQ_<%= bean.getCode() %>">Nuova Quantità:</label>
                    <input type="number" id="newQ_<%= bean.getCode() %>" name="newQ" required>
                    <button type="submit">Salva</button>
                    <button type="button" onclick="toggleForm('quantityForm_<%= bean.getCode() %>')">Annulla</button>
                </form>

                <!-- Form per modificare il nome -->
                <form id="nameForm_<%= bean.getCode() %>" class="popup-form" method="post" action="${pageContext.request.contextPath}/InsertProduct">
                    <input type="hidden" name="action" value="updatenP">
                    <input type="hidden" name="id" value="<%=bean.getCode()%>">
                    <label for="newN_<%= bean.getCode() %>">Nuovo Nome:</label>
                    <input type="text" id="newN_<%= bean.getCode() %>" name="newN" required>
                    <button type="submit">Salva</button>
                    <button type="button" onclick="toggleForm('nameForm_<%= bean.getCode() %>')">Annulla</button>
                </form>

                <!-- Form per modificare la descrizione -->
                <form id="descriptionForm_<%= bean.getCode() %>" class="popup-form" method="post" action="${pageContext.request.contextPath}/InsertProduct">
                    <input type="hidden" name="action" value="updatedP">
                    <input type="hidden" name="id" value="<%=bean.getCode()%>">
                    <label for="newD_<%= bean.getCode() %>">Nuova Descrizione:</label>
                    <input type="text" id="newD_<%= bean.getCode() %>" name="newD" required>
                    <button type="submit">Salva</button>
                    <button type="button" onclick="toggleForm('descriptionForm_<%= bean.getCode() %>')">Annulla</button>
                </form>

                <!-- Form per modificare il prezzo -->
                <form id="priceForm_<%= bean.getCode() %>" class="popup-form" method="post" action="${pageContext.request.contextPath}/InsertProduct">
                    <input type="hidden" name="action" value="updatepP">
                    <input type="hidden" name="id" value="<%=bean.getCode()%>">
                    <label for="newP_<%= bean.getCode() %>">Nuovo Prezzo:</label>
                    <input type="number" id="newP_<%= bean.getCode() %>" name="newP" required>
                    <button type="submit">Salva</button>
                    <button type="button" onclick="toggleForm('priceForm_<%= bean.getCode() %>')">Annulla</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
</div>
<script>
    function toggleForm(formId) {
        var form = document.getElementById(formId);
        form.style.display = (form.style.display === 'block') ? 'none' : 'block';
    }

    window.onload = function() {
        var messageBox = document.getElementById('messageBox');
        if (messageBox.innerHTML.trim() !== "") {
            messageBox.style.display = 'block';
            setTimeout(function() {
                messageBox.style.display = 'none';
            }, 1000);
        }
    }
</script>
</body>
</html>


