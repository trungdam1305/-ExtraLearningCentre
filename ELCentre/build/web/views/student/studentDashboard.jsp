<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang học sinh</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        .sidebar {
            width: 80px;
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
        }

        .sidebar .logo img {
            width: 40px;
            margin-bottom: 30px;
        }

        .nav li {
            list-style: none;
            margin: 20px 0;
        }

        .nav li a img {
            width: 24px;
            display: block;
        }

        .nav li.active {
            border-left: 4px solid #000;
            background-color: #ddd;
        }

        .main-content {
            flex: 1;
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .account {
            position: relative;
            display: inline-block;
        }

        .account-name {
            cursor: pointer;
            font-weight: bold;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #fff;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 4px;
            overflow: hidden;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown-content.show {
            display: block;
        }

        .class-list {
            display: flex;
            gap: 40px;
            margin-top: 30px;
        }

        .class-card {
            width: 180px;
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }

        .image-placeholder {
            height: 100px;
            background-color: #ddd;
            border-radius: 4px;
            margin-bottom: 15px;
        }

        .class-info h3 {
            margin: 10px 0 5px;
        }

        .stars {
            margin-top: 10px;
            font-size: 14px;
            color: #ffaa00;
        }
    </style>
    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById("accountDropdown");
            dropdown.classList.toggle("show");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.account-name')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    dropdowns[i].classList.remove('show');
                }
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <img src="images/logo.png" alt="Logo" />
            </div>
            <ul class="nav">
                <li class="active"><a href="studentDashboard.jsp" title="Lớp học"><img src="images/icon-classes.png" alt="Lớp học"></a></li>
                <li><a href="tuition.jsp" title="Học phí"><img src="images/icon-payment.png" alt="Thanh toán"></a></li>
                <li><a href="classmates.jsp" title="Bạn học"><img src="images/icon-users.png" alt="Người dùng"></a></li>
                <li><a href="report.jsp" title="Báo cáo"><img src="images/icon-report.png" alt="Báo cáo"></a></li>
                <li><a href="settings.jsp" title="Cài đặt"><img src="images/icon-setting.png" alt="Cài đặt"></a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h2>Lớp học đang tham gia</h2>
                <div class="account">
                    <span class="account-name" onclick="toggleDropdown()">Xin chào &#9662;</span>
                    <div class="dropdown-content" id="accountDropdown">
                        <a href="editProfile.jsp">Chỉnh sửa hồ sơ</a>
                        <a href="changePassword.jsp">Đổi mật khẩu</a>
                        <a href="logout">Đăng xuất</a>
                    </div>
                </div>
            </div>

            <div class="class-list">
                <div class="class-card">
                    <div class="image-placeholder"></div>
                    <div class="class-info">
                        <h3>Toán 9</h3>
                        <p>Giáo viên</p>
                        <p>Status</p>
                        <div class="stars">★★★★☆</div>
                    </div>
                </div>

                <div class="class-card">
                    <div class="image-placeholder"></div>
                    <div class="class-info">
                        <h3>Văn 10</h3>
                        <p>Giáo viên</p>
                        <p>Status</p>
                        <div class="stars">★★★★☆</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
