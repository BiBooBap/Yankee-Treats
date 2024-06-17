package com.example.control;

import com.example.model.Cart;
import com.example.model.LoginBean;
import com.example.model.LoginModelDS;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginBean loginBean = new LoginBean();
        loginBean.setEmail(email);
        loginBean.setPassword(password);

        LoginModelDS loginModelDS = new LoginModelDS();
        boolean loginSuccess = loginModelDS.validateUser(loginBean);
        boolean fromCart = Boolean.parseBoolean(request.getParameter("fromCart"));

        if (loginSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);

            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            if(fromCart) {
                response.sendRedirect(request.getContextPath() + "/Checkout.jsp");
            } else
            response.sendRedirect(request.getContextPath() + "/ProductView.jsp");
        } else
            response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Login.jsp?error=invalidCredentials");
    }
}