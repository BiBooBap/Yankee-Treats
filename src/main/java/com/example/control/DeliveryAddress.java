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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DeliveryAddress extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deliveryAddressStreet = request.getParameter("deliveryAddressStreet");
        String deliveryAddressCity = request.getParameter("deliveryAddressCity");
        String deliveryAddressProvince = request.getParameter("deliveryAddressProvince");
        String deliveryAddressZIP = request.getParameter("deliveryAddressZIP");
        String deliveryAddressCountry = request.getParameter("deliveryAddressCountry");

        String userEmail = (String) request.getSession().getAttribute("userEmail");
        String fromCheckout= request.getParameter("fromCheckout");
        if (userEmail != null && !userEmail.isEmpty()) {
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            if (userCode != 0) {
                try {
                    saveDeliveryAddress(userCode, deliveryAddressCountry, deliveryAddressZIP, deliveryAddressCity, deliveryAddressStreet, deliveryAddressProvince);
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
            }
        }
    }

    private void saveDeliveryAddress(int userCode, String country, String zip, String city, String street, String province)
            throws SQLException, NamingException {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
        String query = "INSERT INTO delivery_addresses (user_code, country, zip, city, street, province) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userCode);
            stmt.setString(2, country);
            stmt.setString(3, zip);
            stmt.setString(4, city);
            stmt.setString(5, street);
            stmt.setString(6, province);

            stmt.executeUpdate();
        }
    }

}