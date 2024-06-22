package com.example.control;

import com.example.model.Cart;
import com.example.model.CartItem;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import com.stripe.model.PaymentIntent;
import com.stripe.param.ChargeListParams;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ConfirmPayment")
public class ConfirmPayment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Dotenv dotenv = Dotenv.load();
    private static final String STRIPE_SECRET_KEY = dotenv.get("STRIPE_SECRET_KEY");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Received POST request in ConfirmPayment servlet.");
        Stripe.apiKey = STRIPE_SECRET_KEY;

        String paymentIntentId = request.getParameter("payment_intent_id");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
            return;
        }

        try {
            PaymentIntent paymentIntent = PaymentIntent.retrieve(paymentIntentId);

            Map<String, Object> paymentDetails = new HashMap<>();
            paymentDetails.put("paymentIntentId", paymentIntent.getId());
            paymentDetails.put("amount", paymentIntent.getAmount() / 100.0);
            paymentDetails.put("currency", paymentIntent.getCurrency().toUpperCase());
            paymentDetails.put("created", paymentIntent.getCreated());

            // Aggiungi i dettagli del carrello
            List<CartItem> cartItems = cart.getCart();
            for (CartItem item : cartItems) {
                Map<String, Object> itemDetails = new HashMap<>();
                itemDetails.put("productName", item.getName());
                itemDetails.put("productDescription", item.getDescription());
                itemDetails.put("productQuantity", item.getQuantityCart());
                itemDetails.put("productPrice", item.getProduct().getPrice());
                itemDetails.put("totalPrice", item.getTotalPrice());
                paymentDetails.put("product_" + item.getId(), itemDetails);
            }

            paymentDetails.put("cartTotal", cart.getCartTotalPrice());

            ChargeListParams chargeParams = ChargeListParams.builder()
                    .setPaymentIntent(paymentIntentId)
                    .build();
            List<Charge> charges = Charge.list(chargeParams).getData();

            if (!charges.isEmpty()) {
                Charge charge = charges.get(0);
                paymentDetails.put("receiptUrl", charge.getReceiptUrl());
            }

            session.setAttribute("paymentDetails", paymentDetails);

            response.sendRedirect(request.getContextPath() + "/PaymentConfirmation.jsp");

        } catch (StripeException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(e.getMessage());
        }
    }
}






