<%-- 
    Document   : classAttendanceReport
    Created on : Jul 9, 2025, 11:39:24 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Điểm Danh - ${lopHoc.tenLopHoc}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Container cho phép cuộn ngang trên màn hình siêu nhỏ */
    .table-responsive { overflow-x: auto; }

    /* Quy tắc cho bảng điểm danh */
    .attendance-grid {
        table-layout: fixed; /* QUAN TRỌNG: Chìa khóa để kiểm soát chiều rộng cột */
        width: 100%;
        border-collapse: collapse;
    }

    /* Quy tắc chung cho các ô */
    .attendance-grid th, .attendance-grid td {
        text-align: center;
        vertical-align: middle;
        border: 1px solid #dee2e6; /* Đường viền nhẹ hơn */
        padding: 8px;
        word-wrap: break-word; /* Cho phép chữ xuống dòng nếu cần */
        /* BỎ min-width: 120px; */
    }

    /* Ưu tiên chiều rộng cho cột tên học sinh */
    .attendance-grid .student-name-col {
        width: 25%; /* Cột tên luôn chiếm 25% chiều rộng của bảng */
        text-align: left; /* Căn trái cho dễ đọc */
    }

    /* Các cột ngày sẽ tự động chia đều 75% không gian còn lại */

    /* Style cho các trạng thái điểm danh (giữ nguyên) */
    .present { color: #27ae60; } /* Xanh lá */
    .absent { color: #c0392b; } /* Đỏ */
    .late { color: #f39c12; } /* Cam */
        
        h1 {
            margin-top: 30px;
            color: #1F4E79; /* Màu chữ */
            text-align: center; /* Căn giữa */
            font-size: 24px; /* Cỡ chữ */
            font-weight: bold; /* In đậm */
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
                margin-left: 300px; /* Keep this to offset for sidebar */
                padding: 80px 20px 20px 20px; /* Adjust padding as needed */
                flex: 1;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                gap: 30px;
                margin-right: auto;
                max-width: calc(100% - 250px); /* Adjust this to account for sidebar width */
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
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            }

            .tables-wrapper .data-table-container:first-child {
                flex: 7;
            }

            .tables-wrapper .data-table-container:last-child {
                flex: 3;
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
            .filter-container {
                display: flex;
                align-items: center;
                gap: 20px; /* Tăng khoảng cách một chút */
                flex-wrap: wrap;
                justify-content: flex-end; /* Đẩy các phần tử sang phải */
            }


            .filter-container .filter-group {
                display: flex;
                align-items: center;
                gap: 8px;
            }


            .filter-container label {
                font-weight: bold;
                color: #333;
                white-space: nowrap; /* Ngăn không cho label bị xuống dòng */
            }


            .filter-container input,
            .filter-container select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                min-width: 150px; /* Điều chỉnh độ rộng nếu cần */
            }


            .filter-container button {
                padding: 8px 15px;
                background-color: #1F4E79;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 16px;
                display: flex;
                align-items: center;
            }


            .filter-container button:hover {
                background-color: #163E5C;
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
            
            /* === BỔ SUNG CSS CHO CÁC NÚT HÀNH ĐỘNG MỚI === */
            .action-buttons {
                display: flex;
                align-items: center;
                gap: 8px; /* Khoảng cách giữa các nút */
            }

            /* Kiểu dáng chung cho nút hành động */
            .action-btn {
                display: inline-flex;
                align-items: center;
                gap: 6px; /* Khoảng cách giữa icon và chữ */
                padding: 6px 12px;
                border-radius: 20px; /* Bo tròn các góc */
                color: white;
                font-size: 13px;
                font-weight: 500;
                text-decoration: none;
                border: none;
                cursor: pointer;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
                white-space: nowrap; /* Ngăn không cho chữ xuống dòng */
            }

            .action-btn:hover {
                transform: translateY(-2px); /* Hiệu ứng nhấc lên khi hover */
                box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            }

            /* Nút Sửa (Màu cam) */
            .action-btn.edit {
                background-color: #f39c12; 
            }

            /* Nút Danh sách học sinh (Màu xám) */
            .action-btn.view-students {
                background-color: #6c7a89;
            }

            /* Nút Upload (Màu xanh lá) */
            .action-btn.upload {
                background-color: #27ae60;
            }
            .filter-bar {
                display: flex;
                flex-wrap: wrap; /* Cho phép xuống dòng trên màn hình nhỏ */
                align-items: center;
                gap: 15px; /* Khoảng cách giữa các nhóm filter */
                padding: 15px;
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                margin-bottom: 2rem !important; /* Ghi đè class mb-4 để có khoảng cách lớn hơn */
            }

            .filter-group {
                display: flex;
                align-items: center;
                flex-grow: 1; /* Cho phép các nhóm co giãn bằng nhau */
                position: relative;
            }

            .filter-icon {
                position: absolute;
                left: 15px;
                color: #6c757d; /* Màu xám cho icon */
            }

            /* Style chung cho input và select trong filter bar */
            .filter-bar .form-control,
            .filter-bar .form-select {
                flex: 1;
                min-width: 200px;
                padding-left: 40px; /* Tạo không gian cho icon */
                /* Các style nhất quán với form trong modal */
                background-color: #fff;
                border: 1px solid #ced4da;
                border-radius: 6px;
                padding-top: 10px;
                padding-bottom: 10px;
                transition: border-color 0.2s ease, box-shadow 0.2s ease;
            }

            .filter-bar .form-control:focus,
            .filter-bar .form-select:focus {
                border-color: #86b7fe;
                box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
                outline: none;
            }

            /* Nhóm các nút bấm */
            .filter-buttons {
                display: flex;
                gap: 10px;
            }

            /* Nút Lọc */
            .btn-filter-submit {
                background-color: #1F4E79;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.2s ease;
            }
            .btn-filter-submit:hover {
                background-color: #163E5C;
            }

            /* Nút Reset */
            .btn-filter-reset {
                background-color: #6c757d;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                font-size: 14px;
                transition: background-color 0.2s ease;
            }
            .btn-filter-reset:hover {
                background-color: #5a6268;
            }
            .btn-primary {
                color: white;
                        background-color: #27ae60;
                        border-color: #27ae60;
                        padding: 8px 10px;
                        font-weight: 300;
                        border-radius: 6px;
                        text-decoration: none;
            }
            .btn-primary:hover {
                        background-color: #A2D5C6;
                        border-color: #A2D5C6;
            }
            .btn-back {
                        display: inline-flex;       /* Căn chỉnh icon và chữ */
                        gap: 8px;                   /* Khoảng cách giữa icon và chữ */
                        padding: 10px 20px;         /* Tăng kích thước cho dễ nhấn */
                        font-size: 15px;
                        font-weight: 500;
                        text-decoration: none;
                        margin: 20px 0px    ;
                        color: #1F4E79;             /* Màu chữ và viền theo màu chủ đạo */
                        background-color: transparent;
                        border: 2px solid #1F4E79;
                        border-radius: 8px;         /* Bo góc mềm mại */
                        cursor: pointer;
                        transition: all 0.2s ease-in-out; /* Hiệu ứng chuyển động mượt mà */
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
            <div class="card">
                <div class="card-header">
                    <h1><i class="fas fa-calendar-check"></i> Báo Cáo Điểm Danh Lớp: ${lopHoc.tenLopHoc}</h1>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-bordered attendance-grid">
                        <thead>
                            <tr>
                                <th class="student-name-col" style="min-width: 130px;">Họ Tên Học Sinh</th>
                                <c:forEach var="schedule" items="${scheduleList}">
                                    <th>
                                        <%-- Scriptlet để định dạng ngày tháng --%>
                                        <%
                                            // Lấy đối tượng 'schedule' từ vòng lặp JSTL
                                            Object obj = pageContext.getAttribute("schedule");
                                            if (obj instanceof model.LichHoc) {
                                                model.LichHoc currentSchedule = (model.LichHoc) obj;
                                                java.time.LocalDate ngayHoc = currentSchedule.getNgayHoc();

                                                // Kiểm tra null để tránh lỗi
                                                if (ngayHoc != null) {
                                                    // Định dạng theo mẫu "dd/MM" và in ra
                                                    out.print(ngayHoc.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")));
                                                }
                                            }
                                        %>
                                    </th>
                                    
                                </c:forEach>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${studentList}">

                                <%-- BƯỚC 1: TÍNH TOÁN NGẦM SỐ BUỔI VẮNG VÀ ĐI MUỘN --%>
                                <c:set var="absenceCount" value="0"/>
                                <c:set var="lateCount" value="0"/> <%-- ✅ Thêm biến đếm đi muộn --%>

                                <c:forEach var="schedule" items="${scheduleList}">
                                    <c:set var="key" value="${student.ID_HocSinh}-${schedule.ID_Schedule}"/>
                                    <c:set var="status" value="${attendanceMap[key].trangThai}"/>

                                    <c:if test="${status == 'Vắng'}">
                                        <c:set var="absenceCount" value="${absenceCount + 1}"/>
                                    </c:if>
                                    <%-- ✅ Đếm thêm số lần đi muộn --%>
                                    <c:if test="${status == 'Đi muộn'}">
                                        <c:set var="lateCount" value="${lateCount + 1}"/>
                                    </c:if>
                                </c:forEach>

                                <%-- BƯỚC 2: HIỂN THỊ DÒNG DỮ LIỆU --%>
                                <tr>
                                    <%-- Ô đầu tiên: Hiển thị tên và cả 2 tỷ lệ --%>
                                    <td class="student-name-col">
                                        ${student.hoTen}
                                        <c:if test="${scheduleList.size() > 0}">
                                            <div class="text-muted" style="font-size: 0.85em;">
                                                <%-- Tỷ lệ vắng --%>
                                                <span title="${absenceCount} / ${scheduleList.size()} buổi">
                                                    Vắng: <fmt:formatNumber value="${(absenceCount / scheduleList.size()) * 100}" maxFractionDigits="1"/>%
                                                </span>

                                                <%-- ✅ Tỷ lệ đi muộn --%>
                                                <span style="margin-left: 10px;" title="${lateCount} / ${scheduleList.size()} buổi">
                                                    Đi muộn: <fmt:formatNumber value="${(lateCount / scheduleList.size()) * 100}" maxFractionDigits="1"/>%
                                                </span>
                                            </div>
                                        </c:if>
                                    </td>

                                    <%-- BƯỚC 3: VÒNG LẶP CHỈ ĐỂ HIỂN THỊ TRẠNG THÁI ĐIỂM DANH --%>
                                    <c:forEach var="schedule" items="${scheduleList}">
                                        <td>
                                            <c:set var="key" value="${student.ID_HocSinh}-${schedule.ID_Schedule}"/>
                                            <c:set var="status" value="${attendanceMap[key].trangThai}"/>
                                            <c:choose>
                                                <c:when test="${status == 'Có mặt'}"><span class="present" title="Có mặt"><i class="fas fa-check-circle"></i></span></c:when>
                                                <c:when test="${status == 'Vắng'}"><span class="absent" title="Vắng"><i class="fas fa-times-circle"></i></span></c:when>
                                                <c:when test="${status == 'Đi muộn'}"><span class="late" title="Đi muộn"><i class="fas fa-clock"></i></span></c:when>
                                                <c:otherwise><span class="text-muted" title="Chưa điểm danh">-</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </c:forEach>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty studentList}">
                                <tr><td colspan="${scheduleList.size() + 1}" class="text-center">Lớp này chưa có học sinh.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="card-footer">
                    <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=diemdanh" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </div>
        </div>
    <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
        </div>                    
</body>
</html>
