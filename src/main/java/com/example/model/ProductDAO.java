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
                                     int bestseller, int dolce, int salato, int bevanda,
                                     int trend, int novita, int offerta, int bundle, int b2b) {

        String query = "INSERT INTO " + TABLE_NAME + " (name, description, price, quantity, bestseller, dolce, salato, bevanda, trend, novita, offerta, bundle, B2B) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, price);
            stmt.setInt(4, quantity);
            stmt.setInt(5, bestseller);  // Converti int in int
            stmt.setInt(6, dolce);       // Converti int in int
            stmt.setInt(7, salato);      // Converti int in int
            stmt.setInt(8, bevanda);     // Converti int in int
            stmt.setInt(9, trend);       // Converti int in int
            stmt.setInt(10, novita);     // Converti int in int
            stmt.setInt(11, offerta);    // Converti int in int
            stmt.setInt(12, bundle);     // Converti int in int
            stmt.setInt(13, b2b);

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
}
