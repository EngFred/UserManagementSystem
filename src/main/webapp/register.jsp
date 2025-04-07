<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Bundle JS (includes Toast functionality) -->
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

<!-- Toast Container for Login Error -->
<% if (error != null) { %>
<div class="toast-container">
    <div id="registerToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body">
                <%= error %>
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 card p-4 shadow rounded">
            <h3 class="mb-4 text-center">Create an Account</h3>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="register" method="post">
                <div class="mb-3">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label>Bio</label>
                    <textarea name="bio" class="form-control"></textarea>
                </div>

                <button id="registerBtn" type="submit" class="btn btn-primary w-100">
                     <span id="registerText">Register</span>
                     <span id="spinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                </button>
            </form>
            <div class="mt-3 text-center">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>
</div>

<script>
    const form = document.querySelector("form");
    const registerBtn = document.getElementById("registerBtn");
    const registerText = document.getElementById("registerText");
    const spinner = document.getElementById("spinner");

    form.addEventListener("submit", function () {
        registerBtn.disabled = true;
        registerText.classList.add("d-none");
        spinner.classList.remove("d-none");

        document.querySelectorAll("a, button").forEach(el => el.disabled = true);
    });
</script>

<script>
    const toastEl = document.getElementById("registerToast");
    if (toastEl) {
        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();
    }
</script>

</body>
</html>
