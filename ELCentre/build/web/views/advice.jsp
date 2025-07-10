<%-- 
    Document   : advice
    Created on : 5 thg 6, 2025, 14:23:19
    Author     : vkhan
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="google-signin-client_id" content="495483511522-0e0jq9n40fkng5gpaogj1gifh9a8e7eu.apps.googleusercontent.com">
        <title>Đăng ký nhận tư vấn </title>

        <!-- Bootstrap & FontAwesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Google Identity -->
        <script src="https://accounts.google.com/gsi/client" async defer></script>

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0eff5;
            }
            .login-container { display: flex; height: 100vh; }
            .right-panel {
                flex: 2; background-color: white;
                display: flex; justify-content: center; align-items: center;
            }
            .login-box {
                width: 100%; max-width: 400px;
            }
            .login-box input { margin-bottom: 1rem; }
            .btn-login {
                width: 100%; background-color: #525a6d; color: white;
            }
            .btn-dark {
                background-color: #1877F2;
                color: white;
            }
            .btn-secondary {
                background-color: #DB4437;
                color: white;
            }
            .btn-login:hover {
                background-color: #1877F2; /* Màu xanh Facebook */
                color: white;
            }
            .footer-chat {
                position: fixed; bottom: 0; right: 0;
                background-color: #1877F2; color: white;
                padding: 8px 16px; border-top-left-radius: 8px;
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <!-- Right Panel -->
            <div class="right-panel">
                <div class="login-box">
                    <h3 class="fw-bold">|Đăng ký nhận tư vấn ngay</h3>
                    <br>

                    <% String error = request.getParameter("error");
                       if (error != null) { %>
                        <div class="alert alert-danger"><%= error %></div>
                    <% } %>
                    
                    <!-- Gọi tới Advice Servlet --> 
                    <form action="<%= request.getContextPath() %>/Advice" method="post">
                        <!-- Input Họ và tên -->
                        <input type="text" name="fullName" class="form-control" placeholder="Họ và tên" required>
                        
                        <!-- Input Email -->
                        <input type="text" name="email" class="form-control" placeholder="Email" required>
                        
                        <!-- Input Số điện thoại -->
                        <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" required>
                        
                        <!-- Input Nội dung cần tư vấn -->
                        <textarea name="NoiDung" class="form-control" placeholder="Vui lòng nhập nội dung cần tư vấn" rows="4" required></textarea>
                        <br>
                        <button type="submit" name="action" value="advice" class="btn btn-login">Gửi yêu cầu</button>
                    </form>
                </div>
            </div>
        </div>
                        
        <div class="footer-chat">
            Chat với Extra Learning Centre
        </div>
    </body>
</html>