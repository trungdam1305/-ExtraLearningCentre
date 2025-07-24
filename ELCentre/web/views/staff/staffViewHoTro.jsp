<%-- 
    Document   : staffViewHoTro
    Created on : Jul 17, 2025, 10:09:04 PM
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
            }
            .data-table-container {
                background: linear-gradient(to bottom right, #ffffff, #f7fafd);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                transition: transform 0.2s;
            }
            .data-table-container:hover {
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
            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }
            table th, table td {
                border: 1px solid #e0e0e0;
                padding: 12px 15px;
                text-align: left;
            }
            table th {
                background-color: #E3F2FD;
                color: #0D47A1;
                font-weight: bold;
            }
            table tbody tr:hover {
                background-color: #f1f8ff;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            .no-data {
                text-align: center;
                color: #777;
                padding: 20px;
                font-style: italic;
                background-color: #f9f9f9;
                border-radius: 6px;
            }
            #searchSupportInput {
                padding: 10px 15px;
                width: 100%;
                max-width: 400px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
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
            }
            .btn-action.update {
                background-color: #4CAF50;
                color: #fff;
            }
            .btn-action.update:hover {
                background-color: #388e3c;
            }
            .btn-action.respond {
                background-color: #1F4E79;
                color: #fff;
                margin-left: 10px;
            }
            .btn-action.respond:hover {
                background-color: #163E5C;
            }
            .btn-action.create-support {
                background-color: #1F4E79;
                color: #fff;
                margin-right: 10px;
            }
            .btn-action.create-support:hover {
                background-color: #163E5C;
            }
            .btn-action.view-sent-support {
                background-color: #27ae60;
                color: #fff;
            }
            .btn-action.view-sent-support:hover {
                background-color: #219653;
            }
            .btn-action i {
                margin-right: 6px;
            }
            .status-approved {
                color: #4CAF50;
                font-weight: bold;
            }
            .status-pending {
                color: #F57F17;
                font-weight: bold;
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
                Quản lý hỗ trợ <i class="fas fa-hands-helping"></i>

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
                <li><a href="${pageContext.request.contextPath}/staffGetConsultationRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="data-table-container">
                <h3 class="section-title"><i class="fas fa-envelope-open-text"></i> Yêu Cầu Hỗ Trợ</h3>
                <div style="margin-bottom: 15px;">
                    <a href="${pageContext.request.contextPath}/views/staff/staffSendSupport.jsp" class="btn-action create-support">
                        <i class="fas fa-plus"></i> Gửi Hỗ Trợ
                    </a>
                    <a href="${pageContext.request.contextPath}/staffActionWithSupport" class="btn-action view-sent-support">
                        <i class="fas fa-paper-plane"></i> Xem Hỗ Trợ Đã Gửi
                    </a>
                </div>
                <input type="text" id="searchSupportInput" placeholder="Tìm kiếm (Họ tên, Yêu cầu, Mô tả...)" oninput="searchSupport()">
                 <c:if test="${not empty message}">
                   <div class="no-data">${message}</div>
                 </c:if>
                <c:choose>
                    <c:when test="${not empty sessionScope.HoTroList}">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID Hỗ Trợ</th>
                                    <th>Họ Tên</th>
                                    <th>Vai Trò</th>
                                    <th>Số Điện Thoại</th>
                                    <th>Yêu Cầu</th>
                                    <th>Thời Gian</th>
                                    <th>Mô Tả</th>
                                    <th>Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody id="supportTableBody">
                                <c:forEach var="sp" items="${sessionScope.HoTroList}">
                                    <tr>
                                        <td>${sp.getID_HoTro()}</td>
                                        <td>${sp.getHoTen()}</td>
                                        <td>${sp.getVaiTro()}</td>
                                        <td>${sp.getSoDienThoai()}</td>
                                        <td>${sp.getTenHoTro()}</td>
                                        <td>${sp.getThoiGian()}</td>
                                        <td>${sp.getMoTa()}</td>
                                        <td>
                                            <a class="btn-action respond" href="${pageContext.request.contextPath}/views/staff/staffRespondSupport.jsp?action=respond&id=${sp.getID_HoTro()}&tenhotro=${sp.getTenHoTro()}&mota=${sp.getMoTa()}">
                                                <i class="fas fa-reply"></i> Phản hồi
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">Không có yêu cầu hỗ trợ nào.</div>
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

            document.addEventListener('click', function(event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });

            function searchSupport() {
                const searchInput = document.getElementById('searchSupportInput').value.toLowerCase();
                const supportRows = document.querySelectorAll('#supportTableBody tr');

                supportRows.forEach(row => {
                    const hoTen = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                    const tenHoTro = row.querySelector('td:nth-child(5)').textContent.toLowerCase();
                    const moTa = row.querySelector('td:nth-child(7)').textContent.toLowerCase();
                    if (hoTen.includes(searchInput) || tenHoTro.includes(searchInput) || moTa.includes(searchInput)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        </script>
    </body>
</html>