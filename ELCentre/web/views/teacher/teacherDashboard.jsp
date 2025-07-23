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
                margin-top: 30px;
                transform: translateX(145px)
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

            .schedule-grid {
                table-layout: fixed; 
                width: 100%;
                
            }
            .schedule-grid th, .schedule-grid td {
                text-align: center;
                vertical-align: top;
                padding: 15px;
                height: 20px; 
            }
            .schedule-grid th {
                background-color: #1F4E79;
                color: white;
            }
            .schedule-grid td {
                border: 1px solid #e9ecef;
                background-color: #fff;
            }
            .schedule-grid .slot-time { 
                font-weight: bold;
                background-color: #f8f9fa;
                vertical-align: middle;
            }
            .class-info { 
                border-radius: 6px;
                background-color: #e3f2fd;
                padding: 15px 0px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }
            .class-info-name {
                font-weight: bold;
                font-size: 0.9em;
            }
            .class-info-room {
                font-size: 0.8em;
                color: #6c757d;
            }

            .schedule-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; 
                gap: 15px;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border: 1px solid #e9ecef;
                border-radius: 8px;
            }

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

            .schedule-controls .current-week-display {
                font-size: 1.1em;
                font-weight: bold;
                color: #333;
                text-align: center;
                flex-grow: 1; 
            }

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

            .status-pending {
                text-decoration: none;
                color:red;  
            }
 
            .status-done {
                text-decoration: none;
                color: #27ae60;
            }
            
            .schedule-controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap; 
                gap: 15px;
                margin-bottom: 20px;
                padding: 15px;
                background-color: #ffffff;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }

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
                font-weight: 500;
            }

            .schedule-controls .nav-button:hover {
                background-color: #163E5C;
            }

            .schedule-controls .current-week-display {
                font-size: 1.2em;
                font-weight: bold;
                color: #333;
                text-align: center;
                flex-grow: 1; 
            }

            .schedule-controls .week-picker-form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .schedule-controls .week-picker-form label {
                font-weight: 500;
            }

            .schedule-controls .week-picker-form input[type="week"] {
                padding: 6px;
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
                <!--Notification table-->
                <div>
                    <table >
                        
                    </table>
                </div>
                <!--End Table-->
                
                    <!--Weekly Timetable and Schedule for take Attendance-->
                    <div class="data-table-container schedule-container">
                        <h3 class="section-title"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</h3>

                        <div class="schedule-controls">
                            <!--Filter next and Previous week-->
                            <div class="nav-buttons">
                                <a href="TeacherDashboard?viewDate=${previousWeekLink}" class="nav-button"><i class="fas fa-chevron-left"></i> Tuần trước</a>
                                <a href="TeacherDashboard" class="nav-button"><i class="fas fa-calendar-day"></i> Tuần này</a>
                                <a href="TeacherDashboard?viewDate=${nextWeekLink}" class="nav-button">Tuần sau <i class="fas fa-chevron-right"></i></a>
                            </div>

                            <div class="current-week-display">
                                <span>${displayWeekRange}</span>
                            </div>
                            <!--Filter Select week-->    
                            <form action="TeacherDashboard" method="GET" class="week-picker-form">
                                <label for="week-picker">Chọn tuần:</label>
                                <input type="week" id="week-picker" name="week" value="${selectedWeekValue}">
                                <button type="submit">Xem</button>
                            </form>

                        </div>                                
                        <!--Schedule grid-->
                        <table class="table table-bordered schedule-grid">
                            <thead>
                                <tr>
                                    <th style="width: 12%; background-color: #343a40;">Ca học</th>
                                    <c:forEach var="date" items="${weekDates}">
                                        <th style="width: 12.5%;">
                                            <%
                                                // get date from object in servlet
                                                Object obj = pageContext.getAttribute("date");
                                                if (obj instanceof java.time.LocalDate) {
                                                    java.time.LocalDate currentDate = (java.time.LocalDate) obj;

                                                    // format for day in week
                                                    java.util.Locale localeVN = new java.util.Locale("vi", "VN");
                                                    java.time.format.DateTimeFormatter dayFormatter = 
                                                        java.time.format.DateTimeFormatter.ofPattern("EEEE", localeVN);

                                                    // format for date (day and month)
                                                    java.time.format.DateTimeFormatter dateFormatter = 
                                                        java.time.format.DateTimeFormatter.ofPattern("dd/MM");

                                                    // HTML file
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
                                <!--loop to get slot from db-->
                                <c:forEach var="slot" items="${timeSlots}">
                                    <tr>
                                        <td class="slot-time">${slot.slotThoiGian}</td>

                                        <c:forEach var="date" items="${weekDates}" varStatus="loop">
                                            <c:set var="dayOfWeek" value="${date.dayOfWeek.value}" />
                                            <c:set var="key" value="${slot.ID_SlotHoc}-${dayOfWeek}"/>
                                            <c:set var="lh" value="${scheduleMap[key]}" />

                                            <td>
                                                <c:if test="${not empty lh}">
                                                    <div class="class-info">
                                                        <div>
                                                            <div class="class-info-name">${lh.tenLopHoc}</div>
                                                            <div class="class-info-room"><i class="fas fa-map-marker-alt fa-xs"></i> ${lh.tenPhongHoc}</div>
                                                        </div>
                                                        <div class="mt-auto">
                                                            <c:choose>
                                                                <c:when test="${lh.coTheSua}">
                                                                    <a href="${pageContext.request.contextPath}/teacherGetFromDashboard?action=lichhoc&scheduleId=${lh.ID_Schedule}" 
                                                                       class="btn btn-sm ${lh.daDiemDanh ? 'status-done' : 'status-pending'} w-100">
                                                                       ${lh.daDiemDanh ? 'Đã Điểm Danh' : 'Điểm Danh'}
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-sm btn-secondary w-100" disabled>Đã Khóa</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
});
        </script>
    </body>
</html> 