<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.usermanagementsys.model.User" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background: linear-gradient(to right, #f8f9fa, #e9ecef);
            font-family: 'Segoe UI', sans-serif;
        }

        .toast-container {
            position: fixed;
            top: 1rem;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1055;
        }

        .profile-card {
            max-width: 550px;
            margin: auto;
            margin-top: 50px;
            padding: 30px;
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .profile-image-wrapper {
            position: relative;
            width: 160px;
            height: 160px;
            margin: 20px auto;
        }

        .preview-img {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            border: 4px solid #0d6efd;
            object-fit: cover;
            transition: 0.3s ease;
        }

        .preview-img:hover {
            filter: brightness(0.9);
        }

        .icon-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            background-color: rgba(0, 0, 0, 0.6);
            padding: 10px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 22px;
        }

        #profileImageInput {
            display: none;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-primary {
            width: 100%;
        }

        .btn-secondary {
            width: 100%;
            margin-top: 10px;
        }

        @media (max-width: 576px) {
            .profile-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<!-- Error Toast -->
<% if (error != null) { %>
<div class="toast-container">
    <div id="errorToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"><%= error %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container">
    <div class="profile-card">
        <h4 class="text-center mb-4 text-primary">Edit Your Profile</h4>

        <form action="edit_user" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= user.getId() %>">

            <div class="text-center mb-4">
                <div class="profile-image-wrapper">
                    <img id="preview" class="preview-img"
                         src="<%= user.getImageUrl() != null ? user.getImageUrl() : "https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174401.jpg" %>"
                         alt="Profile Image">
                    <div class="icon-overlay" onclick="document.getElementById('profileImageInput').click();">
                        <i class="bi bi-camera-fill"></i>
                    </div>
                </div>
                <input type="file" name="profile_image" id="profileImageInput" accept="image/*">
            </div>

            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" value="<%= user.getUsername() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Bio</label>
                <input type="text" name="bio" class="form-control" value="<%= user.getBio() != null ? user.getBio() : "" %>">
            </div>

            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<script>
    document.getElementById("profileImageInput").addEventListener("change", function (event) {
        const preview = document.getElementById("preview");
        const file = event.target.files[0];

        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>

<!-- Toast Show Logic -->
<script>
    const toastEl = document.getElementById("errorToast");
    if (toastEl) {
        new bootstrap.Toast(toastEl, { delay: 3000, autohide: true }).show();
    }
</script>

</body>
</html>
