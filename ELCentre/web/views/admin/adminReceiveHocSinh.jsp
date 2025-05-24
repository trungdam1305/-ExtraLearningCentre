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
                            <th>ID_LopHoc</th>
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
                                <td>${hocsinh.getID_LopHoc()}</td>
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
                    <p>Ồ! Lỗi rồi</p>
                </div>
            </c:otherwise>
            </c:choose>
        
        <div class="back-button">
                    <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
