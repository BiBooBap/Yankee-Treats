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
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");

        if (sortBy == null) {
            sortBy = "date"; // Default sort field
        }
        if (sortOrder == null) {
            sortOrder = "DESC"; // Default sorting order
        }

        ArrayList<OrderBeans> orders = UtilDS.showAllOrders(sortBy, sortOrder);
        request.getSession().setAttribute("orders", orders);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortOrder", sortOrder);
        request.getRequestDispatcher("/resources/jsp_pages/AdminOrderHistory.jsp").forward(request, response);
    }
}
