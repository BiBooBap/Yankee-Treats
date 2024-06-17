package com.example.model;

import java.util.ArrayList;
import java.util.List;
import com.example.model.CartItem;
import com.example.model.ProductBean;

public class Cart {

	private ArrayList<CartItem> cart;


	public Cart() {
		cart = new ArrayList<CartItem>();
	}

	public void addProduct(ProductBean product) {
		for (CartItem item : cart) {
			if(item.getId() == product.getCode())
			{
				item.addQuantity();
				return;
			}
		}

		CartItem item = new CartItem(product);
		cart.add(item);
	}

	public void deleteProduct(ProductBean product) {
		for(CartItem item : cart) {
			if(item.getId() == product.getCode()) {
				cart.remove(item);
				break;
			}
		}
 	}

	 public CartItem getCartItem(int id)
	 {
		 for(CartItem item : cart) {
			 if(item.getId() == id)
				 return item;
		 }

		 return null;
	 }

	public double getCartTotalPrice() {
		double total = 0;
		for(CartItem item : cart)
			total += item.getTotalPrice();
		return total;
	}

	public int getTotalItemCount() {
		int totalCount = 0;
		for (CartItem item : cart) {
			totalCount += item.getQuantityCart();
		}
		return totalCount;
	}

	public boolean isEmpty() {
		return (cart.isEmpty());
	}

	public ArrayList<CartItem> getCart() {
		return cart;
	}

	public void clearCart(){
		cart.removeAll(cart);
	}
}