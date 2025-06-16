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
                                    <td>${hocsinh.getTruongHoc()}</td>
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
    </body>
</html>
