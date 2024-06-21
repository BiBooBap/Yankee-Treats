package com.example.control;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.model.RegistrationBean;

import java.io.IOException;
import com.example.model.RegistrationModelDS;
import com.example.model.UtilDS;

public class RegistrationControl extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String dataDiNascita = request.getParameter("data_di_nascita");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String tipoUtente = request.getParameter("tipo_utente");
        String partitaIVA = request.getParameter("partita_iva");
        String codiceFiscale = request.getParameter("codice_fiscale");

        RegistrationBean registrazioneBean = new RegistrationBean();
        registrazioneBean.setNome(nome);
        registrazioneBean.setCognome(cognome);
        registrazioneBean.setDataDiNascita(dataDiNascita);
        registrazioneBean.setEmail(email);
        registrazioneBean.setPassword(password);
        registrazioneBean.setTipoUtente(tipoUtente);
        registrazioneBean.setPartitaIVA(partitaIVA);
        registrazioneBean.setCodiceFiscale(codiceFiscale);

        RegistrationModelDS registrationModelDS = new RegistrationModelDS();
        boolean inserimentoRiuscito = registrationModelDS.insertUser(registrazioneBean);

        if (inserimentoRiuscito) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userType", UtilDS.getUserTypebyEmail(email));
            session.setAttribute("userName", UtilDS.getNamebyEmail(email));
            response.sendRedirect(request.getContextPath()+"/ProductView.jsp?userEmail=" + email);
        } else {
            response.sendRedirect("error.jsp");
        }
        }

    }


