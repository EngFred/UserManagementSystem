<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<%

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.

    String error = (String) request.getAttribute("error");
    String success = request.getParameter("success");
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

<!-- Error Toast -->
<% if (error != null) { %>
<div class="toast-container">
    <div id="loginToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"><%= error %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<!-- Success Toast -->
<% if ("1".equals(success)) { %>
<div class="toast-container">
    <div id="successToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                Registration successful! Please log in.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<!-- Success Toast -->
<% if (message != null) { %>
<div class="toast-container">
    <div id="successToast" class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <%= message %>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 card p-4 shadow rounded">
            <h3 class="mb-4 text-center">Login</h3>

            <form action="login" method="post">
                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required />
                </div>

                <button id="loginBtn" type="submit" class="btn btn-primary w-100">
                    <span id="loginText">Login</span>
                    <span id="spinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                </button>
            </form>

            <div class="mt-3 text-center">
                Don't have an account? <a href="register.jsp">Register here</a>
            </div>

            <div class="mt-3 text-center">
                <a href="forgot-password.jsp">Forgot Password?</a>
            </div>

        </div>
    </div>
</div>

<!-- Spinner Logic -->
<script>
    const form = document.querySelector("form");
    const loginBtn = document.getElementById("loginBtn");
    const loginText = document.getElementById("loginText");
    const spinner = document.getElementById("spinner");

    form.addEventListener("submit", function () {
        loginBtn.disabled = true;
        loginText.classList.add("d-none");
        spinner.classList.remove("d-none");
        document.querySelectorAll("a, button").forEach(el => el.disabled = true);
    });
</script>

<!-- Toast Show Logic -->
<script>
    const toastEl = document.getElementById("loginToast");
    if (toastEl) {
        new bootstrap.Toast(toastEl, { delay: 3000, autohide: true }).show();
    }

    const successToast = document.getElementById("successToast");
    if (successToast) {
        new bootstrap.Toast(successToast, { delay: 3000, autohide: true }).show();
    }
</script>

</body>
</html>