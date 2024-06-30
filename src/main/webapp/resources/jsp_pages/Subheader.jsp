<%@ page language="java"%>

<%
    String userE = (String) request.getSession().getAttribute("userEmail");
    boolean userLogged = userE != null && !userE.isEmpty();

    String user_typ =(String) request.getSession().getAttribute("userType");
%>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/HeaderStyle.css" type="text/css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ErrorMessage.css" type="text/css"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<div id="subheader">
    <a href="#" id="drop">Filtra prodotti</a>

    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/ProductView.jsp">
                &#128269; Tutti i prodotti &#128269;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=offerta">
                &#128293; Offerte &#128293;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=novita">
                &#10024; Novit&agrave; &#10024;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=trend">
                &#127852; Trend &#127852;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=bundle">
                &#127873; Bundle &#127873;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=bestseller">
                &#127881; Bestsellers &#127881;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=bevanda">
                &#127862; Bevande &#127862;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=dolce">
                &#127849; Dolci &#127849;
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/product?sort=salato">
                &#127839; Salati &#127839;
            </a>
        </li>
        <li>
            <a href="#" onclick="return checkUserTypeForB2B();">
                &#128666; B2B &#128666;
            </a>
        </li>
    </ul>
</div>

<div id="errorMessage" class="hidden">Non hai i permessi per accedere a questa pagina.</div>

<script>
    let drop = document.getElementById("drop");
    let body = document.getElementsByTagName("body")[0];
    let ul = document.getElementById("subheader").getElementsByTagName("ul")[0];
    let flag = false;

    drop.addEventListener("click", fullscreenFilters);

    function fullscreenFilters() {
        ul.style.display = "flex";
        body.style.overflow = "hidden";
        flag = true;
    }

    window.addEventListener("resize", function () {
        if (window.innerWidth >= 1251 && flag === false) {
            body.style.overflow = "auto";
        } else if (window.innerWidth < 1251 && flag === true) {
            body.style.overflow = "hidden";
        } else {
            body.style.overflow = "auto";
        }
    });

    function checkUserTypeForB2B() {
        var userType = '<%= user_typ %>';
        if (userType !== 'venditore' && userType !== 'admin') {
            showErrorMessage();
            return false;
        } else {
            window.location.href = '${pageContext.request.contextPath}/resources/jsp_pages/B2b.jsp';
            return true;
        }
    }

    function showErrorMessage() {
        var errorMessage = document.getElementById('errorMessage');
        errorMessage.classList.remove('hidden');
        setTimeout(function() {
            errorMessage.classList.add('hidden');
        }, 2000);
    }
</script>


