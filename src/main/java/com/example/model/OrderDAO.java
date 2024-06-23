package com.example.model;

import com.example.model.OrderDAOInterface;
import com.example.model.OrderBean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderDAO implements OrderDAOInterface {

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

    private static final String TABLE_NAME = "order";


    @Override
    public synchronized void doSave(OrderBean ordine) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + OrderDAO.TABLE_NAME
                + " (EMAIL, TOTAL_IMPORT, STATE, DATE_ORDER, ADDRESS, CAP, CREDIT_CARD, ID_ORDER VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, ordine.getEmail());
            preparedStatement.setDouble(2, ordine.getTotalImport());
            preparedStatement.setString(3, ordine.getState());
            preparedStatement.setString(4, ordine.getDate());
            preparedStatement.setString(5, ordine.getAddress());
            preparedStatement.setString(6, ordine.getCap());
            preparedStatement.setString(7, ordine.getCreditCart());
            preparedStatement.setInt(8, ordine.getOrderId());



            preparedStatement.executeUpdate();

            connection.commit();
        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }
    }


    @Override
    public synchronized OrderBean doRetrieveByKey(int idOrdine) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        OrderBean ordine = new OrderBean();

        String selectSQL = "SELECT * FROM " + OrderDAO.TABLE_NAME
                + " WHERE ID_ORDER = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, idOrdine);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                ordine.setOrderId(rs.getInt("ID_ORDER"));
                ordine.setEmail(rs.getString("EMAIL"));
                ordine.setTotalImport(rs.getDouble("TOTAL_IMPORT"));
                ordine.setState(rs.getString("STATE"));
                ordine.setDate(rs.getString("DATA_ORDER"));
                ordine.setAddress(rs.getString("ADDRESS"));
                ordine.setCap(rs.getString("CAP"));
                ordine.setCreditCard(rs.getString("CREDIT_CARD"));
            }

        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }

        return ordine;
    }


    @Override
    public synchronized ArrayList<OrderBean> doRetrieveByEmail(String email) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList<OrderBean> ordini = new ArrayList<OrderBean>();

        String selectSQL = "SELECT * FROM " + OrderDAO.TABLE_NAME
                + " WHERE EMAIL = ? ";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, email);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean ordine = new OrderBean();
                ordine.setOrderId(rs.getInt("ID_ORDER"));
                ordine.setEmail(rs.getString("EMAIL"));
                ordine.setTotalImport(rs.getDouble("TOTAL_IMPORT"));
                ordine.setState(rs.getString("STATE"));
                ordine.setDate(rs.getString("DATE_ORDER"));
                ordine.setAddress(rs.getString("ADDRESS"));
                ordine.setCap(rs.getString("CAP"));
                ordine.setCreditCard(rs.getString("CREDIT_CARD"));
                ordini.add(ordine);
            }
        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }

        return ordini;
    }


    @Override
    public synchronized ArrayList<OrderBean> doRetrieveAll(String order) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList<OrderBean> ordini = new ArrayList<OrderBean>();

        String selectSQL = "SELECT * FROM " + OrderDAO.TABLE_NAME;

        if (order != null && !order.equals("")) {
            selectSQL += " ORDER BY ? " ;
        }

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, order);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean ordine = new OrderBean();
                ordine.setOrderId(rs.getInt("ID_ORDER"));
                ordine.setEmail(rs.getString("EMAIL"));
                ordine.setTotalImport(rs.getDouble("TOTAL_IMPORT"));
                ordine.setState(rs.getString("STATE"));
                ordine.setDate(rs.getString("DATE_ORDER"));
                ordine.setAddress(rs.getString("ADDRESS"));
                ordine.setCap(rs.getString("CAP"));
                ordine.setCreditCard(rs.getString("CREDIT_CARD"));
                ordini.add(ordine);
            }
        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }

        return ordini;
    }


    public synchronized ArrayList<OrderBean> doRetrieveByDate(String da, String a) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList<OrderBean> ordini = new ArrayList<OrderBean>();

        String selectSQL = "SELECT * FROM " + OrderDAO.TABLE_NAME
                + " WHERE DATE_ORDER >= ? AND DATE_ORDER <= ? "
                + " ORDER BY DATE_ORDER " ;

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, da);
            preparedStatement.setString(2, a);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean ordine = new OrderBean();
                ordine.setOrderId(rs.getInt("ID_ORDER"));
                ordine.setEmail(rs.getString("EMAIL"));
                ordine.setTotalImport(rs.getDouble("TOTAL_IMPORT"));
                ordine.setState(rs.getString("STATE"));
                ordine.setDate(rs.getString("DATE_ORDER"));
                ordine.setAddress(rs.getString("ADDRESS"));
                ordine.setCap(rs.getString("CAP"));
                ordine.setCreditCard(rs.getString("CREDIT_CARD"));
                ordini.add(ordine);
            }
        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }

        return ordini;
    }


    public synchronized ArrayList<OrderBean> doRetrieveByNominativo(String nome, String cognome) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        ArrayList<OrderBean> ordini = new ArrayList<OrderBean>();

        String selectSQL = "SELECT  O.EMAIL, TOTAL_IMPORT, STATE, ORDER_DATE, O.ADDRESS, O.CAP, O.CREDIT_CARD, ID_ORDER"
                + " FROM " + OrderDAO.TABLE_NAME + " O JOIN USERS C ON O.EMAIL = C.EMAIL "
                + " WHERE NAME = ? AND SURNAME = ? ";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, cognome);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean ordine = new OrderBean();
                ordine.setOrderId(rs.getInt("ID_ORDER"));
                ordine.setEmail(rs.getString("EMAIL"));
                ordine.setTotalImport(rs.getDouble("TOTAL_IMPORT"));
                ordine.setState(rs.getString("STATE"));
                ordine.setDate(rs.getString("DATE_ORDER"));
                ordine.setAddress(rs.getString("ADDRESS"));
                ordine.setCap(rs.getString("CAP"));
                ordine.setCreditCard(rs.getString("CREDIT_CARD"));
                ordini.add(ordine);
            }
        }
        finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            }
            finally {
                if (connection != null)
                    connection.close();
            }
        }

        return ordini;
    }

}