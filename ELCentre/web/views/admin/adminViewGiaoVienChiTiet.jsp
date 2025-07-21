<%-- 
    Document   : adminReceiveTeacherInfor
    Created on : June 23, 2025, 12:45 PM
    Author     : chuvv
    Purpose    : This page displays detailed information about specific teachers (giáo viên) in the EL CENTRE system, 
                including account ID, name, specialization, contact details, school, salary, and status. 
    Parameters:
    - @Param giaoviens (ArrayList<GiaoVienChiTiet>): A request attribute containing the list of teacher objects fetched from the database.
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
                text-align: center;
            }

            .table-container {
                background: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                overflow-x: auto;
                display: flex;
                justify-content: center;
                margin: 20px auto;
                max-width: 90%;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                min-width: 800px;
            }

            th, td {
                padding: 12px 15px;
                border: 1px solid #ccc;
                text-align: center;
                vertical-align: middle;
            }

            th {
                background-color: #1F4E79;
                color: white;
                white-space: nowrap;
                text-transform: uppercase;
                font-weight: 600;
            }

            td {
                background-color: #f8f8f8;
            }

            input[type="text"], input[type="number"], input[type="email"] {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
                text-align: center;
            }

            input[readonly] {
                background-color: #e9ecef;
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
                display: block;
                margin-left: auto;
                margin-right: auto;
            }

            button:hover {
                background-color: #163e5f;
            }

            .back-button {
                margin-top: 20px;
                text-align: center;
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
                text-align: center;
                margin: 20px auto;
                max-width: 600px;
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
                EL CENTRE <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <img src="https://png.pngtree.com/png-clipart/20250117/original/pngtree-account-avatar-user-abstract-circle-background-flat-color-icon-png-image_4965046.png" alt="Admin Photo" class="admin-img">
                <span>Admin Vũ Văn Chủ</span>

            </div>
        </div>

        <div class="main-content">
            <h2>Cập Nhật Thông Tin Giáo Viên</h2>
            <%
                String type = (String) request.getAttribute("type");
            %>
            <form method="post" action="adminActionWithTeacher">
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
                                
                                <tr>
                                    <td>ID_TàiKhoản</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="text" name="idtaikhoan" value= "${giaovien.getID_TaiKhoan()}" readonly /></td>
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
                                    <td>Bằng cấp</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="text" value="${giaovien.getBangCap()}" readonly /></td>
                                        </c:forEach>
                                </tr>
                                <tr>
                                    <td>SĐT</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="number" name="sdt" value="${giaovien.getSDT()}" required="" /></td>
                                        </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trường học</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td>
                                            <select name="idTruongHoc">
                                                <c:forEach var="truong" items="${truonghoc}">
                                                    <option value="${truong.getID_TruongHoc()}"
                                                            <c:if test="${truong.getTenTruongHoc() == giaovien.getTenTruongHoc()}">selected</c:if>>
                                                        ${truong.getTenTruongHoc()}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </c:forEach>
                                </tr>
                                <tr>
                                    <td>Lớp đang dạy trên trường</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="text" name="lop" value="${giaovien.getLopDangDayTrenTruong()}" required="" /></td>
                                        </c:forEach>
                                </tr>
                                <tr>
                                    <td>Lương</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="luong" name="luong" value="${giaovien.getLuong()}" required=""     /></td>
                                        </c:forEach>
                                </tr>

                                <tr>
                                    <td>Top Hot</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="number" name="hot" value="${giaovien.getIsHot()}" required="" /></td>
                                        </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trạng thái dạy tại EL CENTRE</td>
                                    <c:forEach var="giaovien" items="${giaoviens}">
                                        <td><input type="text" name="statusday" value="${giaovien.getTrangThaiDay()}" readonly /></td>
                                        </c:forEach>
                                </tr>
                                <tr>
                                    <td>Trạng thái tài khoản</td>
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
                <button type="submit" name="type" value="update">Cập nhật</button>
            </form>
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveGiaoVien.jsp">Quay lại</a>
            </div>
        </div>


        <div class="footer">
            <p>© 2025 EL CENTRE. All rights reserved. | Developed by wrx_Chur04</p>
        </div>


    </body>
</html>