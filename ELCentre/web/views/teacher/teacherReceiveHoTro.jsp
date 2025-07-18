<%-- 
    Document   : teacherReceiveHoTro
    Created on : Jul 17, 2025, 4:45:39 PM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Yêu Cầu Hỗ Trợ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <style>
        h1 {
            margin-top: 30px;
            color: #1F4E79; 
            text-align: center; 
            font-size: 32px; 
            font-weight: bold;
        }
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
            padding: 5px 20px;
            text-align: left;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: fixed;
            width: calc(100% - 250px);
            margin-left: 250px;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 20px;
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

        .teacher-profile {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center; 
            cursor: pointer;
            margin-left: 20px; 
            margin-right: 100px; 
        }

        .teacher-profile .teacher-img {
            width: 40px;
            height: 40px;
            border-radius: 50%; 
            object-fit: cover;
            border: 2px solid #B0C4DE;
            margin-bottom: 5px;
        }

        .teacher-profile span {
            font-size: 14px;
            color: #B0C4DE;
            font-weight: 600;
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .teacher-profile i {
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
            width: 230px; 
        }

        .sidebar-logo {
            width: 60px;
            height: 60px;
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
            font-size: 14px;
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
            margin-left: 260px;
            padding: 120px 20px 40px 20px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 20px;
            width: calc(100% - 260px);
            background: linear-gradient(135deg, #ffffff, #f0f4f8);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .notification-box {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            width: 80%;
            margin: 0 auto;
        }

        .notification-item {
            background-color: #f9f9f9;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 8px;
            border-left: 5px solid #1F4E79;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            width: 97%;
        }

        .notification-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        .notification-item h3 {
            margin: 0 0 15px;
            color: #1F4E79;
            font-size: 22px;
            font-weight: 700;
        }

        .notification-item p {
            margin: 10px 0;
            color: #333;
            font-size: 18px;
            line-height: 1.6;
        }

        .notification-item p strong {
            color: #1F4E79;
            font-weight: 600;
        }

        .notification-time {
            font-size: 16px;
            color: #6c757d;
            text-align: right;
            margin-top: 15px;
            font-style: italic;
        }

        .no-data {
            color: #dc3545;
            font-weight: 600;
            text-align: center;
            padding: 30px;
            font-size: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            width: 100%;
            margin: 0 auto;
        }

        .action-button {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .btn-send-support {
            background-color: #27ae60;
            color: white;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: background-color 0.2s ease, transform 0.2s ease;
        }

        .btn-send-support:hover {
            background-color: #219653;
            transform: translateY(-2px);
        }

        .btn-send-support i {
            font-size: 16px;
        }

        .footer {
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            padding: 5px 0;
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
            Teacher Dashboard <i class="fas fa-tachometer-alt"></i>
        </div>
        <div class="teacher-profile" onclick="toggleDropdown()">
            <img src="${pageContext.request.contextPath}/img/${gv.getAvatar()}" alt="Admin Photo" class="teacher-img">
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
            <li><a href="${pageContext.request.contextPath}/TeacherDashboard">Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc"><i class="fas fa-book"></i>Lớp Học</a></li>
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=diemdanh"><i class="fas fa-book"></i>Điểm Danh</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=hotro"><i class="fas fa-question"></i> Yêu Cầu Hỗ Trợ</a></li>
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <div class="main-content">
        <h1><i class="fas fa-question-circle"></i> Yêu Cầu Hỗ Trợ</h1>
        <div class="action-button">
            <a href="${pageContext.request.contextPath}/views/teacher/teacherGuiYeuCauHoTro.jsp" class="btn-send-support">
                <i class="fas fa-plus"></i> Gửi Yêu Cầu Hỗ Trợ
            </a>
        </div>
        <c:choose>
            <c:when test="${not empty sessionScope.hotros}">
                <div class="notification-box">
                    <c:forEach var="ht" items="${sessionScope.hotros}">
                        <div class="notification-item">
                            <h3>${ht.tenHoTro}</h3>
                            <p><strong>Người gửi:</strong> ${ht.hoTen}</p>
                            <p><strong>Mô tả:</strong> ${ht.moTa}</p>
                            <p><strong>Trạng thái:</strong> ${ht.daDuyet}</p>
                            <c:if test="${not empty ht.phanHoi}">
                                <p><strong>Phản hồi:</strong> ${ht.phanHoi}</p>
                            </c:if>
                            <div class="notification-time">${ht.thoiGian}</div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-data">Bạn hiện không có yêu cầu hỗ trợ nào.</div> 
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
    </div>
</body>
</html>