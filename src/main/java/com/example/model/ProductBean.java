package com.example.model;

import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int code;
	String name;
	String description;
	int price;
	int quantity;
	boolean bestseller;
	boolean dolce;
	boolean salato;
	boolean bevanda;
	boolean bundle;
	boolean trend;
	boolean novita;
	boolean offerta;
	boolean B2B;

	boolean active;

	public ProductBean()
	{
		code = -1;
		name = "";
		description = "";
		quantity = 0;
		bestseller = false;
		dolce = false;
		salato = false;
		bevanda = false;
		bundle = false;
		trend = false;
		novita = false;
		offerta = false;
		B2B = false;
		active=false;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public void decreaseQuantity(int amount) {
		if (this.quantity >= amount) {
			this.quantity -= amount;
		} else {
			throw new IllegalArgumentException("Non ci sono abbastanza prodotti in magazzino");
		}
	}

	public boolean isBestseller() {return bestseller;}

	public boolean isDolce() {return dolce;}

	public boolean isSalato() {return salato;}

	public boolean isBevanda() {return bevanda;}

	public boolean isTrend() {return trend;}

	public boolean isNovita() {return novita;}

	public boolean isOfferta() {return offerta;}

	public boolean isBundle() {return bundle;}

	public boolean isB2B() {return B2B;}

	public void setBestseller(boolean bestseller) {this.bestseller = bestseller;}

	public void setDolce(boolean dolce) {this.dolce = dolce;}

	public void setSalato(boolean salato) {this.salato = salato;}

	public void setBevanda(boolean bevanda) {this.bevanda = bevanda;}

	public void setTrend(boolean trend) {this.trend = trend;}

	public void setNovita(boolean novita) {this.novita = novita;}

	public void setOfferta(boolean offerta) {this.offerta = offerta;}

	public void setBundle(boolean bundle) {this.bundle = bundle;}

	public void setB2B(boolean B2B) {this.B2B = B2B;}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return name + " (" + code + "), " + price + " " + quantity + ". " + description;
	}

}
