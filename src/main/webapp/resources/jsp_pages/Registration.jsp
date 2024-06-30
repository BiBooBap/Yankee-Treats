<%@ page language="java"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/LoginStyle.css" type="text/css"/>
</head>
<body>

<%@ include file="Header.jsp" %>

    <form class="form" action="ValidateOTP.jsp?fromB2B=${param.fromB2B}&fromCart=${param.fromCart}" method="post" onsubmit="return validateForm()">
        <h2>Registrazione</h2>
        <div class="flex-column">
            <label>Informazioni personali</label>
        </div>
        <div class="inputForm">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="20"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M6.02958 19.4012C5.97501 19.9508 6.3763 20.4405 6.92589 20.4951C7.47547 20.5497 7.96523 20.1484 8.01979 19.5988L6.02958 19.4012ZM15.9802 19.5988C16.0348 20.1484 16.5245 20.5497 17.0741 20.4951C17.6237 20.4405 18.025 19.9508 17.9704 19.4012L15.9802 19.5988ZM20 12C20 16.4183 16.4183 20 12 20V22C17.5228 22 22 17.5228 22 12H20ZM12 20C7.58172 20 4 16.4183 4 12H2C2 17.5228 6.47715 22 12 22V20ZM4 12C4 7.58172 7.58172 4 12 4V2C6.47715 2 2 6.47715 2 12H4ZM12 4C16.4183 4 20 7.58172 20 12H22C22 6.47715 17.5228 2 12 2V4ZM13 10C13 10.5523 12.5523 11 12 11V13C13.6569 13 15 11.6569 15 10H13ZM12 11C11.4477 11 11 10.5523 11 10H9C9 11.6569 10.3431 13 12 13V11ZM11 10C11 9.44772 11.4477 9 12 9V7C10.3431 7 9 8.34315 9 10H11ZM12 9C12.5523 9 13 9.44772 13 10H15C15 8.34315 13.6569 7 12 7V9ZM8.01979 19.5988C8.22038 17.5785 9.92646 16 12 16V14C8.88819 14 6.33072 16.3681 6.02958 19.4012L8.01979 19.5988ZM12 16C14.0735 16 15.7796 17.5785 15.9802 19.5988L17.9704 19.4012C17.6693 16.3681 15.1118 14 12 14V16Z" fill="#000000"></path> </g></svg>
            <input type="text" class="input" name="nome" id="nome" placeholder="Nome" required />
        </div>
        <div id="nome-error" class="error-message" style="display: none;">Non &eacute; un nome valido.</div>
        <div class="inputForm">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="20"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M6.02958 19.4012C5.97501 19.9508 6.3763 20.4405 6.92589 20.4951C7.47547 20.5497 7.96523 20.1484 8.01979 19.5988L6.02958 19.4012ZM15.9802 19.5988C16.0348 20.1484 16.5245 20.5497 17.0741 20.4951C17.6237 20.4405 18.025 19.9508 17.9704 19.4012L15.9802 19.5988ZM20 12C20 16.4183 16.4183 20 12 20V22C17.5228 22 22 17.5228 22 12H20ZM12 20C7.58172 20 4 16.4183 4 12H2C2 17.5228 6.47715 22 12 22V20ZM4 12C4 7.58172 7.58172 4 12 4V2C6.47715 2 2 6.47715 2 12H4ZM12 4C16.4183 4 20 7.58172 20 12H22C22 6.47715 17.5228 2 12 2V4ZM13 10C13 10.5523 12.5523 11 12 11V13C13.6569 13 15 11.6569 15 10H13ZM12 11C11.4477 11 11 10.5523 11 10H9C9 11.6569 10.3431 13 12 13V11ZM11 10C11 9.44772 11.4477 9 12 9V7C10.3431 7 9 8.34315 9 10H11ZM12 9C12.5523 9 13 9.44772 13 10H15C15 8.34315 13.6569 7 12 7V9ZM8.01979 19.5988C8.22038 17.5785 9.92646 16 12 16V14C8.88819 14 6.33072 16.3681 6.02958 19.4012L8.01979 19.5988ZM12 16C14.0735 16 15.7796 17.5785 15.9802 19.5988L17.9704 19.4012C17.6693 16.3681 15.1118 14 12 14V16Z" fill="#000000"></path> </g></svg>
            <input type="text" class="input" name="cognome" id="cognome" placeholder="Cognome" required />
        </div>
        <div id="cognome-error" class="error-message" style="display: none;">Non &eacute; un cognome valido.</div>
        <div class="inputForm">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="20"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M6.02958 19.4012C5.97501 19.9508 6.3763 20.4405 6.92589 20.4951C7.47547 20.5497 7.96523 20.1484 8.01979 19.5988L6.02958 19.4012ZM15.9802 19.5988C16.0348 20.1484 16.5245 20.5497 17.0741 20.4951C17.6237 20.4405 18.025 19.9508 17.9704 19.4012L15.9802 19.5988ZM20 12C20 16.4183 16.4183 20 12 20V22C17.5228 22 22 17.5228 22 12H20ZM12 20C7.58172 20 4 16.4183 4 12H2C2 17.5228 6.47715 22 12 22V20ZM4 12C4 7.58172 7.58172 4 12 4V2C6.47715 2 2 6.47715 2 12H4ZM12 4C16.4183 4 20 7.58172 20 12H22C22 6.47715 17.5228 2 12 2V4ZM13 10C13 10.5523 12.5523 11 12 11V13C13.6569 13 15 11.6569 15 10H13ZM12 11C11.4477 11 11 10.5523 11 10H9C9 11.6569 10.3431 13 12 13V11ZM11 10C11 9.44772 11.4477 9 12 9V7C10.3431 7 9 8.34315 9 10H11ZM12 9C12.5523 9 13 9.44772 13 10H15C15 8.34315 13.6569 7 12 7V9ZM8.01979 19.5988C8.22038 17.5785 9.92646 16 12 16V14C8.88819 14 6.33072 16.3681 6.02958 19.4012L8.01979 19.5988ZM12 16C14.0735 16 15.7796 17.5785 15.9802 19.5988L17.9704 19.4012C17.6693 16.3681 15.1118 14 12 14V16Z" fill="#000000"></path> </g></svg>
            <input type="date" class="input" name="data_di_nascita" placeholder="Data di nascita" required />
        </div>
        <div class="flex-column">
            <label>Email</label></div>
        <div class="inputForm">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" viewBox="0 0 32 32" height="20"><g data-name="Layer 3" id="Layer_3"><path d="m30.853 13.87a15 15 0 0 0 -29.729 4.082 15.1 15.1 0 0 0 12.876 12.918 15.6 15.6 0 0 0 2.016.13 14.85 14.85 0 0 0 7.715-2.145 1 1 0 1 0 -1.031-1.711 13.007 13.007 0 1 1 5.458-6.529 2.149 2.149 0 0 1 -4.158-.759v-10.856a1 1 0 0 0 -2 0v1.726a8 8 0 1 0 .2 10.325 4.135 4.135 0 0 0 7.83.274 15.2 15.2 0 0 0 .823-7.455zm-14.853 8.13a6 6 0 1 1 6-6 6.006 6.006 0 0 1 -6 6z"></path></g></svg>
            <input type="email" class="input" id="email" name="email" placeholder="Email" required onkeyup="checkEmail()">
        </div>
        <div id="email-unvalidated" class="error-message" style="display: none;">Email non valida.</div>
        <div id="email-error" class="error-message" style="display: none;"></div>
        <div class="flex-column">
            <label>Password </label></div>
        <div class="inputForm">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="20"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 10.0288C7.47142 10 8.05259 10 8.8 10H15.2C15.9474 10 16.5286 10 17 10.0288M7 10.0288C6.41168 10.0647 5.99429 10.1455 5.63803 10.327C5.07354 10.6146 4.6146 11.0735 4.32698 11.638C4 12.2798 4 13.1198 4 14.8V16.2C4 17.8802 4 18.7202 4.32698 19.362C4.6146 19.9265 5.07354 20.3854 5.63803 20.673C6.27976 21 7.11984 21 8.8 21H15.2C16.8802 21 17.7202 21 18.362 20.673C18.9265 20.3854 19.3854 19.9265 19.673 19.362C20 18.7202 20 17.8802 20 16.2V14.8C20 13.1198 20 12.2798 19.673 11.638C19.3854 11.0735 18.9265 10.6146 18.362 10.327C18.0057 10.1455 17.5883 10.0647 17 10.0288M7 10.0288V8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8V10.0288" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
            <input type="password" class="input" id="password" name="password" placeholder="Password" required>
        </div>
        <div class="inputForm">
            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" width="20"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M12 14.5V16.5M7 10.0288C7.47142 10 8.05259 10 8.8 10H15.2C15.9474 10 16.5286 10 17 10.0288M7 10.0288C6.41168 10.0647 5.99429 10.1455 5.63803 10.327C5.07354 10.6146 4.6146 11.0735 4.32698 11.638C4 12.2798 4 13.1198 4 14.8V16.2C4 17.8802 4 18.7202 4.32698 19.362C4.6146 19.9265 5.07354 20.3854 5.63803 20.673C6.27976 21 7.11984 21 8.8 21H15.2C16.8802 21 17.7202 21 18.362 20.673C18.9265 20.3854 19.3854 19.9265 19.673 19.362C20 18.7202 20 17.8802 20 16.2V14.8C20 13.1198 20 12.2798 19.673 11.638C19.3854 11.0735 18.9265 10.6146 18.362 10.327C18.0057 10.1455 17.5883 10.0647 17 10.0288M7 10.0288V8C7 5.23858 9.23858 3 12 3C14.7614 3 17 5.23858 17 8V10.0288" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
            <input type="password" class="input" name="confermapassword" id="conferma-password" placeholder="Conferma Password" onkeyup="checkPasswordMatch()" required>
        </div>
        <div id="password-error" class="error-message" style="display: none;">La password deve aver almeno un carattele maiuscolo, un carattere minuscolo, un carattere speciale e deve essere lunga 8 caratteri.</div>
        <div id="password-unmatching" class="error-message" style="display: none;">Le password non corrispondono. Riprova.</div>
        <div class="flex-column">
            <label>Dati aggiuntivi</label></div>
        <div class="inputForm">
            <select class="input-nomargin" name="tipo_utente" required>
                <option value="" selected disabled>Seleziona tipo di utente</option>
                <option value="venditore">Venditore</option>
                <option value="privato">Privato</option>
            </select>
        </div>
        <div class="inputForm" id="venditore_field-1" style="display: none;">
            <input type="text" class="input-nomargin" name="partita_iva" placeholder="Partita IVA">
        </div>
        <div id="iva-error" class="error-message" style="display: none;">IVA non nel formato giusto.</div>
        <div class="inputForm" id="venditore_field-2" style="display: none;">
            <input type="text" class="input-nomargin" name="codice_fiscale" placeholder="Codice Fiscale">
        </div>
        <div id="cf-error" class="error-message" style="display: none;">Codice Fiscale non nel formato giusto.</div>
        <input type="submit" class="button-submit" id="submit-btn" value="Registrati">
    </form>

<script>
    function checkPasswordMatch() {
        let password = document.getElementById("password").value;
        let confirmPassword = document.getElementById("conferma-password").value;
        let errorDiv = document.getElementById("password-unmatching");

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
            document.getElementById('venditore_field-1').style.display = 'flex';
            document.getElementById('venditore_field-2').style.display = 'flex';
        } else {
            document.getElementById('venditore_field-1').style.display = 'none';
            document.getElementById('venditore_field-2').style.display = 'none';
        }
    });

    function checkEmail() {
        let email = document.getElementById("email").value;
        let errorDiv = document.getElementById("email-error");
        let submitBtn = document.getElementById("submit-btn");

        if (email) {
            let xhr = new XMLHttpRequest();
            xhr.open("POST", "${pageContext.request.contextPath}/Check", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let response = JSON.parse(xhr.responseText);
                    if (response.exists) {
                        errorDiv.style.display = "block";
                        errorDiv.textContent = "Email gia' registrata. Scegli un'altra email.";
                        submitBtn.disabled = true;
                    } else {
                        errorDiv.style.display = "none";
                        submitBtn.disabled = false;
                    }
                }
            };
            xhr.send("email=" + encodeURIComponent(email));
        } else {
            errorDiv.style.display = "none";
            submitBtn.disabled = false;
        }
    }





    function validateForm() {

        // Funzione per validare l'email
        function validateEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        // Funzione per validare la password
        function validatePassword(password) {
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.{8,})/;
            return passwordRegex.test(password);
        }

        // Funzione per validare la partita IVA italiana
        function validatePartitaIVA(partitaIVA) {
            const partitaIVARegex = /^[0-9]{11}$/;
            return partitaIVARegex.test(partitaIVA);
        }

        // Funzione per validare il codice fiscale italiano
        function validateCodiceFiscale(codiceFiscale) {
            const codiceFiscaleRegex = /^[A-Z]{6}\d{2}[A-Z]\d{2}[A-Z]\d{3}[A-Z]$/;
            return codiceFiscaleRegex.test(codiceFiscale);
        }

        function validateItalianName(name) {
            // Espressione regolare per caratteri italiani
            const italianNameRegex = /^[a-zA-ZàáèéìíòóùúÀÁÈÉÌÍÒÓÙÚ' ]+$/;

            // Rimuove spazi all'inizio e alla fine
            name = name.trim();

            // Controlla se il nome è vuoto
            if (name.length === 0) {
                return false;
            }

            // Controlla se il nome contiene solo caratteri italiani
            if (!italianNameRegex.test(name)) {
                return false;
            }

            // Controlla se ci sono spazi doppi
            if (/\s{2,}/.test(name)) {
                return false;
            }

            // Controlla se inizia con una lettera maiuscola
            if (!/^[A-ZÀÁÈÉÌÍÒÓÙÚ]/.test(name)) {
                return false;
            }

            return true;
        }

        let isValid = true;

        let userType = document.querySelector('select[name="tipo_utente"]').value;
        if (userType === 'venditore') {
            let partitaIva = document.querySelector('input[name="partita_iva"]').value.trim();
            let codiceFiscale = document.querySelector('input[name="codice_fiscale"]').value.trim();
            if (partitaIva === '' || codiceFiscale === '') {
                alert("Inserisci sia la Partita IVA che il Codice Fiscale per il tipo Venditore.");
                return false;
            }
            else {
                if (!validatePartitaIVA(partitaIva)) {
                    isValid = false;
                    document.getElementById('iva-error').style.display = 'block';
                } else {
                    document.getElementById('iva-error').style.display = 'none';}
                }

                if (!validateCodiceFiscale(codiceFiscale)) {
                    isValid = false;
                    document.getElementById('cf-error').style.display = 'block';
                } else {
                    document.getElementById('cf-error').style.display = 'none';
                }
            }

            let nome = document.getElementById('nome').value;
            let cognome = document.getElementById('cognome').value;

            if (!validateItalianName(nome)) {
                isValid = false;
                document.getElementById('nome-error').style.display = 'block';
            } else {
                document.getElementById('nome-error').style.display = 'none';
            }

            if (!validateItalianName(cognome)) {
                isValid = false;
                document.getElementById('cognome-error').style.display = 'block';
            } else {
                document.getElementById('cognome-error').style.display = 'none';
            }

            let email = document.getElementById('email').value;
            let password = document.getElementById('password').value;

            if (!validateEmail(email)) {
                isValid = false;
                document.getElementById('email-unvalidated').style.display = 'block';
            } else {
                document.getElementById('email-unvalidated').style.display = 'none';
            }

            if (!validatePassword(password)) {
                isValid = false;
                document.getElementById('password-error').style.display = 'block';
            } else {
                document.getElementById('password-error').style.display = 'none';
            }

            if (!isValid) {
                document.getElementById('submit-btn').disabled = true;
            } else {
                document.getElementById('submit-btn').disabled = false;
            }
    }

    document.querySelector("form").addEventListener("submit", function(event) {
        if (!validateForm()) {
            event.preventDefault();
        }
    });
</script>

</body>
</html>
