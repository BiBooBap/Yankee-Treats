package com.example.control;

import com.example.model.OrderBeans;
import com.example.model.OrderItem;
import com.example.model.UtilDS;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ShowOrderServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userCode = (int) request.getSession().getAttribute("userCode");
        ArrayList<OrderBeans> orders = UtilDS.showOrder(userCode);

        Map<Integer, List<OrderItem>> orderItemsMap = new HashMap<>();
        for (OrderBeans order : orders) {
            List<OrderItem> orderItems = UtilDS.getOrderItems(order.getOrderId());
            orderItemsMap.put(order.getOrderId(), orderItems);
        }

        request.setAttribute("orders", orders);
        request.setAttribute("orderItemsMap", orderItemsMap);
        request.getRequestDispatcher("/resources/jsp_pages/OrderHistory.jsp").forward(request, response);
    }
    }

