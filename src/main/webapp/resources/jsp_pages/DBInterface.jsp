<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>
<%@ page import="java.sql.SQLException" %>

<%
    Collection<ProductBean> products = null;
    try {
        products = ProductModelDM.doRetrieveAll();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }

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
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --border-color: #bdc3c7;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
        }

        h2 {
            color: var(--primary-color);
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
        }

        form {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--secondary-color);
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group input[type="number"],
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
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

        .btn, .btn-home {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--primary-color);
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover, .btn-home:hover {
            background-color: #2980b9;
        }

        .product-item {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }

        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .product-info {
            flex: 1;
            margin-right: 20px;
        }

        .product-info h3 {
            margin-bottom: 5px;
            color: var(--secondary-color);
        }

        .product-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .btn-edit, .btn-delete, .btn-readd {
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-edit {
            background-color: var(--primary-color);
            color: #fff;
        }

        .btn-delete {
            background-color: var(--error-color);
            color: #fff;
        }

        .btn-readd {
            background-color: var(--success-color);
            color: #fff;
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

        #alert {
            color: var(--error-color);
            font-weight: bold;
            background-color: rgba(231, 76, 60, 0.1);
            padding: 3px 5px;
            border-radius: 3px;
            margin-left: 5px;
        }

        #messageBox {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: var(--secondary-color);
            color: #fff;
            padding: 20px;
            border-radius: 8px;
            display: none;
        }

        @media (max-width: 768px) {
            .product-actions {
                width: 100%;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }

            @media (max-width: 480px) {
                .btn, .btn-home, .btn-edit, .btn-delete, .btn-readd {
                    width: 100%;
                }

                .product-image {
                    margin-right: 0;
                    margin-bottom: 20px;
                }

                .product-info {
                    margin-right: 0;
                    margin-bottom: 20px;
                }

                .product-actions {
                    width: 100%;
                    justify-content: space-between;
                }

                btn, .btn-home, .btn-edit, .btn-delete, .btn-readd {
                    width: calc(50% - 5px);
                    margin-bottom: 10px;
                    text-align: center;
                    padding: 10px 5px;
                    font-size: 14px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }}}
    </style>

</head>
<body>
<%@ include file="Header.jsp" %>

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
                <button class="btn btn-edit" onclick="toggleForm('quantityForm_<%= bean.getCode() %>')">Modifica Quantità</button>
                <button class="btn btn-edit" onclick="toggleForm('nameForm_<%= bean.getCode() %>')">Modifica Nome</button>
                <button class="btn btn-edit" onclick="toggleForm('descriptionForm_<%= bean.getCode() %>')">Modifica Descrizione</button>
                <button class="btn btn-edit" onclick="toggleForm('priceForm_<%= bean.getCode() %>')">Modifica Prezzo</button>
                <% if(bean.isActive()){%>
                <a href="${pageContext.request.contextPath}/ProductDelete?code=<%=bean.getCode()%>&fromInsertProduct=true"> <button class="btn btn-delete">Elimina</button> </a>
                <%} else {%>
                <a href="${pageContext.request.contextPath}/ProductAdd?code=<%=bean.getCode()%>"> <button class="btn btn-readd">Riaggiungi</button> </a>
                <%}%>
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
