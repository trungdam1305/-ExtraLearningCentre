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
        background-color: #f4f8fb;
        margin: 0;
        padding: 0;
    }

    .login-container {
        display: flex;
        height: 100vh;
        justify-content: center;
        align-items: center;
    }

    .right-panel {
        background-color: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        max-width: 450px;
        width: 100%;
    }

    .login-box h3 {
        color: #1F4E79;
        margin-bottom: 25px;
        border-left: 5px solid #1F4E79;
        padding-left: 10px;
    }

    .form-control {
        margin-bottom: 15px;
        height: 42px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    textarea.form-control {
        height: auto;
        resize: vertical;
    }

    .btn-login {
        width: 100%;
        background-color: #1F4E79;
        color: white;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        padding: 12px;
        transition: background-color 0.3s ease;
        font-size: 15px;
    }

    .btn-login:hover {
        background-color: #163E5C;
    }

    .alert {
        font-size: 14px;
        padding: 10px;
        border-radius: 4px;
    }

    .footer-chat {
        position: fixed;
        bottom: 0;
        right: 0;
        background-color: #1F4E79;
        color: white;
        padding: 10px 18px;
        font-size: 14px;
        border-top-left-radius: 10px;
        box-shadow: 0 -2px 6px rgba(0,0,0,0.15);
    }

    @media (max-width: 576px) {
        .right-panel {
            padding: 20px;
        }
    }
    
    .background-decor {
    position: relative;
    background: linear-gradient(135deg, #1F4E79 0%, #3a6b9e 100%);
    min-height: 100vh;
    overflow: hidden;
}

/* Các vòng tròn bóng nước */
.background-decor::before,
.background-decor::after {
    content: "";
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.05);
    z-index: 0;
}

/* Vòng tròn trên bên trái */
.background-decor::before {
    width: 400px;
    height: 400px;
    top: -100px;
    left: -100px;
}

/* Vòng tròn dưới bên phải */
.background-decor::after {
    width: 300px;
    height: 300px;
    bottom: -80px;
    right: -80px;
}
</style>

    </head>

    <body>
        <div class="background-decor">
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
        </div>                
                        
        <div class="footer-chat">
            Chat với Extra Learning Centre
        </div>
    </body>
</html>