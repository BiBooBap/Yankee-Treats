package com.example.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.example.model.*;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OrdineServlet
 */
@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        OrderDAO ordDao = new OrderDAO();
        ProductModelDM compDao = new ProductModelDM();
        LoginBean user = (LoginBean) request.getSession().getAttribute("userEmail");

        String action = request.getParameter("action");

        try {
            if(action!=null) {
                if(action.equalsIgnoreCase("orders")) {
                    String email = user.getEmail();
                    request.getSession().removeAttribute("ordini");
                    request.getSession().setAttribute("ordini", ordDao.doRetrieveByEmail(email));

                    response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/Orders.jsp");
                }
            }
            else if(action.equalsIgnoreCase("orderDetails")) {
                int id = Integer.parseInt(request.getParameter("id"));
                request.getSession().removeAttribute("composizione");
                request.getSession().setAttribute("composizione", compDao.doRetrieveByKey(id));

                response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/OrdersDetails.jsp");
            }


        }catch(SQLException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

}
