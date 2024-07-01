package com.example.control;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayPalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userCode = request.getParameter("userCode");
        String cardNumber = request.getParameter("cardNumber");
        String expiryMonth = request.getParameter("expiryMonth");
        String expiryYear = request.getParameter("expiryYear");
        String cardholderName = request.getParameter("cardholderName");

        if (userCode == null || cardNumber == null || expiryMonth == null || expiryYear == null || cardholderName == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

            try (Connection con = ds.getConnection()) {
                con.setAutoCommit(false);

                try {
                    String insertQuery = "INSERT INTO payment_method (user_code, card_number, expiry_month, expiry_year, cardholder_name) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement pstmt = con.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                        pstmt.setInt(1, Integer.parseInt(userCode));
                        pstmt.setString(2, cardNumber);
                        pstmt.setInt(3, Integer.parseInt(expiryMonth));
                        pstmt.setInt(4, Integer.parseInt(expiryYear));
                        pstmt.setString(5, cardholderName);

                        int affectedRows = pstmt.executeUpdate();

                        if (affectedRows == 0) {
                            throw new SQLException("Creating payment method failed, no rows affected.");
                        }


                    }

                    con.commit();
                    response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Checkout.jsp");
                } catch (Exception e) {
                    con.rollback();
                    throw e;
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } catch (NamingException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing PayPal payment: " + e.getMessage());
        }
    }
}