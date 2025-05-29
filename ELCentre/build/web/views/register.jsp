<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Register - Extra Learning Center</title>
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
        .btn-register {
            width: 100%;
            background-color: #1877F2;
            color: white;
        }
        .btn-register:hover {
            background-color: #2e3547;
        }
        .btn-social {
            width: 48%;
        }
        .btn-login {
            background-color: #1877F2; /* Màu xanh Facebook */
            color: white;
        }

        .btn-dark {
            background-color: #1877F2; /* Màu xanh Facebook */
            color: white;
        }

        .btn-secondary {
            background-color: #DB4437; /* Màu đỏ Google */
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
<div class="register-container">
    <!-- Left Panel -->
    <div class="left-panel text-center">
        <i class="fas fa-user-circle fa-4x mb-3"></i>
        <h4><strong>Extra Learning Center</strong></h4>
        <div class="bg-light p-4 rounded mt-4" style="width: 80%;">
            <label>Label 1</label>
            <div style="width: 100%; height: 60px; background-color: #ccc;" class="my-2"></div>
            <label>Label 2</label>
        </div>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
        <div class="register-box">
            <h3 class="fw-bold">|Đăng kí ngay</h3>
            <p class="small">Đã có tài khoản? <a href="login.jsp">Nhấn vào đây để đăng nhập</a></p>

            <% String error = request.getParameter("error");
               if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
                <input type="text" name="fullname" class="form-control" placeholder="Họ và tên" >
                <input type="email" name="email" class="form-control" placeholder="Email" >
                <input type="password" name="password" class="form-control" placeholder="Mật khẩu" >
                <input type="password" name="confirm" class="form-control" placeholder="Xác nhận mật khẩu" >
                <select name="vaitro" class="form-control" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="2">Staff</option>
                    <option value="3">Giáo viên</option>
                    <option value="4">Học sinh</option>
                    <option value="5">Phụ huynh</option>
                </select>


                <button type="submit" name="action" value="register" class="btn btn-register mt-2">Đăng kí</button>
            </form>

            <div class="text-center mt-4">
                <p class="small">Đăng kí với tài khoản mạng xã hội</p>
                <div class="d-flex justify-content-between">
                    <button class="btn btn-dark btn-social">
                        <i class="fab fa-facebook-f"></i> Facebook
                    </button>
                    <button class="btn btn-danger btn-social">
                        <i class="fab fa-google"></i> Google+
                    </button>
                </div>
            </div>

            <div class="footer-chat">
                Chat với Extra Learning Centre
            </div>
        </div>
    </div>
</div>
</body>
</html>
