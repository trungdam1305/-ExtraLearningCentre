<%-- 
    Document   : adminReceiveHocSinh
    Created on : May 24, 2025, 11:09:21 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Students Learn</title  >
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
        <h2>All Students</h2>

        <c:choose>
            <c:when test = "${not empty hocsinhs}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_HocSinh</th>
                            <th>ID_TaiKhoan</th>

                            <th>HoTen</th>
                            <th>NgaySinh</th>
                            <th>GioiTinh</th>
                            <th>DiaChi</th>
                            <th>SDT_PhuHuynh</th>
                            <th>TruongHoc</th>
                            <th>GhiChu</th>
                            <th>TrangThai</th>
                            <th>NgayTao</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="hocsinh" items="${hocsinhs}">
                            <tr>
                                <td>${hocsinh.getID_HocSinh()}</td>
                                <td>${hocsinh.getID_TaiKhoan()}</td>

                                <td>${hocsinh.getHoTen()}</td>
                                <td>${hocsinh.getNgaySinh()}</td>
                                <td>${hocsinh.getGioiTinh()}</td>
                                <td>${hocsinh.getDiaChi()}</td>
                                <td>${hocsinh.getSDT_PhuHuynh()}</td>
                                <td>${hocsinh.getTruongHoc()}</td>
                                <td>${hocsinh.getGhiChu()}</td>
                                <td>${hocsinh.getTrangThai()}</td>
                                <td>${hocsinh.getNgayTao()}</td>
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
                    <p>Không có dữ liệu học sinh để hiển thị.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
