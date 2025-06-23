<!-- 
  Created on: May 24, 2025, 2:44:16 PM
  Author: wrx_Chur04
  Purpose: This admin dashboard page for the EL CENTRE system is designed to provide an overview of key 
  metrics including the number of students, teachers, classes, and revenue. It also tracks recent user activities, today's schedule, 
  and offers visual charts for attendance, student satisfaction, and monthly revenue analysis.
-->

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
        <title>Admin Dashboard</title>
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
                align-items: center; /* Center image and text horizontally */
                cursor: pointer;
                margin-left: 50px; /* Shift leftward */
            }

            .admin-profile .admin-img {
                width: 40px;
                height: 40px;
                border-radius: 50%; /* Ensure circular shape */
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
                margin-right: 40px; /* Extra space from the right */
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
                margin: 0 auto; /* Center horizontally in the sidebar column */
                font-weight: bold;
                letter-spacing: 1.5px;
                text-align: center; /* Ensure text is centered */
            }

            .sidebar-logo {
                width: 100px;
                height: 100px;
                border-radius: 50%; /* Make the logo circular */
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
                padding: 100px 40px 20px 40px; /* Increased padding-top to push content down */
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

            .charts-wrapper {
                display: flex;
                gap: 20px;
                margin-top: 20px;
            }

            .charts-wrapper .chart-container {
                flex: 1;
                margin: 0;
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .charts-bottom {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .charts-bottom .chart-container {
                width: 70%;
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .chart-container canvas {
                max-height: 300px;
            }
            
            #pagination button {
                margin: 0 5px;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            /* Footer Styles */
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
                Admin Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ </span>
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
                <li><a href="#">Dashboard</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý người dùng</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý tài chính</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=khoahoc"><i class="fas fa-book"></i> Khoá học</a></li>
            </ul>

            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
            </ul>

            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <!-- Dashboard Stats -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3><i class="fas fa-user-graduate"></i> Tổng số học sinh</h3>
                    <%
                        Integer tongSoHocSinh = HocSinhDAO.adminGetTongSoHocSinh();
                    %>
                    <p><%= tongSoHocSinh %></p>
                </div>

                <div class="stat-card">
                    <h3><i class="fas fa-chalkboard-teacher"></i> Tổng số giáo viên</h3>
                    <%
                        Integer tongSoGiaoVien = GiaoVienDAO.adminGetTongSoGiaoVien();
                    %>
                    <p><%= tongSoGiaoVien %></p>
                </div>

                <div class="stat-card">
                    <h3><i class="fas fa-school"></i> Tổng số lớp học</h3>
                    <%
                        Integer tongSoLopHoc = LopHocDAO.adminGetTongSoLopHoc();
                    %>
                    <p><%= tongSoLopHoc %></p>
                </div>

                <div class="stat-card">
                    <h3><i class="fas fa-money-bill"></i> Tổng doanh thu</h3>
                    <p>300.000</p>
                </div>
            </div>

            <!-- User Logs and Schedule -->
            <div class="tables-wrapper">
                <!-- Hoạt động gần đây -->
                <div class="data-table-container">
                    <h3 class="section-title"><i class="fas fa-history"></i> Hoạt động gần đây</h3>
                    <%
                      ArrayList<UserLogView> userLogsList = (ArrayList) UserLogsDAO.adminGetAllUserLogs();
                      request.setAttribute("userLogsList", userLogsList);
                    %>
                    <c:choose>
                        <c:when test="${not empty userLogsList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID_Tài Khoản</th>
                                        <th>Họ và Tên</th>
                                        <th>Hành Động</th>
                                        <th>Thời Gian</th>
                                    </tr>
                                </thead>
                                <tbody id="userLogTableBody">
                                    <c:forEach var="log" items="${userLogsList}">
                                        <tr>
                                            <td>${log.getID_TaiKhoan()}</td>
                                            <td>${log.getHoTen()}</td>
                                            <td>${log.getHanhDong()}</td>
                                            <td>${log.getThoiGian()}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="no-data">Không có dữ liệu nhật ký để hiển thị.</p>
                        </c:otherwise>
                    </c:choose>
                            <div id="pagination" style="text-align:center; margin-top: 20px;"></div>
                </div>

                <!-- Lịch Học -->
                <div class="data-table-container">
                    <h3 class="section-title">Lịch Học Hôm Nay</h3>
                    <%
                        LocalDate today = LocalDate.now();
                        String ngayHienTai = today.toString();
                        ArrayList<LichHoc> lichHocList = (ArrayList) LichHocDAO.adminGetAllLichHoc(ngayHienTai);
                        request.setAttribute("lichHocList", lichHocList);
                    %>
                    <c:choose>
                        <c:when test="${not empty lichHocList}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID Schedule</th>
                                        <th>Ngày Học</th>
                                        <th>Giờ Học</th>
                                        <th>ID Lớp Học</th>
                                        <th>Ghi Chú</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="lich" items="${lichHocList}">
                                        <tr>
                                            <td>${lich.getID_Schedule()}</td>
                                            <td>${lich.getNgayHoc()}</td>
                                            <td>${lich.getGioHoc()}</td>
                                            <td>${lich.getID_LopHoc()}</td>
                                            <td>${lich.getGhiChu()}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="no-data">Không có dữ liệu lịch học để hiển thị.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Charts Wrapper (Top Row) -->
            <div class="charts-wrapper">
                <!-- Attendance Report Chart -->
                <div class="data-table-container chart-container">
                    <h3 class="section-title"><i class="fas fa-chart-pie"></i> Báo cáo điểm danh</h3>
                    <div class="chart-container">
                        <canvas id="attendanceChart"></canvas>
                    </div>
                </div>

                <!-- Student Satisfaction Report Chart -->
                <div class="data-table-container chart-container">
                    <h3 class="section-title"><i class="fas fa-chart-pie"></i> Báo cáo mức độ hài lòng của học sinh</h3>
                    <div class="chart-container">
                        <canvas id="satisfactionChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Charts Bottom (Revenue Report) -->
            <div class="charts-bottom">
                <div class="data-table-container chart-container">
                    <h3 class="section-title"><i class="fas fa-chart-bar"></i> Báo cáo thống kê doanh thu theo tháng</h3>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>

        <script>
            // Toggle Dropdown Menu
            function toggleDropdown() {
                const dropdown = document.getElementById('adminDropdown');
                dropdown.classList.toggle('active');
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });

            // Attendance Chart (Enhanced Pie Chart)
            const attendanceCtx = document.getElementById('attendanceChart').getContext('2d');
            const attendanceGradient = attendanceCtx.createLinearGradient(0, 0, 200, 0);
            attendanceGradient.addColorStop(0, '#1F4E79');
            attendanceGradient.addColorStop(1, '#4A90E2');
            new Chart(attendanceCtx, {
                type: 'pie',
                data: {
                    labels: ['Học sinh có mặt', 'Học sinh vắng'],
                    datasets: [{
                        data: [45, 5],
                        backgroundColor: [attendanceGradient, '#E57373'],
                        borderColor: '#ffffff',
                        borderWidth: 3,
                        borderRadius: 5,
                        hoverOffset: 15
                    }]
                },
                
            });

            // Student Satisfaction Chart (Doughnut Chart)
            const satisfactionCtx = document.getElementById('satisfactionChart').getContext('2d');
            const satisfactionGradient = satisfactionCtx.createLinearGradient(0, 0, 200, 0);
            satisfactionGradient.addColorStop(0, '#8E24AA');
            satisfactionGradient.addColorStop(1, '#CE93D8');
            new Chart(satisfactionCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Hài lòng', 'Không hài lòng'],
                    datasets: [{
                        data: [80, 20],
                        backgroundColor: [satisfactionGradient, '#F06292'],
                        borderColor: '#ffffff',
                        borderWidth: 3,
                        borderRadius: 5,
                        hoverOffset: 15
                    }]
                },
                
            });

            // Revenue Chart (Bar Chart)
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            const revenueGradient = revenueCtx.createLinearGradient(0, 0, 0, 400);
            revenueGradient.addColorStop(0, '#2E7D32');
            revenueGradient.addColorStop(1, '#81C784');
            new Chart(revenueCtx, {
                type: 'bar',
                data: {
                    labels: ['Tháng 1/2025', 'Tháng 2/2025', 'Tháng 3/2025', 'Tháng <%= today.getMonthValue() %>/<%= today.getYear() %>'],
                    datasets: [{                                                                                                                                                                                                    
                        label: 'Doanh thu (VND)',
                        data: [1500000, 1800000, 2000000, 2500000],
                        backgroundColor: revenueGradient,
                        borderColor: '#2E7D32',
                        borderWidth: 2,
                        borderRadius: 5,
                        hoverBackgroundColor: '#A5D6A7'
                    }]
                },
                
            });




            
            // Số dòng muốn hiển thị mỗi trang
            var soDongMoiTrang = 10;

            // Lấy tất cả dòng (tr) trong bảng giáo viên
            var tatCaDong = document.querySelectorAll("#userLogTableBody tr");

            // Tổng số trang = tổng số dòng chia cho số dòng mỗi trang (làm tròn lên)
            var tongSoTrang = Math.ceil(tatCaDong.length / soDongMoiTrang);

            // Nơi hiển thị các nút phân trang
            var phanTrangDiv = document.getElementById("pagination");

            // Hàm hiển thị trang số "trang"
            function hienThiTrang(trang) {
                // Ẩn tất cả dòng
                for (var i = 0; i < tatCaDong.length; i++) {
                    tatCaDong[i].style.display = "none";
                }

                // Hiện các dòng thuộc trang đang chọn
                var batDau = (trang - 1) * soDongMoiTrang;
                var ketThuc = batDau + soDongMoiTrang;
                for (var i = batDau; i < ketThuc && i < tatCaDong.length; i++) {
                    tatCaDong[i].style.display = "";
                }

                // Tạo lại các nút phân trang
                phanTrangDiv.innerHTML = "";
                for (var j = 1; j <= tongSoTrang; j++) {
                    var nut = document.createElement("button");
                    nut.innerText = j;

                    // Khi bấm vào nút thì sẽ gọi lại chính hàm này với số trang mới
                    nut.onclick = (function(trangDuocChon) {
                        return function() {
                            hienThiTrang(trangDuocChon);
                        };
                    })(j);

                    // Tô màu cho trang đang chọn
                    if (j === trang) {
                        nut.style.backgroundColor = "#1F4E79";
                        nut.style.color = "white";
                    }

                    phanTrangDiv.appendChild(nut);
                }
            }

            // Lần đầu gọi hàm để hiện trang 1
            hienThiTrang(1);
        </script>
    </body>
</html> 