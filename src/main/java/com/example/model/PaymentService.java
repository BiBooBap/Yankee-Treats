package com.example.model;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import com.example.model.Cart;
import com.example.model.CartItem;
import io.github.cdimascio.dotenv.Dotenv;

import java.util.ArrayList;
import java.util.List;

public class PaymentService {

    private static final long serialVersionUID = 1L;

    private static final Dotenv dotenv = Dotenv.load();
    private static final String STRIPE_SECRET_KEY = dotenv.get("STRIPE_SECRET_KEY");

    public PaymentService(String apiKey) {
        Stripe.apiKey = STRIPE_SECRET_KEY;
    }

    public String createCheckoutSession(Cart cart, String successUrl, String cancelUrl) throws StripeException {
        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        for (CartItem item : cart.getCart()) {
            SessionCreateParams.LineItem.PriceData priceData = SessionCreateParams.LineItem.PriceData.builder()
                    .setCurrency("usd") // Sostituisci con la tua valuta
                    .setUnitAmount((long) (item.getProduct().getPrice() * 100)) // Converti il prezzo in centesimi
                    .setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder()
                            .setName(item.getName())
                            .build())
                    .build();

            SessionCreateParams.LineItem lineItem = SessionCreateParams.LineItem.builder()
                    .setPriceData(priceData)
                    .setQuantity((long) item.getQuantityCart())
                    .build();

            lineItems.add(lineItem);
        }

        SessionCreateParams params = SessionCreateParams.builder()
                .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                .addAllLineItem(lineItems)
                .setMode(SessionCreateParams.Mode.PAYMENT)
                .setSuccessUrl(successUrl)
                .setCancelUrl(cancelUrl)
                .build();

        Session session = Session.create(params);
        return session.getId();
    }
}






