<%-- 
    Document   : adminDashboard
    Created on : May 24, 2025, 2:44:16 PM
    Author     : wrx_Chur04
--%>

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
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                display: flex;
                min-height: 100vh;
                background-color: #f9f9f9;
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
                margin: 0 0 30px 0;
                font-weight: bold;
                letter-spacing: 1.5px;
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
                display: block;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            ul.sidebar-menu li a:hover {
                background-color: #163E5C;
            }

            .main-content {
                margin-left: 250px; /* Đẩy nội dung chính sang phải tương ứng với sidebar */
                padding: 20px 40px;
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
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                flex: 1 1 220px;
                text-align: center;
            }

            .stat-card h3 {
                margin-bottom: 15px;
                color: #1F4E79;
                font-weight: 700;
                font-size: 18px;
            }

            .stat-card p {
                font-size: 24px;
                font-weight: bold;
                margin: 0;
                color: #333;
            }

            .data-table-container {
                background: white;
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
                gap: 20px; /* khoảng cách giữa 2 bảng */
            }

            .tables-wrapper .data-table-container {
                background: white;
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

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table th, table td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: left;
            }

            .section-title {
                margin-bottom: 10px;
                color: #1F4E79;
            }

            .no-data {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <h4>EDU ADMIN</h4>

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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi">Học phí</a></li>
            </ul>

            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=khoahoc">Khoá học</a></li>
            </ul>

            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#">Cài đặt</a></li>
            </ul>

            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao">Thông báo</a></li>
                <li><a href="#">Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <!-- Dashboard Stats -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3>Tổng số học sinh</h3>
                    <%
                        Integer tongSoHocSinh = HocSinhDAO.adminGetTongSoHocSinh();
                    %>
                    <p><%= tongSoHocSinh %></p>
                </div>

                <div class="stat-card">
                    <h3>Tổng số giáo viên</h3>
                    <%
                        Integer tongSoGiaoVien = GiaoVienDAO.adminGetTongSoGiaoVien();
                    %>
                    <p><%= tongSoGiaoVien %></p>
                </div>

                <div class="stat-card">
                    <h3>Tổng số lớp học</h3>
                    <%
                        Integer tongSoLopHoc = LopHocDAO.adminGetTongSoLopHoc();
                    %>
                    <p><%= tongSoLopHoc %></p>
                </div>

                <div class="stat-card">
                    <h3>Tổng doanh thu</h3>
                    <p>300.000</p>
                </div>
            </div>

            <!-- User Logs -->
            <div class="tables-wrapper">
                <!-- Hoạt động gần đây -->
                <div class="data-table-container">
                    <h3 class="section-title">Hoạt động gần đây</h3>
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
                                <tbody>
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
                </div>

                <!-- Lịch Học -->
                <div class="data-table-container">
                    <h3 class="section-title">Lịch Học Hôm Nay</h3>
                    <%
                        
                        
                        java.time.LocalDate today = java.time.LocalDate.now();
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
                                        <th>Ngày Tạo</th>
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
    </body>
</html>
