<%-- 
    Document   : staffReceiveHoTroCuaMinh
    Created on : Jul 24, 2025, 4:23:32 PM
    Author     : wrx_Chur04
--%>
<%--
    Document   : staffReceiveHoTroCuaMinh
    Created on : Jul 24, 2025, 4:23:16 PM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Yêu Cầu Hỗ Trợ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
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
            margin-left: 270px;
            padding: 150px 50px 100px 50px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 40px;
            width: calc(100% - 270px);
            background: linear-gradient(to bottom right, #ffffff, #f7fafd);
            border-radius: 16px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }
        .data-table-container {
            background: linear-gradient(to bottom right, #ffffff, #f7fafd);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.08);
            transition: transform 0.2s;
            max-width: 1200px;
            margin: 0 auto;
        }
        .data-table-container:hover {
            transform: translateY(-3px);
        }
        h3.section-title {
            font-size: 24px;
            color: #1F4E79;
            font-weight: 600;
            border-left: 6px solid #1F4E79;
            padding-left: 15px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        h3.section-title i {
            color: #1F4E79;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
        }
        table th, table td {
            border: 1px solid #e0e0e0;
            padding: 18px 20px;
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
            padding: 30px;
            font-size: 20px;
            font-style: italic;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        #searchSupportInput {
            padding: 12px 18px;
            width: 100%;
            max-width: 500px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            outline: none;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
        }
        .btn-action {
            display: inline-flex;
            align-items: center;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
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

    <div class="header">
        <div class="left-title">
            Danh sách yêu cầu hỗ trợ đã gửi <i class="fas fa-envelope-open-text"></i> 
        </div>
        <div class="admin-profile" onclick="toggleDropdown()">
            <img src="${pageContext.request.contextPath}/img/${gv.getAvatar()}" alt="Admin Photo" class="admin-img">
            <span>${user.getEmail()}</span>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="teacherDropdown">
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
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <div class="main-content">
        <h1><i class="fas fa-envelope-open-text"></i> Danh Sách Yêu Cầu Hỗ Trợ</h1>
        <div class="data-table-container">
            <h3 class="section-title"><i class="fas fa-envelope-open-text"></i> Yêu Cầu Hỗ Trợ Đã Gửi</h3>
            <c:choose>
                <c:when test="${not empty hotros}">
                    <table>
                        <thead>
                            <tr>
                                <th>Tiêu đề</th>
                                <th>Mô tả</th>
                                <th>Ngày gửi</th>
                                <th>Trạng thái</th>
                                <th>Phản hồi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="hotro" items="${hotros}">
                                <tr>
                                    <td>${hotro.getTenHoTro()}</td>
                                    <td>${hotro.getMoTa()}</td>
                                    <td>${hotro.getThoiGian()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${hotro.getDaDuyet() == 'Đã duyệt'}">
                                                <span class="status-approved">${hotro.getDaDuyet()}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-pending">${hotro.getDaDuyet()}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${hotro.getPhanHoi()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="no-data">${message}</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("teacherDropdown").classList.toggle("active");
        }
    </script>
</body>
</html>