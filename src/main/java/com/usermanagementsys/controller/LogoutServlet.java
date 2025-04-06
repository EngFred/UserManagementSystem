package com.usermanagementsys.controller;

import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false); // Avoid creating new one
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}
