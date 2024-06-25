package com.example.control;

import com.example.model.OrderBeans;
import com.example.model.UtilDS;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;


    public class ShowOrderServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            int userCode = (int) request.getSession().getAttribute("userCode");
            ArrayList<OrderBeans> orders = UtilDS.showOrder(userCode);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/resources/jsp_pages/OrderHistory.jsp").forward(request, response);
        }
    }

