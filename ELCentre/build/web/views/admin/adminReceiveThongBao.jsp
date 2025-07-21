        <%-- 
    Document   : adminReceiveThongBao
    Created on : May 29, 2025, 4:12:42 PM
    Author     : chuvv
    Purpose    : This page displays a list of sent notifications (thông báo) in the EL CENTRE system, 
                 including notification ID, account ID, content, associated tuition fee ID, and timestamp. 
                 Supports filtering by date range and recipient type, with pagination and action buttons.
    Parameters:
    - @Param thongbaos (ArrayList<ThongBao>): A request attribute containing the list of notification objects fetched from the database.
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <title>Quản lý thông báo</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            :root {
                --main-color: #1F4E79;
                --hover-color: #163E5C;
                --accent-color: #B0C4DE;
                --bg-color: #f4f6f8;
                --text-color: #333;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
            }

            .header {
                background-color: var(--main-color);
                color: white;
                padding: 12px 24px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: fixed;
                top: 0;
                left: 250px;
                right: 0;
                z-index: 1000;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                transition: background-color 0.3s;
            }

            .header .left-title {
                font-size: 20px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .admin-profile {
                display: flex;
                align-items: center;
                position: relative;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .admin-img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                margin-right: 10px;
            }

            .admin-profile span {
                color: var(--accent-color);
                font-weight: 600;
                max-width: 180px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .admin-profile i {
                color: var(--accent-color);
                margin-left: 8px;
            }

            .dropdown-menu {
                position: absolute;
                top: 48px;
                right: 0;
                background-color: var(--hover-color);
                display: none;
                border-radius: 4px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
                min-width: 160px;
                z-index: 1001;
            }

            .dropdown-menu.active {
                display: block;
            }

            .dropdown-menu a {
                display: block;
                color: white;
                padding: 10px 15px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .dropdown-menu a:hover {
                background-color: var(--main-color);
            }

            .sidebar {
                width: 250px;
                background-color: var(--main-color);
                color: white;
                position: fixed;
                height: 100vh;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar h4 {
                text-align: center;
                font-weight: bold;
                letter-spacing: 1px;
            }

            .sidebar-logo {
                display: block;
                margin: 15px auto;
                width: 90px;
                height: 90px;
                border-radius: 50%;
                border: 2px solid var(--accent-color);
                object-fit: cover;
            }

            .sidebar-section-title {
                margin-top: 25px;
                font-size: 13px;
                color: var(--accent-color);
                text-transform: uppercase;
                border-bottom: 1px solid var(--accent-color);
                padding-bottom: 5px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 10px 0;
            }

            .sidebar-menu li {
                margin: 8px 0;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                color: white;
                text-decoration: none;
                padding: 8px 12px;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .sidebar-menu a:hover {
                background-color: var(--hover-color);
            }

            .sidebar-menu a i {
                margin-right: 10px;
            }

            .main-content {
                margin-left: 250px;
                padding: 100px 40px 60px;
                background-color: var(--bg-color);
                min-height: 100vh;
                box-sizing: border-box;
            }

            .page-header {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .page-header h2 {
                font-size: 24px;
                color: var(--main-color);
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 0;
            }

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 20px;
            }

            .action-bar {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                align-items: center;
            }

            .filter-bar {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: center;
                flex-grow: 1;
                justify-content: flex-end;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 600;
                font-size: 14px;
                color: var(--text-color);
            }

            .filter-group input[type="text"],
            .filter-group select {
                padding: 8px 12px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                transition: border-color 0.3s;
            }

            .filter-group input[type="text"]:focus,
            .filter-group select:focus {
                border-color: var(--main-color);
                outline: none;
            }

            .filter-group input[type="text"] {
                min-width: 200px;
                flex-grow: 1;
            }

            .filter-bar button {
                padding: 8px 14px;
                background-color: var(--main-color);
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s;
            }

            .filter-bar button:hover {
                background-color: var(--hover-color);
            }

            .data-table-wrapper {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
            }

            table th, table td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: center;
                vertical-align: middle;
            }

            table th {
                background-color: #e2eaf0;
                color: var(--main-color);
                font-weight: 600;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #f1f4f8;
            }

            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-action {
                padding: 6px 12px;
                border: none;
                border-radius: 5px;
                font-size: 13px;
                cursor: pointer;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.3s;
            }

            .btn-action.send {
                background-color: #2ecc71;
                color: white;
            }

            .btn-action.all-students {
                background-color: #3498db;
                color: white;
            }

            .btn-action.all-teachers {
                background-color: #2ecc71;
                color: white;
            }

            .btn-action.all-classes {
                background-color: #f39c12;
                color: white;
            }

            .btn-action.notification-history {
                background-color: #9b59b6;
                color: white;
            }


            .btn-action:hover {
                opacity: 0.85;
            }

            .btn-action:focus {
                outline: 2px solid var(--main-color);
                outline-offset: 2px;
            }

            .notification-forms {
                display: flex;
                gap: 20px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .notification-form {
                flex: 1;
                min-width: 300px;
                background-color: #ffffff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
            }

            .notification-form label {
                font-weight: 600;
                font-size: 14px;
                color: var(--text-color);
                display: block;
                margin-bottom: 8px;
            }

            .notification-form textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                resize: vertical;
                min-height: 100px;
                transition: border-color 0.3s;
            }

            .notification-form textarea:focus {
                border-color: var(--main-color);
                outline: none;
            }

            .no-data {
                text-align: center;
                color: red;
                font-weight: 600;
                margin: 20px 0;
            }

            #pagination {
                margin-top: 20px;
                text-align: center;
            }

            #pagination button {
                margin: 0 4px;
                padding: 8px 12px;
                border: none;
                border-radius: 4px;
                background-color: #ddd;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s, color 0.3s;
            }

            #pagination button.active {
                background-color: var(--main-color);
                color: white;
            }

            #pagination button:hover:not(.active) {
                background-color: var(--hover-color);
                color: white;
            }

            .back-button {
                text-align: right;
                margin-top: 20px;
            }

            .back-button a {
                text-decoration: none;
                color: var(--main-color);
                font-weight: 600;
                transition: color 0.3s;
            }

            .back-button a:hover {
                color: var(--hover-color);
            }

            .footer {
                background-color: var(--main-color);
                color: var(--accent-color);
                text-align: center;
                padding: 10px;
                font-size: 13px;
                position: fixed;
                bottom: 0;
                left: 250px;
                right: 0;
            }

            @media (max-width: 768px) {
                .header {
                    left: 0;
                }

                .sidebar {
                    display: none;
                }

                .main-content {
                    margin-left: 0;
                    padding: 80px 20px 60px;
                }

                .top-bar {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .filter-bar {
                    justify-content: center;
                    width: 100%;
                }

                .filter-group input[type="text"] {
                    min-width: 100%;
                }

                .notification-forms {
                    flex-direction: column;
                }

                .notification-form {
                    min-width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="left-title">
                Quản lý thông báo <i class="fas fa-bell"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                    ArrayList<Admin> admins = AdminDAO.getNameAdmin();
                %>
                <img src="<%= admins.get(0).getAvatar() %>" alt="Admin Photo" class="admin-img">
                <span><%= admins.get(0).getHoTen() %></span>
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
                <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
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
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
                <li><a href="${pageContext.request.contextPath}/ManageSchedule"><i class="fas fa-calendar-alt"></i> Lịch học</a></li>
            </ul>
            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <c:if test="${not empty message}">
                <div style="color: red; font-weight: bold; margin-bottom: 15px; text-align: center;">
                    ${message}
                </div>
            </c:if>
            <div class="page-header">
                <h2><i class="fas fa-bell"></i> Gửi thông báo đến các lớp học</h2>
            </div>

            <div class="top-bar">
                <div class="action-bar">
                    <a href="${pageContext.request.contextPath}/views/admin/adminSendNotificationToAllStudent.jsp" class="btn-action all-students">
                        <i class="fas fa-user-graduate"></i> Gửi tất cả học sinh
                    </a>
                    <a href="${pageContext.request.contextPath}/views/admin/adminSendNotificationToAllTeacher.jsp" class="btn-action all-teachers">
                        <i class="fas fa-chalkboard-teacher"></i> Gửi tất cả giáo viên
                    </a>
                    <a href="${pageContext.request.contextPath}/views/admin/adminSendNotificationToAllClass.jsp" class="btn-action all-classes">
                        <i class="fas fa-users"></i> Gửi toàn bộ lớp học
                    </a>
                    <a href="${pageContext.request.contextPath}/adminActionWithNotification?action=historyNotification" class="btn-action notification-history">
                        <i class="fas fa-history"></i> Xem lịch sử thông báo
                    </a>
                        
                </div>
                <form action="${pageContext.request.contextPath}/adminActionWithNotification" method="get">
                    <div class="filter-bar">
                        <div class="filter-group">
                            <label for="keyword">Từ khóa:</label>
                            <input type="text" id="keyword" name="keyword" placeholder="Tìm kiếm nội dung...">
                        </div>
                        <div class="filter-group">
                            <label for="khoi">Lọc theo khối</label>
                            <select id="khoi" name="khoi">
                                <option value="">Tất cả</option>
                                <option value="1">6</option>
                                <option value="2">7</option>
                                <option value="3">8</option>
                                <option value="4">9</option>
                                <option value="5">10</option>
                                <option value="6">11</option>
                                <option value="7">12</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="mon">Lọc theo môn học</label>
                            <select id="mon" name="mon">
                                <option value="">Tất cả</option>
                                <option value="Toán">Toán</option>
                                <option value="Vật lý">Vật lý</option>
                                <option value="Hóa học">Hóa học</option>
                            </select>
                        </div>
                        <button><i class="fas fa-search"></i></button>
                    </div>
                </form>
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.lophocs}">
                    <div class="data-table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Tên môn học</th>
                                    <th>Khối</th>
                                    <th>Lớp học số</th>
                                    <th>Tên lớp học</th>
                                    <th>Sĩ số</th>
                                    <th>Tên giáo viên</th>
                                    <th>Ghi chú</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody id="notificationTableBody">
                                <c:forEach var="lop" items="${sessionScope.lophocs}">
                                    <tr>
                                        <td>${lop.getTenKhoaHoc()}</td>
                                        <td>${lop.getID_Khoi()}</td>
                                        <td>${lop.getID_LopHoc()}</td>
                                        <td>${lop.getTenLopHoc()}</td>
                                        <td>${lop.getSiSo()}</td>
                                        <td>${lop.getHoTen()}</td>
                                        <td>${lop.getGhiChu()}</td>
                                        <td>${lop.getNgayTao()}</td>
                                        <td class="action-buttons">
                                            <a class="btn-action send" href="${pageContext.request.contextPath}/views/admin/adminSendNotificationToClass.jsp?idLop=${lop.getID_LopHoc()}">
                                                <i class="fas fa-paper-plane"></i> Gửi thông báo
                                            </a>
                                            <a class="btn-action send" href="${pageContext.request.contextPath}/adminActionWithNotification?type=historyNotificationClass?idLop=${lop.getID_LopHoc()}">
                                                <i class="fas fa-paper-plane"></i> Lịch sử thông báo lớp học
                                            </a>
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
                            <p style="color: red;">${message}</p>
                        </c:if>
                        <p>Không có dữ liệu lớp học để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div id="pagination"></div>

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/adminGoToFirstPage">← Quay lại trang chủ</a>
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

            const tableBody = document.getElementById("notificationTableBody");
            let allRows = [], filteredRows = [], currentPage = 1;
            const rowsPerPage = 12;

            window.onload = () => {
                if (tableBody) {
                    allRows = Array.from(tableBody.querySelectorAll("tr"));
                    filteredRows = [...allRows];
                    renderPage();
                }
            };

            function renderPage() {
                tableBody.innerHTML = "";
                const start = (currentPage - 1) * rowsPerPage;
                const end = start + rowsPerPage;
                filteredRows.slice(start, end).forEach(row => tableBody.appendChild(row));
                renderPagination();
            }

            function renderPagination() {
                const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
                const pagination = document.getElementById("pagination");
                pagination.innerHTML = "";

                const maxPagesToShow = 3;
                let startPage = Math.max(1, currentPage - 1);
                let endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);

                if (endPage - startPage + 1 < maxPagesToShow) {
                    startPage = Math.max(1, endPage - maxPagesToShow + 1);
                }

                if (currentPage > 1) {
                    const prevBtn = document.createElement("button");
                    prevBtn.textContent = "«";
                    prevBtn.onclick = () => {
                        currentPage--;
                        renderPage();
                    };
                    pagination.appendChild(prevBtn);
                }

                for (let i = startPage; i <= endPage; i++) {
                    const btn = document.createElement("button");
                    btn.textContent = i;
                    btn.className = i === currentPage ? "active" : "";
                    btn.onclick = () => {
                        currentPage = i;
                        renderPage();
                    };
                    pagination.appendChild(btn);
                }

                if (currentPage < totalPages) {
                    const nextBtn = document.createElement("button");
                    nextBtn.textContent = "»";
                    nextBtn.onclick = () => {
                        currentPage++;
                        renderPage();
                    };
                    pagination.appendChild(nextBtn);
                }
            }
        </script>
    </body>
</html>