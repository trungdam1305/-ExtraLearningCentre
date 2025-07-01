<%-- 
    Document   : adminReceiveKhoaHoc
    Created on : May 29, 2025, 10:54:36 PM
    Author     : chuvv
    Purpose    : This page displays a list of all courses (khóa học) in the EL CENTRE system, including details like course ID, name, 
                 description, start/end dates, status, and creation date. 
    Parameters:
    - @Param khoahocs (ArrayList<KhoaHoc>): A request attribute containing the list of course objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Course</title>
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
        <c:choose>
            <c:when test = "${not empty khoahocs}">
                <table>

                    <thead>
                        <tr>
                            <th>Mã Khoá Học</th>
                            <th>Tên Khóa Học</th>
                            <th>Mô tả</th>
                            <th>Thời Gian Bắt Đầu</th>
                            <th>Thời Gian Kết Thúc</th>
                            <th>Ghi Chú</th>
                            <th>Trạng Thái</th>
                            <th>Ngày tạo</th>


                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="khoahoc" items="${khoahocs}">
                            <tr>
                                <td>${khoahoc.getID_KhoaHoc()}</td>
                                <td>${khoahoc.getTenKhoaHoc()}</td>
                                <td>${khoahoc.getMoTa()}</td>
                                <td>${khoahoc.getThoiGianBatDau()}</td>
                                <td>${khoahoc.getThoiGianKetThuc()}</td>
                                <td>${khoahoc.getGhiChu()}</td>
                                <td>${khoahoc.getTrangThai()}</td>


                                <td>${khoahoc.getNgayTao()}</td>


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
                    <p>Không có dữ liệu khóa học để hiển thị.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
