<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.TaiKhoan" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quên mật khẩu - Extra Learning Center</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f4f4f8;
            }
            .register-container {
                display: flex;
                height: 100vh;
            }
            .left-panel {
                flex: 1;
                background-color: #eaeaea;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 2rem;
            }
            .right-panel {
                flex: 2;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: white;
            }
            .register-box {
                width: 100%;
                max-width: 400px;
            }
            .register-box input {
                margin-bottom: 1rem;
            }
            .btn-submit {
                width: 100%;
                background-color: #1877F2;
                color: white;
            }
            .btn-submit:hover {
                background-color: #2e3547;
            }
            .footer-chat {
                position: fixed;
                bottom: 0;
                right: 0;
                background-color: #1877F2;
                color: white;
                padding: 8px 16px;
                border-top-left-radius: 8px;
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <!-- Left Panel -->
            <div class="left-panel text-center">
                <i class="fas fa-lock fa-4x mb-3"></i>
                <h4><strong>Khôi phục mật khẩu</strong></h4>
                <p class="text-muted">Bạn cần nhập email để bắt đầu quá trình đặt lại mật khẩu.</p>
            </div>

            <!-- Right Panel -->
            <div class="right-panel">
                <div class="register-box">
                    <h3 class="fw-bold">| Quên mật khẩu</h3>
                    <p class="small">Trở lại <a href="login.jsp">trang đăng nhập</a></p>

                    <!-- Thông báo -->
                    <% 
                        String error = request.getParameter("error");
                        String success = request.getParameter("success");
                        if (error != null) {
                    %>
                        <div class="alert alert-danger"><%= error %></div>
                    <% } else if (success != null) { %>
                        <div class="alert alert-success"><%= success %></div>
                    <% } %>

                    <%
                        TaiKhoan foundUser = (TaiKhoan) request.getAttribute("foundUser");
                        if (foundUser == null) {
                    %>
                        <!-- Form xác minh email và số điện thoại -->
                        <form action="<%= request.getContextPath() %>/ForgotPasswordServlet" method="post">
                            <input type="email" name="email" class="form-control" placeholder="Nhập email của bạn" required>
                            <input type="text" name="phone" class="form-control" placeholder="Nhập số điện thoại đã đăng ký" required>
                            <button type="submit" name="action" value="search" class="btn btn-submit mt-2">Xác minh tài khoản</button>
                        </form>
                    <%
                        } else {
                    %>
                        <!-- Form đổi mật khẩu -->
                        <hr>
                        <h5 class="mt-4">Đặt lại mật khẩu cho: <%= foundUser.getEmail() %></h5>
                        <form action="<%= request.getContextPath() %>/ForgotPasswordServlet" method="post">
                            <input type="hidden" name="email" value="<%= foundUser.getEmail() %>">
                            <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
                            <input type="password" name="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required>
                            <button type="submit" name="action" value="reset" class="btn btn-submit mt-2">Đặt lại mật khẩu</button>
                        </form>
                    <%
                        }
                    %>




                    <div class="footer-chat">
                        Chat với Extra Learning Centre
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
