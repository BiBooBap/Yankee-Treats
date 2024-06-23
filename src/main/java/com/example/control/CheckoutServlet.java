package com.example.control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.model.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ProductModelDM daoProd = new ProductModelDM();
        OrderDAO daoOrd = new OrderDAO();
        CartItem daoComp = new CartItem();
        IndirizzoSpedizioneDao daoSped = new IndirizzoSpedizioneDao();
        MetodoPagamentoDao daoPag = new MetodoPagamentoDao();

        LoginBean user = (LoginBean) request.getSession().getAttribute("currentSessionUser");
        OrderBean ordine = new OrderBean();
        ProductBean comp = new ProductBean();
        IndirizzoSpedizioneBean sped = new IndirizzoSpedizioneBean();
        MetodoPagamentoBean pag = new MetodoPagamentoBean();

        Cart cart = (Cart) request.getSession().getAttribute("cart");
        Double prezzoTot = cart.getCartTotalPrice();

        Date now = new Date();
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
        String mysqlDateString = formatter.format(now);

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String telefono = request.getParameter("tel");
        String città = request.getParameter("città");
        String ind = request.getParameter("ind");
        String cap = request.getParameter("cap");
        String prov = request.getParameter("prov");

        String tit = request.getParameter("tit");
        String numC = request.getParameter("numC");
        String scad = request.getParameter("scad");


        try {

            if(daoSped.doRetrieveByKey(ind,cap)==null){
                sped.setNome(nome);
                sped.setCognome(cognome);
                sped.setIndirizzo(ind);
                sped.setTelefono(telefono);
                sped.setCap(cap);
                sped.setProvincia(prov);
                sped.setCittà(città);
                daoSped.doSave(sped);
            }

            if(daoPag.doRetrieveByKey(numC)==null){
                pag.setTitolare(tit);
                pag.setNumero(numC);
                pag.setScadenza(scad);
                daoPag.doSave(pag);
            }


            ordine.setEmail(user.getEmail());
            ordine.setAddress(ind);
            ordine.setCap(cap);
            ordine.setCreditCard(numC);
            ordine.setDate(mysqlDateString);
            ordine.setState("Confermato");
            ordine.setTotalImport(prezzoTot);
            daoOrd.doSave(ordine);

            ArrayList<OrderBean> ordini = daoOrd.doRetrieveByEmail(user.getEmail());
            int newId = ordini.get(ordini.size() - 1).getOrderId();


            for (CartItem item : cart.getCart()) {
                int quantityCart = item.getQuantityCart();
                ProductBean product = item.getProduct();
                int newQuantity = product.getQuantity() - quantityCart;

                daoProd.doUpdateQnt(product.getCode(), newQuantity);

                comp.setIdOrdine(newId);
                comp.setIdProdotto(product.getCode());
                comp.setPrezzoTotale(item.getTotalPrice());
                comp.setQuantità(quantityCart);
                daoComp.doSave(comp);
            }



        }catch(SQLException e) {
            e.printStackTrace();
            return;

        }

        request.getSession().removeAttribute("cart");

        response.sendRedirect(request.getContextPath() + "/Home.jsp");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doPost(request, response);
    }

}







