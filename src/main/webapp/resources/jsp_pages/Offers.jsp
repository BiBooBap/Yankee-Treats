
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Header.css" type="text/css"/>



<div class="body-container">
    <div class="text-container">
        <span class="moving-text">Spedizione gratuita per gli ordini di 50 euro</span>
        <!-- Aggiungi più frasi qui -->
    </div>
</div>




<script>
    const movingTexts = document.querySelectorAll('.moving-text');

    function startMarquee() {
        movingTexts.forEach((movingText, index) => {
            const clone = movingText.cloneNode(true);
            movingText.parentNode.appendChild(clone);
            const duration = 10 * (index + 1);
            const delay = 5 * (index + 1);

            movingText.style.animation = `marquee ${duration}s linear infinite`;
            clone.style.animation = `marquee ${duration}s linear infinite`;
            clone.style.animationDelay = `${delay}s`;
        });
    }

    document.addEventListener('DOMContentLoaded', startMarquee);
</script>
