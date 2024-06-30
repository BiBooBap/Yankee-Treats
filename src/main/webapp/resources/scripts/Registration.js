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