package com.example.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UtilDS     {
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

    public static int getUserCodebyEmail(String email) {
        String query = "SELECT code FROM " + TABLE_NAME + " WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("code");                }

            }
        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }
        return 0;
    }

    public static String getUserTypebyEmail(String email) {
        String query = "SELECT user_type FROM " + TABLE_NAME + " WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("user_type");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }
        return null;
    }

    public static String getNamebyEmail(String email) {
        String query = "SELECT name FROM " + TABLE_NAME + " WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }
        return null;
    }

    public static ArrayList<String[]> returnDeliveryAddress(String userEmail) throws NamingException, SQLException {
        ArrayList<String[]> deliveryAddresses = new ArrayList<>();

        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
            Connection conn = ds.getConnection();
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            String query = "SELECT * FROM delivery_addresses WHERE user_code = ? AND active=1";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userCode);
            ResultSet rs = pstmt.executeQuery();

            int columns = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                String[] row = new String[columns];
                for (int i = 0; i < columns; i++) {
                    row[i] = rs.getString(i + 1);
                }
                deliveryAddresses.add(row);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            throw e;
        }

        return deliveryAddresses;
    }

    public static ArrayList<String[]> returnBillingAddress(String userEmail) throws NamingException, SQLException {
        ArrayList<String[]> billingAddresses = new ArrayList<>();

        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
            Connection conn = ds.getConnection();
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            String query = "SELECT * FROM billing_addresses WHERE user_code = ? AND active=1";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userCode);
            ResultSet rs = pstmt.executeQuery();

            int columns = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                String[] row = new String[columns];
                for (int i = 0; i < columns; i++) {
                    row[i] = rs.getString(i + 1);
                }
                billingAddresses.add(row);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            throw e;
        }

        return billingAddresses;
    }

    public static ArrayList<String[]> returnPaymentMethod(String userEmail) throws NamingException, SQLException {
        ArrayList<String[]> PaymentMethod = new ArrayList<>();

        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");
            Connection conn = ds.getConnection();
            int userCode = UtilDS.getUserCodebyEmail(userEmail);

            String query = "SELECT * FROM payment_method WHERE user_code = ? AND active=1";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userCode);
            ResultSet rs = pstmt.executeQuery();

            int columns = rs.getMetaData().getColumnCount();

            while (rs.next()) {
                String[] row = new String[columns];
                for (int i = 0; i < columns; i++) {
                    row[i] = rs.getString(i + 1);
                }
                PaymentMethod.add(row);
            }

            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
            throw e;
        }

        return PaymentMethod;
    }

    public static int getNextCode() {
        String query = "SELECT MAX(code) AS max_code FROM product";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("max_code");
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving max product code: " + e.getMessage());
        }

        return -1;
    }


    public static ArrayList<ArrayList<String>> showBillingAddress(int userCode) {
        ArrayList<ArrayList<String>> billingAddresses = new ArrayList<>();
        String query = "SELECT * FROM billing_addresses WHERE user_code = ? AND active=1";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ArrayList<String> row = new ArrayList<>();
                    row.add(String.valueOf(rs.getInt("address_id")));
                    row.add(String.valueOf(rs.getInt("user_code")));
                    row.add(rs.getString("street"));
                    row.add(rs.getString("city"));
                    row.add(rs.getString("province"));
                    row.add(rs.getString("zip"));
                    billingAddresses.add(row);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving billing addresses: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error retrieving billing addresses: " + e.getMessage());
            e.printStackTrace();
        }
        return billingAddresses;
    }

    public static ArrayList<ArrayList<String>> showDeliveryAddress(int userCode) {
        ArrayList<ArrayList<String>> deliveryAddresses = new ArrayList<>();
        String query = "SELECT * FROM delivery_addresses WHERE user_code = ? AND active=1";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ArrayList<String> row = new ArrayList<>();
                    row.add(String.valueOf(rs.getInt("address_id")));
                    row.add(String.valueOf(rs.getInt("user_code")));
                    row.add(rs.getString("country"));
                    row.add(rs.getString("zip"));
                    row.add(rs.getString("city"));
                    row.add(rs.getString("street"));
                    row.add(rs.getString("province"));
                    deliveryAddresses.add(row);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving delivery addresses: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error retrieving delivery addresses: " + e.getMessage());
            e.printStackTrace();
        }
        return deliveryAddresses;
    }

    public static ArrayList<ArrayList<String>> showPaymentMethods(int userCode) {
        ArrayList<ArrayList<String>> paymentMethods = new ArrayList<>();
        String query = "SELECT * FROM payment_method WHERE user_code = ? AND active=1";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ArrayList<String> row = new ArrayList<>();
                    row.add(String.valueOf(rs.getInt("card_id")));           // card_id
                    row.add(String.valueOf(rs.getInt("user_code")));         // user_code
                    row.add(rs.getString("card_number"));                   // card_number
                    row.add(String.valueOf(rs.getInt("expiry_month")));      // expiry_month
                    row.add(String.valueOf(rs.getInt("expiry_year")));       // expiry_year
                    row.add(rs.getString("cvv"));                           // cvv
                    row.add(rs.getString("cardholder_name"));               // cardholder_name
                    paymentMethods.add(row);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving payment methods: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error retrieving payment methods: " + e.getMessage());
            e.printStackTrace();
        }
        return paymentMethods;
    }

    public static ArrayList<OrderBeans> showOrder(int userCode) {
        ArrayList<OrderBeans> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_code, o.total_cost, o.order_date,\n" +
                "       u.name as user_name, u.email as user_email,\n" +
                "       p.card_number, p.cardholder_name,\n" +
                "       d.country, d.zip as delivery_zip, d.city as delivery_city, d.street as delivery_street, d.province as delivery_province,\n" +
                "       b.street as billing_street, b.city as billing_city, b.province as billing_province, b.zip as billing_zip\n" +
                "FROM orders o\n" +
                "LEFT JOIN payment_method p ON o.payment_card_id = p.card_id\n" +
                "LEFT JOIN delivery_addresses d ON o.delivery_address_id = d.address_id\n" +
                "LEFT JOIN billing_addresses b ON o.billing_address_id = b.address_id\n" +
                "LEFT JOIN users u ON o.user_code = u.code\n" +
                "WHERE o.user_code = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userCode);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderBeans order = new OrderBeans();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserName(rs.getString("user_name"));
                    order.setUserEmail(rs.getString("user_email"));
                    order.setTotalCost(rs.getDouble("total_cost"));
                    order.setOrderDate(rs.getTimestamp("order_date"));

                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setCardNumber(rs.getString("card_number"));
                    paymentMethod.setCardholderName(rs.getString("cardholder_name"));
                    order.setPaymentMethod(paymentMethod);

                    DeliveryAddress deliveryAddress = new DeliveryAddress();
                    deliveryAddress.setStreet(rs.getString("delivery_street"));
                    deliveryAddress.setCity(rs.getString("delivery_city"));
                    deliveryAddress.setZip(rs.getString("delivery_zip"));
                    deliveryAddress.setCountry(rs.getString("country"));
                    deliveryAddress.setProvince(rs.getString("delivery_province"));
                    order.setDeliveryAddress(deliveryAddress);

                    BillingAddress billingAddress = new BillingAddress();
                    billingAddress.setStreet(rs.getString("billing_street"));
                    billingAddress.setCity(rs.getString("billing_city"));
                    billingAddress.setZip(rs.getString("billing_zip"));
                    billingAddress.setProvince(rs.getString("billing_province"));
                    order.setBillingAddress(billingAddress);

                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    public static ArrayList<OrderBeans> showAllOrders() {
        ArrayList<OrderBeans> orders = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_code, o.total_cost, o.order_date,\n" +
                "       u.name as user_name, u.email as user_email,\n" +
                "       p.card_number, p.cardholder_name,\n" +
                "       d.country, d.zip as delivery_zip, d.city as delivery_city, d.street as delivery_street, d.province as delivery_province,\n" +
                "       b.street as billing_street, b.city as billing_city, b.province as billing_province, b.zip as billing_zip\n" +
                "FROM orders o\n" +
                "LEFT JOIN payment_method p ON o.payment_card_id = p.card_id\n" +
                "LEFT JOIN delivery_addresses d ON o.delivery_address_id = d.address_id\n" +
                "LEFT JOIN billing_addresses b ON o.billing_address_id = b.address_id\n" +
                "LEFT JOIN users u ON o.user_code = u.code\n" +
                "ORDER BY o.order_date DESC";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrderBeans order = new OrderBeans();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserCode(rs.getInt("user_code"));  // Aggiunto il codice utente
                order.setUserName(rs.getString("user_name"));
                order.setUserEmail(rs.getString("user_email"));
                order.setTotalCost(rs.getDouble("total_cost"));
                order.setOrderDate(rs.getTimestamp("order_date"));

                PaymentMethod paymentMethod = new PaymentMethod();
                paymentMethod.setCardNumber(rs.getString("card_number"));
                paymentMethod.setCardholderName(rs.getString("cardholder_name"));
                order.setPaymentMethod(paymentMethod);

                DeliveryAddress deliveryAddress = new DeliveryAddress();
                deliveryAddress.setStreet(rs.getString("delivery_street"));
                deliveryAddress.setCity(rs.getString("delivery_city"));
                deliveryAddress.setZip(rs.getString("delivery_zip"));
                deliveryAddress.setCountry(rs.getString("country"));
                deliveryAddress.setProvince(rs.getString("delivery_province"));
                order.setDeliveryAddress(deliveryAddress);

                BillingAddress billingAddress = new BillingAddress();
                billingAddress.setStreet(rs.getString("billing_street"));
                billingAddress.setCity(rs.getString("billing_city"));
                billingAddress.setZip(rs.getString("billing_zip"));
                billingAddress.setProvince(rs.getString("billing_province"));
                order.setBillingAddress(billingAddress);

                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving all orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    public static List<OrderItem> getOrderItems(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT oi.product_code, p.name, oi.quantity, p.price " +
                "FROM order_items oi " +
                "JOIN product p ON oi.product_code = p.code " +
                "WHERE oi.order_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setProductCode(rs.getInt("product_code"));
                    item.setProductName(rs.getString("name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error retrieving order items: " + e.getMessage());
            e.printStackTrace();
        }
        return items;
    }
}
