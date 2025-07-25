<%-- 
    Document   : staffSendTBAOHocPhiChoPHHS
    Created on : Jul 23, 2025, 9:55:15 PM
    Author     : wrx_Chur04
--%>




<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Dashboard - EL CENTRE</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                min-height: 100vh;
                background-color: #f9f9f9;
            }
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 10px 20px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                position: fixed;
                width: calc(100% - 250px);
                margin-left: 250px;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .header .left-title {
                font-size: 24px;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
            }
            .header .left-title i {
                margin-left: 10px;
            }
            .admin-profile {
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center;
                cursor: pointer;
                margin-left: 50px;
            }
            .admin-profile .admin-img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #B0C4DE;
                margin-bottom: 5px;
            }
            .admin-profile span {
                font-size: 16px;
                color: #B0C4DE;
                font-weight: 600;
                max-width: 250px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                margin-right: 40px;
            }
            .admin-profile i {
                color: #B0C4DE;
                margin-left: 10px;
            }
            .dropdown-menu {
                display: none;
                position: absolute;
                top: 50px;
                right: 0;
                background: #163E5C;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                min-width: 150px;
                z-index: 1001;
            }
            .dropdown-menu.active {
                display: block;
            }
            .dropdown-menu a {
                display: block;
                padding: 10px 15px;
                color: white;
                text-decoration: none;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }
            .dropdown-menu a:hover {
                background-color: #1F4E79;
            }
            .dropdown-menu a i {
                margin-right: 8px;
            }
            .sidebar {
                width: 250px;
                background-color: #1F4E79;
                color: white;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                height: 100vh;
                position: fixed;
                overflow-y: auto;
            }
            .sidebar h4 {
                margin: 0 auto;
                font-weight: bold;
                letter-spacing: 1.5px;
                text-align: center;
            }
            .sidebar-logo {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                margin: 15px auto;
                display: block;
                border: 3px solid #B0C4DE;
            }
            .sidebar-section-title {
                font-weight: bold;
                margin-top: 30px;
                font-size: 14px;
                text-transform: uppercase;
                color: #B0C4DE;
                border-bottom: 1px solid #B0C4DE;
                padding-bottom: 5px;
            }
            ul.sidebar-menu {
                list-style: none;
                padding-left: 0;
                margin: 10px 0 0 0;
            }
            ul.sidebar-menu li {
                margin: 10px 0;
            }
            ul.sidebar-menu li a {
                color: white;
                text-decoration: none;
                padding: 8px 12px;
                display: flex;
                align-items: center;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
            ul.sidebar-menu li a:hover {
                background-color: #163E5C;
            }
            ul.sidebar-menu li a i {
                margin-right: 10px;
            }
            .main-content {
                margin-left: 250px;
                padding: 100px 40px 20px 40px;
                flex: 1;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                gap: 30px;
                background-color: #f4f6f8;
            }
            .footer {
                background-color: #1F4E79;
                color: #B0C4DE;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                width: calc(100% - 250px);
                bottom: 0;
                margin-left: 250px;
                box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
            }
            .footer p {
                margin: 0;
                font-size: 14px;
            }
            /* Notification Container */
            .notification-container {
                background: linear-gradient(to bottom right, #ffffff, #f7fafd);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                margin-bottom: 20px;
                max-width: 800px;
                margin-left: auto;
                margin-right: auto;
            }
            .notification-container h2 {
                font-size: 22px;
                color: #1F4E79;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
                border-left: 5px solid #1F4E79;
                padding-left: 12px;
                margin-bottom: 20px;
            }
            .notification-container form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            .notification-container label {
                font-size: 14px;
                color: #1F4E79;
                font-weight: 600;
                margin-bottom: 5px;
            }
            .notification-container textarea {
                width: 100%;
                height: 150px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                font-family: Arial, sans-serif;
                resize: vertical;
                outline: none;
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
            }
            .notification-container textarea:focus {
                border-color: #1F4E79;
                box-shadow: 0 0 5px rgba(31, 78, 121, 0.3);
            }
            .notification-container button {
                background-color: #4CAF50;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                align-self: flex-start;
            }
            .notification-container button:hover {
                background-color: #388e3c;
            }
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                background-color: #1F4E79;
                color: #fff;
                padding: 8px 14px;
                border-radius: 6px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s ease;
                font-weight: 600;
                margin-top: 20px;
                align-self: center;
            }
            .back-link:hover {
                background-color: #163E5C;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="left-title">
                Staff Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <c:forEach var="staff" items="${staffs}">
                    <img src="${staff.getAvatar()}" alt="Staff Photo" class="admin-img">
                    <span>${staff.getHoTen()}</span>
                </c:forEach>
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
                <li><a href="${pageContext.request.contextPath}/staffGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/Staff_ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageTimeTable"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageAttendance"><i class="fas fa-check-square"></i> Điểm danh</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý tài chính</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGoToTuition"><i class="fas fa-money-check-alt"></i> Học phí</a></li>
            </ul>
            <div class="sidebar-section-title">Hỗ trợ</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-envelope-open-text"></i> Yêu cầu hỗ trợ</a></li>
                <li><a href="${pageContext.request.contextPath}/staffGetConsultationRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
                <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-envelope-open-text"></i> Tài Liệu</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="notification-container">
                <h2><i class="fas fa-paper-plane"></i> Soạn nội dung thông báo học phí</h2>

                <form action="staffActionWithTuition" method="post">
                    <!-- Hidden inputs to submit correct data -->
                    <input type="hidden" name="ID_TKHocSinh" value="${ID_TKHocSinh}" />
                    <input type="hidden" name="ID_TKPhuHuynh" value="${ID_TKPhuHuynh}" />
                    <input type="hidden" name="soTienDong" value="${soTienDong}" />
                    <input type="hidden" name="thang" value="${thang}" />
                    <input type="hidden" name="nam" value="${nam}" />
                    <input type="hidden" name="TenHocSinh" value="${TenHocSinh}" />
                    <input type="hidden" name="TenLopHoc" value="${TenLopHoc}" />

                    <!-- Nội dung gửi phụ huynh -->
                    <label for="contentPH">Nội dung gửi phụ huynh:</label>
                    <textarea name="contentPH" id="contentPH">
Kính gửi quý phụ huynh,

Trung tâm Anh ngữ ELCENTRE xin thông báo học phí của học sinh ${TenHocSinh} – lớp ${sessionScope.tenlop} cho tháng ${thang}/${nam} như sau:

Số tiền cần đóng: ${soTienDong} VNĐ

Quý phụ huynh vui lòng hoàn tất học phí đúng hạn để đảm bảo quá trình học tập của học sinh diễn ra thuận lợi.

Trân trọng cảm ơn quý phụ huynh đã đồng hành cùng ELCENTRE!
                    </textarea>

                    <!-- Nội dung gửi học sinh -->
                    <label for="contentHS">Nội dung gửi học sinh:</label>
                    <textarea name="contentHS" id="contentHS">
Chào em ${TenHocSinh},

Đây là thông báo học phí tháng ${thang}/${nam} của em tại lớp ${sessionScope.tenlop}. Số tiền: ${soTienDong} VNĐ.

Chúc em học tập tốt và đạt kết quả cao nhé!

– ELCENTRE –
                    </textarea>

                    <button type="submit">Gửi thông báo</button>
                </form>

                <a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi" class="back-link">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách lớp
                </a>
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