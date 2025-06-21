<%-- 
    Document   : adminReceiveUsers
    Created on : May 24, 2025, 10:03:15 PM
    Author     : wrx_Chur04
    Purpose    : This page manages user accounts in the EL CENTRE system, displaying details like ID, email, role, phone number, and status. 
                 It supports filtering by status and role, searching, pagination, and actions such as viewing, 
                 enabling/disabling, and updating accounts for admin users.
    Parameters:
    - @Param taikhoans (ArrayList<TaiKhoan>): A session attribute containing the list of user account objects fetched from the database.
    - @Param message (String): An optional request or session attribute for displaying error or success messages.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý tài khoản</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f8fb;
                color: #1F4E79;
                margin: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            h2 {
                text-align: center;
                color: #1F4E79;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px auto;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                max-height: 70vh; /* Prevent table from taking over entire space */
                overflow-y: auto; /* Allow scrolling if content exceeds */
            }

            th, td {
                padding: 10px 12px;
                border: 1px solid #d0d7de;
                text-align: center;
            }

            th {
                background-color: #1F4E79;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f0f4f8;
            }

            tr:hover {
                background-color: #d9e4f0;
            }

            .no-data {
                text-align: center;
                margin: 30px;
                color: red;
                display: block;
                flex: 0 0 auto;
                z-index: 1000; /* Higher z-index to ensure it stays on top */
                position: relative; /* Ensure it respects layout */
                background-color: rgba(255, 255, 255, 0.8); /* Temporary background to debug visibility */
            }

            .back-button {
                text-align: center;
                margin-top: 30px;
            }

            .back-button a {
                background-color: #1F4E79;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }

            .back-button a:hover {
                background-color: #163b5c;
            }

            input[type="text"], select {
                padding: 8px;
                font-size: 16px;
                margin-bottom: 15px;
            }

            #pagination {
                text-align: center;
                margin: 15px 0;
            }

            #pagination button {
                margin: 0 5px;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: #ddd;
                color: #333;
            }

            #pagination button.active {
                background-color: #1F4E79;
                color: white;
            }

            .action-link {
                background-color: #1F4E79;
                color: white;
                padding: 6px 12px;
                margin: 2px;
                text-decoration: none;
                border-radius: 4px;
                display: inline-block;
                transition: background-color 0.3s;
                font-size: 14px;
            }

            .action-link:hover {
                background-color: #163b5c;
            }

            /* Header Styles */
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 10px 20px;
                text-align: left;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-bottom: 20px;
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

            .header .left-title img {
                width: 90px;
                height: 90px;
                margin-right: 10px;
                border-radius: 5px;
                object-fit: contain;
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

            /* Footer Styles */
            .footer {
                background-color: #1F4E79;
                color: #B0C4DE;
                text-align: center;
                padding: 10px 0;
                margin-top: auto;
            }

            .footer p {
                margin: 0;
                font-size: 14px;
            }

            /* Ensure main content pushes footer down */
            .main-content {
                flex: 1 0 auto;
                padding-bottom: 60px; /* Increased padding to ensure space for message */
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header">
            <div class="left-title">
                <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
                EL CENTRE <i class="fas fa-users"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ</span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="adminDropdown">
                    <a href="#"><i class="fas fa-key"></i> Change Password</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Update Information</a>
                </div>
            </div>
        </div>

        <div class="main-content">
            <h2>Quản lý tài khoản</h2>

            <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
                <input type="text" id="searchInput" placeholder="Tìm kiếm...">

                <label for="statusFilter" style="margin: 0;">Lọc theo trạng thái:</label>
                <select id="statusFilter">
                    <option value="all">Tất cả</option>
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                </select>

                <label for="roleFilter" style="margin: 0;">Lọc theo vai trò:</label>
                <select id="roleFilter">
                    <option value="all">Tất cả</option>
                    <option value="hocsinh">Học sinh</option>
                    <option value="giaovien">Giáo viên</option>
                    <option value="phuhuynh">Phụ huynh</option>
                </select>
            </div>

            <!-- Debug and Message Display -->
            <c:if test="${not empty message}">
                <div class="no-data">
                    <p>${message}</p>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty sessionScope.taikhoans}">
                    <table id="userTable">
                        <thead>
                            <tr>
                                <th>ID</th>
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
                                    <td>${tk.email}</td>
                                    <td>${tk.userType}</td>
                                    <td>${tk.soDienThoai}</td>
                                    <td>${tk.trangThai}</td>
                                    <td>
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithUser?action=view&id=${tk.ID_TaiKhoan}&type=${tk.userType}">View</a> |
                                        <c:choose>
                                            <c:when test="${tk.trangThai == 'Active'}">
                                                <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithUser?action=disable&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Disable</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithUser?action=enable&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Enable</a>
                                            </c:otherwise>
                                        </c:choose>
                                        |
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWithUser?action=update&id=${tk.ID_TaiKhoan}&type=${tk.userType}">Update</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-data">
                        <p>${message != null ? message : 'Không có dữ liệu tài khoản để hiển thị.'}</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div id="pagination" style="text-align: center; margin-top: 15px;"></div>

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>

        <script>
            // Dropdown Toggle Functionality
            function toggleDropdown() {
                const dropdown = document.getElementById('adminDropdown');
                dropdown.classList.toggle('active');
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', function (event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
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
            const allRows = Array.from(table.rows);
            let filteredRows = allRows;
            let currentPage = 1;
            const rowsPerPage = 7;

            function filterRows() {
                const keyword = searchInput.value.toLowerCase();
                const status = statusFilter.value;
                const role = roleFilter.value;

                filteredRows = allRows.filter(row => {
                    const cells = row.querySelectorAll("td");
                    const matchesKeyword = Array.from(cells).slice(0, 4).some(cell =>
                        cell.textContent.toLowerCase().includes(keyword)
                    );
                    const matchesStatus =
                            status === "all" ||
                            (status === "active" && cells[4].textContent.toLowerCase() === "active") ||
                            (status === "inactive" && cells[4].textContent.toLowerCase() !== "active");

                    const matchesRole =
                            role === "all" ||
                            cells[2].textContent.toLowerCase() === role;

                    return matchesKeyword && matchesStatus && matchesRole;
                });

                currentPage = 1;
                renderPage();
            }

            function renderPage() {
                table.innerHTML = "";
                const start = (currentPage - 1) * rowsPerPage;
                const end = start + rowsPerPage;
                const pageRows = filteredRows.slice(start, end);
                pageRows.forEach(row => table.appendChild(row));
                renderPagination();
            }

            function renderPagination() {
                const totalPages = Math.ceil(filteredRows.length / rowsPerPage);
                const pagination = document.getElementById("pagination");
                pagination.innerHTML = "";

                for (let i = 1; i <= totalPages; i++) {
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
            }

            searchInput.addEventListener("input", filterRows);
            statusFilter.addEventListener("change", filterRows);
            roleFilter.addEventListener("change", filterRows);

            window.onload = () => renderPage();
        </script>
    </body>
</html>