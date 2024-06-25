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

public class DeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String selectedAddressId = request.getParameter("selectedAddressId");
        String userCode = request.getParameter("userCode");
        int code = Integer.parseInt(request.getParameter("code"));

        if(code==1){ //eliminiamo delivery adress
            Context initCtx = null;
            try {
                initCtx = new InitialContext();
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            Context envCtx = null;
            try {
                envCtx = (Context) initCtx.lookup("java:comp/env");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            DataSource ds = null;
            try {
                ds = (DataSource) envCtx.lookup("jdbc/storage");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }

            String query = "UPDATE delivery_addresses SET active = 0 WHERE user_code = ? AND address_id = ?";

                try (Connection conn = ds.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(query)) {

                    stmt.setInt(1, Integer.parseInt(userCode));
                    stmt.setInt(2, Integer.parseInt(selectedAddressId));

                    stmt.executeUpdate();
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                response.sendRedirect("resources/jsp_pages/ViewUserData.jsp");
        }
        if(code==2){ //eliminiamo BillingAdress
            Context initCtx = null;
            try {
                initCtx = new InitialContext();
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            Context envCtx = null;
            try {
                envCtx = (Context) initCtx.lookup("java:comp/env");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            DataSource ds = null;
            try {
                ds = (DataSource) envCtx.lookup("jdbc/storage");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }

            String query = "UPDATE billing_addresses SET active = 0 WHERE user_code = ?  AND address_id = ?";

            try (Connection conn = ds.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setInt(1, Integer.parseInt(userCode));
                stmt.setInt(2, Integer.parseInt(selectedAddressId));

                stmt.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            response.sendRedirect("resources/jsp_pages/ViewUserData.jsp");
        }

        if(code==3){
            Context initCtx = null;
            try {
                initCtx = new InitialContext();
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            Context envCtx = null;
            try {
                envCtx = (Context) initCtx.lookup("java:comp/env");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
            DataSource ds = null;
            try {
                ds = (DataSource) envCtx.lookup("jdbc/storage");
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }

            String query = "UPDATE payment_method SET active = 0 WHERE user_code = ?  AND card_id = ?";

            try (Connection conn = ds.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {

                stmt.setInt(1, Integer.parseInt(userCode));
                stmt.setInt(2, Integer.parseInt(selectedAddressId));

                stmt.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            response.sendRedirect("resources/jsp_pages/ViewUserData.jsp");
        }

        }

}



