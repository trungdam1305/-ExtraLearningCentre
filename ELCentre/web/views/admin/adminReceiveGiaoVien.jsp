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
    </head>
    <body>
        <h2>All Teachers</h2>
        
        <c:choose>
            <c:when test = "${not empty giaoviens}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_GiaoVien</th>
                            <th>ID_TaiKhoan</th>
                            <th>HoTen</th>
                            <th>ChuyenMon</th>
                            <th>SDT</th>
                            <th>TruongGiangDay</th>
                            <th>Luong</th>
                            <th>GhiChu</th>
                            <th>TrangThai</th>
                            <th>NgayTao</th>
                            
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
                    <p>Ồ! Lỗi rồi</p>
                </div>
            </c:otherwise>
            </c:choose>
        
        <div class="back-button">
                    <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
