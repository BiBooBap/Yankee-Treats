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

public class GuestControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            saveGuest(email);
            response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Checkout.jsp");
            request.getSession().setAttribute("userEmail", email);
            request.getSession().setAttribute("userType","guest");
        } catch (NamingException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }

    }

    private void saveGuest(String email) throws NamingException, SQLException {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

        String query = "INSERT INTO users (email, user_type, password) VALUES (?, 'guest','guest')";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            stmt.executeUpdate();
        }
    }

}
