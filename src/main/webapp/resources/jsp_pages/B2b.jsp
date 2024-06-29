<%@ page language="java"%>
<%@ page import="java.util.*, com.example.model.*, com.example.control.*"%>

<%
    String userMail = request.getParameter("userEmail");
    if (userMail != null && !userMail.isEmpty()) {
        session.setAttribute("userEmail", userMail);
    } else {
        userMail = (String) session.getAttribute("userEmail");
    }

    List<ProductBean> products = (List<ProductBean>) request.getSession().getAttribute("products");
    request.getSession().setAttribute("products", products);

    if (products == null) {
        response.sendRedirect(request.getContextPath() + "/B2b.jsp");
        return;
    }

    String userType = request.getParameter("userType");
    if (userType != null && !userType.isEmpty()) {
        session.setAttribute("userType", userType);
    } else {
        userType = (String) session.getAttribute("userType");
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/B2bStyle.css" rel="stylesheet" type="text/css">
    <title>B2B - Yankee Treats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@ include file="Header.jsp" %>

<section id="intro">
    <h1>Benvenuto al nostro programma B2B</h1>
    <p>Scopri la nostra vasta selezione di snack americani, perfetti per rivenditori, distributori e aziende. Approfitta di prezzi competitivi, offerte speciali e un servizio clienti dedicato.</p>
    <p>I nostri prezzi all'ingrosso sono pensati per offrire il massimo vantaggio ai nostri clienti B2B. Offriamo prezzi speciali per ordini di grandi dimensioni. Ordina oggi per sorprendere i tuoi clienti con i migliori marchi americani come Lay's, Coca-Cola, Hershey's e molti altri!</p>
</section>

<div class="container">
    <% for (ProductBean bean : products) {
        if (bean.isB2B()) { %>
    <div class="product-card">
        <div class="card-img">
            <img src="${pageContext.request.contextPath}/resources/images/product_<%=bean.getCode()%>.png" alt="<%=bean.getName()%>" class="product-image">
        </div>
        <div class="product-info">
            <h3 class="product-name"><%=bean.getName()%></h3>
            <p class="product-description"><%=bean.getDescription()%></p>
            <p class="product-price">&#8364;<%=bean.getPrice()%></p>
            <a href="${pageContext.request.contextPath}/cart?action=addB2B&id=<%=bean.getCode()%>"><button class="add-to-cart">Aggiungi al Carrello</button></a>
        </div>
    </div>
    <% } } %>
</div>

<section id="testimonials">
    <h2>Cosa dicono i nostri clienti</h2>
    <div class="testimonial-card">
        <p>"Collaborare con Yankee Treats &eacute; stata un'esperienza fantastica. La qualit&agrave; dei prodotti e l'efficienza del loro servizio clienti hanno superato ogni nostra aspettativa. I nostri clienti sono entusiasti della variet&agrave; e del gusto unico degli snack americani!"</p>
        <span>- Marco Rossi, CEO di SnackMania</span>
    </div>
    <div class="testimonial-card">
        <p>"I prezzi competitivi e le offerte speciali di Yankee Treats ci hanno permesso di aumentare significativamente i nostri margini di profitto. Inoltre, il loro servizio di supporto &eacute; sempre pronto ad assisterci in ogni fase dell'acquisto."</p>
        <span>- Alessandra Bianchi, Responsabile Acquisti di Sweet&Snack</span>
    </div>
    <div class="testimonial-card">
        <p>"La nostra collaborazione con Yankee Treats ha trasformato il nostro business. La selezione di snack e bibite &eacute; sempre fresca e di alta qualit&agrave;, e i tempi di consegna sono rapidissimi. Non possiamo che raccomandarli a tutti!"</p>
        <span>- Luca Verdi, Direttore Vendite di American Goodies</span>
    </div>
    <div class="testimonial-card">
        <p>"La gamma di prodotti offerta da Yankee Treats &egrave; incredibile. I nostri clienti adorano le novit&agrave; e la variet&agrave; disponibile. Inoltre, la loro piattaforma B2B &eacute; intuitiva e facile da usare."</p>
        <span>- Giulia Neri, Proprietaria di Snack Corner</span>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const cards = document.querySelectorAll('.product-card');

        cards.forEach(card => {
            // Price animation
            const priceElement = card.querySelector('.price-value');
            const originalPrice = parseFloat(card.dataset.price);
            let currentPrice = 0;

            const animatePrice = () => {
                if (currentPrice < originalPrice) {
                    currentPrice += 0.01;
                    priceElement.textContent = currentPrice.toFixed(2);
                    requestAnimationFrame(animatePrice);
                } else {
                    priceElement.textContent = originalPrice.toFixed(2);
                }
            };

            animatePrice();
        });
    });
</script>

<%@ include file="Footer.jsp" %>
</body>
</html>



