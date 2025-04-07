package com.usermanagementsys.controller;

import com.usermanagementsys.model.User;
import com.usermanagementsys.service.UserService;
import com.usermanagementsys.util.MailUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

public class ForgotPasswordServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        User user = userService.findByEmail(email);

        if (user == null) {
            request.setAttribute("error", "No user found with that email.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate temporary password
        String tempPassword = UUID.randomUUID().toString().substring(0, 8);

        // Send email
        boolean result = MailUtil.sendTemporaryPassword(email, tempPassword);

        if ( result ) {
            HttpSession session = request.getSession();
            session.setAttribute("tempPassword", tempPassword);
            session.setAttribute("email", email);
            session.setAttribute("userId", user.getId()); //this is needed in the reset-password-screen
            request.setAttribute("tempPasswordSent", true);
            request.setAttribute("message", "A temporary password was sent to " + user.getEmail());
        } else {
            request.setAttribute("error", "Unable to send temporary password. Please try again");
        }
        request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
    }
}

