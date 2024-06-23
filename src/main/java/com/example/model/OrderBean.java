
package com.example.model;

import java.io.Serializable;
import java.util.Date;

public class OrderBean implements Serializable {

    private static final long serialVersionUID = 1L;

    public OrderBean() {

    }

    public int getOrderId() {
        return id_order;
    }

    public void setOrderId(int OrderId) {
        this.id_order = OrderId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getTotalImport() {
        return total_import;
    }

    public void setTotalImport(double importoTotale) {
        this.total_import = importoTotale;
    }

    public String getState() {
        return state;
    }

    public void setState(String stato) {
        this.state = stato;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String data) {
        this.date = data;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String indirizzo) {
        this.address = indirizzo;
    }

    public String getCap() {
        return cap;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }

    public String getCreditCart() {
        return credit_card;
    }

    public void setCreditCard(String cartaCredito) {
        this.credit_card = cartaCredito;
    }

    private int id_order;
    private String email;
    private double total_import;
    private String state;
    private String date;
    private String address;
    private String cap;
    private String credit_card;

}
