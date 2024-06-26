package com.example.control;

import com.example.model.OrderBeans;
import com.example.model.UtilDS;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class ShowOrderAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<OrderBeans> orders = UtilDS.showAllOrders();
        request.getSession().setAttribute("orders", orders);
        request.getRequestDispatcher("/resources/jsp_pages/AdminHistory.jsp").forward(request, response);
    }
}
