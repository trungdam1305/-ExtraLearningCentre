<%-- 
    Document   : adminReceiveHocPhi
    Created on : May 29, 2025, 3:45:49 PM
    Author     : chuvv
    Purpose    : This page displays a table of tuition fee (học phí) details for the EL CENTRE system, 
                 including student IDs, class IDs, subjects, payment methods, status, and dates. 
    Parameters:
    - @Param hocphis (ArrayList<HocPhi>): A request attribute containing the list of tuition fee objects fetched from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Receive TuiTion</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f4f8;
                color: #1F4E79;
                margin: 20px;
            }

            h2 {
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
        <h2>Biểu học phí</h2>

        <c:choose>
            <c:when test = "${not empty hocphis}">
                <table>

                    <thead>
                        <tr>
                            <th>Mã Học Phí</th>
                            <th>Mã Học Sinh</th>
                            <th>Mã Lớp Học</th>
                            <th>Môn Học</th>
                            <th>Phương Thức Thanh Toán</th>
                            <th>Tình Trạng Thanh Toán</th>
                            <th>Ngày Thanh Toán</th>
                            <th>Ghi Chú</th>

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
            <a href="${pageContext.request.contextPath}/adminGoToFirstPage">← Quay lại trang chủ</a>
        </div>
    </body>
</html>
