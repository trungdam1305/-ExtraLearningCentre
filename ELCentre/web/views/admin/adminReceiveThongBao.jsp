<%-- 
    Document   : adminReceiveThongBao
    Created on : May 29, 2025, 4:12:42 PM
    Author     : wrx_Chur04
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin View Notifications</title>
    </head>
    <body>
        <h1>Các Thông Báo Đã Gửi</h1>
        
        <c:choose>
            <c:when test = "${not empty thongbaos}">
                <table>

                    <thead>
                        <tr>
                            <th>ID_ThongBao</th>
                            <th>ID_TaiKhoan</th>
                            <th>NoiDung</th>
                            <th>ID_HocPhi</th>
                            <th>ThoiGian</th>
                            

                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="thongbao" items="${thongbaos}">
                            <tr>
                                <td>${thongbao.getID_ThongBao()}</td>
                                <td>${thongbao.getID_TaiKhoan()}</td>
                                <td>${thongbao.getNoiDung()}</td>
                                <td>${thongbao.getID_HocPhi()}</td>
                                <td>${thongbao.getThoiGian()}</td>
                                

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
                    <p>Không có dữ liệu thông báo đã gửi.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
