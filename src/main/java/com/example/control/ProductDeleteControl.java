package com.example.control;

import com.example.model.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ProductDeleteControl extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int code = Integer.parseInt(request.getParameter("code"));
        boolean fromInsertProduct = Boolean.parseBoolean(request.getParameter("fromInsertProduct"));
        String redirectURL = null;

        try {
            boolean isDeactivated = ProductDAO.doDelete(code);

            if (isDeactivated) {
                if (fromInsertProduct) {
                    redirectURL = request.getContextPath() + "/resources/jsp_pages/DBInterface.jsp";
                } else if(request.getSession().getAttribute("sort")!=null){
                    redirectURL = request.getContextPath() + "/product?sort=" + request.getSession().getAttribute("sort");
                }
                else  redirectURL = request.getContextPath() + "/ProductView.jsp";

            } else {
                redirectURL = request.getContextPath() + "/resources/jsp_pages/errors/500.jsp";
            }

            response.sendRedirect(redirectURL);

        } catch (SQLException e) {
            throw new ServletException("Errore durante la disattivazione del prodotto", e);
        }
    }
}
