<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.model.OrderBean, java.util.*"%>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
    <title>I miei ordini</title>
</head>
<body>

<div id="main" class="clear">

    <h2>I Miei Ordini</h2>

    <% ArrayList<?> ordini = (ArrayList<?>) request.getSession().getAttribute("ordini");

        if (ordini != null && ordini.size() != 0) {%>

    <table class = "ordini">
        <tr>
            <th>Id</th>
            <th>Data</th>
            <th>Importo totale</th>
            <th></th>

        </tr>

        <% Iterator<?> it = ordini.iterator();
            while (it.hasNext()) {
                OrderBean bean = (OrderBean) it.next();
        %>

        <tr>
            <td> <%= bean.getOrderId() %></td>
            <td> <%= bean.getDate() %></td>
            <td> &euro;<%=String.format("%.2f",bean.getTotalImport())%></td>
            <td> <a href="Ordine?action=orderDetails&id=<%= bean.getOrderId() %>"> dettagli</a></td>
        </tr>

        <%}%></table>
    <%} else {%>


    <h2>Non ci sono ordini</h2>

    <%
        }
    %>



</div>
</body>
</html>
