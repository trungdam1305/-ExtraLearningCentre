<%-- 
    Document   : adminReceiveTeacherInfor
    Created on : June 19, 2025, 12:35 AM
    Author     : wrx_Chur04
    Purpose    : This page displays detailed information about specific teachers (giáo viên) in the EL CENTRE system, 
                including account ID, name, specialization, contact details, school, salary, and status. 
    Parameters:
    - @Param giaoviens (ArrayList<GiaoVien>): A request attribute containing the list of teacher objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specific Teacher Information</title>
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
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px 15px;
                text-align: center; /* Center all text in cells */
                vertical-align: middle; /* Vertically center text */
                font-size: 14px;
            }

            th {
                background-color: #1F4E79;
                color: #fff;
                white-space: nowrap;
                text-transform: uppercase;
                font-weight: 600;
            }

            tr:nth-child(even) td:first-child {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #1F4E79;
                text-align: center; /* Center the label column */
            }

            tr td:first-child {
                background-color: #f8f8f8;
                font-weight: bold;
                width: 180px;
                padding-left: 20px;
                text-align: center; /* Center the first column */
            }

            .no-reports-message {
                margin-top: 20px;
                padding: 15px;
                background-color: #ffefef;
                border: 1px solid #e0a8a8;
                color: #cc0000;
                border-radius: 8px;
                max-width: 600px;
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
                border-radius: 6px;
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
                EL CENTRE <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ</span>
                
                
            </div>
        </div>

        <div class="main-content">
            <h2>Thông tin giáo viên</h2>

            <c:choose>
                <c:when test="${not empty giaoviens}">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Thông tin</th>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <th>GV ${giaovien.getID_GiaoVien()}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ID_TàiKhoản</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getID_TaiKhoan()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Họ tên</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getHoTen()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Chuyên môn</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getChuyenMon()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>SĐT</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getSDT()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trường giảng dạy</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getTenTruongHoc()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Lương</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getLuong()}</td>
                                    </c:forEach>
                                </tr>
                                
                                <tr>
                                    <td>Trạng thái</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getTrangThai()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ngày tạo</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>${giaovien.getNgayTao()}</td>
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

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveUsers.jsp">Quay lại</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>

       
    </body>
</html>