<%-- 
    Document   : adminUpdateParentInfor
    Created on : June 19, 2025, 12:58 AM
    Author     : wrx_Chur04
    Purpose    : This page allows admin users to update information for parents (phụ huynh) in the EL CENTRE system, 
                 including phone number, address, and notes, while displaying read-only fields 
                 like account ID, name, email, student ID, status, and creation date.
    Parameters:
    - @Param phuhuynhs (ArrayList<PhuHuynh>): A request attribute containing the list of parent objects to be updated.
    - @Param type (String): A request attribute indicating the user type for the update action.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Information Parent of Student</title>
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
                EL CENTRE <i class="fas fa-users"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ</span>
                <i class="fas fa-caret-down"></i>
               
            </div>
        </div>

        <div class="main-content">
            <h2>Cập Nhật Thông Tin Phụ Huynh</h2>
            <%
                String type = (String) request.getAttribute("type");
            %>
            <form method="post" action="adminActionWithUser">
                <c:choose>
                    <c:when test="${not empty phuhuynhs}">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Thông tin</th>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <th><input type="text" name="idphuhuynh" value="${ph.getID_PhuHuynh()}" readonly /></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <input type="hidden" name="type" value="${type}" />
                                    <tr>
                                        <td>ID_TàiKhoản</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" name="idtaikhoan" value="${ph.getID_TaiKhoan()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Họ tên</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" value="${ph.getHoTen()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>SĐT</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="number" name="sdt" value="${ph.getSDT()}" required="" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Email</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="email" name="email" value="${ph.getEmail()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Địa chỉ</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" name="diachi" value="${ph.getDiaChi()}" required="" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>ID_Học Sinh</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" value="${ph.getID_HocSinh()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Ghi chú</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" name="ghichu" value="<c:out value='${ph.getGhiChu()}' default='Không có ghi chú' />" /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Trạng thái</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" value="${ph.getTrangThai()}" readonly /></td>
                                        </c:forEach>
                                    </tr>
                                    <tr>
                                        <td>Ngày tạo</td>
                                        <c:forEach var="ph" items="${phuhuynhs}">
                                            <td><input type="text" value="${ph.getNgayTao()}" readonly /></td>
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

        
    </body>
</html>