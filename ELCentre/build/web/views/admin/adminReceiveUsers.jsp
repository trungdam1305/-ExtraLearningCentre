<%-- 
    Document   : adminReceiveUsers
    Created on : May 24, 2025, 10:03:15 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All User Use System</title>
    </head>
    <body>
        <h2>All Users</h2>

        <c:choose>
            <c:when test = "${not empty taikhoans}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_TaiKhoan</th>
                            <th>Email</th>
                            <th>MatKhau</th>
                            <th>ID_VaiTro</th>
                            <th>UserType</th>
                            <th>SoDienThoai</th>
                            <th>TrangThai</th>
                            <th>NgayTao</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="taikhoan" items="${taikhoans}">
                            <tr>
                                <td>${taikhoan.getID_TaiKhoan()}</td>
                                <td>${taikhoan.getEmail()}</td>
                                <td>${taikhoan.getMatKhau()}</td>
                                <td>${taikhoan.getID_VaiTro()}</td>
                                <td>${taikhoan.getUserType()}</td>
                                <td>${taikhoan.getSoDienThoai()}</td>
                                <td>${taikhoan.getTrangThai()}</td>
                                <td>${taikhoan.getNgayTao()}</td>
                            </tr>   
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>   
                <div class="no-reports-message">
                    <p>Ồ! Lỗi rồi</p>
                </div>
            </c:otherwise>
            </c:choose>
        
        <div class="back-button">
                    <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
        </body>
    </html>
