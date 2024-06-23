package com.example.model;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import java.util.ArrayList;
import java.util.List;

public class PaymentService {

    private static final String STRIPE_SECRET_KEY = System.getenv("STRIPE_SECRET_KEY");

    public PaymentService() {
        Stripe.apiKey = STRIPE_SECRET_KEY;
    }

    public String createCheckoutSession(Cart cart, String successUrl, String cancelUrl) throws StripeException {
        List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
        for (CartItem item : cart.getCart()) {
            SessionCreateParams.LineItem.PriceData priceData = SessionCreateParams.LineItem.PriceData.builder()
                    .setCurrency("eur")
                    .setUnitAmount((long) (item.getProduct().getPrice() * 100))
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








