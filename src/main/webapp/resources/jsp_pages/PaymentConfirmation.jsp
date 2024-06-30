<%@ page language="java" %>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conferma Pagamento</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/PaymentConfirmation.css" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>Conferma Pagamento</h2>
    <div class="details">
        <h3>Dettagli Pagamento</h3>
        <ul>
            <li>ID Pagamento: ${paymentDetails.paymentIntentId}</li>
            <li>Importo: ${paymentDetails.amount} ${paymentDetails.currency}</li>
            <li>Creato il: ${paymentDetails.created}</li>
        </ul>
    </div>

    <div class="details">
        <h3>Dettagli Carrello</h3>
        <ul>
            <c:forEach var="entry" items="${paymentDetails.entrySet()}">
                <c:if test="${entry.key.startsWith('product_')}">
                    <li>
                        <strong>${entry.value.productName}</strong> -
                            ${entry.value.productDescription} -
                        Quantità: ${entry.value.productQuantity} -
                        Prezzo unitario: ${entry.value.productPrice} -
                        Prezzo totale: ${entry.value.totalPrice}
                    </li>
                </c:if>
            </c:forEach>
            <li><strong>Totale Carrello: ${paymentDetails.cartTotal}</strong></li>
        </ul>
    </div>

    <a href="checkout.jsp" class="btn">Torna alla pagina di pagamento</a>
</div>
</body>
</html>



