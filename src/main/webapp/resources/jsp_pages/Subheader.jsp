<%@ page language="java"%>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    boolean userLogged = userE != null && !userE.isEmpty();

    String user_typ =(String) request.getSession().getAttribute("userType");
%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Header.css" type="text/css"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">




<div id="subheader">


    <a href="#" id="drop">Prodotti</a>
    <ul>
        <li>
            <a href="/product">
                &#128269; Tutti i prodotti &#128269;
            </a>
        </li>
        <li>
            <a href="product?sort=offerta">
                &#128293; Offerte &#128293;
            </a>
        </li>
        <li>
            <a href="product?sort=novita">
                &#10024; Novit&agrave; &#10024;
            </a>
        </li>
        <li>
            <a href="product?sort=trend">
                &#127852; Trend &#127852;
            </a>
        </li>
        <li>
            <a href="product?sort=bundle">
                &#127873; Bundle &#127873;
            </a>
        </li>
        <li>
            <a href="product?sort=bestseller">
                &#127881; Bestsellers &#127881;
            </a>
        </li>
        <li>
            <a href="product?sort=bevanda">
                &#127862; Bevande &#127862;
            </a>
        </li>
        <li>
            <a href="product?sort=dolce">
                &#127849; Dolci &#127849;
            </a>
        </li>
        <li>
            <a href="product?sort=salato">
                &#127839; Salati &#127839;
            </a>
        </li>
        <li>
            <% if (userLogged && user_typ != null && user_typ.equals("venditore")) { %>
            <a href="${pageContext.request.contextPath}resources/jsp_pages/B2b.jsp" class="link">
                    <% } else if (!userLogged) { %>
                <a href="resources/jsp_pages/Login.jsp?fromB2B=true">
                        <% } else { %>
                    <a href="resources/jsp_pages/errors/403.jsp">
                        <% } %>
                        &#128666; B2B &#128666;
                    </a>
        </li>
    </ul>



</div>


<script>
    let drop = document.getElementById("drop");
    let body = document.getElementsByTagName("body")[0];
    let ul = document.getElementById("subheader").getElementsByTagName("ul")[0];

    drop.addEventListener("click", function () {
        if (ul.style.display === "none" && document.body.clientWidth <= 1250) {
            ul.style.display = "flex";
            body.style.overflow = "hidden"
        } else {
            ul.style.display = "none";
            body.style.overflow = "auto";
        }

        return false; //Needed to avoid the page to scroll to the top or follow the link
    });
</script>