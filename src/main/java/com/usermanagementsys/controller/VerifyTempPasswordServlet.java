package com.usermanagementsys.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class VerifyTempPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tempInput = request.getParameter("tempPasswordInput");
        HttpSession session = request.getSession();
        String actualTemp = (String) session.getAttribute("tempPassword");
        String email = (String) session.getAttribute("email");

        if (tempInput != null && tempInput.equals(actualTemp)) {
            response.sendRedirect("reset-password.jsp");
        } else {
            // Temp password does not match
            request.setAttribute("error", "Temporary password is incorrect. Please try again.");
            request.setAttribute("tempPasswordSent", true); // To show the second form again
            request.setAttribute("email", email); // to refill the email input
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}
