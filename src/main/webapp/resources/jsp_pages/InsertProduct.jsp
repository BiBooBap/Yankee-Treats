<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

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
    </style>
</head>
<body>
<div class="container">

    <div class="section">
        <h2>Inserisci prodotto</h2>
        <form action="${pageContext.request.contextPath}/InsertProduct" method="post" >
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
                        <input type="checkbox" id="bestseller" name="bestseller" value="true">
                        <label for="bestseller">Bestseller</label>
                    </div>
                    <div>
                        <input type="checkbox" id="dolce" name="dolce" value="true">
                        <label for="dolce">Dolce</label>
                    </div>
                    <div>
                        <input type="checkbox" id="salato" name="salato" value="true">
                        <label for="salato">Salato</label>
                    </div>
                    <div>
                        <input type="checkbox" id="bevanda" name="bevanda" value="true">
                        <label for="bevanda">Bevanda</label>
                    </div>
                    <div>
                        <input type="checkbox" id="trend" name="trend" value="true">
                        <label for="trend">Trend</label>
                    </div>
                    <div>
                        <input type="checkbox" id="novita" name="novita" value="true">
                        <label for="novita">Novità</label>
                    </div>
                    <div>
                        <input type="checkbox" id="offerta" name="offerta" value="true">
                        <label for="offerta">Offerta</label>
                    </div>
                    <div>
                        <input type="checkbox" id="bundle" name="bundle" value="true">
                        <label for="bundle">Bundle</label>
                    </div>
                    <div>
                        <input type="checkbox" id="b2b" name="b2b" value="true">
                        <label for="b2b">B2B</label>
                    </div>
                    <div class="form-group">
                        <label for="productImage">Immagine del Prodotto (PNG)</label>
                        <input type="file" id="productImage" name="productImage" accept=".png" required>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn">Inserisci Prodotto</button>
        </form>
    </div>

</div>

</body>
</html>
