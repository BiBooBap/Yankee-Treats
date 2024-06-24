package com.example.control;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int paymentCardId;
        int deliveryAddressId;
        int billingAddressId;
        double totalCost;

        try {
            paymentCardId = Integer.parseInt(request.getParameter("selectedPaymentMethodId"));
            deliveryAddressId = Integer.parseInt(request.getParameter("selectedDeliveryAddressId"));
            billingAddressId = Integer.parseInt(request.getParameter("selectedAddressId"));
            totalCost = (double) request.getSession().getAttribute("cartTotal");


        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.html");
            return;
        }

        int userCode = (int) request.getSession().getAttribute("userCode");

        try {
            saveOrder(userCode, paymentCardId, deliveryAddressId, billingAddressId, totalCost);
            response.sendRedirect(request.getContextPath()+"/resources/jsp_pages/OrderComplete.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.html");
        } catch (NamingException e) {
            throw new ServletException(e);
        }
    }

    private void saveOrder(int userCode, int paymentCardId, int deliveryAddressId, int billingAddressId, double totalCost)
            throws SQLException, NamingException {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

        try (Connection conn = ds.getConnection()) {

            String sql = "INSERT INTO orders (user_code, payment_card_id, delivery_address_id, billing_address_id, total_cost) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userCode);
                stmt.setInt(2, paymentCardId);
                stmt.setInt(3, deliveryAddressId);
                stmt.setInt(4, billingAddressId);
                stmt.setDouble(5, totalCost);
                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
        }
    }
}
