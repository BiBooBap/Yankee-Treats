<%@ page language="java"%>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    boolean userLogged = userE != null && !userE.isEmpty();

    String user_typ=(String) request.getSession().getAttribute("userType");
%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Header.css" type="text/css"/>



<div id="subheader">
    <ul>
        <li>
            <a href="ProductView.jsp" class="link">
                <span class="link--top">Tutti i prodotti &#128269;</span>
                <span class="link--bottom">Tutti i prodotti &#128269;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=offerta" class="link">
                <span class="link--top">Offerte &#128293;</span>
                <span class="link--bottom">Offerte &#128293;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=novita" class="link">
                <span class="link--top">Novit&agrave; &#10024;</span>
                <span class="link--bottom">Novit&agrave; &#10024;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=trend" class="link">
                <span class="link--top">Trend &#127852;</span>
                <span class="link--bottom">Trend &#127852;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=bundle" class="link">
                <span class="link--top">Bundle &#127873;</span>
                <span class="link--bottom">Bundle &#127873;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=bestseller" class="link">
                <span class="link--top">Bestsellers &#127881;</span>
                <span class="link--bottom">Bestsellers &#127881;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=bevanda" class="link">
                <span class="link--top">Bevande &#127862;</span>
                <span class="link--bottom">Bevande &#127862;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=dolce" class="link">
                <span class="link--top">Dolci &#127849;</span>
                <span class="link--bottom">Dolci &#127849;</span>
            </a>
        </li>
        <li>
            <a href="product?sort=salato" class="link">
                <span class="link--top">Salati &#127839;</span>
                <span class="link--bottom">Salati &#127839;</span>
            </a>
        </li>
        <li>
            <% if (userLogged && user_typ != null && user_typ.equals("venditore")) { %>
            <a href="resources/jsp_pages/B2b.jsp" class="link">
                    <% } else if (!userLogged) { %>
                <a href="resources/jsp_pages/Login.jsp?fromB2B=true" class="link">
                    <% } else { %>
                        <a href="#" class="link">
                    <% } %>
                    <span class="link--top">B2B &#128666;</span>
                <span class="link--bottom">B2B &#128666;</span>
            </a>
        </li>
    </ul>

</div>

<script>
    window.onscroll = function() {myFunction()};

    let header = document.getElementById("subheader");
    let sticky = header.offsetTop;

    function myFunction() {
        if (window.scrollY > sticky) {
            header.classList.add("sticky");
        } else {
            header.classList.remove("sticky");
        }
    }

    function showErrorMessage() {

    }

</script>

