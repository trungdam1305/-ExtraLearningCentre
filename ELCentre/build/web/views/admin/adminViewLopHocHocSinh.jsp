<%-- 
    Document   : adminReceiveTeacherInfor
    Created on : June 23, 2025, 12:50 AM
    Author     : chuvv
    Purpose    : This page displays detailed information about specific classes of teachers (lớp học) in the EL CENTRE system, 
                including class code, class name, teacher name, student count, schedule, notes, status, creation date, tuition fee, 
                teacher avatar, course ID, and block ID. Admin can view details of students in the class or remove the teacher from the class.
    Parameters:
    - @Param lopHocs (ArrayList<LopHocInfoDTO>): A request attribute containing the list of class objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Classes</title>
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
                EL CENTRE <i class="fas fa-chalkboard-teacher"></i>
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
            <h2>Lớp học của giáo viên tại trung tâm</h2>
            <div style="display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
            </div>

            <c:choose>
                <c:when test="${not empty lopHocs}">
                    <table>
                        <thead>
                            <tr>
                                <th>Mã Lớp</th>
                                <th>Tên Lớp Học</th>
                                <th>Tên Giáo Viên</th>
                                <th>Sĩ Số</th>
                                <th>Sĩ Số Tối Thiểu</th>
                                <th>Sĩ Số Tối Đa</th>
                                <th>Thời Gian Học</th>
                                <th>Ghi Chú</th>
                                <th>Trạng Thái</th>
                                <th>Ngày Tạo</th>
                                <th>Học Phí</th>
                                <th>Ảnh Giáo Viên</th>
                                <th>Khóa Học</th>
                                <th>Khối</th>
                                <th>Hành Động</th>
                            </tr>
                        </thead>
                        <tbody id="teacherTableBody">
                            <c:forEach var="lopHoc" items="${lopHocs}">
                                <tr>
                                    <td>${lopHoc.classCode}</td>
                                    <td>${lopHoc.tenLopHoc}</td>
                                    <td>${lopHoc.tenGiaoVien}</td>
                                    <td>${lopHoc.siSo}</td>
                                    <td>${lopHoc.siSoToiThieu}</td>
                                    <td>${lopHoc.siSoToiDa}</td>
                                    <td><c:out value="${lopHoc.thoiGianHoc != null ? lopHoc.thoiGianHoc : 'Chưa có lịch'}" /></td>
                                    <td><c:out value="${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Không có ghi chú'}" /></td>
                                    <td>${lopHoc.trangThai}</td>
                                    <td><fmt:formatDate value="${lopHoc.ngayTao}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td><fmt:formatNumber value="${lopHoc.soTien}" pattern="#,##0" /> VNĐ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty lopHoc.avatarGiaoVien}">
                                                <img src="${pageContext.request.contextPath}/img/${lopHoc.avatarGiaoVien}" alt="Avatar" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;" />
                                            </c:when>
                                            <c:otherwise>
                                                Không có ảnh
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${lopHoc.idKhoaHoc}</td>
                                    <td>${lopHoc.idKhoi}</td>
                                    <td>
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWith?action=viewStudents&id=${lopHoc.idLopHoc}">Xem học sinh trong lớp</a>
                                        <a class="action-link" href="${pageContext.request.contextPath}/adminActionWith?action=removeTeacher&id=${lopHoc.idLopHoc}">Xóa giáo viên khỏi lớp</a>
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
                        <p>Không có dữ liệu lớp học để hiển thị.</p>
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

        <script>
            function toggleDropdown() {
                document.getElementById("adminDropdown").classList.toggle("active");
            }
        </script>
    </body>
</html>