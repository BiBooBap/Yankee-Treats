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