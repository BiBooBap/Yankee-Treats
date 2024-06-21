package com.example.control;

import com.example.model.Cart;
import com.example.model.CartItem;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.param.PaymentIntentCreateParams;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/CreatePaymentIntent")
public class CreatePaymentIntent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String STRIPE_SECRET_KEY = System.getenv("sk_test_9W1R4v0cz6AtC9PVwHFzywti");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stripe.apiKey = STRIPE_SECRET_KEY;

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
            return;
        }

        // Calculate total amount in cents
        int amount = (int) (cart.getCartTotalPrice() * 100);

        try {
            Map<String, Object> params = new HashMap<>();
            params.put("amount", amount);
            params.put("currency", "eur");
            params.put("payment_method_types", Collections.singletonList("card"));

            PaymentIntent paymentIntent = PaymentIntent.create(params);

            Map<String, Object> paymentDetails = new HashMap<>();
            paymentDetails.put("clientSecret", paymentIntent.getClientSecret());

            // Save payment details in session
            session.setAttribute("paymentDetails", paymentDetails);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"clientSecret\":\"" + paymentIntent.getClientSecret() + "\"}");

        } catch (StripeException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(e.getMessage());
        }
    }
}


