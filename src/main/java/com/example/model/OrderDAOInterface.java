package com.example.model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface OrderDAOInterface {

    public void doSave(OrderBean order) throws SQLException;

    public OrderBean doRetrieveByKey(int idOrder) throws SQLException;

    public ArrayList<OrderBean> doRetrieveByEmail(String email) throws SQLException;

    public ArrayList<OrderBean> doRetrieveAll(String order) throws SQLException;
}
