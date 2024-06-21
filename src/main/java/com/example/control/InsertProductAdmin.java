package com.example.control;

import com.example.model.ProductDAO;
import com.example.model.UtilDS;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertProductAdmin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("productName");
        String description = request.getParameter("productDescription");
        int price = Integer.parseInt(request.getParameter("productPrice"));
        int quantity = Integer.parseInt(request.getParameter("productQuantity"));
        boolean bestseller = Boolean.parseBoolean(request.getParameter("productBestseller"));
        boolean dolce = Boolean.parseBoolean(request.getParameter("productDolce"));
        boolean salato = Boolean.parseBoolean(request.getParameter("productSalato"));
        boolean bevanda = Boolean.parseBoolean(request.getParameter("productBevanda"));
        boolean trend = Boolean.parseBoolean(request.getParameter("productTrend"));
        boolean novita = Boolean.parseBoolean(request.getParameter("productNovita"));
        boolean offerta = Boolean.parseBoolean(request.getParameter("productOfferta"));
        boolean bundle = Boolean.parseBoolean(request.getParameter("productBundle"));
        boolean b2b = Boolean.parseBoolean(request.getParameter("productB2B"));

        ProductDAO.insertProduct(name, description, price, quantity, bestseller ? 1 : 0, dolce ? 1 : 0, salato ? 1 : 0, bevanda ? 1 : 0,
                trend ? 1 : 0, novita ? 1 : 0, offerta ? 1 : 0, bundle ? 1 : 0, b2b ? 1 : 0);


        int next_code=UtilDS.getNextCode();
        next_code=next_code+1;
        InputStream fileContent = request.getInputStream();
        String fileName = "product_" +next_code + ".png";
        String savePath = "/Users/giuseppedisomma/Yankee-Treats/src/main/webapp/resources/images/" + fileName;

        try (OutputStream outputStream = new FileOutputStream(new File(savePath))) {
            int read;
            byte[] bytes = new byte[1024];
            while ((read = fileContent.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return;
        } finally {
            fileContent.close();
        }
        System.out.println("Saving file to: " + savePath);
        response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/InsertProduct.jsp");
    }
}
