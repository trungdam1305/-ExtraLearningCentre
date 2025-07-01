<%-- 
    Document   : adminReceiveTeacherInfor
    Created on : June 23, 2025, 12:50 AM
    Author     : chuvv
    Purpose    : This page displays detailed information about specific classes of teachers (lớp học)  in the EL CENTRE system, 
                including  name of class , image , date create , ... and admin can view details student in this class
    Parameters:
    - @Param giaoviens (ArrayList<GiaoVien>): A request attribute containing the list of teacher objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Teacher</title>
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

            #pagination button {
                margin: 0 5px;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
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
                width: 80px;
                height: 80px;
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
                EL   CENTRE <i class="fas fa-chalkboard-teacher"></i>
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
            <h2>Lớp của giáo viên tại trung tâm</h2>
            <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
                
            </div>

            <c:choose>
                <c:when test="${not empty giaoviens}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <td>ID_Lớp Học</td>
                                <td>Tên Giảng Viên</td>
                               <td>Trường Đang Giảng Dạy</td>

                                <td>Tên Lớp Học</td>


                                 <td>Sĩ số lớp</td>

                                <td>Thời Gian</td>
                                <td>Ghi Chú Lớp</td>
                                <td>Trạng Thái</td>
                                <td>Ngày Tạo Lớp</td>
                                 <td>Image</td>
                                 <td>Hành động</td>
                            </tr>
                        </thead>
                        <tbody id="teacherTableBody">
                            <c:forEach var="giaovien" items="${giaoviens}">
                                <tr>
                                     <th>Lớp số ${giaovien.getID_KhoaHoc()}</th>
                                    <td>${giaovien.getID_LopHoc()}</td>
                                    <td>${giaovien.getHoTen()}</td>

                                      <td>${giaovien.getTenTruongHoc()}</td>


                                     <td>${giaovien.getTenLopHoc()}</td>
                                    <td>${giaovien.getSiSo()}</td>
                                    <td>${giaovien.getSlotThoiGian()}</td>
                                    <td>${giaovien.getGhiChu()}</td>
                                    <td>${giaovien.getTrangThai()}</td>
                                    <td>${giaovien.getNgayTao()}</td>
                                     <td>${giaovien.getImage()}</td>
                                    <td>
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWith?action=view&id=${giaovien.getID_LopHoc()}">Xem học sinh trong lớp</a>
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWith?action=view&id=${giaovien.getID_LopHoc()}">Chuyển giáo viên khỏi lớp</a>

                                    </td>
                                </tr>   
                            </c:forEach>
                        </tbody>
                    </table>    
                </c:when>
                <c:otherwise>   
                    <div class="no-data">
                        <c:if test="${not empty message}">
                            <p style="color: red;">${message}</p>
                        </c:if>
                        <p>Không có dữ liệu giáo viên để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div id="pagination" style="text-align:center; margin-top: 20px;"></div>
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveGiaoVien.jsp">Quay lại</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>


    </body>
</html>