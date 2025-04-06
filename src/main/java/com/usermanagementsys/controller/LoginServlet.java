package com.usermanagementsys.controller;

import com.usermanagementsys.model.User;
import com.usermanagementsys.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");

        User result = userService.loginUser(email, password);

        if(result != null) {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("user", result);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

