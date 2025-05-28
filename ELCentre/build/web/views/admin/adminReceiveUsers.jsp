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
        <h2>Quản lý tài khoản</h2>

        <c:choose>
            <c:when test = "${not empty taikhoans}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_TaiKhoan</th>
                            <th>Email</th>


                            <th>UserType</th>
                            <th>SoDienThoai</th>
                            <th>TrangThai</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="taikhoan" items="${taikhoans}">
                            <tr>
                                <td>${taikhoan.getID_TaiKhoan()}</td>
                                <td>${taikhoan.getEmail()}</td>


                                <td>${taikhoan.getUserType()}</td>
                                <td>${taikhoan.getSoDienThoai()}</td>
                                <td>${taikhoan.getTrangThai()}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/adminActionWithUser?action=view&id=${taikhoan.getID_TaiKhoan()}&type=${taikhoan.getUserType()}">View Details</a><br>
                                    <a href="${pageContext.request.contextPath}/adminActionWithUser?action=disable&id=${item.id}&type=${item.type}">Disable</a><br>
                                    <a href="${pageContext.request.contextPath}/adminActionWithUser?action=update&id=${item.id}&type=${item.type}">Update</a>
                                </td>
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
