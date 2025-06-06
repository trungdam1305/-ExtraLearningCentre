<%-- 
    Document   : advice
    Created on : 3 thg 6, 2025, 13:50:48
    Author     : vkhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tư vấn - Extra Learning Centre</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0eff5;
        }
        .advice-container { display: flex; height: 100vh; }
        .left-panel {
            flex: 1; background-color: #e1e3e8;
            display: flex; flex-direction: column;
            justify-content: center; align-items: center;
            padding: 2rem;
        }
        .right-panel {
            flex: 2; background-color: white;
            display: flex; justify-content: center; align-items: center;
        }
        .form-box {
            width: 100%; max-width: 450px;
        }
        .form-box input, .form-box textarea {
            margin-bottom: 1rem;
        }
        .btn-submit {
            width: 100%; background-color: #525a6d; color: white;
        }
        .btn-submit:hover {
            background-color: #3e4454;
        }
        .home-link {
            position: absolute;
            top: 10px; left: 10px;
            font-size: 1.2rem; color: #333;
            text-decoration: none;
        }
    </style>
</head>
<body>
<a href="HomePage.jsp" class="home-link">
    <i class="fas fa-home"></i> Trang chủ
</a>
<div class="advice-container">
    <!-- Left Panel -->
    <div class="left-panel text-center">
        <i class="fas fa-user-edit fa-4x mb-3"></i>
        <h4><strong>Đăng ký tư vấn học tập</strong></h4>
        <p class="mt-3 text-muted">Đội ngũ Extra Learning Centre sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
    </div>

    <!-- Right Panel -->
    <div class="right-panel">
        <div class="form-box">
            <h3 class="fw-bold">| Đăng ký nhận thông tin tư vấn</h3>
            <form action="AdviceServlet" method="post">
                <input type="text" name="hoTen" class="form-control" placeholder="Họ và tên" required>
                <input type="email" name="email" class="form-control" placeholder="Email liên hệ" required>
                <input type="text" name="soDienThoai" class="form-control" placeholder="Số điện thoại" required>
                <textarea name="noiDung" class="form-control" placeholder="Nội dung cần tư vấn" rows="4" required></textarea>
                <button type="submit" class="btn btn-submit">Gửi đăng ký tư vấn</button>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap Script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
