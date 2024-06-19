<%@ page language="java"%>
<%@ page import="com.example.model.OtpBean" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ValidateOTP</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f1f1f1;
        }

        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: calc(100% - 10px);
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }

        .success-message {
            color: green;
            font-size: 14px;
            margin-top: 10px;
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
%>

<% OtpBean otp= new OtpBean();
    int code=otp.getOtp();
    otp.setDestinatario(email);
    otp.sentEmail();
%>

<form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" onsubmit="return validateOTP()">
    <input type="hidden" name="nome" value="<%= nome %>">
    <input type="hidden" name="cognome" value="<%= cognome %>">
    <input type="hidden" name="data_di_nascita" value="<%= dataDiNascita %>">
    <input type="hidden" name="email" value="<%= email %>">
    <input type="hidden" name="password" value="<%= password %>">
    <input type="hidden" name="tipo_utente" value="<%= tipoUtente %>">
    <input type="hidden" name="partita_iva" value="<%= partitaIVA %>">
    <input type="hidden" name="codice_fiscale" value="<%= codiceFiscale %>">

    <label for="otp">Inserisci il codice OTP:</label>
    <input type="text" id="otp" name="otp" required>

    <input type="submit" value="Invia">
</form>

<script>
    var code = '<%= code %>';
    function validateOTP() {
        var otpInput = document.getElementById('otp').value;
        if (otpInput !== code) {
            alert('Codice OTP non corretto.');
            return false;
        }
        return true;
    }
</script>

</body>
</html>

