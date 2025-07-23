<%-- 
    Document   : staffViewHocPhiTheoLopHoc
    Created on : Jul 23, 2025, 9:50:07 PM
    Author     : wrx_Chur04
--%>

```jsp
<%-- 
    Document   : staffDashboard
    Created on : Jul 13, 2025, 12:35:02 AM
    Author     : wrx_Chur04
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Dashboard - EL CENTRE</title>
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
            /* Message Box */
            .message-box {
                background: linear-gradient(135deg, #FFEBEE, #FFCDD2);
                color: #C62828;
                font-weight: bold;
                margin-bottom: 15px;
                padding: 10px;
                border-radius: 6px;
                text-align: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            /* Page Header */
            .page-header {
                margin-bottom: 20px;
            }
            .page-header h2 {
                font-size: 22px;
                color: #1F4E79;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
                border-left: 5px solid #1F4E79;
                padding-left: 12px;
            }
            .page-header h2 i {
                color: #1F4E79;
            }
            /* Top Bar */
            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 20px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            /* Action Bar */
            .action-bar {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .btn-action.btn-payment,
            .btn-action.btn-send-tuition-notice,
            .btn-action.back {
                background-color: #4CAF50;
                color: #fff;
                padding: 8px 14px;
                border-radius: 6px;
                font-size: 14px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                transition: background-color 0.3s ease;
                font-weight: 600;
            }
            .btn-action.btn-payment:hover,
            .btn-action.btn-send-tuition-notice:hover,
            .btn-action.back:hover {
                background-color: #388e3c;
            }
            /* Filter Bar */
            .filter-bar {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            .filter-group label {
                font-size: 14px;
                color: #1F4E79;
                font-weight: 600;
            }
            .filter-group input,
            .filter-group select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
                min-width: 150px;
            }
            .filter-group input:focus,
            .filter-group select:focus {
                border-color: #1F4E79;
                box-shadow: 0 0 5px rgba(31, 78, 121, 0.3);
            }
            .btn-filter {
                background-color: #1F4E79;
                color: #fff;
                padding: 8px 14px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .btn-filter:hover {
                background-color: #163E5C;
            }
            /* Data Table */
            .data-table-container {
                background: linear-gradient(to bottom right, #ffffff, #f7fafd);
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                margin-bottom: 20px;
            }
            .data-table-container table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }
            .data-table-container th,
            .data-table-container td {
                border: 1px solid #e0e0e0;
                padding: 10px 14px;
                text-align: left;
            }
            .data-table-container th {
                background-color: #E3F2FD;
                color: #0D47A1;
                font-weight: bold;
            }
            .data-table-container tbody tr:hover {
                background-color: #f1f8ff;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }
            /* No Data */
            .no-data {
                text-align: center;
                color: #777;
                padding: 20px;
                font-style: italic;
                background-color: #f9f9f9;
                border-radius: 6px;
            }
            .no-data .error-message {
                color: #C62828;
                font-weight: bold;
            }
            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin: 20px 0;
            }
            .pagination a {
                background-color: #1F4E79;
                color: #fff;
                padding: 8px 12px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }
            .pagination a:hover {
                background-color: #163E5C;
            }
            /* Back Button */
            .back-button {
                margin-top: 20px;
                text-align: center;
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
            <c:if test="${not empty message}">
                <div class="message-box">
                    ${message}
                </div>
            </c:if>

            <div class="page-header">
                <h2><i class="fas fa-money-bill-wave"></i> Học phí lớp ${sessionScope.tenlop} tháng </h2>
            </div>

            <div class="top-bar">
                <div class="action-bar">
                    

                </div>
                <form action="${pageContext.request.contextPath}/staffActionWithTuition" method="get">
                    <input type="hidden" name="action" value="filterHocPhi" />
                    <div class="filter-bar">
                        <div class="filter-group">
                            <label for="keyword">Từ khóa:</label>
                            <input type="text" id="keyword" name="keyword" placeholder="Tìm kiếm nội dung...">
                        </div>
                        <div class="filter-group">
                            <label for="thang">Lọc theo tháng</label>
                            <select id="thang" name="thang">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="nam">Lọc theo năm</label>
                            <select id="nam" name="nam">
                                <option value="2024">2024</option>
                                <option value="2025">2025</option>
                                <option value="2026">2026</option>
                            </select>
                        </div>
                        <button type="submit" class="btn-filter"><i class="fas fa-search"></i> Tìm kiếm</button>
                    </div>
                </form>
            </div>

            <c:choose>
                <c:when test="${not empty requestScope.hocphis}">
                    <div class="data-table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Mã Học Sinh</th>
                                    <th>Họ và Tên</th>
                                    <th>Số điện thoại phụ huynh</th>
                                    <th>Tháng</th>
                                    <th>Năm</th>
                                    <th>Số buổi có mặt</th>
                                    <th>Học Phí Phải Đóng</th>
                                    <th>Tình trạng thanh toán</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody id="notificationTableBody">
                                <c:forEach var="hp" items="${requestScope.hocphis}">
                                    <tr>
                                        <td>${hp.getMaHocSinh()}</td>
                                        <td>${hp.getHoTen()}</td>
                                        <td>${hp.getSDT_PhuHuynh()}</td>
                                        <td>${hp.getThang()}</td>
                                        <td>${hp.getNam()}</td>
                                        <td>${hp.getSoBuoi()}</td>
                                        <td>${hp.getHocPhiPhaiDong()} VND</td>
                                        <td>${hp.getTinhTrangThanhToan()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty hp.ngayThanhToan}">
                                                    ${hp.ngayThanhToan}
                                                </c:when>
                                                <c:otherwise>
                                                    Chưa đóng
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="action-buttons">
                                            <c:if test="${hp.getTinhTrangThanhToan() ne 'Đã thanh toán'}">
                                                <a class="btn-action btn-payment" href="${pageContext.request.contextPath}/staffActionWithTuition?action=dongtien&idLop=${hp.getID_LopHoc()}&idHocSinh=${hp.getID_HocSinh()}&thang=${hp.getThang()}&nam=${hp.getNam()}&soTienDong=${hp.getHocPhiPhaiDong()}&tenLopHoc=${tenlop}">
                                                    <i class="fas fa-money-bill-wave"></i> Đánh dấu là đã đóng tiền
                                                </a>
                                                <a class="btn-action btn-send-tuition-notice" href="${pageContext.request.contextPath}/staffActionWithTuition?action=guithongbao&idTaiKhoanHocSinh=${hp.getID_TaiKhoan()}&sodienthoai=${hp.getSDT_PhuHuynh()}&TenHocSinh=${hp.getHoTen()}&thang=${hp.getThang()}&nam=${hp.getNam()}&soTienDong=${hp.getHocPhiPhaiDong()}">
                                                    <i class="fas fa-paper-plane"></i> Gửi thông báo đóng học phí
                                                </a>

                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <c:if test="${not empty message}">
                            <p class="error-message">${message}</p>
                        </c:if>
                        <p>Không có dữ liệu học phí của lớp học để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div id="pagination" class="pagination"></div>

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/adminGoToFirstPage" class="btn-action back">
                    <i class="fas fa-arrow-left"></i> Quay lại trang chủ
                </a>
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
        </script>
    </body>
</html>
```
