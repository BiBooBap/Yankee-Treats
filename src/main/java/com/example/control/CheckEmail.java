package com.example.control;

import com.example.model.RegistrationModelDS;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CheckEmail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        RegistrationModelDS registrationModelDS = new RegistrationModelDS();
        boolean emailExists = registrationModelDS.checkEmail(email);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"exists\":" + emailExists + "}");
        out.flush();
    }
}
