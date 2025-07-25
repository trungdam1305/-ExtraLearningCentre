<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- SIDEBAR CỐ ĐỊNH
    Cách dùng trong các trang: 
    Chỉ cần thêm dòng sau 
    < %@ include file="/views/includes/sidebar.jsp" % >



-->
<div class="sidebar">
    <h4>EL CENTRE</h4>
    <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
    <div class="sidebar-title">STUDENT</div>

    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/StudentDashboardServlet">Trang chủ</a>

    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/StudentEnrollClassServlet">Đăng ký học</a>
    <a href="${pageContext.request.contextPath}/StudentViewClassServlet">Lớp học</a>
    <a href="${pageContext.request.contextPath}/StudentViewScheduleServlet">Lịch học</a>

    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/StudentPaymentServlet">Học phí</a>

    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/StudentViewNotificationServlet">Thông báo</a>
    <a href="${pageContext.request.contextPath}/StudentEditProfileServlet">Tài khoản</a>
    <a href="${pageContext.request.contextPath}/StudentSupportServlet">Hỗ trợ</a>
    
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

    <style>
    .sidebar {
        width: 260px;
        background-color: #1F4E79;
        height: 100vh;
        padding: 20px;
        color: white;
        box-sizing: border-box;
    }

    .sidebar-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 25px;
    }

    .sidebar-section {
        margin-top: 20px;
        font-size: 20px;
        font-weight: bold;
        color: #a9c0dc;
        letter-spacing: 1px;
        border-top: 1px solid #3e5f87;
        padding-top: 10px;
    }

    .sidebar a {
        display: block;
        text-decoration: none;
        color: white;
        padding: 8px 0;
        font-size: 20px;
        transition: background-color 0.2s ease;
    }

    .sidebar a:hover {
        background-color: #294f78;
        padding-left: 10px;
    }

    .logout-link {
        margin-top: 30px;
        font-weight: bold;
        color: #ffcccc;
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
    .sidebar h4 {
        text-align: center;
        margin: 0;
        font-weight: bold;
        font-size: 20px;
        letter-spacing: 1.5px;
    }
</style>
