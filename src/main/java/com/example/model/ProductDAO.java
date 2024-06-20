package com.example.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ProductDAO {
    private static DataSource ds;
    private static final String TABLE_NAME = "product";
    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/storage");

        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

    public static void insertProduct(String name, String description, int price, int quantity,
                                     boolean bestseller, boolean dolce, boolean salato, boolean bevanda,
                                     boolean trend, boolean novita, boolean offerta, boolean bundle, boolean b2b) {

        String query = "INSERT INTO " + TABLE_NAME + " (name, description, price, quantity, bestseller, dolce, salato, bevanda, trend, novita, offerta, bundle, B2B) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, price);
            stmt.setInt(4, quantity);
            stmt.setBoolean(5, bestseller);
            stmt.setBoolean(6, dolce);
            stmt.setBoolean(7, salato);
            stmt.setBoolean(8, bevanda);
            stmt.setBoolean(9, trend);
            stmt.setBoolean(10, novita);
            stmt.setBoolean(11, offerta);
            stmt.setBoolean(12, bundle);
            stmt.setBoolean(13, b2b);

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
}
