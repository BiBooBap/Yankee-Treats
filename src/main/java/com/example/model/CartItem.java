package com.example.model;

public class CartItem {
    private ProductBean product;
    private int quantityCart;

    public CartItem(ProductBean product) {
        this.product = product;
        this.quantityCart = 1;
    }

    public ProductBean getProduct() {
        return product;
    }

    public void setProduct(ProductBean product) {
        this.product = product;
    }

    public int getQuantityCart() {
        return quantityCart;
    }

    public void setQuantityCart(int quantity) {
        if (quantity > 0 && quantity <= product.getQuantity()) {
            this.quantityCart = quantity;
        }
    }

    public int getId() {
        return product.getCode();
    }

    public double getTotalPrice() {
        return quantityCart * product.getPrice();
    }

    public String getDescription() {
        return product.getDescription();
    }

    public String getName() {
        return product.getName();
    }

    public void addQuantity() {
        if (quantityCart < product.getQuantity()) {
            quantityCart += 1;
        }
    }

    public void reduceQuantity() {
        if (quantityCart > 1) {
            quantityCart -= 1;
        }
    }

    public String toString() {
        return "CartItem{" +
                "product=" + product +
                ", quantityCart=" + quantityCart +
                ", totalPrice=" + getTotalPrice() +
                '}';
    }

}