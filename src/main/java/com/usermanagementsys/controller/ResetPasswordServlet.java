package com.usermanagementsys.controller;

import com.usermanagementsys.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ResetPasswordServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        String newPassword = request.getParameter("newPassword");

        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Invalid input.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        // Update password in DB
        boolean updated = userService.updatePassword(userId, newPassword);

        if (updated) {
            // Redirect to log in with success message
            session.setAttribute("message", "Password updated successfully. You can now log in.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}
