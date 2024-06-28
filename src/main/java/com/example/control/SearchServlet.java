package com.example.control;

import com.example.model.ProductBean;
import com.example.model.ProductModelDM;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        try {
            ProductModelDM productModel = new ProductModelDM();
            List<ProductBean> allProducts=null;
            if(request.getSession().getAttribute("userType").equals("venditore") || request.getSession().getAttribute("userType").equals("admin") ) {
                allProducts = productModel.doRetrieveAllWithActive(null).stream()
                        .filter(p -> p.getName().toLowerCase().contains(query.toLowerCase()))
                        .limit(5)
                        .collect(Collectors.toList());
            } else {
                allProducts = productModel.doRetrieveAllWithActiveNob2b().stream()
                        .filter(p -> p.getName().toLowerCase().contains(query.toLowerCase()))
                        .limit(5)
                        .collect(Collectors.toList());
            }

            String jsonResults = convertToJSON(allProducts);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResults);
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error during search");
        }
    }

    private String convertToJSON(List<ProductBean> products) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < products.size(); i++) {
            ProductBean product = products.get(i);
            json.append("{");
            json.append("\"code\":").append(product.getCode()).append(",");
            json.append("\"name\":\"").append(escapeJSON(product.getName())).append("\",");
            json.append("\"description\":\"").append(escapeJSON(product.getDescription())).append("\",");
            json.append("\"price\":").append(product.getPrice()).append(",");
            json.append("\"quantity\":").append(product.getQuantity()).append(",");
            json.append("\"bestseller\":").append(product.isBestseller()).append(",");
            json.append("\"dolce\":").append(product.isDolce()).append(",");
            json.append("\"salato\":").append(product.isSalato()).append(",");
            json.append("\"bevanda\":").append(product.isBevanda()).append(",");
            json.append("\"trend\":").append(product.isTrend()).append(",");
            json.append("\"novita\":").append(product.isNovita()).append(",");
            json.append("\"offerta\":").append(product.isOfferta()).append(",");
            json.append("\"bundle\":").append(product.isBundle()).append(",");
            json.append("\"b2b\":").append(product.isB2B());
            json.append("}");
            if (i < products.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }

    private String escapeJSON(String value) {
        return value.replace("\"", "\\\"");
    }
}
