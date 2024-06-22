package com.example.control;

import com.example.control.*;
import com.example.model.*;
import com.stripe.Stripe;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import com.example.model.Cart;
import com.example.model.CartItem;

import javax.servlet.ServletException;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Dotenv dotenv = Dotenv.load();
    private static final String STRIPE_SECRET_KEY = dotenv.get("STRIPE_SECRET_KEY");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String successUrl = "/PaymentConfirmation.jsp"; // Personalizza con il tuo URL di successo
        String cancelUrl = "http://example.com/cancel"; // Personalizza con il tuo URL di annullamento

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            // Gestione del caso in cui il carrello sia vuoto
            response.sendRedirect("cart.jsp?error=empty_cart");
            return;
        }

        PaymentService paymentService = new PaymentService(STRIPE_SECRET_KEY); // Imposta la tua chiave segreta di Stripe

        try {
            String sessionId = paymentService.createCheckoutSession(cart, successUrl, cancelUrl);

            // Redirect a Stripe Checkout
            response.sendRedirect("/checkout.jsp?sessionId=" + sessionId); // Redirigi a una JSP per gestire il checkout con Stripe
        } catch (Exception e) {
            // Gestione degli errori
            response.sendRedirect("cart.jsp?error=checkout_error");
        }
    }
}







