<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Removed JSTL fmt import as it's no longer used for formatting dates --%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.LichHoc" %>
<%@ page import="model.SlotHoc" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thời Khóa Biểu Lớp ${lopHoc.tenLopHoc} - EL CENTRE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            min-height: 100vh;
            background-color: #f9f9f9;
        }

        /* Header (unchanged from previous version, kept for completeness) */
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

        .admin-profile {
            position: relative;
            display: flex;
            align-items: center;
            cursor: pointer;
            margin-right: 20px;
        }

        .admin-profile .admin-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #B0C4DE;
            margin-right: 10px;
        }

        .admin-profile span {
            font-size: 14px;
            color: #B0C4DE;
            font-weight: 600;
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
            min-width: 180px;
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

        /* Sidebar (unchanged from previous version, with overflow-y: auto) */
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
            overflow-y: auto; /* Enable scrolling for sidebar content */
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
            padding: 8px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        ul.sidebar-menu li a:hover {
            background-color: #163E5C;
        }

        ul.sidebar-menu li a i {
            margin-right: 10px;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: 80px 20px 20px 20px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 20px; /* Reduced gap slightly */
            width: calc(100% - 250px);
        }

        h1 {
            color: #1F4E79;
            text-align: center;
            font-size: 28px; /* Larger for main title */
            font-weight: bold;
            margin-bottom: 25px;
        }

        .card {
            background: linear-gradient(135deg, #ffffff, #f0f4f8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .card-header {
            background-color: transparent;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 {
            margin: 0;
            color: #1F4E79;
            display: flex;
            align-items: center;
            font-size: 22px;
        }

        .card-header h3 i {
            margin-right: 10px;
            color: #1F4E79;
        }

        /* Schedule specific styles */
        .schedule-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap; /* Allows wrapping on smaller screens */
            gap: 15px; /* Spacing between elements */
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
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
            font-size: 0.9em;
        }

        .schedule-controls .nav-button:hover {
            background-color: #163E5C;
        }

        .schedule-controls .current-week-display {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
            text-align: center;
            flex-grow: 1; /* Allows it to take up available space */
        }

        /* Styles for the week picker form */
        .week-picker-form {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .week-picker-form label {
            font-weight: 500;
            color: #333;
        }

        .week-picker-form input[type="week"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.9em;
        }

        .week-picker-form button {
            padding: 8px 12px;
            background-color: #555;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
            font-size: 0.9em;
        }
        .week-picker-form button:hover {
            background-color: #333;
        }


        .schedule-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            table-layout: fixed; /* Ensures columns have equal width */
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .schedule-table th, .schedule-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            vertical-align: top;
            font-size: 0.9em;
        }

        .schedule-table th {
            background-color: #1F4E79; /* Dark blue for headers */
            color: white;
            font-weight: bold;
        }

        .schedule-table td {
            background-color: #fff;
        }

        .schedule-table td.time-slot {
            background-color: #f0f4f8;
            font-weight: bold;
            color: #333;
        }

        .schedule-entry {
            background-color: #e6f7ff; /* Lighter blue for schedule entries */
            border: 1px solid #91d5ff;
            border-radius: 5px;
            padding: 8px;
            margin: 5px 0;
            font-size: 0.85em;
            line-height: 1.4;
            color: #004085;
            text-align: left;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            cursor: pointer; /* Indicate clickable */
            transition: background-color 0.2s ease-in-out;
        }

        .schedule-entry:hover {
            background-color: #cceeff;
        }

        .schedule-entry .teacher-name {
            font-weight: bold;
            display: block;
            margin-top: 5px;
            color: #1F4E79; /* Darker blue for teacher name */
        }

        .schedule-empty {
            color: #999;
            font-style: italic;
        }

        .no-schedule-message {
            text-align: center;
            padding: 30px;
            font-size: 1.1em;
            color: #555;
            background-color: #f0f4f8;
            border-radius: 8px;
            margin-top: 20px;
            border: 1px solid #e9ecef;
        }

        /* Attendance Status Styles (for buttons in class-info) */
        .status-done {
            background-color: #28a745; /* Green for "Đã Điểm Danh" */
            color: white;
            border: none;
        }

        .status-pending {
            background-color: #007bff; /* Blue for "Điểm Danh" */
            color: white;
            border: none;
        }

        /* Modal Styles */
        .modal-overlay {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.6);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fefefe;
            padding: 25px 30px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px; /* Max width */
            border-radius: 10px;
            position: relative;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            animation: fadeIn 0.3s;
        }

        .close-button {
            color: #aaa;
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 28px;
            font-weight: bold;
        }

        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: scale(0.9);}
            to {opacity: 1; transform: scale(1);}
        }

        /* Footer */
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
                <a href="${pageContext.request.contextPath}/staffChangePassword"><i class="fas fa-key"></i> Change Password</a>
                <a href="${pageContext.request.contextPath}/staffUpdateInfo"><i class="fas fa-user-edit"></i> Update Information</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
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

    <main class="main-content">
        <h1>Thời Khóa Biểu Của Lớp: ${lopHoc.tenLopHoc} (${lopHoc.classCode})</h1>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-calendar-day"></i> Lịch học trong tuần</h3>
                <a href="${pageContext.request.contextPath}/StaffManageTimeTable" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-alt-circle-left"></i> Quay lại danh sách lớp
                </a>
            </div>
            <div class="card-body">
                <div class="schedule-controls">
                    <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewDetail&classId=${lopHoc.ID_LopHoc}&viewDate=${prevWeekStart}" class="nav-button"><i class="fas fa-chevron-left"></i> Tuần trước</a>
                    <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewDetail&classId=${lopHoc.ID_LopHoc}" class="nav-button"><i class="fas fa-calendar-day"></i> Tuần này</a>
                    <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewDetail&classId=${lopHoc.ID_LopHoc}&viewDate=${nextWeekStart}" class="nav-button">Tuần sau <i class="fas fa-chevron-right"></i></a>

                    <div class="current-week-display">
                        <span>${displayWeekRange}</span>
                    </div>
                    <form action="${pageContext.request.contextPath}/StaffManageTimeTable" method="GET" class="week-picker-form">
                        <input type="hidden" name="action" value="viewDetail">
                        <input type="hidden" name="classId" value="${lopHoc.ID_LopHoc}">
                        <label for="week-picker">Chọn tuần:</label>
                        <input type="week" id="week-picker" name="viewDate" value="${selectedWeekValue}">
                        <button type="submit">Xem</button>
                    </form>
                </div>

                <c:choose>
                    <c:when test="${empty timeSlots}">
                        <div class="no-schedule-message">
                            <p>Không có khung giờ học nào được định nghĩa.</p>
                        </div>
                    </c:when>
                    <c:when test="${empty scheduleMap && not empty timeSlots}">
                         <div class="no-schedule-message mt-4">
                            <p>Không có lịch học nào được tìm thấy cho lớp này trong tuần đã chọn.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="schedule-table">
                                <thead>
                                    <tr>
                                        <th>Khung giờ</th>
                                        <c:forEach var="date" items="${weekDates}">
                                            <th>
                                                <%
                                                    // This part remains using scriptlets for date formatting as per your provided code
                                                    Object obj = pageContext.getAttribute("date");
                                                    if (obj instanceof java.time.LocalDate) {
                                                        java.time.LocalDate currentDate = (java.time.LocalDate) obj;
                                                        java.util.Locale localeVN = new java.util.Locale("vi", "VN");
                                                        java.time.format.DateTimeFormatter dayFormatter = 
                                                            java.time.format.DateTimeFormatter.ofPattern("EEEE", localeVN);
                                                        java.time.format.DateTimeFormatter dateFormatter = 
                                                            java.time.format.DateTimeFormatter.ofPattern("dd/MM");
                                                        out.print(currentDate.format(dayFormatter));
                                                        out.print("<br><small>");
                                                        out.print(currentDate.format(dateFormatter));
                                                        out.print("</small>");
                                                    }
                                                %>
                                            </th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="slot" items="${timeSlots}">
                                        <tr>
                                            <td class="time-slot">${slot.slotThoiGian}</td>
                                            <c:forEach var="date" items="${weekDates}" varStatus="loop">
                                                <td>
                                                    <c:set var="dayOfWeekValue" value="${date.getDayOfWeek().getValue()}" />
                                                    <c:set var="key" value="${slot.ID_SlotHoc}-${dayOfWeekValue}"/>
                                                    <c:set var="lh" value="${scheduleMap[key]}" />

                                                    <c:if test="${not empty lh}">
                                                        <div class="schedule-entry"
                                                             data-schedule-id="${lh.ID_Schedule}"
                                                             data-class-name="${lopHoc.tenLopHoc}"
                                                             data-course-name="${lopHoc.tenKhoaHoc}"
                                                             data-room="${lh.tenPhongHoc}"
                                                             data-date="<%= ((LocalDate)pageContext.getAttribute("date")).format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>"
                                                             data-time-slot="${slot.slotThoiGian}"
                                                             data-da-diem-danh="${lh.daDiemDanh}"
                                                             data-co-the-sua="${lh.coTheSua}">
                                                            <div>Môn: ${lh.tenKhoaHoc}</div>
                                                            <div>Phòng: ${lh.tenPhongHoc}</div>
                                                            <div class="mt-auto">
                                                                <c:choose>
                                                                    <c:when test="${lh.daDiemDanh}">
                                                                        <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewAttendance&scheduleId=${lh.ID_Schedule}&classId=${lopHoc.ID_LopHoc}&viewDate=${param.viewDate}"
                                                                           class="btn btn-sm w-100 ${lh.daDiemDanh ? 'status-done' : 'status-pending'}">
                                                                            ${lh.daDiemDanh ? 'Đã Điểm Danh' : 'Điểm Danh'}
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="${pageContext.request.contextPath}/StaffManageTimeTable?action=viewAttendance&scheduleId=${lh.ID_Schedule}&classId=${lopHoc.ID_LopHoc}&viewDate=${param.viewDate}" class="btn btn-sm w-100 ${lh.daDiemDanh ? 'status-done' : 'status-pending'}">
                                                                            ${lh.daDiemDanh ? 'Đã Điểm Danh' : 'Điểm Danh'}</a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${empty lh}">
                                                        <span class="schedule-empty">Trống</span>
                                                    </c:if>
                                                </td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by EL CENTRE</p>
    </div>
    <script>
        function toggleDropdown() {
            document.getElementById("adminDropdown").classList.toggle("active");
        }

        // Close the dropdown if the user clicks outside of it
        window.onclick = function(event) {
            if (!event.target.matches('.admin-profile') && !event.target.matches('.admin-profile *')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('active')) {
                        openDropdown.classList.remove('active');
                    }
                }
            }
        }
    </script>
</body>
</html>