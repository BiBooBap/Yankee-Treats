package com.example.control;

import com.example.model.*;
import jakarta.servlet.annotation.WebServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ProductModelDM productModel = new ProductModelDM();

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }

        String action = request.getParameter("action");
        try {
            if (action != null && action.equalsIgnoreCase("addC")) {
                int productId = Integer.parseInt(request.getParameter("id"));
                cart.addProduct(productModel.doRetrieveByKey(productId));
                response.sendRedirect("ProductView.jsp");
                return; // Ensure no further processing occurs after redirect
            } else if (action != null && action.equalsIgnoreCase("deleteC")) {
                int productId = Integer.parseInt(request.getParameter("id"));
                cart.deleteProduct(productModel.doRetrieveByKey(productId));
                response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
                return; // Ensure no further processing occurs after redirect
            } else if (action != null && action.equalsIgnoreCase("incrementC")) {
                int productId = Integer.parseInt(request.getParameter("id"));
                CartItem item = cart.getCartItem(productId);
                if (item != null) {
                    item.addQuantity();
                }
                response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
                return; // Ensure no further processing occurs after redirect
            } else if (action != null && action.equalsIgnoreCase("decrementC")) {
                int productId = Integer.parseInt(request.getParameter("id"));
                CartItem item = cart.getCartItem(productId);
                if (item != null) {
                    item.reduceQuantity();
                }
                response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
                return; // Ensure no further processing occurs after redirect
            }
        } catch (SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }

        double cartTotal = cart.getCartTotalPrice();
        request.getSession().setAttribute("cartTotal", cartTotal);

        request.getSession().setAttribute("cart", cart);
        request.setAttribute("cart", cart);

        // Fallback redirect if no action matched
        response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Cart.jsp");
    }
}



