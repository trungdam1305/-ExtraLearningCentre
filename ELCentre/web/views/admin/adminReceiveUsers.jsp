<%-- 
    Document   : adminReceiveUsers
    Created on : May 24, 2025, 10:03:15 PM
    Author     : chuvv
    Purpose    : This page manages user accounts in the EL CENTRE system, displaying details like ID, name, email, role, phone number, and status. 
                 It supports filtering by status and role, searching, pagination, and actions such as viewing, 
                 enabling/disabling, and updating accounts for admin users.
    Parameters:(Handle from adminGetFromDashboard servlet)
    - Method to get data from database in TaiKhoanChiTietDAO - (adminGetAllTaiKhoanHaveName)
    - @Param taikhoans (ArrayList<TaiKhoanChiTiet>): A session attribute containing the list of user account objects fetched from the database.
    - @Param message (String): An optional request or session attribute for displaying error or success messages.
--%>   

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý tài khoản</title>
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
                display: flex;
                min-height: 100vh;
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
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .header .left-title {
                font-size: 20px;
                font-weight: 600;
            }

            .admin-profile {
                display: flex;
                align-items: center;
                position: relative;
                cursor: pointer;
            }

            .admin-profile .admin-img {
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
                box-shadow: 0 2px 5px rgba(0,0,0,0.15);
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
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
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
                padding: 90px 30px 40px;
                background-color: var(--bg-color);
                flex-grow: 1;
            }

            .page-header {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }

            .page-header h2 {
                font-size: 24px;
                color: #1F4E79;
                display: flex;
                align-items: center;
                gap: 10px;
                margin: 0;
            }

            .filter-bar {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .filter-bar input[type="text"] {
                flex: 1;
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                min-width: 200px;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 600;
                font-size: 14px;
                color: #333;
            }

            .filter-group select {
                padding: 6px 10px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            .data-table-container {
                background-color: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            table th, table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
                vertical-align: middle;
            }

            table th {
                background-color: #e2eaf0;
                color: #1F4E79;
                font-weight: 600;
            }

            #pagination {
                margin-top: 15px;
                text-align: center;
            }

            #pagination button {
                margin: 0 4px;
                padding: 6px 10px;
                border: none;
                border-radius: 4px;
                background-color: #ddd;
                cursor: pointer;
                font-size: 14px;
            }

            #pagination button.active {
                background-color: #1F4E79;
                color: white;
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
                transition: background-color 0.2s;
            }

            .btn-action.view {
                background-color: #3498db;
                color: white;
            }

            .btn-action.disable {
                background-color: #e74c3c;
                color: white;
            }

            .btn-action.enable {
                background-color: #2ecc71;
                color: white;
            }

            .btn-action.update {
                background-color: #f39c12;
                color: white;
            }

            .btn-action:hover {
                opacity: 0.85;
            }

            .no-data {
                text-align: center;
                color: red;
                font-weight: 600;
                margin: 15px 0;
            }

            .back-button {
                text-align: right;
                margin-top: 20px;
            }

            .back-button a {
                text-decoration: none;
                color: #1F4E79;
                font-weight: 600;
            }

            .status-badge {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: bold;
                text-transform: uppercase;
                display: inline-block;
                min-width: 80px;
            }

            .status-badge.active {
                background-color: #d4f4dd;
                color: #2ecc71;
                border: 1px solid #2ecc71;
            }

            .status-badge.inactive {
                background-color: #fce1e1;
                color: #e74c3c;
                border: 1px solid #e74c3c;
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

        </style>
    </head>
    <body>
        <div class="header">
            <div class="left-title">
                Quản lý tài khoản <i class="fas fa-users-cog"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                      ArrayList<Admin> admins  = (ArrayList) AdminDAO.getNameAdmin();
                      
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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h2><i class="fas fa-users-cog"></i> Tất cả tài khoản</h2>
            </div>

            <div class="filter-bar">
                <input type="text" id="searchInput" placeholder="🔍 Tìm kiếm tài khoản...">

                <div class="filter-group">
                    <label for="statusFilter">Trạng thái:</label>
                    <select id="statusFilter">
                        <option value="all">Tất cả</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="roleFilter">Vai trò:</label>
                    <select id="roleFilter">
                        <option value="all">Tất cả</option>
                        <option value="hocsinh">Học sinh</option>
                        <option value="giaovien">Giáo viên</option>
                        <option value="phuhuynh">Phụ huynh</option>
                    </select>
                </div>
            </div>

            <c:if test="${not empty message}">
                <div class="no-data">${message}</div>
            </c:if>

            <div class="data-table-container">
                <c:choose>
                    <c:when test="${not empty sessionScope.taikhoans}">
                        <table id="userTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và Tên</th>
                                    <th>Email</th>
                                    <th>Vai Trò</th>
                                    <th>Số điện thoại</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tk" items="${sessionScope.taikhoans}">
                                    <tr>
                                        <td>${tk.ID_TaiKhoan}</td>
                                        <td>${tk.hoTen}</td>
                                        <td>${tk.email}</td>
                                        <td>${tk.userType}</td>
                                        <td>${tk.soDienThoai}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${tk.trangThai == 'Active'}">
                                                    <span class="status-badge active">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge inactive">Cấm hoạt động</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                       
                                        <td>
                                            <div class="action-buttons">
                                                <c:if test="${tk.userType != 'Staff'}">
                                                    <a class="btn-action view" href="${pageContext.request.contextPath}/adminActionWithUser?action=view&id=${tk.ID_TaiKhoan}&type=${tk.userType}"><i class="fas fa-eye"></i>Chi tiết</a> |
                                                </c:if>

                                                <c:choose>
                                                    <c:when test="${tk.trangThai == 'Active'}">
                                                        <a class="btn-action disable" href="${pageContext.request.contextPath}/adminActionWithUser?action=disable&id=${tk.ID_TaiKhoan}&type=${tk.userType}"><i class="fas fa-user-slash"></i>Vô hiệu hóa</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="btn-action enable" href="${pageContext.request.contextPath}/adminActionWithUser?action=enable&id=${tk.ID_TaiKhoan}&type=${tk.userType}"><i class="fas fa-user-check"></i>Kích hoạt</a>
                                                    </c:otherwise>
                                                </c:choose>

                                                <c:if test="${tk.userType != 'Admin'}">
                                                    |
                                                    <a class="btn-action update" href="${pageContext.request.contextPath}/adminActionWithUser?action=update&id=${tk.ID_TaiKhoan}&type=${tk.userType}"><i class="fas fa-edit"></i>Cập nhật</a>
                                                </c:if>
                                            </div>
                                        </td>

                                        
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">${message != null ? message : 'Không có dữ liệu tài khoản để hiển thị.'}</div>
                    </c:otherwise>
                </c:choose>

                <div id="pagination"></div>
            </div>

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
                if (profile && !profile.contains(event.target)) {
                    dropdown?.classList.remove('active');
                }
            });

            const messageDiv = document.querySelector('.no-data');
            if (messageDiv) {
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                }, 5000);
            }

            const searchInput = document.getElementById("searchInput");
            const statusFilter = document.getElementById("statusFilter");
            const roleFilter = document.getElementById("roleFilter");
            const table = document.querySelector("#userTable tbody");
            let allRows = [];
            let filteredRows = [];
            let currentPage = 1;
            const rowsPerPage = 14;

            function filterRows() {
                const keyword = searchInput.value.toLowerCase();
                const status = statusFilter.value;
                const role = roleFilter.value;

                filteredRows = allRows.filter(row => {
                    const cells = row.querySelectorAll("td");
                    if (cells.length < 6)
                        return false;

                    const statusText = cells[5].textContent.trim().toLowerCase();
                    const normalizedStatus = statusText.includes("cấm") ? "inactive" : "active";
                    const matchesStatus =
                            status === "all" ||
                            (status === "active" && normalizedStatus === "active") ||
                            (status === "inactive" && normalizedStatus === "inactive");

                    const matchesKeyword = Array.from(cells).slice(0, 4).some(cell =>
                        cell.textContent.toLowerCase().includes(keyword)
                    );

                    const matchesRole =
                            role === "all" ||
                            cells[3].textContent.toLowerCase().includes(role);

                    return matchesKeyword && matchesStatus && matchesRole;
                });

                currentPage = 1;
                renderPage();
            }

            function renderPage() {
                // Ẩn tất cả dòng
                allRows.forEach(row => row.style.display = "none");

                const start = (currentPage - 1) * rowsPerPage;
                const end = start + rowsPerPage;
                const pageRows = filteredRows.slice(start, end);

                pageRows.forEach(row => row.style.display = "");

                renderPagination();
            }

            function renderPagination() {
                const pagination = document.getElementById("pagination");
                pagination.innerHTML = "";

                const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
                if (totalPages <= 1)
                    return;

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
                    btn.style.backgroundColor = (i === currentPage) ? "#1F4E79" : "#ddd";
                    btn.style.color = (i === currentPage) ? "white" : "black";
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

            // Sự kiện lọc
            searchInput?.addEventListener("input", filterRows);
            statusFilter?.addEventListener("change", filterRows);
            roleFilter?.addEventListener("change", filterRows);

            // Khởi tạo sau khi DOM đã có <tr>
            window.addEventListener("DOMContentLoaded", () => {
                const tbody = document.querySelector("#userTable tbody");
                allRows = Array.from(tbody.rows);
                filteredRows = [...allRows]; // ban đầu là tất cả
                renderPage();
            });
        </script>

    </body>
</html> 