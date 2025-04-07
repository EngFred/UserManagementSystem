package com.usermanagementsys.controller;


import com.usermanagementsys.service.UserService;

import javax.servlet.http.*;
import java.io.IOException;


public class DeleteUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        // Delete user
        boolean result = userService.deleteUser(userId);

        // Invalidate session if current user deleted their own account
        if (result) {
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
}

