function toggleForm(formId) {
    var form = document.getElementById(formId);
    form.style.display = (form.style.display === 'block') ? 'none' : 'block';
}

window.onload = function() {
    var messageBox = document.getElementById('messageBox');
    if (messageBox.innerHTML.trim() !== "") {
        messageBox.style.display = 'block';
        setTimeout(function() {
            messageBox.style.display = 'none';
        }, 1000);
    }
}