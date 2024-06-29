package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.example.control.PasswordUtils;

public class LoginModelDS {

    private static DataSource ds;
    private static final String TABLE_NAME = "users";

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/storage");

        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

    public boolean validateUser(LoginBean loginBean) {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE email = ? AND password = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, loginBean.getEmail());
            stmt.setString(2, loginBean.getPassword());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.getString(2) != null && PasswordUtils.checkPassword(loginBean.getPassword(), rs.getString(2)))
                {
                return rs.next();
            }
            } catch (SQLException e) {
                System.out.println("Error validating user: " + e.getMessage());
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
            return false;
        }
        return false;
    }
}

