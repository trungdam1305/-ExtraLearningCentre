<%-- 
    Document   : adminReceiveGiaoVien
    Created on : May 24, 2025, 11:28:36 PM
    Author     : wrx_Chur04
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
                background-color: #f4f6f8;
                color: #333;
                padding: 20px;
            }

            h2 {
                color: #1F4E79;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background-color: #fff;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px 12px;
                text-align: left;
            }

            th {
                background-color: #1F4E79;
                color: #fff;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .no-reports-message {
                margin-top: 20px;
                padding: 10px;
                background-color: #ffefef;
                border: 1px solid #e0a8a8;
                color: #cc0000;
            }

            .back-button {
                margin-top: 30px;
            }

            .back-button a {
                text-decoration: none;
                padding: 8px 16px;
                background-color: #1F4E79;
                color: white;
                border-radius: 4px;
            }

            .back-button a:hover {
                background-color: #163c5b;
            }
        </style>
    </head>
    <body>
        <h2>All Teachers</h2>

        <c:choose>
            <c:when test = "${not empty giaoviens}">
                <table>

                    <thead>
                        <tr>
                            <th>Mã Giáo Viên</th>
                            <th>Mã Tài Khoản</th>
                            <th>Họ và Tên</th>
                            <th>Chuyên Môn</th>
                            <th>Số điện thoại</th>
                            <th>Trường đang dạy</th>
                            <th>Lương</th>
                            <th>Ghi Chú</th>
                            <th>Trạng Thái</th>
                            <th>Ngày Tạo</th>

                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="giaovien" items="${giaoviens}">
                            <tr>
                                <td>${giaovien.getID_GiaoVien()}</td>
                                <td>${giaovien.getID_TaiKhoan()}</td>
                                <td>${giaovien.getHoTen()}</td>
                                <td>${giaovien.getChuyenMon()}</td>
                                <td>${giaovien.getSDT()}</td>
                                <td>${giaovien.getTruongGiangDay()}</td>
                                <td>${giaovien.getLuong()}</td>
                                <td><c:out value="${giaovien.getGhiChu()}" default="Không có ghi chú" /></td>

                                <td>${giaovien.getTrangThai()}</td>
                                <td>${giaovien.getNgayTao()}</td>

                            </tr>   
                        </c:forEach>
                    </tbody>
                </table>    
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
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
