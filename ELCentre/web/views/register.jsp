<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - Extra Learning Centre</title>
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
            max-width: 450px;
        }
        .register-box input, .register-box select {
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
        <i class="fas fa-user-circle fa-4x mb-3"></i>
        <h4><strong>Extra Learning Centre</strong></h4>
        <div class="bg-light p-4 rounded mt-4" style="width: 80%;">
            <label>Chào mừng bạn đến với hệ thống</label>
            <div style="width: 100%; height: 60px; background-color: #ccc;" class="my-2"></div>
            <label>Hãy hoàn tất đăng ký bên phải</label>
        </div>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
        <div class="register-box">
            <h3 class="fw-bold">| Đăng ký tài khoản học viên</h3>
            <p class="small">Đã có tài khoản? <a href="login.jsp">Nhấn vào đây để đăng nhập</a></p>

            <% String error = request.getParameter("error");
               String emailParam = request.getParameter("email");
               if (error != null) { %>
                <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
                <!-- Thông tin tài khoản -->
                <input type="text" name="fullname" class="form-control" placeholder="Họ và tên" required>

                <input type="email" name="email" class="form-control" placeholder="Email" required>

                <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" required>

                <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>

                <input type="password" name="confirm" class="form-control" placeholder="Xác nhận mật khẩu" required>

                <select name="vaitro" class="form-control" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="3">Giáo viên</option>
                    <option value="4">Học sinh</option>
                    <option value="5">Phụ huynh</option>
                </select>

                <!-- Thông tin riêng cho học sinh -->
                <select name="gender" class="form-control" required>
                    <option value="">-- Giới tính --</option>
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                </select>

                <input type="date" name="dob" class="form-control" placeholder="Ngày sinh" required>

                <input type="text" name="address" class="form-control" placeholder="Địa chỉ" required>

                <button type="submit" name="action" value="register" class="btn btn-register mt-2">Đăng ký</button>
            </form>

            <div class="footer-chat">Chat với Extra Learning Centre</div>
        </div>
    </div>
</div>
</body>
</html>
