<%@ page language="java"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/Registration.css" type="text/css"/>

</head>
<body>

<%@ include file="Header.jsp" %>

<div class="container">
    <h2>Registrazione</h2>
    <form action="ValidateOTP.jsp" method="post">
        <input type="text" name="nome" placeholder="Nome" required>
        <input type="text" name="cognome" placeholder="Cognome" required>
        <input type="date" name="data_di_nascita" placeholder="Data di nascita" required>
        <br>
        <br>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" id="password" name="password" placeholder="Password" required>
        <input type="password" name="confermapassword" id="conferma-password" placeholder="Conferma Password" onkeyup="checkPasswordMatch()" required>
        <div id="password-error" class="error-message" style="display: none;">Le password non corrispondono. Riprova.</div>
        <select name="tipo_utente" required>
            <option value="">Seleziona tipo di utente</option>
            <option value="venditore">Venditore</option>
            <option value="privato">Privato</option>
        </select>
        <div id="partita_iva" style="display: none;">
            <input type="text" name="partita_iva" placeholder="Partita IVA">
        </div>
        <div id="codice_fiscale" style="display: none;">
            <input type="text" name="codice_fiscale" placeholder="Codice Fiscale">
        </div>
        <input type="submit" value="Registrati">
    </form>
</div>

<script>
    function checkPasswordMatch() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("conferma-password").value;
        var errorDiv = document.getElementById("password-error");

        if (password != confirmPassword) {
            errorDiv.style.display = "block";
            return false;
        } else {
            errorDiv.style.display = "none";
            return true;
        }
    }

    document.querySelector('select[name="tipo_utente"]').addEventListener('change', function() {
        if (this.value === 'venditore') {
            document.getElementById('partita_iva').style.display = 'block';
            document.getElementById('codice_fiscale').style.display = 'none';
        } else if (this.value === 'privato') {
            document.getElementById('partita_iva').style.display = 'none';
            document.getElementById('codice_fiscale').style.display = 'block';
        } else {
            document.getElementById('partita_iva').style.display = 'none';
            document.getElementById('codice_fiscale').style.display = 'none';
        }
    });
</script>


</body>
</html>