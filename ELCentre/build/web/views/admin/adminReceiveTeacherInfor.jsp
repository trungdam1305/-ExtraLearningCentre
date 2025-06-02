<%-- 
    Document   : adminReceiveTeacherInfor
    Created on : May 29, 2025, 1:37:53 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specific Teacher Information</title>
    </head>
    <body>
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

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
            }

            table {
                border-collapse: collapse;
                min-width: 800px;
                background-color: #fff;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 10px 15px;
                text-align: left;
                vertical-align: top;
            }

            th {
                background-color: #1F4E79;
                color: #fff;
                white-space: nowrap;
            }

            tr:nth-child(even) td:first-child {
                background-color: #f0f0f0;
                font-weight: bold;
                color: #1F4E79;
            }

            tr td:first-child {
                background-color: #f8f8f8;
                font-weight: bold;
                width: 180px;
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
    <h2>Thông tin giáo viên</h2>

    <c:choose>
        <c:when test = "${not empty giaoviens}">
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
                                <td>${giaovien.getTruongGiangDay()}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>Lương</td>
                            <c:forEach var="giaovien" items="${giaoviens}">
                                <td>${giaovien.getLuong()}</td>
                            </c:forEach>
                        </tr>
                        <tr>
                            <td>Ghi chú</td>
                            <c:forEach var="giaovien" items="${giaoviens}">
                                <td><c:out value="${giaovien.getGhiChu()}" default="Không có ghi chú" /></td>
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
</body>
</html>

