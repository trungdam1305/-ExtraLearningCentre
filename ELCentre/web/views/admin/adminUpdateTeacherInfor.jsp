<%-- 
    Document   : adminUpdateTeacherInfor
    Created on : June 19, 2025, 12:50 AM
    Author     : wrx_Chur04
    Purpose    : This page allows admin users to update information for teachers (giáo viên) in the EL CENTRE system, 
                 including phone number, school, salary, and notes, while displaying read-only fields 
                 like account ID, name, specialization, status, and creation date.
    Parameters:
    - @Param giaoviens (ArrayList<GiaoVien>): A request attribute containing the list of teacher objects to be updated.
    - @Param type (String): A request attribute indicating the user type for the update action.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Teacher Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                padding: 0;
                margin: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            h2 {
                color: #1F4E79;
                margin-bottom: 20px;
                text-align: center; /* Center the title */
            }

            .table-container {
                background: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                overflow-x: auto;
                display: flex;
                justify-content: center; /* Center the table horizontally */
                margin: 20px auto; /* Center and add margin */
                max-width: 90%; /* Limit width for better presentation */
            }

            table {
                width: 100%;
                border-collapse: collapse;
                min-width: 800px;
            }

            th, td {
                padding: 12px 15px;
                border: 1px solid #ccc;
                text-align: center; /* Center text in cells */
                vertical-align: middle; /* Vertically center text */
            }

            th {
                background-color: #1F4E79;
                color: white;
                white-space: nowrap;
                text-transform: uppercase;
                font-weight: 600;
            }

            td {
                background-color: #f8f8f8; /* Light background for all cells */
            }

            input[type="text"], input[type="number"], input[type="email"] {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                text-align: center; /* Center input text */
            }

            input[readonly] {
                background-color: #e9ecef; /* Lighter background for read-only fields */
                cursor: not-allowed;
            }

            button {
                background-color: #1F4E79;
                color: white;
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                cursor: pointer;
                margin-top: 20px;
                border-radius: 5px;
                display: block; /* Center the button */
                margin-left: auto;
                margin-right: auto;
            }

            button:hover {
                background-color: #163e5f;
            }

            .back-button {
                margin-top: 20px;
                text-align: center; /* Center the back button */
            }

            .back-button a {
                text-decoration: none;
                color: #1F4E79;
                font-weight: bold;
                padding: 10px 20px;
                border: 1px solid #1F4E79;
                border-radius: 5px;
                transition: color 0.3s ease, background-color 0.3s ease;
            }

            .back-button a:hover {
                background-color: #1F4E79;
                color: white;
            }

            .no-reports-message {
                padding: 20px;
                background-color: #fff0f0;
                border: 1px solid #e0b4b4;
                color: #a94442;
                border-radius: 5px;
                text-align: center; /* Center the message */
                margin: 20px auto;
                max-width: 600px; /* Limit width for better centering */
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
                Thông tin giáo viên <i class="fas fa-chalkboard-teacher"></i>
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
            <h2>Thông tin giáo viên</h2>
            <%
                String type = (String) request.getAttribute("type");
            %>
            <form method="post" action="adminActionWithUser">
                <c:choose>
                    <c:when test="${not empty giaoviens}">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Thông tin</th>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <th><input type="text" name="idgiaovien" value="${giaovien.getID_GiaoVien()}" readonly /></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <input type="hidden" name="type" value="${type}" />
                                    <tr>
                                        <td>ID_TàiKhoản</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" name="idtaikhoan" value="${giaovien.getID_TaiKhoan()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Họ tên</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" value="${giaovien.getHoTen()}" readonly /></td>    
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Chuyên môn</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" value="${giaovien.getChuyenMon()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>SĐT</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="number" name="sdt" value="${giaovien.getSDT()}" required="" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Trường giảng dạy</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" name="truong" value="${giaovien.getTenTruongHoc()}" required="" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Lương</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="number" name="luong" value="${giaovien.getLuong()}" required="" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Ghi chú</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" name="ghichu" value="<c:out value='${giaovien.getGhiChu()}' default='Không có ghi chú' />" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Trạng thái</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" value="${giaovien.getTrangThai()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Ngày tạo</td>
                                        <c:forEach var="giaovien" items="${giaoviens}">
                                            <td><input type="text" value="${giaovien.getNgayTao()}" readonly /></td>
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
                            <p>Không có dữ liệu giáo viên để hiển thị.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
                <br/>
                <button type="submit">Cập nhật</button>
            </form>
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