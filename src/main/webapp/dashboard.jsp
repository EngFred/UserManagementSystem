<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.usermanagementsys.model.User" %>
<%@ page import="com.usermanagementsys.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.usermanagementsys.util.DateUtils" %>
<%@ page session="true" %>

<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserService userService = new UserService();
    List<User> users = userService.getAllUsers(currentUser.getId());

    String defaultProfileImage = "https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174401.jpghttps://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174401.jpg";
    String success = (String) session.getAttribute("success");
    if (success != null) session.removeAttribute("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard | User Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .profile-img,
        .profile-img-small {
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #0d6efd;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        .profile-img {
            width: 100px;
            height: 100px;
        }

        .profile-img-small {
            width: 40px;
            height: 40px;
        }

        .action-buttons a {
            margin-right: 10px;
        }

        .toast-container {
            position: fixed;
            top: 1rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1055;
        }
    </style>
</head>
<body class="bg-light">

<% if (success != null) { %>
<div class="toast-container">
    <div class="toast align-items-center text-bg-success border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <%= success %>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Welcome, <%= currentUser.getUsername() %></h2>
        <a href="logout" class="btn btn-danger">Logout</a>
    </div>

    <div class="card p-4 mb-4">
        <div class="d-flex align-items-center">
            <img src="<%= currentUser.getImageUrl() != null ? currentUser.getImageUrl() : defaultProfileImage %>" alt="Profile Image" class="profile-img me-4">
            <div>
                <h5 class="mb-1">Your Info</h5>
                <p class="mb-1"><strong>Email:</strong> <%= currentUser.getEmail() %></p>
                <p class="mb-1"><strong>Joined:</strong> <%= DateUtils.formatCurrentUserDate(currentUser.getJoinDate()) %></p>
                <p class="mb-3 text-muted">
                    <%= (currentUser.getBio() != null && !currentUser.getBio().trim().isEmpty())
                        ? currentUser.getBio()
                        : "No bio added yet." %>
                </p>
                <div class="action-buttons">
                    <a href="edit-user.jsp?id=<%= currentUser.getId() %>" class="btn btn-outline-primary btn-sm">Edit Profile</a>
                    <button class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">
                        Delete Profile
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="card p-4">
        <h5 class="mb-3">Other Users in the System</h5>
        <table class="table table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th>Profile</th>
                <th>Name</th>
                <th>Email</th>
                <th>Joined</th>
            </tr>
            </thead>
            <tbody>
            <% for (User user : users) { %>
                <tr>
                    <td>
                        <img src="<%= user.getImageUrl() != null ? user.getImageUrl() : defaultProfileImage %>" alt="Profile Image" class="profile-img-small">
                    </td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= DateUtils.formatOtherUserDate(user.getJoinDate()) %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-danger">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete your account? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a href="delete_user?id=<%= currentUser.getId() %>" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>


<script>
    const toastEl = document.querySelector('.toast');
    if (toastEl) {
        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();
    }
</script>
</body>
</html>
