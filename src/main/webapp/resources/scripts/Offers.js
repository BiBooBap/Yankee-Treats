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