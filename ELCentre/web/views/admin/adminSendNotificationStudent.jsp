<%-- 
    Document   : adminSendNotificationStudentAndTeacher
    Created on : Jul 10, 2025, 9:07:42 AM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Gửi thông báo</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --main-color: #1F4E79;
                --hover-color: #163E5C;
                --accent-color: #B0C4DE;
                --bg-color: #f4f6f8;
                --text-color: #333;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
            }

            .header {
                background-color: var(--main-color);
                color: white;
                padding: 12px 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                left: 250px;
                right: 0;
                z-index: 1000;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s;
            }

            .header .left-title {
                font-size: 20px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .admin-profile {
                display: flex;
                align-items: center;
                position: relative;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .admin-img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                margin-right: 10px;
            }

            .admin-profile span {
                color: var(--accent-color);
                font-weight: 600;
                max-width: 180px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .admin-profile i {
                color: var(--accent-color);
                margin-left: 8px;
            }

            .dropdown-menu {
                position: absolute;
                top: 48px;
                right: 0;
                background-color: var(--hover-color);
                display: none;
                border-radius: 4px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
                min-width: 160px;
                z-index: 1001;
            }

            .dropdown-menu.active {
                display: block;
            }

            .dropdown-menu a {
                display: block;
                color: white;
                padding: 10px 15px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .dropdown-menu a:hover {
                background-color: var(--main-color);
            }

            .sidebar {
                width: 250px;
                background-color: var(--main-color);
                color: white;
                position: fixed;
                height: 100vh;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar h4 {
                text-align: center;
                font-weight: bold;
                letter-spacing: 1px;
            }

            .sidebar-logo {
                display: block;
                margin: 15px auto;
                width: 90px;
                height: 90px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                object-fit: cover;
            }

            .sidebar-section-title {
                margin-top: 25px;
                font-size: 13px;
                color: var(--accent-color);
                text-transform: uppercase;
                border-bottom: 1px solid var(--accent-color);
                padding-bottom: 5px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 10px 0;
            }

            .sidebar-menu li {
                margin: 8px 0;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                color: white;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .sidebar-menu a:hover {
                background-color: var(--hover-color);
            }

            .sidebar-menu a i {
                margin-right: 10px;
            }

            .main-content {
                margin-left: 250px;
                padding: 60px 15px 30px;
                background-color: var(--bg-color);
                min-height: 100vh;
                box-sizing: border-box;
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            .notification-container {
                background-color: #ffffff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                width: 100%;
                max-width: 1200px;
                margin: 10px 0;
            }

            .notification-container .page-header {
                justify-content: center;
                margin-bottom: 25px;
            }

            .notification-container .page-header h2 {
                font-size: 28px;
                color: var(--main-color);
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 0;
            }

            .notification-form {
                display: flex;
                flex-direction: column;
                gap: 30px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .form-group label {
                font-weight: 600;
                font-size: 16px;
                color: var(--text-color);
                margin-bottom: 12px;
            }

            .form-group textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 16px;
                resize: vertical;
                min-height: 180px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .form-group textarea:focus {
                border-color: var(--main-color);
                box-shadow: 0 0 6px rgba(31, 78, 121, 0.2);
                outline: none;
            }

            .form-group textarea::placeholder {
                color: #999;
                font-style: italic;
            }

            .notification-form button {
                align-self: flex-start;
                padding: 14px 28px;
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: background-color 0.3s, transform 0.2s;
            }

            .notification-form button:hover {
                background-color: #27ae60;
                transform: translateY(-2px);
            }

            .notification-form button:active {
                transform: translateY(0);
            }

            .notification-form button i {
                margin-right: 8px;
            }

            .back-button {
                text-align: right;
                margin-top: 20px;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                color: var(--main-color);
                font-weight: 600;
                font-size: 15px;
                transition: color 0.3s;
            }

            .back-link:hover {
                color: var(--hover-color);
            }

            .back-link i {
                font-size: 16px;
            }

            .footer {
                background-color: var(--main-color);
                color: var(--accent-color);
                text-align: center;
                padding: 10px;
                font-size: 13px;
                position: fixed;
                bottom: 0;
                left: 250px;
                right: 0;
            }

            @media (max-width: 768px) {
                .header {
                    left: 0;
                }

                .sidebar {
                    display: none;
                }

                .main-content {
                    margin-left: 0;
                    padding: 50px 10px 20px;
                }

                .notification-container {
                    padding: 15px;
                    margin: 5px;
                }

                .notification-form button {
                    align-self: stretch;
                }

                .form-group textarea {
                    min-height: 140px;
                }

                .notification-container .page-header h2 {
                    font-size: 24px;
                }
            }
        </style>
    </head>
    <body>
        <%
            ArrayList<Admin> admins = AdminDAO.getNameAdmin();
            String idtaikhoan = request.getParameter("idtaikhoan");
            String sotien = request.getParameter("sotien");
            String tenlophoc = request.getParameter("tenlophoc");
            String name = request.getParameter("name");
        %>

        <div class="header">
            <div class="left-title">
                Gửi thông báo <i class="fas fa-bell"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="<%= admins.get(0).getAvatar() %>" alt="Admin Photo" class="admin-img">
                <span><%= admins.get(0).getHoTen() %></span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="adminDropdown">
                    <a href="#"><i class="fas fa-key"></i> Change Password</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý người dùng</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
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

        <div class="main-content">
            <c:if test="${not empty message}">
                <div style="color: red; font-weight: bold; margin-bottom: 20px; text-align: center;">
                    ${message}
                </div>
            </c:if>
            <div class="notification-container">
                <div class="page-header">
                    <h2><i class="fas fa-bell"></i> Gửi thông báo đến học sinh</h2>
                </div>

                <form action="${pageContext.request.contextPath}/adminActionWithStudent" method="post" class="notification-form">
                    <input type="hidden" name="idtaikhoan" value="<%= idtaikhoan %>">
                    <input type="hidden" name="type" value="sendNotification">

                    <div class="form-group">
                        <label for="noidung">Nội dung thông báo:</label>
                        <textarea id="noidung" name="noidung" placeholder="Soạn nội dung thông báo cho học sinh...">Chào em <%= name %>,

Đây là thông báo từ EL CENTRE...

– ELCENTRE –</textarea>
                    </div>

                    <button type="submit"><i class="fas fa-paper-plane"></i> Gửi thông báo</button>
                </form>

                <div class="back-button">
                    <a href="${pageContext.request.contextPath}/views/admin/adminReceiveHocSinh.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại danh sách học sinh</a>
                </div>
            </div>
        </div>

        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by EL CENTRE</p>
        </div>

        <script>
            function toggleDropdown() {
                const dropdown = document.getElementById('adminDropdown');
                dropdown.classList.toggle('active');
            }

            document.addEventListener('click', function (event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });
        </script>
    </body>
</html>


