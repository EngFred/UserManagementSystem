<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermanagementsys.model.User" %>
<%@ page import="com.usermanagementsys.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserService userService = new UserService();
    List<User> users = userService.getAllUsers(currentUser.getId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard | User Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome, <%= currentUser.getUsername() %></h2>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">Logout</a>
    </div>

    <div class="card p-3 mb-4">
        <h5>Your Info</h5>
        <p><strong>Email:</strong> <%= currentUser.getEmail() %></p>
        <p><strong>Joined:</strong> <%= currentUser.getJoinDate() %></p>
    </div>

    <div class="card p-3">
        <h5>Other Users in the System</h5>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Joined</th>
            </tr>
            </thead>
            <tbody>
            <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getJoinDate() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
