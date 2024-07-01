<%@ page language="java"%>
<%@ page import="com.example.model.OtpBean" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifica OTP</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ValidateOTP.css" type="text/css"/>
</head>
<body>
<%
    String nome = request.getParameter("nome");
    String cognome = request.getParameter("cognome");
    String dataDiNascita = request.getParameter("data_di_nascita");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String tipoUtente = request.getParameter("tipo_utente");
    String partitaIVA = request.getParameter("partita_iva");
    String codiceFiscale = request.getParameter("codice_fiscale");

    request.setAttribute("nome", nome);
    request.setAttribute("cognome", cognome);
    request.setAttribute("dataDiNascita", dataDiNascita);
    request.setAttribute("email", email);
    request.setAttribute("password", password);
    request.setAttribute("tipoUtente", tipoUtente);
    request.setAttribute("partitaIVA", partitaIVA);
    request.setAttribute("codiceFiscale", codiceFiscale);

    OtpBean otp = new OtpBean();
    int code = otp.getOtp();
    otp.setDestinatario(email);
    otp.sentEmail();
    session.setAttribute("otpBean", otp);
%>
<div class="container">
    <h1>Verifica OTP</h1>
    <p>Abbiamo inviato un codice di verifica all'indirizzo email: <strong><%= email %></strong></p>
    <form action="${pageContext.request.contextPath}/register?fromB2B=${param.fromB2B}&fromCart=${param.fromCart}" method="post" id="registerForm" onsubmit="return validateOTP()">
        <input type="hidden" name="nome" value="<%= nome %>">
        <input type="hidden" name="cognome" value="<%= cognome %>">
        <input type="hidden" name="data_di_nascita" value="<%= dataDiNascita %>">
        <input type="hidden" name="email" value="<%= email %>">
        <input type="hidden" name="password" value="<%= password %>">
        <input type="hidden" name="tipo_utente" value="<%= tipoUtente %>">
        <input type="hidden" name="partita_iva" value="<%= partitaIVA %>">
        <input type="hidden" name="codice_fiscale" value="<%= codiceFiscale %>">
        <label for="otp">Inserisci il codice OTP:</label>
        <input type="text" id="otp" name="otp" required maxlength="6" autocomplete="off">
        <input type="submit" value="Verifica">
    </form>
    <div id="errorMessage" class="error-message"></div>
    <div class="resend-otp">
        <a href="#" onclick="resendOTP()">Non hai ricevuto il codice? Invia di nuovo</a>
    </div>
</div>
</body>

<script>
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
</script>
</html>

