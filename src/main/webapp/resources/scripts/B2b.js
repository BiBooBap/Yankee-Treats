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