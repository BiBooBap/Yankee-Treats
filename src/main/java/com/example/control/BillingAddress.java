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


public class BillingAddress extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billingAddressStreet = request.getParameter("billingAddressStreet");
        String billingAddressCity = request.getParameter("billingAddressCity");
        String billingAddressProvince = request.getParameter("billingAddressProvince");
        String billingAddressZIP = request.getParameter("billingAddressZIP");

        String userEmail = (String) request.getSession().getAttribute("userEmail");

            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            if (userCode != 0) {
                try {
                    saveBillingAddress(userCode, billingAddressStreet, billingAddressCity, billingAddressProvince,
                            billingAddressZIP);
                    response.sendRedirect("success.html");
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (NamingException e) {
                    throw new RuntimeException(e);
                }
            } else {
                response.sendRedirect("error.html");
                System.out.println(userCode);
            }
    }



    private void saveBillingAddress(int userCode, String street, String city, String province, String zip) throws SQLException, NamingException {

                Context initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
        Connection connection = ds.getConnection();


        String sql = "INSERT INTO billing_addresses (user_code, street, city, province, zip) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, userCode);
        statement.setString(2, street);
        statement.setString(3, city);
        statement.setString(4, province);
        statement.setString(5, zip);

        // Esecuzione della query
        statement.executeUpdate();

        // Chiusura delle risorse
        statement.close();
        connection.close();
    }
}

