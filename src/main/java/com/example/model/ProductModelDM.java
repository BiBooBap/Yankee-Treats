package com.example.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class ProductModelDM implements ProductModel {

	private static final String TABLE_NAME = "product";

	@Override
	public synchronized void doSave(ProductBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModelDM.TABLE_NAME
				+ " (NAME, DESCRIPTION, PRICE, QUANTITY, BESTSELLER, DOLCE, SALATO, BEVANDA, TREND, NOVITA, OFFERTA, BUNDLE, B2B) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, product.getName());
			preparedStatement.setString(2, product.getDescription());
			preparedStatement.setInt(3, product.getPrice());
			preparedStatement.setInt(4, product.getQuantity());

			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
	}

	@Override
	public synchronized ProductBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + ProductModelDM.TABLE_NAME + " WHERE CODE = ? AND active=1";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setCode(rs.getInt("CODE"));
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getInt("PRICE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setBestseller(rs.getBoolean("BESTSELLER"));
				bean.setDolce(rs.getBoolean("DOLCE"));
				bean.setSalato(rs.getBoolean("SALATO"));
				bean.setBevanda(rs.getBoolean("BEVANDA"));
				bean.setTrend(rs.getBoolean("TREND"));
				bean.setNovita(rs.getBoolean("NOVITA"));
				bean.setOfferta(rs.getBoolean("OFFERTA"));
				bean.setBundle(rs.getBoolean("BUNDLE"));
				bean.setB2B(rs.getBoolean("B2B"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return bean;
	}

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductModelDM.TABLE_NAME + " WHERE CODE = ?";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

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

	@Override
	public synchronized Collection<ProductBean> doRetrieveAllWithActive(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + ProductModelDM.TABLE_NAME + " WHERE active = 1";

		if (order != null && !order.equals("")) {
			selectSQL += " AND (" + order + " = 1 OR B2B = 1) AND active = 1";
		}


		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setCode(rs.getInt("CODE"));
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getInt("PRICE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setBestseller(rs.getBoolean("BESTSELLER"));
				bean.setDolce(rs.getBoolean("DOLCE"));
				bean.setSalato(rs.getBoolean("SALATO"));
				bean.setBevanda(rs.getBoolean("BEVANDA"));
				bean.setTrend(rs.getBoolean("TREND"));
				bean.setNovita(rs.getBoolean("NOVITA"));
				bean.setOfferta(rs.getBoolean("OFFERTA"));
				bean.setBundle(rs.getBoolean("BUNDLE"));
				bean.setB2B(rs.getBoolean("B2B"));
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return products;
	}

	public static synchronized Collection<ProductBean> doRetrieveAll() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + ProductModelDM.TABLE_NAME;


		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setCode(rs.getInt("CODE"));
				bean.setName(rs.getString("NAME"));
				bean.setDescription(rs.getString("DESCRIPTION"));
				bean.setPrice(rs.getInt("PRICE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setBestseller(rs.getBoolean("BESTSELLER"));
				bean.setDolce(rs.getBoolean("DOLCE"));
				bean.setSalato(rs.getBoolean("SALATO"));
				bean.setBevanda(rs.getBoolean("BEVANDA"));
				bean.setTrend(rs.getBoolean("TREND"));
				bean.setNovita(rs.getBoolean("NOVITA"));
				bean.setOfferta(rs.getBoolean("OFFERTA"));
				bean.setBundle(rs.getBoolean("BUNDLE"));
				bean.setB2B(rs.getBoolean("B2B"));
				bean.setActive(rs.getBoolean("ACTIVE"));
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return products;
	}


	public synchronized void doUpdateQnt(int id, int qnt) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String updateSQL = "UPDATE " + ProductModelDM.TABLE_NAME
				+ " SET QUANTITY = ? "
				+ " WHERE CODE = ? ";

		try {
			connection = DriverManagerConnectionPool.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setInt(1, qnt);
			preparedStatement.setInt(2, id);



			preparedStatement.executeUpdate();

			connection.commit();
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

}
