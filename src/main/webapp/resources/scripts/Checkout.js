function checkEmail() {
    var email = document.getElementById("email").value;
    var errorDiv = document.getElementById("email-error");
    var submitBtn = document.getElementById("submit-btn");

    if (email) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "${pageContext.request.contextPath}/Check", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.exists) {
                    errorDiv.style.display = "block";
                    errorDiv.textContent = "Email gia registrata. Effettua il login o usa un'altra email.";
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
    var billingSelected = document.querySelector('input[name="selectedAddressId"]:checked');
    var deliverySelected = document.querySelector('input[name="selectedDeliveryAddressId"]:checked');
    var paymentSelected = document.querySelector('input[name="selectedPaymentMethodId"]:checked');

    if (!billingSelected || !deliverySelected || !paymentSelected) {
        alert("Seleziona almeno un'opzione per ogni sezione.");
        return false;
    }
    return true;
}


if (document.getElementById('paypal-button-container')) {
    paypal.Buttons({
        fundingSource: paypal.FUNDING.PAYPAL,
        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '<%= cartTotal %>'
                    }
                }]
            });
        },
        onApprove: function(data, actions) {
            return actions.order.capture().then(function(details) {
                // Invia i dati del pagamento alla servlet
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/PayPal';

                var userCode = document.createElement('input');
                userCode.type = 'hidden';
                userCode.name = 'userCode';
                userCode.value = '<%= userCode %>';
                form.appendChild(userCode);

                var cardNumber = document.createElement('input');
                cardNumber.type = 'hidden';
                cardNumber.name = 'cardNumber';
                cardNumber.value = details.purchase_units[0].payments.captures[0].id; // Utilizziamo l'ID della transazione come identificatore unico
                form.appendChild(cardNumber);

                var expiryMonth = document.createElement('input');
                expiryMonth.type = 'hidden';
                expiryMonth.name = 'expiryMonth';
                expiryMonth.value = '11'
                form.appendChild(expiryMonth);

                var expiryYear = document.createElement('input');
                expiryYear.type = 'hidden';
                expiryYear.name = 'expiryYear';
                expiryYear.value = '2030'; // Valore fittizio
                form.appendChild(expiryYear);

                var cardholderName = document.createElement('input');
                cardholderName.type = 'hidden';
                cardholderName.name = 'cardholderName';
                cardholderName.value = details.payer.name.given_name + ' ' + details.payer.name.surname;
                form.appendChild(cardholderName);

                document.body.appendChild(form);
                form.submit();
            });
        },
        onError: function(err) {
            console.error('PayPal error:', err);
            alert('An error occurred during the payment process: ' + err.message);
        }
    }).render('#paypal-button-container');

}