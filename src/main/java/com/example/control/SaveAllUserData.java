package com.example.control;

import com.example.model.UtilDS;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SaveAllUserData")
public class SaveAllUserData extends HttpServlet {
    private Connection conn;

    @Override
    public void init() throws ServletException {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
            conn = ds.getConnection();
        } catch (NamingException | SQLException e) {
            throw new ServletException("Cannot initialize DB connection", e);
        }
    }

    @Override
    public void destroy() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        String fromCheckout = request.getParameter("fromCheckout");
        String action = request.getParameter("action");

        if (userEmail != null && !userEmail.isEmpty()) {
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            try {
                if (userCode != 0) {
                    if (action != null) {
                        if (action.equalsIgnoreCase("SaveAll")) {
                            saveAllUserData(request, userCode);
                        } else if (action.equalsIgnoreCase("SaveDelivery")) {
                            saveDeliveryAddress(request, userCode);
                        } else if (action.equalsIgnoreCase("SavePayment")) {
                            savePaymentMethod(request, userCode);
                        } else if (action.equalsIgnoreCase("SaveBilling")) {
                            saveBillingAddress(request, userCode);
                        }
                    }
                }
            } catch (SQLException e) {
                System.out.println("Error:" + e.getMessage());
            }

            String redirectURL = request.getContextPath() + "/resources/jsp_pages/UserData.jsp";
            if (fromCheckout != null && !fromCheckout.isEmpty()) {
                redirectURL += "?fromCheckout=" + fromCheckout;
            }
            response.sendRedirect(redirectURL);
        }
    }

    private void saveAllUserData(HttpServletRequest request, int userCode) throws SQLException {
        try {
            conn.setAutoCommit(false);

            try {
                saveDeliveryAddress(request, userCode);
                savePaymentMethod(request, userCode);
                saveBillingAddress(request, userCode);

                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } finally {
            conn.setAutoCommit(true);
        }
    }

    private void saveDeliveryAddress(HttpServletRequest request, int userCode) throws SQLException {
        String query = "INSERT INTO delivery_addresses (user_code, country, zip, city, street, province) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            stmt.setString(2, request.getParameter("deliveryAddressCountry"));
            stmt.setString(3, request.getParameter("deliveryAddressZIP"));
            stmt.setString(4, request.getParameter("deliveryAddressCity"));
            stmt.setString(5, request.getParameter("deliveryAddressStreet"));
            stmt.setString(6, request.getParameter("deliveryAddressProvince"));
            stmt.executeUpdate();
        }
    }

    private void savePaymentMethod(HttpServletRequest request, int userCode) throws SQLException {
        String query = "INSERT INTO payment_method (user_code, cardholder_name, card_number, expiry_month, expiry_year, cvv) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            stmt.setString(2, request.getParameter("cardholder_name"));
            stmt.setString(3, request.getParameter("card_number"));
            stmt.setInt(4, Integer.parseInt(request.getParameter("expiry_month")));
            stmt.setInt(5, Integer.parseInt(request.getParameter("expiry_year")));
            stmt.setString(6, request.getParameter("cvv"));
            stmt.executeUpdate();
        }
    }

    private void saveBillingAddress(HttpServletRequest request, int userCode) throws SQLException {
        String query = "INSERT INTO billing_addresses (user_code, street, city, province, zip) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            stmt.setString(2, request.getParameter("billingAddressStreet"));
            stmt.setString(3, request.getParameter("billingAddressCity"));
            stmt.setString(4, request.getParameter("billingAddressProvince"));
            stmt.setString(5, request.getParameter("billingAddressZIP"));
            stmt.executeUpdate();
        }
    }
}

