package com.example.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class OrderDetails {
    private int orderId;
    private String userName;
    private String userEmail;
    private double totalCost;
    private Timestamp orderDate;
    private PaymentMethod paymentMethod;
    private DeliveryAddress deliveryAddress;
    private BillingAddress billingAddress;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public DeliveryAddress getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(DeliveryAddress deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public BillingAddress getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(BillingAddress billingAddress) {
        this.billingAddress = billingAddress;
    }

    public static DataSource getDs() {
        return ds;
    }

    public static void setDs(DataSource ds) {
        OrderDetails.ds = ds;
    }

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/storage");
        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }
    
    public static OrderDetails getOrderDetails(int orderId) throws SQLException {
        OrderDetails details = new OrderDetails();
        try (Connection conn = ds.getConnection()) {
            String sql = "SELECT o.*, u.name AS user_name, u.email AS user_email, " +
                    "pm.card_number, pm.cardholder_name, " +
                    "da.street AS delivery_street, da.city AS delivery_city, da.province AS delivery_province, da.zip AS delivery_zip, da.country AS delivery_country, " +
                    "ba.street AS billing_street, ba.city AS billing_city, ba.province AS billing_province, ba.zip AS billing_zip " +
                    "FROM orders o " +
                    "JOIN users u ON o.user_code = u.code " +
                    "JOIN payment_method pm ON o.payment_card_id = pm.card_id " +
                    "JOIN delivery_addresses da ON o.delivery_address_id = da.address_id " +
                    "JOIN billing_addresses ba ON o.billing_address_id = ba.address_id " +
                    "WHERE o.order_id = ?";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, orderId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        details.setOrderId(rs.getInt("order_id"));
                        details.setUserName(rs.getString("user_name"));
                        details.setUserEmail(rs.getString("user_email"));
                        details.setTotalCost(rs.getDouble("total_cost"));
                        details.setOrderDate(rs.getTimestamp("order_date"));

                        PaymentMethod pm = new PaymentMethod();
                        pm.setCardNumber(rs.getString("card_number"));
                        pm.setCardholderName(rs.getString("cardholder_name"));
                        details.setPaymentMethod(pm);

                        DeliveryAddress da = new DeliveryAddress();
                        da.setStreet(rs.getString("delivery_street"));
                        da.setCity(rs.getString("delivery_city"));
                        da.setProvince(rs.getString("delivery_province"));
                        da.setZip(rs.getString("delivery_zip"));
                        da.setCountry(rs.getString("delivery_country"));
                        details.setDeliveryAddress(da);

                        BillingAddress ba = new BillingAddress();
                        ba.setStreet(rs.getString("billing_street"));
                        ba.setCity(rs.getString("billing_city"));
                        ba.setProvince(rs.getString("billing_province"));
                        ba.setZip(rs.getString("billing_zip"));
                        details.setBillingAddress(ba);
                    }
                }
            }
        }
        return details;
    }
}