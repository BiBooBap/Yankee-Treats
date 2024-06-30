<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conferma Eliminazione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/confirmDelete.css" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>Conferma Eliminazione</h2>
    <p>Sei sicuro di voler eliminare questo prodotto?</p>
    <div class="btn-container">
        <form action="${pageContext.request.contextPath}/InsertProduct" method="post" style="width: 48%;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="code" value="${deleteCode}">
            <button type="submit" class="btn btn-danger">Elimina</button>
        </form>
        <a href="${pageContext.request.contextPath}/resources/jsp_pages/DBInterface.jsp" class="btn btn-secondary">Annulla</a>
    </div>
</div>
</body>
</html>
