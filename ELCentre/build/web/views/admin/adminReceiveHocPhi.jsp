<%-- 
    Document   : adminReceiveHocPhi
    Created on : May 29, 2025, 3:45:49 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Receive TuiTion</title>
    </head>
    <body>
        <h2>Biểu học phí</h2>
        
        <c:choose>
            <c:when test = "${not empty hocphis}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_HocPhi</th>
                            <th>ID_HocSinh</th>
                            <th>ID_LopHoc</th>
                            <th>MonHoc</th>
                            <th>PhuongThucThanhToan</th>
                            <th>TinhTrangThanhToan</th>
                            <th>NgayThanhToan</th>
                            <th>GhiChu</th>
                            
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="hocphi" items="${hocphis}">
                            <tr>
                                <td>${hocphi.getID_HocPhi()}</td>
                                <td>${hocphi.getID_HocSinh()}</td>
                                <td>${hocphi.getID_LopHoc()}</td>
                                <td>${hocphi.getMonHoc()}</td>
                                <td>${hocphi.getPhuongThucThanhToan()}</td>
                                <td>${hocphi.getTinhTrangThanhToan()}</td>
                                <td>${hocphi.getNgayThanhToan()}</td>
                                <td>${hocphi.getGhiChu()}</td>

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
                    <p>Không có dữ liệu học phí để hiển thị.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
