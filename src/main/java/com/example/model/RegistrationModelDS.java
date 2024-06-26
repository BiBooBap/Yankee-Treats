package com.example.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegistrationModelDS {

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

    private static final String TABLE_NAME = "users";

    public boolean insertUser(RegistrationBean registrazioneBean) {
        try (Connection connection = ds.getConnection()) {
            String insertSQL;
            if ("venditore".equals(registrazioneBean.getTipoUtente())) {
                insertSQL = "INSERT INTO " + RegistrationModelDS.TABLE_NAME
                        + " (name, surname, date_of_birth, email, password, user_type, partita_iva, CF) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            } else {
                insertSQL = "INSERT INTO " + RegistrationModelDS.TABLE_NAME
                        + " (name, surname, date_of_birth, email, password, user_type) VALUES (?, ?, ?, ?, ?, ?)";
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
                preparedStatement.setString(1, registrazioneBean.getNome());
                preparedStatement.setString(2, registrazioneBean.getCognome());
                preparedStatement.setString(3, registrazioneBean.getDataDiNascita());
                preparedStatement.setString(4, registrazioneBean.getEmail());
                preparedStatement.setString(5, registrazioneBean.getPassword());
                preparedStatement.setString(6, registrazioneBean.getTipoUtente());

                if ("venditore".equals(registrazioneBean.getTipoUtente())) {
                    preparedStatement.setString(7, registrazioneBean.getPartitaIVA());
                    preparedStatement.setString(8, registrazioneBean.getCodiceFiscale());
                }

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    System.out.println("Inserimento utente riuscito.");
                    return true;
                } else {
                    System.out.println("Nessuna riga inserita.");
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore durante l'inserimento utente: " + e.getMessage());
            return false;
        }
    }

    public boolean checkEmail(String email) {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE email = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println("Error validating user: " + e.getMessage());
        }
        return false;
    }
}