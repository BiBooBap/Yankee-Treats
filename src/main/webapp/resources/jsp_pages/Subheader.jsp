<<<<<<< HEAD
<%@ page language="java"%>



<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Varela+Round&display=swap" rel="stylesheet">




<link rel="stylesheet" href="resources/css/Subheader.css" type="text/css"/>
<div id="subheader">
    <ul>
        <li>
            <a href="ProductView.jsp" class="link">
=======


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Header.css" type="text/css"/>



<div id="subheader">
    <ul>
        <li>
            <a href="#" class="link">
>>>>>>> a0017e3 (Restructured pages, Header now is sticky, Offers.jsp page implemented (differenced to Header.jsp), created proper CSS files for some of the pages, made relative references for most of the implementations)
                <span class="link--top">Tutti i prodotti &#128269;</span>
                <span class="link--bottom">Tutti i prodotti &#128269;</span>
            </a>
        </li>
        <li>
            <a href="#" class="link">
                <span class="link--top">Offerte &#128293;</span>
                <span class="link--bottom">Offerte &#128293;</span>
            </a>
        </li>
        <li>
            <a href="#" class="link">
                <span class="link--top">Novit&agrave; &#10024;</span>
                <span class="link--bottom">Novit&agrave; &#10024;</span>
            </a>
        </li>
        <li>
            <a href="#" class="link">
                <span class="link--top">Trend &#127852;</span>
                <span class="link--bottom">Trend &#127852;</span>
            </a>
        </li>
        <li>
            <a href="#" class="link">
                <span class="link--top">Bundle &#127873;</span>
                <span class="link--bottom">Bundle &#127873;</span>
            </a>
        </li>
        <li>
            <a href="#" class="link">
                <span class="link--top">B2B &#128666;</span>
                <span class="link--bottom">B2B &#128666;</span>
            </a>
        </li>
    </ul>
</div>


<<<<<<< HEAD
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
</script>
=======

>>>>>>> a0017e3 (Restructured pages, Header now is sticky, Offers.jsp page implemented (differenced to Header.jsp), created proper CSS files for some of the pages, made relative references for most of the implementations)
