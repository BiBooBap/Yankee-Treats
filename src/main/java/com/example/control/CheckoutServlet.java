package com.example.control;

import com.example.model.Cart;
import com.example.model.CartItem;
import com.example.model.OrderBeans;
import com.example.model.OrderDetails;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int paymentCardId;
        int deliveryAddressId;
        int billingAddressId;
        double totalCost;
        int order_id = 0;
        Cart cart;
        try {
            paymentCardId = Integer.parseInt(request.getParameter("selectedPaymentMethodId"));
            deliveryAddressId = Integer.parseInt(request.getParameter("selectedDeliveryAddressId"));
            billingAddressId = Integer.parseInt(request.getParameter("selectedAddressId"));
            totalCost = (double) request.getSession().getAttribute("cartTotal");

            HttpSession session = request.getSession();
            cart = (Cart) session.getAttribute("cart");

            if (cart == null || cart.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/error.html");
                return;
            }

        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.html");
            return;
        }

        int userCode = (int) request.getSession().getAttribute("userCode");

        try {
            order_id = saveOrder(userCode, paymentCardId, deliveryAddressId, billingAddressId, totalCost);
            if (order_id != -1) {
                request.getSession().setAttribute("lastOrder", order_id);
                createInvoicePDF(order_id, cart, getServletContext());
                sendInvoicePDF((String) request.getSession().getAttribute("userEmail"), order_id, getServletContext());
                response.sendRedirect(request.getContextPath() + "/resources/jsp_pages/OrderComplete.jsp");
                saveorderItems(order_id, cart);
            } else {
                response.sendRedirect(request.getContextPath() + "/error.html");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.html");
        } catch (NamingException e) {
            throw new ServletException(e);
        }
    }

    private int saveOrder(int userCode, int paymentCardId, int deliveryAddressId, int billingAddressId, double totalCost)
            throws SQLException, NamingException {
        int orderId = -1;
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

        try (Connection conn = ds.getConnection()) {

            String sql = "INSERT INTO orders (user_code, payment_card_id, delivery_address_id, billing_address_id, total_cost) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userCode);
                stmt.setInt(2, paymentCardId);
                stmt.setInt(3, deliveryAddressId);
                stmt.setInt(4, billingAddressId);
                stmt.setDouble(5, totalCost);
                stmt.executeUpdate();

                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to retrieve generated order ID.");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
            return orderId;
        }
    }

    private void createInvoicePDF(int orderId, Cart cart, ServletContext context) throws IOException, SQLException {
        try (PDDocument document = new PDDocument()) {
            PDPage page = new PDPage();
            document.addPage(page);

            // Recupera i dettagli dell'ordine dal database
            OrderDetails orderDetails = OrderDetails.getOrderDetails(orderId);

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                contentStream.beginText();
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(25, 750);

                // Intestazione fattura
                contentStream.setFont(PDType1Font.TIMES_BOLD, 16);
                contentStream.showText("Fattura per l'ordine #" + orderId);
                contentStream.newLineAtOffset(0, -20);

                // Dettagli cliente
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                if(orderDetails.getUserName()!=null) {
                    contentStream.showText("Cliente: " + orderDetails.getUserName());
                    contentStream.newLineAtOffset(0, -15);
                }
                contentStream.showText("Email: " + orderDetails.getUserEmail());
                contentStream.newLineAtOffset(0, -20);

                // Indirizzo di consegna
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Indirizzo di Consegna:");
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Via: " + orderDetails.getDeliveryAddress().getStreet());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Comune: " + orderDetails.getDeliveryAddress().getCity());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Provincia: " + orderDetails.getDeliveryAddress().getProvince());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("CAP: " + orderDetails.getDeliveryAddress().getZip());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Paese: " + orderDetails.getDeliveryAddress().getCountry());
                contentStream.newLineAtOffset(0, -20);

                // Indirizzo di fatturazione
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Indirizzo di Fatturazione:");
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Via: " + orderDetails.getBillingAddress().getStreet());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Comune: " + orderDetails.getBillingAddress().getCity());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Provincia: " + orderDetails.getBillingAddress().getProvince());
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("CAP: " + orderDetails.getBillingAddress().getZip());
                contentStream.newLineAtOffset(0, -20);

                // Metodo di pagamento
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Metodo di Pagamento:");
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Carta: **** **** **** " + orderDetails.getPaymentMethod().getCardNumber().substring(orderDetails.getPaymentMethod().getCardNumber().length() - 4));
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Intestatario: " + orderDetails.getPaymentMethod().getCardholderName());
                contentStream.newLineAtOffset(0, -20);

                // Dettagli ordine
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Dettagli Ordine:");
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(0, -15);
                contentStream.showText("Data Ordine: " + orderDetails.getOrderDate());
                contentStream.newLineAtOffset(0, -20);

                // Prodotti ordinati
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Prodotti Ordinati:");
                contentStream.setFont(PDType1Font.TIMES_ROMAN, 12);
                contentStream.newLineAtOffset(0, -15);
                for (CartItem item : cart.getCart()) {
                    contentStream.showText(item.getQuantityCart() + "x " + item.getName() + " - €" + String.format("%.2f", item.getTotalPrice()));
                    contentStream.newLineAtOffset(0, -15);
                }


                // Totale
                contentStream.newLineAtOffset(0, -20);
                contentStream.setFont(PDType1Font.TIMES_BOLD, 14);
                contentStream.showText("Totale: €" + String.format("%.2f", orderDetails.getTotalCost()));

                contentStream.endText();
            }

            String relativePath = "/WEB-INF/invoices/" + orderId + ".pdf";
            String realPath = context.getRealPath(relativePath);

            File directory = new File(realPath).getParentFile();
            if (!directory.exists()) {
                directory.mkdirs();
            }

            document.save(realPath);
        } catch (IOException | SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    private void sendInvoicePDF(String destinatario, int orderId, ServletContext context) {
        String senderEmail = "yankeetreats.confirm@gmail.com";
        String senderPassword = "ejhx kqbs viga ojzs";
        String recipientEmail = destinatario;
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Fattura del tuo ordine Yankee Treats");


            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText("Gentile Cliente,\n\n"
                    + "Grazie per il tuo ordine su Yankee Treats! In allegato trovi la fattura del tuo acquisto.\n\n"
                    + "Numero dell'ordine: ORDRN" + orderId + "\n\n"
                    + "Se hai domande riguardo al tuo ordine, non esitare a contattarci.\n\n"
                    + "Grazie ancora per aver scelto Yankee Treats!\n\n"
                    + "Cordiali saluti,\n"
                    + "Il Team di Yankee Treats");

            MimeBodyPart attachmentPart = new MimeBodyPart();
            String filePath = context.getRealPath("/WEB-INF/invoices/" + orderId + ".pdf");
            attachmentPart.attachFile(new File(filePath));
            attachmentPart.setFileName("Fattura_ORDRN" + orderId + ".pdf");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            multipart.addBodyPart(attachmentPart);

            message.setContent(multipart);

            Transport.send(message);


        } catch (MessagingException | IOException e) {
            System.out.println("Errore nell'invio dell'email con fattura: " + e.getMessage());
        }
    }

    public void saveorderItems(int orderId, Cart cart) throws NamingException {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");

        DataSource ds = (DataSource) envCtx.lookup("jdbc/storage");

        try (Connection conn = ds.getConnection()) {
            String sql = "INSERT INTO order_items (order_id, product_code, quantity) VALUES (?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (CartItem item : cart.getCart()) {
                    stmt.setInt(1, orderId);
                    stmt.setInt(2, item.getId());
                    stmt.setInt(3, item.getQuantityCart());
                    stmt.addBatch();
                }
                stmt.executeBatch();
            } catch (SQLException e) {
                e.printStackTrace();
                throw e;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}

