<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- Add fmt taglib back if you are using it for formatting numbers/dates --%>

<%--
    Document   : parentClassAttendanceReport
    Created on : Jul 25, 2025 (Adjusted for parent view)
    Author     : trungdam
--%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Chi Tiết Điểm Danh - ${hocSinh.hoTen} - Lớp ${lopHoc.tenLopHoc}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Keep your existing styles as they are, no changes needed here */

        .attendance-grid {
            table-layout: fixed;
            width: 100%;
            border-collapse: collapse;
        }

        .attendance-grid th, .attendance-grid td {
            text-align: center;
            vertical-align: middle;
            border: 1px solid #dee2e6;
            padding: 8px;
            word-wrap: break-word;
        }

        .attendance-grid .student-name-col {
            width: 25%;
            text-align: left;
        }

        .present { color: #27ae60; }
        .absent { color: #c0392b; }
        .late { color: #f39c12; }

        h1 {
            margin-top: 30px;
            color: #1F4E79;
            text-align: center;
            font-size: 24px;
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
            margin-left: 260px;
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

        .teacher-profile { /* Changed from teacher-profile to user-profile for parent context */
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            cursor: pointer;
            margin-left: 20px;
            margin-right: 100px;
        }

        .teacher-profile .teacher-img { /* Renamed class for clarity if needed, but styling stays same */
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
        .main-content {
            padding: 80px 20px 20px 20px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-right: auto;
            max-width: calc(100% - 250px);
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
            margin-left: 260px;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }
        .filter-container {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }


        .filter-container .filter-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }


        .filter-container label {
            font-weight: bold;
            color: #333;
            white-space: nowrap;
        }


        .filter-container input,
        .filter-container select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            min-width: 150px;
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
            color: #555;
            text-decoration: none;
            padding: 6px 12px;
            margin: 0 2px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            border: 1px solid #ddd;
        }

        .pagination a.active {
            background-color: #1F4E79;
            color: white;
            border-color: #1F4E79;
            font-weight: bold;
        }

        .pagination a:hover:not(.active) {
            background-color: #e2eaf0;
            color: #1F4E79;
        }

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            color: white;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            white-space: nowrap;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        .action-btn.edit {
            background-color: #f39c12;
        }

        .action-btn.view-students {
            background-color: #6c7a89;
        }

        .action-btn.upload {
            background-color: #27ae60;
        }
        .filter-bar {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 15p;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 2rem !important;
        }

        .filter-group {
            display: flex;
            align-items: center;
            flex-grow: 1;
            position: relative;
        }

        .filter-icon {
            position: absolute;
            left: 15px;
            color: #6c757d;
        }

        .filter-bar .form-control,
        .filter-bar .form-select {
            flex: 1;
            min-width: 200px;
            padding-left: 40px;
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

        .filter-buttons {
            display: flex;
            gap: 10px;
        }

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
            display: inline-flex;
            gap: 8px;
            padding: 10px 20px;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            margin: 20px 0px;
            color: #1F4E79;
            background-color: transparent;
            border: 2px solid #1F4E79;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }
        .sidebar {
        width: 260px;
        background-color: #1F4E79;

        padding: 10px;
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

</head>
<body>
    <div class="header">
        <div class="left-title">
            Báo cáo điểm danh của ${hocSinh.hoTen} <i class="fas fa-calendar-check"></i>
        </div>
        <div class="teacher-profile" onclick="toggleDropdown()">
            <img src="${pageContext.request.contextPath}/${phuHuynh.avatar}" alt="User Photo" class="teacher-img"> <%-- Using phuHuynh.avatar --%>
            <span>${sessionScope.user.email} </span>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="teacherDropdown"> <%-- Renamed ID for clarity --%>
                <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
    </div>
    <div class="sidebar">
    <h4>EL CENTRE</h4>
    <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
    <div class="sidebar-title">PARENT</div>

    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/ParentDashboardServlet">Trang chủ</a>

    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/ParentViewScheduleServlet">Lịch học</a>

    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/ParentPaymentServlet">Học phí</a>

    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/ParentViewNotificationServlet">Thông báo</a>
    <a href="${pageContext.request.contextPath}/ParentEditProfileServlet">Tài khoản</a>
    <a href="${pageContext.request.contextPath}/ParentSupportServlet">Hỗ trợ</a>
    
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

    <div class="main-content">
        <div class="card">
            <div class="card-header">
                <h1>Điểm danh lớp: ${lopHoc.tenLopHoc}</h1>
            </div>
            <div class="card-body table-responsive">
                <table class="table table-bordered attendance-grid">
                    <thead>
                        <tr>
                            <th class="student-name-col" style="min-width: 130px;">Họ Tên Học Sinh</th>
                            <c:forEach var="schedule" items="${scheduleList}">
                                <th style="font-size: 0.85em;">
                                    <%
                                        Object obj = pageContext.getAttribute("schedule");
                                        if (obj instanceof model.LichHoc) {
                                            model.LichHoc currentSchedule = (model.LichHoc) obj;
                                            java.time.LocalDate ngayHoc = currentSchedule.getNgayHoc();
                                            if (ngayHoc != null) {
                                                out.print(ngayHoc.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")));
                                            }
                                        }
                                    %>
                                </th>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- The studentList now contains only ONE student (the selected child) --%>
                        <c:forEach var="student" items="${studentList}">
                            <c:set var="absenceCount" value="0"/>
                            <c:set var="lateCount" value="0"/>
                            <c:forEach var="schedule" items="${scheduleList}">
                                <c:set var="key" value="${student.ID_HocSinh}-${schedule.ID_Schedule}"/>
                                <c:set var="status" value="${attendanceMap[key].trangThai}"/>
                                <c:if test="${status == 'Vắng'}">
                                    <c:set var="absenceCount" value="${absenceCount + 1}"/>
                                </c:if>
                                <c:if test="${status == 'Đi muộn'}">
                                    <c:set var="lateCount" value="${lateCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            <tr>
                                <td class="student-name-col">
                                    ${student.hoTen}
                                    <c:if test="${scheduleList.size() > 0}">
                                        <div class="text-muted" style="font-size: 0.85em;">
                                            <span title="${absenceCount} / ${scheduleList.size()} buổi">
                                                Vắng: <fmt:formatNumber value="${(absenceCount / scheduleList.size()) * 100}" maxFractionDigits="1"/>%
                                            </span>
                                            <span style="margin-left: 10px;" title="${lateCount} / ${scheduleList.size()} buổi">
                                                Đi muộn: <fmt:formatNumber value="${(lateCount / scheduleList.size()) * 100}" maxFractionDigits="1"/>%
                                            </span>
                                        </div>
                                    </c:if>
                                </td>
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
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <a href="${pageContext.request.contextPath}/ParentViewStudentDetailServlet?idHocSinh=${hocSinh.ID_HocSinh}" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại chi tiết học sinh
                </a>
            </div>
        </div>
    </div>
    <div class="footer">
        <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by ELCentre</p>
    </div>
    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById("teacherDropdown");
            dropdown.classList.toggle("active");
        }
        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
            if (!event.target.matches('.teacher-profile') && !event.target.matches('.teacher-img') && !event.target.matches('.teacher-profile span') && !event.target.matches('.teacher-profile i')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('active')) {
                        openDropdown.classList.remove('active');
                    }
                }
            }
        }
        // Assuming openModal function is defined in a separate JS file or parent JSP
        // If not, you'll need to define it or ensure it's included.
        // function openModal() { /* ... */ }
    </script>
</body>
</html>