<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordine Completato con Successo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/OrderComplete.css" type="text/css"/>
</head>
<body>

<div class="container">
    <h1>Ordine Completato con Successo!</h1>
    <% if (!request.getSession().getAttribute("userType").equals("guest")){%>
    <p>Grazie per il tuo acquisto. Il tuo ordine numero: ORDRN<%= request.getSession().getAttribute("lastOrder") %> è stato completato con successo. Puoi visionare tutti i tuoi ordini nella sezione dedicata. Premi qui per scaricare la fattura, oppure controlla la mail.</p>
    <a href="${pageContext.request.contextPath}/ProductView.jsp" class="btn">Torna alla Homepage</a>
    <a href="${pageContext.request.contextPath}/Download" class="btn btn-download">Scarica Fattura</a>
    <% } else { %>
    <p>Grazie per il tuo acquisto. Il tuo ordine numero: ORDRN<%= request.getSession().getAttribute("lastOrder") %> è stato completato con successo. Premi qui per scaricare la fattura, oppure controlla la mail scelta precedentemente.</p>
    <a href="${pageContext.request.contextPath}/logout" class="btn">Torna alla Homepage</a>
    <a href="${pageContext.request.contextPath}/Download" class="btn btn-download">Scarica Fattura</a>
    <% } %>
</div>

</body>
</html>
