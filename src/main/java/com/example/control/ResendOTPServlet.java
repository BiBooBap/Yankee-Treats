package com.example.control;

import com.example.model.OtpBean;
import javax.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/resendOTP")
public class ResendOTPServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        OtpBean otpBean = (OtpBean) session.getAttribute("otpBean");

        if (otpBean != null) {
            // Genera un nuovo OTP
            otpBean = new OtpBean();
            otpBean.setDestinatario(request.getParameter("email"));
            otpBean.sentEmail();

            // Aggiorna l'oggetto OtpBean nella sessione
            session.setAttribute("otpBean", otpBean);

            // Invia la risposta JSON
            out.print("{\"success\": true, \"newCode\": \"" + otpBean.getOtp() + "\"}");
        } else {
            out.print("{\"success\": false, \"message\": \"Errore nel reinvio dell'OTP\"}");
        }
        out.flush();
    }
}
