package com.example.model;

import java.io.Serializable;
import java.util.Random;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;


public class OtpBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int otp;
    private String destinatario;

    public String getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(String destinatario) {
        this.destinatario = destinatario;
    }

    public OtpBean() {
        this.otp = generateOTP();
    }

    public int getOtp() {
        return this.otp;
    }

    private int generateOTP() {
        Random random = new Random();
        return otp = random.nextInt(9000);
    }

    public void sentEmail() {
        String senderEmail = "yankeetreats.confirm@gmail.com";
        String senderPassword = "ejhx kqbs viga ojzs";
        String recipientEmail = this.destinatario;
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Codice di conferma Yankee Treats");
            message.setText("Ciao "+this.getDestinatario()+".\n\n"
                    + "Grazie per esserti registrato su Yankee Treats! Per completare la registrazione, inserisci il seguente codice di conferma sul nostro sito:\n\n"
                    + "Codice di Conferma: " + this.getOtp() + "\n\n"
                    + "Ti preghiamo di inserire questo codice sul nostro sito per attivare il tuo account. Se non hai tentato di registrarti su Yankee Treats, ti preghiamo di ignorare questa email.\n\n"
                    + "Grazie ancora per aver scelto Yankee Treats!\n\n"
                    + "Cordiali saluti,\n"
                    + "Il Team di Yankee Treats");
            Transport.send(message);

            System.out.println("Email inviata con successo!");

        } catch (MessagingException e) {
            System.out.println("Errore nell'invio dell'email: " + e.getMessage());
        }
    }
}
