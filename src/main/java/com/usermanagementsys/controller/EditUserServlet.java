package com.usermanagementsys.controller;

import com.usermanagementsys.model.User;
import com.usermanagementsys.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.IOException;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50
)   // 50MB
public class EditUserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username").trim();
        String bio = request.getParameter("bio").trim();
        Part filePart = request.getPart("profile_image");

        if( username.isEmpty() ) {
            request.setAttribute("error", "Username is required!");
            request.getRequestDispatcher("edit-user.jsp").forward(request, response);
            return;
        }

        User updatedUser = userService.updateUser(userId, username, bio, filePart);

        if(updatedUser != null) {
            // Update session with new name if changed
            request.getSession().setAttribute("user", updatedUser);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Error updating user info.");
            request.getRequestDispatcher("edit-user.jsp").forward(request, response);
        }
    }
}

