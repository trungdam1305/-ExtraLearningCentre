<%-- 
    Document   : adminReceiveThongBao
    Created on : May 29, 2025, 4:12:42 PM
    Author     : wrx_Chur04
    Purpose    : This page displays a list of sent notifications (thông báo) in the EL CENTRE system, 
                 including notification ID, account ID, content, associated tuition fee ID, and timestamp. 
    Parameters:
    - @Param thongbaos (ArrayList<ThongBao>): A request attribute containing the list of notification objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin View Notifications</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f4f8;
                color: #1F4E79;
                margin: 20px;
            }

            h1 {
                color: #1F4E79;
                text-align: center;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
                box-shadow: 0 0 8px rgba(31, 78, 121, 0.3);
                background-color: white;
            }

            th, td {
                padding: 10px 15px;
                border: 1px solid #1F4E79;
                text-align: center;
                font-size: 14px;
            }

            thead th {
                background-color: #1F4E79;
                color: white;
            }

            tbody tr:hover {
                background-color: #d6e4f0;
            }

            .no-reports-message {
                text-align: center;
                font-size: 16px;
                padding: 15px;
                border: 1px solid #1F4E79;
                background-color: #e8f0fc;
                color: #1F4E79;
                max-width: 400px;
                margin: 0 auto 20px auto;
                border-radius: 5px;
            }

            .back-button {
                text-align: center;
            }

            .back-button a {
                text-decoration: none;
                color: white;
                background-color: #1F4E79;
                padding: 10px 20px;
                border-radius: 5px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .back-button a:hover {
                background-color: #163c59;
            }
        </style>

    </head>
    <body>
        <h1>Các Thông Báo Đã Gửi</h1>

        <c:choose>
            <c:when test = "${not empty thongbaos}">
                <table>

                    <thead>
                        <tr>
                            <th>Mã Thông Báo</th>
                            <th>Mã Tài Khoản</th>
                            <th>Nội dung</th>
                            <th>Mã Học Phí</th>
                            <th>Thời Gian</th>


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
