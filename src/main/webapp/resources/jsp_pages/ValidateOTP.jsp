<%@ page language="java"%>
<%@ page import="com.example.model.OtpBean" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifica OTP</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            max-width: 400px;
            width: 90%;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            text-align: center;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error-message {
            color: #d32f2f;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
        .resend-otp {
            text-align: center;
            margin-top: 15px;
        }
        .resend-otp a {
            color: #1976d2;
            text-decoration: none;
        }
        .resend-otp a:hover {
            text-decoration: underline;
        }
    </style>
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
</body>
</html>

