package com.example.control;

import com.example.model.ProductDAO;
import com.example.model.ProductModelDM;
import com.example.model.UtilDS;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
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
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.util.List;

@WebServlet("/InsertProduct")
@MultipartConfig
public class InsertProductAdmin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String message = "";

        try {
            if (action != null) {
                if (action.equalsIgnoreCase("addP")) {

                    String name = request.getParameter("productName");
                    String description = request.getParameter("productDescription");
                    int price = Integer.parseInt(request.getParameter("productPrice"));
                    int quantity = Integer.parseInt(request.getParameter("productQuantity"));
                    byte bestseller = (byte) (request.getParameter("productBestseller") != null ? 1 : 0);
                    byte dolce = (byte) (request.getParameter("productDolce") != null ? 1 : 0);
                    byte salato = (byte) (request.getParameter("productSalato") != null ? 1 : 0);
                    byte bevanda = (byte) (request.getParameter("productBevanda") != null ? 1 : 0);
                    byte trend = (byte) (request.getParameter("productTrend") != null ? 1 : 0);
                    byte novita = (byte) (request.getParameter("productNovita") != null ? 1 : 0);
                    byte offerta = (byte) (request.getParameter("productOfferta") != null ? 1 : 0);
                    byte bundle = (byte) (request.getParameter("productBundle") != null ? 1 : 0);
                    byte b2b = (byte) (request.getParameter("productB2B") != null ? 1 : 0);

                    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                    FileItem fileItem = null;

                    if (isMultipart) {
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);

                        try {
                            List<FileItem> items = upload.parseRequest(request);

                            for (FileItem item : items) {
                                if (!item.isFormField() && item.getFieldName().equals("productImage")) {
                                    fileItem = item;
                                }
                            }

                            if (ProductDAO.insertProduct(name, description, price, quantity, bestseller, dolce, salato, bevanda,
                                    trend, novita, offerta, bundle, b2b)) {

                                if (fileItem != null && !fileItem.getName().isEmpty()) {
                                    int next_code = UtilDS.getNextCode();
                                    String fileName = "product_" + next_code + ".png";
                                    String uploadPath = getServletContext().getRealPath("/resources/images");
                                    File uploadDir = new File(uploadPath);
                                    if (!uploadDir.exists()) uploadDir.mkdirs();

                                    File file = new File(uploadPath + File.separator + fileName);
                                    fileItem.write(file);

                                    // Ensure the file is actually saved
                                    if (file.exists()) {
                                        System.out.println("File uploaded to: " + file.getAbsolutePath());
                                    } else {
                                        System.err.println("File was not saved.");
                                    }
                                }

                                message = "Operazione riuscita con successo!";
                            } else {
                                message = "Operazione fallita!";
                            }
                        } catch (Exception e) {
                            message = "Si è verificato un errore durante l'elaborazione della richiesta.";
                            e.printStackTrace();
                        }
                    } else {
                        message = "La richiesta non è multipart.";
                    }
                } else {
                    message = "Azione non valida.";
                }


                if (action.equalsIgnoreCase("updateqP")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int newQ = Integer.parseInt(request.getParameter("newQ"));
                    if (ProductDAO.doUpdateQnt(id, newQ)) {
                        message = "Operazione riuscita con successo!";
                    } else {
                        message = "Operazione fallita!";
                    }
                }

                if (action.equalsIgnoreCase("updatenP")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String newN = request.getParameter("newN");
                    if (ProductDAO.doUpdateName(id, newN)) {
                        message = "Operazione riuscita con successo!";
                    } else {
                        message = "Operazione fallita!";
                    }
                }

                if (action.equalsIgnoreCase("updatedP")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String newD = request.getParameter("newD");
                    if (ProductDAO.doUpdateDesc(id, newD)) {
                        message = "Operazione riuscita con successo!";
                    } else {
                        message = "Operazione fallita!";
                    }
                }

                if (action.equalsIgnoreCase("updatepP")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int newP = Integer.parseInt(request.getParameter("newP"));
                    if (ProductDAO.doUpdatePrice(id, newP)) {
                        message = "Operazione riuscita con successo!";
                    } else {
                        message = "Operazione fallita!";
                    }
                }

                if (action.equalsIgnoreCase("deleteP")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    if (ProductDAO.doDelete(id)) {
                        message = "Operazione riuscita con successo!";
                    } else {
                        message = "Operazione fallita!";
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/InsertProduct.jsp");
        request.getSession().setAttribute("message", message);
    }
}
