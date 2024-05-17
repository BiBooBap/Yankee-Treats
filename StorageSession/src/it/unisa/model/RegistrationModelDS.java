package it.unisa.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
            String insertSQL = "INSERT INTO " + RegistrationModelDS.TABLE_NAME
                    + " (name, surname, date_of_birth, email, password, user_type, partita_iva, CF) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
                preparedStatement.setString(1, registrazioneBean.getNome());
                preparedStatement.setString(2, registrazioneBean.getCognome());
                preparedStatement.setString(3, registrazioneBean.getDataDiNascita());
                preparedStatement.setString(4, registrazioneBean.getEmail());
                preparedStatement.setString(5, registrazioneBean.getPassword());
                preparedStatement.setString(6, registrazioneBean.getTipoUtente());
                preparedStatement.setString(7, registrazioneBean.getPartitaIVA());
                preparedStatement.setString(8, registrazioneBean.getCodiceFiscale());

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
}
