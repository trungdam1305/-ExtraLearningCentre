<%-- 
    Document   : staffDashboard
    Created on : Jul 13, 2025, 12:35:02 AM
    Author     : wrx_Chur04
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="dal.HocPhiDAO" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Dashboard - EL CENTRE</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                overflow-y: auto;
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
                padding: 100px 40px 20px 40px;
                flex: 1;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                gap: 30px;
                background-color: #f4f6f8;
            }
            .dashboard-stats {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }
            .stat-card {
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                flex: 1 1 220px;
                text-align: center;
                transition: transform 0.2s;
                color: white;
            }
            .stat-card:hover {
                transform: translateY(-5px);
            }
            .stat-card h3 {
                margin-bottom: 15px;
                color: inherit;
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
                font-size: 28px;
                font-weight: bold;
                margin: 0;
                color: inherit;
            }
            .data-table-container {
                background: linear-gradient(to bottom right, #ffffff, #f7fafd);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.08);
                flex: 1 1 48%;
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
                padding: 10px 14px;
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
            .tables-wrapper {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }
            .charts-wrapper {
                display: flex;
                gap: 20px;
                margin-top: 20px;
            }
            .chart-container {
                flex: 1;
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            .chart-container canvas {
                max-height: 300px;
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
            #searchLogInput {
                padding: 8px 12px;
                width: 100%;
                margin-bottom: 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
            }
            .btn-action.update {
                display: inline-flex;
                align-items: center;
                background-color: #4CAF50;
                color: #fff;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 13px;
                text-decoration: none;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            .btn-action.update i {
                margin-right: 6px;
            }
            .btn-action.update:hover {
                background-color: #388e3c;
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
            .stat-tuvan {
                background: linear-gradient(135deg, #FFEBEE, #FFCDD2);
                color: #C62828;
            }
            .stat-salary {
                background: linear-gradient(135deg, #E0F7FA, #B2EBF2);
                color: #006064;
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

        <div class="main-content">
            <!-- Dashboard Stats -->
            <div class="dashboard-stats">
                <div class="stat-card stat-hocsinh">
                    <h3><i class="fas fa-user-graduate"></i> Tổng số học sinh đang học</h3>
                    <p>${tongHS}</p>
                </div>
                <div class="stat-card stat-giaovien">
                    <h3><i class="fas fa-chalkboard-teacher"></i> Tổng số giáo viên đang dạy</h3>
                    <p>${tongGV}</p>
                </div>
                <div class="stat-card stat-lophoc">
                    <h3><i class="fas fa-school"></i> Tổng số lớp học đang học</h3>
                    <p>${tongLH}</p>
                </div>
                <div class="stat-card stat-tuvan">
                    <h3><i class="fas fa-envelope-open-text"></i> Tổng đơn đăng ký tư vấn chưa duyệt</h3>
                    <p>${tongSoDonTuVan}</p>
                </div>
                <div class="stat-card stat-hocsinh">
                    <h3><i class="fas fa-user-clock"></i> Tổng số học sinh chờ lớp</h3>
                    <p>${hsChoHoc}</p>
                </div>
            </div>

            <!-- Support Requests Table -->
            <div class="tables-wrapper">
                <div class="data-table-container">
                    <h3 class="section-title"><i class="fas fa-envelope-open-text"></i> Yêu Cầu Hỗ Trợ Từ Người Dùng</h3>
                    <input type="text" id="searchLogInput" placeholder="Tìm kiếm..." oninput="searchLogs()">
                    <c:choose>
                        <c:when test="${not empty HoTroList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Họ Tên</th>
                                        <th>Vai Trò</th>
                                        <th>Số Điện Thoại</th>
                                        <th>Yêu Cầu</th>
                                        <th>Mô Tả</th>
                                        <th>Thời Gian</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody id="userHoTroTableBody">
                                    <c:forEach var="sp" items="${HoTroList}">
                                        <tr>
                                            <td>${sp.getHoTen()}</td>
                                            <td>${sp.getVaiTro()}</td>
                                            <td>${sp.getSoDienThoai()}</td>
                                            <td>${sp.getTenHoTro()}</td>
                                            <td>${sp.getMoTa()}</td>
                                            <td>${sp.getThoiGian()}</td>
                                            <td>
                                                <a class="btn-action update" href="${pageContext.request.contextPath}/staffActionWithSupport?action=handle&id=${sp.getID_HoTro()}">
                                                    <i class="fas fa-check-circle"></i> Duyệt nhanh
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">Không có yêu cầu nào ...</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Consultation Requests Table -->
                <div class="data-table-container">
                    <h3 class="section-title"><i class="fas fa-blog"></i> Yêu Cầu Tư Vấn Chưa Duyệt</h3>
                    <input type="text" id="searchConsultationInput" placeholder="Tìm kiếm..." oninput="searchConsultations()">
                    <c:choose>
                        <c:when test="${not empty requestScope.ConsultationList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nội dung</th>
                                        <th>Thời gian</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="tb" items="${requestScope.ConsultationList}">
                                        <tr>
                                            <td>${tb.ID_ThongBao}</td>
                                            <td>${tb.noiDung}</td>
                                            <td>${tb.thoiGian}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/views/sendAdviceMail.jsp" method="get">

                                                    <input type="hidden" name="id" value="${tb.ID_ThongBao}" />
                                                    <button type="submit">Gửi email tư vấn</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">
                                <p>Không có yêu cầu tư vấn nào.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Attendance Chart -->
            <div class="charts-wrapper">
                <div class="data-table-container chart-container">
                    <h3 class="section-title"><i class="fas fa-chart-pie"></i> Báo cáo điểm danh ngày hôm nay</h3>
                    <div class="chart-container">
                        <canvas id="attendanceChart"></canvas>
                    </div>
                </div>
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

            document.addEventListener('click', function (event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });

            function searchLogs() {
                const input = document.getElementById('searchLogInput').value.toLowerCase();
                const rows = document.querySelectorAll('#userHoTroTableBody tr');
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    const text = Array.from(cells).map(cell => cell.textContent.toLowerCase()).join(' ');
                    row.style.display = text.includes(input) ? '' : 'none';
                });
            }

            function searchConsultations() {
                const input = document.getElementById('searchConsultationInput').value.toLowerCase();
                const rows = document.querySelectorAll('#consultationTableBody tr');
                rows.forEach(row => {
                    const cells = row.querySelectorAll('td');
                    const text = Array.from(cells).map(cell => cell.textContent.toLowerCase()).join(' ');
                    row.style.display = text.includes(input) ? '' : 'none';
                });
            }

            <% 
                Integer tongSoHocSinhDiHoc = HocPhiDAO.adminTinhDiemDanhHomNay();
                Integer tongSoHocSinhKhongDiHoc = HocPhiDAO.adminTinhVangHomNay();
            %>
            const tongsohocsinhhocc = <%= tongSoHocSinhDiHoc %>;
            const tongsohocsinhvang = <%= tongSoHocSinhKhongDiHoc %>;
            const attendanceCtx = document.getElementById('attendanceChart').getContext('2d');
            const attendanceGradient = attendanceCtx.createLinearGradient(0, 0, 200, 0);
            attendanceGradient.addColorStop(0, '#1F4E79');
            attendanceGradient.addColorStop(1, '#4A90E2');
            new Chart(attendanceCtx, {
                type: 'pie',
                data: {
                    labels: ['Học sinh có mặt', 'Học sinh vắng'],
                    datasets: [{
                            data: [tongsohocsinhhocc, tongsohocsinhvang],
                            backgroundColor: [attendanceGradient, '#E57373'],
                            borderColor: '#ffffff',
                            borderWidth: 3,
                            borderRadius: 5,
                            hoverOffset: 15
                        }]
                }
            });
        </script>
    </body>
</html>