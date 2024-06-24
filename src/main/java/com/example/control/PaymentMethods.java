package com.example.control;

import com.example.model.UtilDS;

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

public class PaymentMethods extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cardholder_name=request.getParameter("cardholder_name");
        String card_number=request.getParameter("card_number");
        String expiry_month=request.getParameter("expiry_month");
        String expiry_year=request.getParameter("expiry_year");
        String cvv=request.getParameter("cvv");

        String userEmail = (String) request.getSession().getAttribute("userEmail");
        String fromCheckout= request.getParameter("fromCheckout");
        if (userEmail != null && !userEmail.isEmpty()) {
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            if (userCode != 0) {
                try {
                    savePaymentMethod(userCode, cardholder_name, card_number, expiry_month, expiry_year, cvv);
                    String redirectURL = request.getContextPath() + "/resources/jsp_pages/UserData.jsp";
                    if (fromCheckout != null && !fromCheckout.isEmpty()) {
                        redirectURL += "?fromCheckout=" + fromCheckout;
                    }
                    response.sendRedirect(redirectURL);
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("error.html");
                } catch (NamingException e) {
                    throw new RuntimeException(e);
                }
            } else {
                response.sendRedirect("error.html");
            }
        }
    }
    private void savePaymentMethod(int userCode, String cardholderName, String cardNumber, String expiryMonthStr, String expiryYearStr, String cvv)
            throws SQLException, NamingException {
        // Conversione dei parametri di scadenza da stringhe a interi
        int expiryMonth = Integer.parseInt(expiryMonthStr);
        int expiryYear = Integer.parseInt(expiryYearStr);

        // Inizializzazione del contesto e del data source
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

        // Query SQL per l'inserimento dei dati
        String query = "INSERT INTO payment_method (user_code, cardholder_name, card_number, expiry_month, expiry_year, cvv) VALUES (?, ?, ?, ?, ?, ?)";

        // Esecuzione della query
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userCode);
            stmt.setString(2, cardholderName);
            stmt.setString(3, cardNumber);
            stmt.setInt(4, expiryMonth);
            stmt.setInt(5, expiryYear);
            stmt.setString(6, cvv);

            stmt.executeUpdate();
        }
    }

}


