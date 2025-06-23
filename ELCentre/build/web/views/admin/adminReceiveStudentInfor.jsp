<%-- 
    Document   : adminReceiveHocSinhDetails
    Created on : May 29, 2025, 4:22:32 PM
    Author     : wrx_Chur04
    Purpose    : This page displays detailed information about specific students (học sinh) in the EL CENTRE system, 
                including account ID, name, birth date, gender, address, parent contact, school, and status. 
    Parameters:
    - @Param hocsinhs (ArrayList<HocSinh>): A request attribute containing the list of student objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specific Student Information</title>
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
                text-align: center; 
            }

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
                display: flex;
                justify-content: center; 
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
                text-align: center; 
                vertical-align: middle;
                font-size: 14px; 
            }

            th {
                background-color: #1F4E79;
                color: #fff;
                white-space: nowrap;
                text-transform: uppercase; 
                font-weight: 600; 
            }

            tr td:first-child {
                background-color: #f8f8f8;
                font-weight: bold;
                width: 180px;
                padding-left: 20px; 
                text-align: center; 
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
                text-align: center; 
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
                EL CENTRE <i class="fas fa-user-graduate"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ</span>
                <i class="fas fa-caret-down"></i>
                
            </div>
        </div>

        <div class="main-content">
            <h2>Thông tin học sinh</h2>

            <c:choose>
                <c:when test="${not empty hocsinhs}">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Thông tin</th>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <th>HS ${hocsinh.getID_HocSinh()}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>ID_TàiKhoản</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getID_TaiKhoan()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Họ tên</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getHoTen()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ngày sinh</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getNgaySinh()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Giới tính</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getGioiTinh()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Địa chỉ</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getDiaChi()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>SĐT phụ huynh</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getSDT_PhuHuynh()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trường học</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getTenTruongHoc()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td><c:out value="${hocsinh.getGhiChu()}" default="Không có ghi chú" /></td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trạng thái</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getTrangThai()}</td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Ngày tạo</td>
                                    <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <td>${hocsinh.getNgayTao()}</td>
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
                        <p>Không có dữ liệu học sinh để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveUsers.jsp">Quay lại</a>
            </div>
        </div>

        
        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>

        
    </body>
</html>