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

    public static boolean insertProduct(String name, String description, int price, int quantity,
                                        byte bestseller, byte dolce, byte salato, byte bevanda,
                                        byte trend, byte novita, byte offerta, byte bundle, byte b2b) {

        String query = "INSERT INTO " + TABLE_NAME + " (name, description, price, quantity, bestseller, dolce, salato, bevanda, trend, novita, offerta, bundle, B2B) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, price);
            stmt.setInt(4, quantity);
            stmt.setByte(5, bestseller);
            stmt.setByte(6, dolce);
            stmt.setByte(7, salato);
            stmt.setByte(8, bevanda);
            stmt.setByte(9, trend);
            stmt.setByte(10, novita);
            stmt.setByte(11, offerta);
            stmt.setByte(12, bundle);
            stmt.setByte(13, b2b);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
            return false;
        }
    }

    public static boolean doDelete(int code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String updateSQL = "UPDATE " + TABLE_NAME +" SET active = 0 WHERE code = ?";
        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setInt(1, code);

            result = preparedStatement.executeUpdate();
            connection.commit();
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                DriverManagerConnectionPool.releaseConnection(connection);
            }
        }
        return (result != 0);
    }

    public static synchronized boolean doUpdateQnt(int id, int qnt) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE " + TABLE_NAME
                + " SET QUANTITY = ? "
                + " WHERE CODE = ? ";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setInt(1, qnt);
            preparedStatement.setInt(2, id);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();

            return rowsAffected > 0;
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public static synchronized boolean doUpdateName(int id, String name) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE " + TABLE_NAME
                + " SET NAME = ? "
                + " WHERE CODE = ? ";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setString(1, name);
            preparedStatement.setInt(2, id);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();

            return rowsAffected > 0;
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public static synchronized boolean doUpdatePrice(int id, int price) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE " + TABLE_NAME
                + " SET PRICE = ? "
                + " WHERE CODE = ? ";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setInt(1, price);
            preparedStatement.setInt(2, id);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();

            return rowsAffected > 0;
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public static synchronized boolean doUpdateDesc(int id, String description) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE " + TABLE_NAME
                + " SET DESCRIPTION = ? "
                + " WHERE CODE = ? ";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setString(1, description);
            preparedStatement.setInt(2, id);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();

            return rowsAffected > 0;
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public static synchronized boolean addActive(int code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String updateSQL = "UPDATE " + TABLE_NAME
                + " SET active = TRUE "
                + " WHERE CODE = ? ";

        try {
            connection = DriverManagerConnectionPool.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(updateSQL);
            preparedStatement.setInt(1, code);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();

            return rowsAffected > 0;
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public static boolean doUpdateFeatures(int code, byte bestseller, byte dolce, byte salato, byte bevanda,
                                           byte trend, byte novita, byte offerta, byte bundle, byte b2b) throws SQLException {
        String updateSQL = "UPDATE " + TABLE_NAME + " SET bestseller = ?, dolce = ?, salato = ?, bevanda = ?, trend = ?, novita = ?, offerta = ?, bundle = ?, b2b = ? WHERE code = ?";
        try (Connection connection = ds.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {

            connection.setAutoCommit(false);
            preparedStatement.setByte(1, bestseller);
            preparedStatement.setByte(2, dolce);
            preparedStatement.setByte(3, salato);
            preparedStatement.setByte(4, bevanda);
            preparedStatement.setByte(5, trend);
            preparedStatement.setByte(6, novita);
            preparedStatement.setByte(7, offerta);
            preparedStatement.setByte(8, bundle);
            preparedStatement.setByte(9, b2b);
            preparedStatement.setInt(10, code);

            int rowsAffected = preparedStatement.executeUpdate();
            connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
            return false;
        }
    }



}