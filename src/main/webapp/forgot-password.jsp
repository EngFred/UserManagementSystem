<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    Boolean tempPasswordSent = (Boolean) request.getAttribute("tempPasswordSent");
    String email = request.getParameter("email");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
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

<!-- Toast Notifications -->
<% if (error != null) { %>
<div class="toast-container">
    <div id="errorToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"><%= error %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } else if (message != null) { %>
<div class="toast-container">
    <div id="messageToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"><%= message %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 card p-4 shadow rounded">
            <h4 class="text-center mb-3">Forgot Password</h4>
            <p class="text-muted text-center mb-4">Enter your registered email to receive a temporary password.</p>

            <% if (tempPasswordSent == null || !tempPasswordSent) { %>
                <form action="forgot_password" method="post">
                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" value="<%= email != null ? email : "" %>" required />
                    </div>

                    <button id="fpBtn" type="submit" class="btn btn-primary w-100 mb-2">
                        <span id="fpText">Send Reset Password</span>
                        <span id="spinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                    </button>
                </form>
            <% } %>

            <% if (tempPasswordSent != null && tempPasswordSent) { %>
            <form action="verify_temp_password" method="post">
                <input type="hidden" name="email" value="<%= email %>"/>
                <div class="mb-3 mt-3">
                    <label>Enter Temporary Password</label>
                    <input type="text" name="tempPasswordInput" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-2">Reset Password</button>
            </form>
            <% } %>

            <div class="mt-3 text-center">
                <a href="login.jsp">Back to Login</a>
            </div>
        </div>
    </div>
</div>

<!-- Spinner Logic -->
<script>
    const form = document.querySelector("form");
    const forgotPasswordBtn = document.getElementById("fpBtn");
    const forgotPasswordText = document.getElementById("fpText");
    const spinner = document.getElementById("spinner");

    form.addEventListener("submit", function () {
        forgotPasswordBtn.disabled = true;
        forgotPasswordText.classList.add("d-none");
        spinner.classList.remove("d-none");
        document.querySelectorAll("a, button").forEach(el => el.disabled = true);
    });
</script>

<!-- Toast Show Script -->
<script>
    const errorToast = document.getElementById("errorToast");
    if (errorToast) {
        new bootstrap.Toast(errorToast, { delay: 3000, autohide: true }).show();
    }

    const messageToast = document.getElementById("messageToast");
    if (messageToast) {
        new bootstrap.Toast(messageToast, { delay: 3000, autohide: true }).show();
    }
</script>

</body>
</html>
