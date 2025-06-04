<%-- 
    Document   : adminUpdateTeacherInfor
    Created on : Jun 2, 2025, 6:44:28 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Student Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f8;
                padding: 20px;
            }

            h2 {
                color: #1F4E79;
                margin-bottom: 20px;
            }

            .table-container {
                background: #ffffff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 12px 15px;
                border: 1px solid #ccc;
                text-align: center;
            }

            th {
                background-color: #1F4E79;
                color: white;
            }

            input[type="text"], input[type="number"], input[type="email"] {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
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
            }

            button:hover {
                background-color: #163e5f;
            }

            .back-button {
                margin-top: 20px;
            }

            .back-button a {
                text-decoration: none;
                color: #1F4E79;
                font-weight: bold;
            }

            .back-button a:hover {
                text-decoration: underline;
            }

            .no-reports-message {
                padding: 20px;
                background-color: #fff0f0;
                border: 1px solid #e0b4b4;
                color: #a94442;
                border-radius: 5px;
            }
        </style>

    </head>
    <body>
        <h2>Thông tin học sinh</h2>
        <%
             String type = (String) request.getAttribute("type");
        %>
        <form method="post" action="adminActionWithUser">
            <input type="hidden" name="type" value="${type}" />
            <c:choose>
                <c:when test="${not empty hocsinhs}">
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Thông tin</th>
                                        <c:forEach var="hocsinh" items="${hocsinhs}">
                                        <th><input type="text" name="idhocsinh" value="${hocsinh.getID_HocSinh()}" readonly /></th>
                                        </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                            <input type="hidden" name="type" value="${type}" />
                            <tr>
                                <td>ID_TàiKhoản</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" name="idtaikhoan" value="${hocsinh.getID_TaiKhoan()}" readonly /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Họ tên</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" value="${hocsinh.getHoTen()}" readonly /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Ngày sinh</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="date" name="ngaysinh" value="${hocsinh.getNgaySinh()}" readonly/></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Giới tính</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" name="gioitinh" value="${hocsinh.getGioiTinh()}" readonly /></td>
                                    </c:forEach>
                            </tr>

                            <tr>
                                <td>Địa chỉ</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" name="diachi" value="${hocsinh.getDiaChi()}" required="" /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>SĐT phụ huynh</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text"  value="${hocsinh.getSDT_PhuHuynh()}" readonly /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Trường học</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" name="truonghoc" value="${hocsinh.getTruongHoc()}" required=""/></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Ghi chú</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" name="ghichu" value="<c:out value='${hocsinh.getGhiChu()}' default='Không có ghi chú' />" /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Trạng thái</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" value="${hocsinh.getTrangThai()}" readonly /></td>
                                    </c:forEach>
                            </tr>
                            <tr>
                                <td>Ngày tạo</td>
                                <c:forEach var="hocsinh" items="${hocsinhs}">
                                    <td><input type="text" value="${hocsinh.getNgayTao()}" readonly /></td>
                                    </c:forEach>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-reports-message" style="color:red; margin-top:20px;">
                        <c:if test="${not empty message}">
                            <p>${message}</p>
                        </c:if>
                        <p>Không có dữ liệu học sinh để hiển thị.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <button type="submit">Cập nhật</button>
        </form>
        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminReceiveUsers.jsp">Quay lại</a>
        </div>


    </body>
</html>

