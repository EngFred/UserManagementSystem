<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
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
    <div id="errorToast" class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body"><%= error %></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<% } %>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 card p-4 shadow rounded">
            <h3 class="mb-4 text-center">Reset Password</h3>
            <form action="reset_password" method="post">
                <div class="mb-3">
                    <label>New Password</label>
                    <input type="password" name="newPassword" class="form-control" required />
                </div>
                <button id="rpBtn" type="submit" class="btn btn-primary w-100 mb-2">
                        <span id="rpText">Update Password</span>
                        <span id="spinner" class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                </button>
            </form>
        </div>
    </div>
</div>

<!-- Spinner Logic -->
<script>
    const form = document.querySelector("form");
    const resetPasswordBtn = document.getElementById("rpBtn");
    const resetPasswordText = document.getElementById("rpText");
    const spinner = document.getElementById("spinner");

    form.addEventListener("submit", function () {
        resetPasswordBtn.disabled = true;
        resetPasswordText.classList.add("d-none");
        spinner.classList.remove("d-none");
        document.querySelectorAll("a, button").forEach(el => el.disabled = true);
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
