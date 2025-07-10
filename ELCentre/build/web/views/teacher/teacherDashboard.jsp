<!-- 
  Created on: JUNE 18, 2025, 2:44:16 PM
  Author: trungdam1305
  Purpose: This teacher dashboard page for the EL CENTRE system is designed to provide an overview of key 
  metrics including the number of students, teachers, classes. Also provide courses, class that this teacher taught
-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dal.HocSinhDAO" %>
<%@ page import="model.HocSinh" %>
<%@ page import="dal.GiaoVienDAO" %>
<%@ page import="model.GiaoVien" %>
<%@ page import="dal.LopHocDAO" %>
<%@ page import="model.LopHoc" %>
<%@ page import="dal.UserLogsDAO" %>
<%@ page import="model.UserLogs" %>
<%@ page import="dal.LichHocDAO" %>
<%@ page import="model.LichHoc" %>
<%@ page import="model.UserLogView" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Teacher Dashboard</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                text-align: left;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                position: fixed;
                width: calc(100% - 250px);
                margin-left: 290px;
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
                width: 230px; /* nhỏ hơn 250px */
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
                margin-left: 1000px;
                padding: 80px 20px 20px 20px; 
                flex: 1;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                gap: 30px;
                margin-right: auto;
                margin-left: auto;
                max-width: 1200px;
                
            }

            .dashboard-stats {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                transform: translate(145px, 30px);
                
            }

            .stat-card {
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 10px;
                font-size: 14px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                flex: 1 1 200px;
                text-align: center;
                transition: transform 0.2s;
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-card h3 {
                margin-bottom: 15px;
                color: #1F4E79;
                font-weight: 700;
                font-size: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .stat-card h3 i {
                margin-right: 8px;
            }

            .stat-card p {
                font-size: 24px;
                font-weight: bold;
                margin: 0;
                color: #333;
            }
            
            .stat-hocsinh {
                background: linear-gradient(135deg, #E3F2FD, #BBDEFB);
                color: #0D47A1;
            }
            .stat-giaovien {
                background: linear-gradient(135deg, #E8F5E9, #C8E6C9);
                color: #1B5E20;
            }
            .stat-lophoc {
                background: linear-gradient(135deg, #FFFDE7, #FFF9C4);
                color: #F57F17;
            }

            .data-table-container {
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            h3.section-title {
                margin-top: 0;
                margin-bottom: 15px;
                color: #1F4E79;
                font-weight: 700;
                font-size: 20px;
                border-bottom: 2px solid #1F4E79;
                padding-bottom: 5px;
                display: flex;
                align-items: center;
            }

            h3.section-title i {
                margin-right: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table th, table td {
                border: 1px solid #ccc;
                padding: 8px 12px;
                text-align: left;
            }

            table th {
                background-color: #e2eaf0;
                color: #1F4E79;
            }

            p.no-data {
                color: red;
                font-weight: 600;
                text-align: center;
                padding: 15px 0;
            }

            .tables-wrapper {
                display: flex;
                gap: 20px;
                transform: translate(145px, 30px);
            }

            .tables-wrapper .data-table-container {
                padding: 15px;
                border-radius: 8px;
            }

            .tables-wrapper .data-table-container:first-child {
                flex: 7;
            }

            .tables-wrapper .data-table-container:last-child {
                flex: 3;
            }
            /* === CSS CHO KHU VỰC LỊCH HỌC VÀ BỘ LỌC TUẦN === */

            /* Class cho container chính của lịch học */
            .schedule-container {
                margin-top: 30px;
                margin-left: 130px;
                width: calc(100% - 30px);   
            }

            /* Class cho form lọc tuần */
            .week-filter {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-bottom: 20px; /* Tăng khoảng cách với bảng */
                padding: 15px;
                border: 1px solid #e9ecef;
                border-radius: 8px;
            }

            /* Định dạng cho label bên trong form */
            .week-filter label {
                font-weight: bold;
                
            }

            /* Định dạng cho ô chọn tuần */
            .week-filter input[type="week"] {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            /* Định dạng cho nút Lọc */
            .week-filter button {
                padding: 6px 12px;
                background-color: #1F4E79;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 5px;
                transition: background-color 0.2s;
            }

            .week-filter button:hover {
                background-color: #163E5C;
            }

            /* Footer Styles */
            .footer {
                background-color: #1F4E79;
                color: #B0C4DE;
                text-align: center;
                padding: 5px 0;
                position: fixed;
                width: calc(100% - 250px);
                bottom: 0;
                margin-left: 290px;
                box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
            }

            .footer p {
                margin: 0;
                font-size: 14px;
            }
            /* === CSS CHO KHU VỰC ĐIỀU KHIỂN LỊCH HỌC === */
            .schedule-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; /* Cho phép xuống dòng trên màn hình nhỏ */
                gap: 15px;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border: 1px solid #e9ecef;
                border-radius: 8px;
            }

            /* Khu vực chứa các nút bấm */
            .schedule-controls .nav-buttons {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .schedule-controls .nav-button {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 8px 15px;
                background-color: #1F4E79;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.2s;
            }

            .schedule-controls .nav-button:hover {
                background-color: #163E5C;
            }

            /* Khu vực hiển thị tuần hiện tại */
            .schedule-controls .current-week-display {
                font-size: 1.1em;
                font-weight: bold;
                color: #333;
                text-align: center;
                flex-grow: 1; /* Cho phép co giãn để lấp đầy không gian */
            }

            /* Khu vực chọn tuần cụ thể */
            .schedule-controls .week-picker-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .schedule-controls .week-picker-form label {
                font-weight: 500;
            }

            .schedule-controls .week-picker-form input[type="week"] {
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .schedule-controls .week-picker-form button {
                 padding: 8px 12px;
                background-color: #555;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .schedule-controls .week-picker-form button:hover {
                background-color: #333;
            }   
            /* === CSS CHO NÚT ĐIỂM DANH === */
            .attendance-btn {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 12px;
                border-radius: 5px;
                color: white;
                text-decoration: none;
                font-size: 13px;
                font-weight: 500;
                transition: opacity 0.2s;
                border: none;
                cursor: pointer;
                white-space: nowrap;
            }
            .attendance-btn:hover {
                opacity: 0.85;
            }
            /* Trạng thái chưa điểm danh: MÀU CAM */
            .status-pending {
                background-color: #f39c12; 
            }
            /* Trạng thái đã điểm danh: MÀU XANH LÁ */
            .status-done {
                background-color: #27ae60;
            }
            .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 25px;
            }

            .pagination a {
                color: #555; /* Màu chữ xám nhẹ */
                text-decoration: none;
                padding: 6px 12px; /* Giảm padding để nhỏ hơn */
                margin: 0 2px; /* Giảm margin để gần nhau hơn */
                border-radius: 4px; /* Bo góc mềm mại */
                transition: background-color 0.3s, color 0.3s;
                border: 1px solid #ddd; /* Thêm viền mỏng */
            }

            /* Style cho trang đang được chọn */
            .pagination a.active {
                background-color: #1F4E79; /* Màu xanh chủ đạo */
                color: white; /* Chữ trắng */
                border-color: #1F4E79; /* Viền cùng màu */
                font-weight: bold;
            }

            /* Hiệu ứng khi di chuột vào các trang khác */
            .pagination a:hover:not(.active) {
                background-color: #e2eaf0; /* Màu nền nhạt khi hover */
                color: #1F4E79;
            }
        </style>
    </head>
    <body>
        
        <div class="header">
            <div class="left-title">
                Teacher Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <!-- User's email and option to change or update information-->
            <div class="teacher-profile" onclick="toggleDropdown()">
                <img src="${pageContext.request.contextPath}/img/${gv.getAvatar()}" alt="Admin Photo" class="teacher-img">
                <span>${user.getEmail()} </span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="teacherDropdown">
                    <a href="#"><i class="fas fa-key"></i> Change Password</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
                </div>
            </div>
        </div>
            <!--Navigation Bar-->    
        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/TeacherDashboard">Dashboard</a></li>
            </ul>
            <!--Academy Management-->
            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <!--Teacher's Class Management-->
            <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lophoc"><i class="fas fa-book"></i>Lớp Học</a></li>
                <!--Attendance's Management-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=diemdanh"><i class="fas fa-book"></i>Điểm Danh</a></li>
            </ul>
            <!--Other Management-->
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <!--Teacher's Notification Management-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <!--Blog's View-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=blog"><i class="fas fa-blog"></i> Blog</a></li>
                <!--Help Request to Admin-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=hotro"><i class="fas fa-question"></i> Yêu Cầu Hỗ Trợ</a></li>
                <!--Logout-->
                <li style="padding-top: 4px"><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <!-- Dashboard Stats -->
            <div class="dashboard-stats">
                <div class="stat-card stat-hocsinh">
                    <!--Teacher's Num of Student-->
                    <h3><i class="fas fa-user-graduate"></i> Tổng số học sinh đang giảng dạy</h3>
                    <p>${numHocSinh}</p>
                </div>

                <div class="stat-card stat-giaovien">
                    <!--Teacher's Num of Class-->
                    <h3><i class="fas fa-school"></i> Tổng số lớp học đang giảng dạy</h3>
                    <p>${numLopHoc}</p>
                </div>

                <div class="stat-card stat-lophoc">
                    <!--Teacher's Salary-->
                    <h3><i class="fas fa-money-bill"></i> Lương hằng tháng</h3>
                    <p>${luongGV}</p>
                </div>
            </div>  

            <%-- Thay thế toàn bộ khối div này --%>
            <div class="data-table-container schedule-container">
                <h3 class="section-title"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</h3>

                <div class="schedule-controls">
                    <div class="nav-buttons">
                        <a href="TeacherDashboard?viewDate=${previousWeekLink}" class="nav-button"><i class="fas fa-chevron-left"></i> Tuần trước</a>
                        <a href="TeacherDashboard" class="nav-button"><i class="fas fa-calendar-day"></i> Tuần này</a>
                        <a href="TeacherDashboard?viewDate=${nextWeekLink}" class="nav-button">Tuần sau <i class="fas fa-chevron-right"></i></a>
                    </div>
                    <div class="current-week-display">${displayWeekRange}</div>
                    <form action="TeacherDashboard" method="GET" class="day-picker-form">
                        <label for="day-picker">Chọn ngày:</label>
                        <input type="date" id="day-picker" name="filterDate" value="${filterDateValue}">
                        <button type="submit">Xem</button>
                    </form>
                </div>
                <c:choose>
                    <c:when test="${not empty tkbTrongTuan}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Ngày Học</th>
                                    <th>Ca Học</th>
                                    <th>Thời Gian</th>
                                    <th>Lớp Học</th>
                                    <th>Ghi Chú</th>
                                    <th>Phòng học</th>
                                    <th>Hành động</th> <%-- THÊM CỘT HÀNH ĐỘNG --%>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lh" items="${tkbTrongTuan}">
                                    <%-- Thêm data-schedule-id vào thẻ <tr> để JS dễ dàng lấy ID --%>
                                    <tr data-schedule-id="${lh.ID_Schedule}">
                                        <td>
                                            <%-- Scriptlet format ngày --%>
                                            <%
                                                Object obj = pageContext.getAttribute("lh");
                                                if (obj instanceof model.LichHoc) {
                                                    model.LichHoc currentLichHoc = (model.LichHoc) obj;
                                                    java.time.LocalDate ngayHoc = currentLichHoc.getNgayHoc();
                                                    if (ngayHoc != null) {
                                                        java.time.format.DateTimeFormatter formatter = 
                                                            java.time.format.DateTimeFormatter.ofPattern("EEEE, dd/MM/yyyy", new java.util.Locale("vi", "VN"));
                                                        out.print(ngayHoc.format(formatter));
                                                    }
                                                }
                                            %>
                                        </td>
                                        <td>${lh.ID_SlotHoc}</td>
                                        <td>${lh.slotThoiGian}</td>
                                        <td>${lh.tenLopHoc}</td>
                                        <td>
                                            <%-- Vùng Ghi Chú --%>
                                            <span class="note-display">${lh.ghiChu}</span>
                                            <input type="text" class="form-control note-edit" value="${lh.ghiChu}" style="display:none;">
                                        </td>
                                        <td>${lh.getTenPhongHoc()}</td>
                                        <td>
                                            <c:choose>
                                                <%-- TRƯỜNG HỢP 1: NẾU HÔM NAY LÀ NGÀY HỌC (coTheSua == true) -> HIỂN THỊ CÁC NÚT --%>
                                                <c:when test="${lh.coTheSua}">

                                                    <%-- Vùng Hành Động (Trạng thái xem) --%>
                                                    <div class="action-view" style="display: flex; gap: 8px;">
                                                        <%-- Nút Điểm Danh --%>
                                                        <c:choose>
                                                            <c:when test="${lh.daDiemDanh}">
                                                                <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lichhoc&scheduleId=${lh.ID_Schedule}" 
                                                                   class="attendance-btn status-done">
                                                                    <i class="fas fa-check-circle"></i> Đã Điểm Danh
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lichhoc&scheduleId=${lh.ID_Schedule}" 
                                                                   class="attendance-btn status-pending">
                                                                    <i class="fas fa-edit"></i> Điểm Danh
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <%-- Nút Sửa Ghi Chú --%>
                                                        <button class="edit-note-btn"
                                                                style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; font-size: 13px; font-weight: 500; border: 1px solid transparent; border-radius: 20px; cursor: pointer; background-color: #ffc107; color: #333;">
                                                            <i class="fas fa-pencil-alt"></i> Sửa
                                                        </button>
                                                    </div>

                                                    <%-- Vùng Hành Động (Trạng thái sửa), mặc định ẩn --%>
                                                    <div class="action-edit" style="display: none; gap: 8px;">
                                                        <button class="save-note-btn"
                                                                style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; font-size: 13px; font-weight: 500; border: 1px solid transparent; border-radius: 20px; cursor: pointer; background-color: #0d6efd; color: white;">
                                                            <i class="fas fa-save"></i> Lưu
                                                        </button>
                                                        <button class="cancel-note-btn"
                                                                style="display: inline-flex; align-items: center; gap: 6px; padding: 6px 14px; font-size: 13px; font-weight: 500; border: 1px solid #ced4da; border-radius: 20px; cursor: pointer; background-color: transparent; color: #6c757d;">
                                                            <i class="fas fa-times"></i> Hủy
                                                        </button>
                                                    </div>

                                                </c:when>

                                                <%-- ================================================================== --%>
                                                <%-- TRƯỜNG HỢP 2: NẾU LÀ NGÀY KHÁC -> HIỂN THỊ NÚT "ĐÃ KHÓA" --%>
                                                <%-- ================================================================== --%>
                                                <c:otherwise>
                                                    <button class="btn btn-sm btn-secondary" disabled title="Chỉ có thể thao tác trong ngày diễn ra buổi học">
                                                        <i class="fas fa-lock"></i> Đã Khóa Điểm Danh
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                    </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p class="no-data">Không có lịch học trong tuần này.</p>
                    </c:otherwise>
                </c:choose>

                <div class="pagination">
                    <%-- Kiểm tra nếu có nhiều hơn 1 trang thì mới hiển thị phân trang --%>
                    <c:if test="${totalPages > 1}">

                        <%-- Nút 'Previous' --%>
                        <c:if test="${currentPage > 1}">
                            <c:url var="prevUrl" value="TeacherDashboard">
                                <c:param name="page" value="${currentPage - 1}" />
                                <c:if test="${not empty currentViewDate}">
                                    <c:param name="viewDate" value="${currentViewDate}" />
                                </c:if>
                            </c:url>
                            <a href="${prevUrl}">&laquo; Previous</a>
                        </c:if>

                        <%-- Các nút số trang --%>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:url var="pageUrl" value="TeacherDashboard">
                                <c:param name="page" value="${i}" />
                                <c:if test="${not empty currentViewDate}">
                                    <c:param name="viewDate" value="${currentViewDate}" />
                                </c:if>
                            </c:url>
                            <a href="${pageUrl}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <%-- Nút 'Next' --%>
                        <c:if test="${currentPage < totalPages}">
                            <c:url var="nextUrl" value="TeacherDashboard">
                                <c:param name="page" value="${currentPage + 1}" />
                                <c:if test="${not empty currentViewDate}">
                                    <c:param name="viewDate" value="${currentViewDate}" />
                                </c:if>
                            </c:url>
                            <a href="${nextUrl}">Next &raquo;</a>
                        </c:if>

                    </c:if>
                </div>
            </div>
        </div>
                        
        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
        </div>

        <script>
            // Toggle Dropdown Menu
            function toggleDropdown() {
                const dropdown = document.getElementById('teacherDropdown');
                dropdown.classList.toggle('active');
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                const profile = document.querySelector('.teacher-profile');
                const dropdown = document.getElementById('teacherDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });
            document.addEventListener('DOMContentLoaded', function() {
    const tableBody = document.querySelector('tbody');

    // Hàm để chuyển đổi giữa chế độ xem và sửa cho một dòng
    function toggleEditState(row, isEditing) {
        const noteDisplay = row.querySelector('.note-display');
        const noteEdit = row.querySelector('.note-edit');
        const actionView = row.querySelector('.action-view');
        const actionEdit = row.querySelector('.action-edit');

        noteDisplay.style.display = isEditing ? 'none' : 'block';
        noteEdit.style.display = isEditing ? 'block' : 'none';
        actionView.style.display = isEditing ? 'none' : 'flex';
        actionEdit.style.display = isEditing ? 'flex' : 'none';

        if (isEditing) {
            noteEdit.focus(); // Tự động focus vào ô input khi sửa
        }
    }

    // Sử dụng event delegation để xử lý click cho toàn bộ bảng
    tableBody.addEventListener('click', function(event) {
        const target = event.target;
        const row = target.closest('tr');
        if (!row) return;

        // 1. Khi nhấn nút "Sửa"
        if (target.classList.contains('edit-note-btn')) {
            toggleEditState(row, true);
        }

        // 2. Khi nhấn nút "Hủy"
        if (target.classList.contains('cancel-note-btn')) {
            // Reset lại giá trị ô input về giá trị ban đầu
            row.querySelector('.note-edit').value = row.querySelector('.note-display').innerText;
            toggleEditState(row, false);
        }

        // 3. Khi nhấn nút "Lưu"
        if (target.classList.contains('save-note-btn')) {
            const scheduleId = row.dataset.scheduleId;
            const noteInput = row.querySelector('.note-edit');
            const newNote = noteInput.value;

            const formData = new URLSearchParams();
            formData.append('action', 'updateNote');
            formData.append('scheduleId', scheduleId);
            formData.append('noteText', newNote);

            // Gửi yêu cầu lên server
            fetch('${pageContext.request.contextPath}/teacherGetFromDashboard', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Lỗi từ server');
                }
                // Cập nhật giao diện nếu thành công
                row.querySelector('.note-display').innerText = newNote;
                toggleEditState(row, false);
                // alert('Đã cập nhật ghi chú thành công!');
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Không thể cập nhật ghi chú. Vui lòng thử lại.');
            });
        }
    });
});
        </script>
    </body>
</html> 