<%-- 
    Document   : staffSideBar
    Created on : Jul 23, 2025, 2:33:54 PM
    Author     : Vuh26
--%>

<%-- staffHeader.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
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
        overflow-y: auto;
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
</style>
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
