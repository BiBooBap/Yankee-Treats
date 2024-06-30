var code = '<%= code %>';
var attempts = 3;

function validateOTP() {
    var otpInput = document.getElementById('otp').value;
    if (otpInput !== code) {
        attempts--;
        var errorMessage = document.getElementById('errorMessage');
        if (attempts > 0) {
            errorMessage.textContent = 'Codice OTP non corretto. Tentativi rimanenti: ' + attempts;
        } else {
            errorMessage.textContent = 'Hai esaurito i tentativi. Richiedi un nuovo codice OTP.';
            document.querySelector('input[type="submit"]').disabled = true;
        }
        return false;
    }
    return true;
}

function resendOTP() {
    fetch('${pageContext.request.contextPath}/resendOTP', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'email=<%= email %>'
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                code = data.newCode;
                alert('Nuovo codice OTP inviato. Controlla la tua email.');
                attempts = 3;
                document.getElementById('errorMessage').textContent = '';
                document.querySelector('input[type="submit"]').disabled = false;
            } else {
                alert('Si è verificato un errore nell\'invio del nuovo codice OTP. Riprova più tardi.');
            }
        })
        .catch(error => {
            console.error('Errore:', error);
            alert('Si è verificato un errore. Riprova più tardi.');
        });}