<%-- 
    Document   : staffRespondSupport
    Created on : Jul 17, 2025, 10:54:09 PM
    Author     : wrx_Chur04
--%>


<%-- 
    Document   : staffRespondSupport
    Created on : Jul 17, 2025, 11:01:02 PM
    Author     : wrx_Chur04
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Phản Hồi Yêu Cầu Hỗ Trợ - EL CENTRE</title>
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
                padding: 100px 40px 80px 40px;
                flex: 1;
                min-height: 100vh;
                background-color: #f4f6f8;
                display: flex;
                flex-direction: column;
                gap: 20px;
            }
            .data-container {
                background: linear-gradient(to bottom right, #ffffff, #f7fafd);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                transition: transform 0.2s;
            }
            .data-container:hover {
                transform: translateY(-3px);
            }
            h3.section-title {
                font-size: 18px;
                color: #1F4E79;
                font-weight: 600;
                border-left: 5px solid #1F4E79;
                padding-left: 12px;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            h3.section-title i {
                color: #1F4E79;
            }
            .support-details {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-bottom: 20px;
            }
            .support-details div {
                padding: 10px;
                background-color: #E3F2FD;
                border-radius: 6px;
                color: #0D47A1;
            }
            .support-details div label {
                font-weight: bold;
                margin-right: 10px;
            }
            .response-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            .response-form textarea {
                width: 100%;
                min-height: 100px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                resize: vertical;
                outline: none;
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                padding: 8px 15px;
                border-radius: 6px;
                font-size: 13px;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.3s ease;
                cursor: pointer;
                border: none;
            }
            .btn-action.accept {
                background-color: #4CAF50;
                color: #fff;
            }
            .btn-action.accept:hover {
                background-color: #388e3c;
            }
            .btn-action.reject {
                background-color: #C62828;
                color: #fff;
            }
            .btn-action.reject:hover {
                background-color: #b71c1c;
            }
            .btn-action.back {
                background-color: #1F4E79;
                color: #fff;
            }
            .btn-action.back:hover {
                background-color: #163E5C;
            }
            .btn-action i {
                margin-right: 6px;
            }
            .error-message, .success-message {
                padding: 10px;
                border-radius: 6px;
                margin-bottom: 15px;
                font-size: 14px;
                text-align: center;
            }
            .error-message {
                background-color: #FFCDD2;
                color: #C62828;
            }
            .success-message {
                background-color: #C8E6C9;
                color: #1B5E20;
            }
            .no-data {
                text-align: center;
                color: #777;
                padding: 20px;
                font-style: italic;
                background-color: #f9f9f9;
                border-radius: 6px;
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
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageTimeTable"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageAttendance"><i class="fas fa-check-square"></i> Điểm danh</a></li>
                <li><a href="#" class="btn-action upload-document"><i class="fas fa-calendar-alt"></i> Đăng tài liệu</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý tài chính</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffViewSalary"><i class="fas fa-money-check-alt"></i> Học phí</a></li>
            </ul>
            <div class="sidebar-section-title">Hỗ trợ</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-envelope-open-text"></i> Yêu cầu hỗ trợ</a></li>
                <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="data-container">
                <h3 class="section-title"><i class="fas fa-reply"></i> Phản Hồi Yêu Cầu Hỗ Trợ</h3>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty successMessage}">
                    <div class="success-message">${successMessage}</div>
                </c:if>
                <c:choose>
                    <c:when test="${not empty param.id and not empty param.tenhotro and not empty param.mota}">
                        <div class="support-details">
                            <div><label>ID Hỗ Trợ:</label> ${param.id}</div>
                            <div><label>Yêu Cầu:</label> ${param.tenhotro}</div>
                            <div><label>Mô tả:</label> ${param.mota}</div>
                        </div>
                        <form class="response-form" action="${pageContext.request.contextPath}/staffGetSupportRequests" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="action" value="submitResponse">
                            <input type="hidden" name="id" value="${param.id}">
                            <textarea name="phanHoi" placeholder="Nhập phản hồi của bạn..." required></textarea>
                            <div>
                                <button type="submit" class="btn-action accept" name="daDuyet" value="daduyet"><i class="fas fa-check-circle"></i> Chấp nhận</button>
                                <button type="submit" class="btn-action reject" name="daDuyet" value="tuchoi"><i class="fas fa-times-circle"></i> Từ chối</button>
                                <a href="${pageContext.request.contextPath}/staffGetSupportRequests" class="btn-action back"><i class="fas fa-arrow-left"></i> Quay Lại</a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Không tìm thấy yêu cầu hỗ trợ.</div>
                    </c:otherwise>
                </c:choose>
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

            function validateForm() {
                const phanHoi = document.querySelector('textarea[name="phanHoi"]').value.trim();
                if (phanHoi.length === 0) {
                    alert('Vui lòng nhập nội dung phản hồi.');
                    return false;
                }
                if (phanHoi.length > 1000) {
                    alert('Phản hồi không được vượt quá 1000 ký tự.');
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>