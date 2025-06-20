<%-- 
    Document   : adminReceiveParentInfor
    Created on : June 19, 2025, 12:48 AM
    Author     : wrx_Chur04
    Purpose    : This page displays detailed information about parents (phụ huynh) in the EL CENTRE system, 
                 including account ID, name, contact details, address, associated student IDs, and status.
    Parameters:
    - @Param phuhuynhs (ArrayList<PhuHuynh>): A request attribute containing the list of parent objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specific Parent Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                color: #333;
                margin: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            h2 {
                color: #1F4E79;
                text-align: center; /* Center the title */
            }

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
                display: flex;
                justify-content: center; /* Center the table horizontally */
            }

            table {
                border-collapse: collapse;
                min-width: 800px;
                background-color: #fff;
                border-radius: 8px; /* Rounded corners for a modern look */
                overflow: hidden; /* Ensure rounded corners apply to content */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Softer shadow for depth */
            }

            th, td {
                border: 1px solid #ddd; /* Lighter border for better contrast */
                padding: 12px 15px; /* Increased padding for readability */
                text-align: center; /* Center all text in cells */
                vertical-align: middle; /* Vertically center text */
                font-size: 14px; /* Consistent font size */
            }

            th {
                background-color: #1F4E79;
                color: #fff;
                white-space: nowrap;
                text-transform: uppercase; /* Uppercase for headers */
                font-weight: 600; /* Slightly bolder headers */
            }

            tr td:first-child {
                background-color: #f8f8f8;
                font-weight: bold;
                width: 180px;
                padding-left: 20px; /* Extra padding for the label column */
                text-align: center; /* Center the first column */
            }

            .no-reports-message {
                margin-top: 20px;
                padding: 15px;
                background-color: #ffefef;
                border: 1px solid #e0a8a8;
                color: #cc0000;
                border-radius: 8px; /* Rounded corners for consistency */
                max-width: 600px; /* Limit width for better centering */
                margin-left: auto;
                margin-right: auto;
                text-align: center; /* Center the no-data message */
            }

            .back-button {
                margin-top: 30px;
                text-align: center;
            }

            .back-button a {
                text-decoration: none;
                padding: 10px 20px;
                background-color: #1F4E79;
                color: white;
                border-radius: 6px; /* Slightly larger radius */
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            .back-button a:hover {
                background-color: #163c5b;
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
                width: 40px;
                height: 40px;
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
                padding-bottom: 40px;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <div class="header">
            <div class="left-title">
                <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
                Thông tin phụ huynh <i class="fas fa-users"></i>
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
            <h2>Thông tin phụ huynh</h2>

            <c:choose>
                <c:when test="${not empty phuhuynhs}">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Thông tin</th>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <th>PH ${ph.getID_PhuHuynh()}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ID_TàiKhoản</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getID_TaiKhoan()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Họ tên</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getHoTen()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>SĐT</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getSDT()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Email</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getEmail()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Địa chỉ</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getDiaChi()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>ID_Học Sinh</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getID_HocSinh()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td><c:out value="${ph.getGhiChu()}" default="Không có ghi chú" /></td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trạng thái</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getTrangThai()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ngày tạo</td>
                                    <c:forEach var="ph" items="${phuhuynhs}">
                                        <td>${ph.getNgayTao()}</td>
                                    </c:forEach>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-reports-message">
                        <c:if test="${not empty message}">
                            <p style="color: red;">${message}</p>
                        </c:if>
                        <p>Không có dữ liệu phụ huynh để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveUsers.jsp">Quay lại</a>
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
            document.addEventListener('click', function(event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });
        </script>
    </body>
</html>