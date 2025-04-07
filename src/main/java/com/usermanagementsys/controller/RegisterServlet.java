package com.usermanagementsys.controller;

import com.usermanagementsys.model.User;
import com.usermanagementsys.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String bio = request.getParameter("bio");

        // Basic validation
        if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User(username, email, password, bio, null);

        boolean result = userService.registerUser(user);

        if(result) {
            response.sendRedirect("login.jsp?success=1");
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

    }
}

