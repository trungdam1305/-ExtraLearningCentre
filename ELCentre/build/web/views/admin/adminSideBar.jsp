<%-- 
    Document   : adminSideBar
    Created on : Jul 9, 2025, 4:36:39 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome for additional icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #1F4E79;
            color: white;
            padding: 4px 8px;
            text-align: left;
            position: fixed;
            width: calc(100% - 160px);
            left: 160px;
            right: 0;
            top: 0;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header .left-title {
            font-size: 0.83rem;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
        }
        .header .left-title i {
            margin-right: 8px;
        }
        .admin-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
            position: relative;
        }
        .admin-img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 8px;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            border-radius: 5px;
            min-width: 150px;
            z-index: 1001;
        }
        .dropdown-menu a {
            display: block;
            padding: 8px 12px;
            color: #333;
            text-decoration: none;
            font-size: 0.75rem;
        }
        .dropdown-menu a:hover {
            background-color: #f1f1f1;
        }
        .footer {
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            padding: 3px 0;
            position: fixed;
            width: calc(100% - 160px);
            left: 160px;
            right: 0;
            bottom: 0;
            z-index: 1000;
        }
        .footer p {
            margin: 0;
            font-size: 0.5rem;
        }
        .sidebar {
            width: 160px;
            background-color: #1F4E79;
            color: white;
            padding: 6px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1001;
        }
        .sidebar h4 {
            margin: 0 auto;
            font-weight: bold;
            letter-spacing: 1.5px;
            text-align: center;
            font-size: 0.9rem;
        }
        .sidebar-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin: 5px auto;
            display: block;
            border: 3px solid #B0C4DE;
        }
        .sidebar-section-title {
            font-weight: bold;
            margin-top: 15px;
            font-size: 11px;
            text-transform: uppercase;
            color: #B0C4DE;
            border-bottom: 1px solid #B0C4DE;
            padding-bottom: 3px;
        }
        ul.sidebar-menu {
            list-style: none;
            padding-left: 0;
            margin: 4px 0 0 0;
        }
        ul.sidebar-menu li {
            margin: 4px 0;
        }
        ul.sidebar-menu li a {
            color: white;
            text-decoration: none;
            padding: 4px 6px;
            display: flex;
            align-items: center;
            border-radius: 5px;
            font-size: 0.75rem;
            transition: background-color 0.3s ease;
        }
        ul.sidebar-menu li a:hover {
            background-color: #163E5C;
        }
        ul.sidebar-menu li a i {
            margin-right: 5px;
        }
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                box-shadow: none;
                padding: 5px;
            }
            .header, .footer {
                width: 100%;
                margin-left: 0;
                left: 0;
                right: 0;
            }
            .sidebar h4 {
                font-size: 0.85rem;
            }
            .sidebar-logo {
                width: 50px;
                height: 50px;
                margin: 5px auto;
            }
            .sidebar-section-title {
                margin-top: 12px;
                font-size: 10px;
                padding-bottom: 3px;
            }
            ul.sidebar-menu {
                margin: 4px 0 0 0;
            }
            ul.sidebar-menu li {
                margin: 4px 0;
            }
            ul.sidebar-menu li a {
                padding: 3px 5px;
                font-size: 0.7rem;
            }
            ul.sidebar-menu li a i {
                margin-right: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="left-title">
            Admin Dashboard <i class="fas fa-tachometer-alt"></i>
        </div>
        <div class="admin-profile" onclick="toggleDropdown()">
            <%
                ArrayList<Admin> admins = (ArrayList) AdminDAO.getNameAdmin();
                if (admins != null && !admins.isEmpty()) {
            %>
                <img src="<%= admins.get(0).getAvatar() %>" alt="Admin Photo" class="admin-img">
                <span><%= admins.get(0).getHoTen() %></span>
            <% } else { %>
                <img src="https://via.placeholder.com/30" alt="Admin Photo" class="admin-img">
                <span>Admin</span>
            <% } %>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="adminDropdown">
                <a href="#"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                <a href="#"><i class="fas fa-user-edit"></i> Cập nhật thông tin</a>
            </div>
        </div>
    </div>

    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminDashboard"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý người dùng</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh"><i class="fas fa-user-graduate"></i> Học sinh</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien"><i class="fas fa-chalkboard-teacher"></i> Giáo viên</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan"><i class="fas fa-users"></i> Tài khoản</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageSchedule"><i class="fas fa-calendar-alt"></i> Lịch học</a></li>
        </ul>
        <div class="sidebar-section-title">Hệ thống</div>
        <ul class="sidebar-menu">
            <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
            <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <div class="footer">
        <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
    </div>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('adminDropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        // Đóng dropdown khi click bên ngoài
        document.addEventListener('click', function(event) {
            const dropdown = document.getElementById('adminDropdown');
            const profile = document.querySelector('.admin-profile');
            if (!profile.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
    </script>
</body>
</html>