<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="com.example.model.*, java.util.*"%>

<%
    ArrayList<ProductBean> prodotti = (ArrayList<ProductBean>) request.getSession().getAttribute("products");
    if(prodotti == null) {
        response.sendRedirect("./catalogo?page=ComposizioneOrdine.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
    <title>Dettagli ordine</title>
</head>
<body>

<div id="main" class="clear">

    <%ArrayList<CartItem> composizione = (ArrayList<CartItem>) request.getSession().getAttribute("composizione");
        if(composizione!=null){
    %>

    <h2> ORDINE #<%=composizione.get(0).getId() %></h2>
    <table class = "ordini">
        <tr>
            <th>Prodotto</th>
            <th>Quantità</th>
            <th>Prezzo Unitario</th>
            <th>Prezzo totale</th>
            <th>Iva</th>
        </tr>
        <% String nomeP = null;
            double prezzoUnitario = 0;

            for(CartItem comp : composizione){
                for(ProductBean p: prodotti){
                    if(p.getCode()==comp.getId()){
                        nomeP = p.getName();
                        prezzoUnitario = p.getPrice();
                    }
                }
        %>

        <tr>
            <td> <%= nomeP%></td>
            <td> <%= comp.getQuantityCart()%></td>
            <td> &euro;<%= prezzoUnitario%></td>
            <td>  &euro;<%= String.format("%.2f",comp.getTotalPrice())%></td>
        </tr>

        <%}%>
    </table>
    <% } %>



</div>
</body>
</html>
