<%-- 
    Document   : parentViewAllClassOfChildPayment
    Created on : Jul 25, 2025, 5:27:47 AM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin học phí</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
                color: #333;
            }
            .main-content {
                flex: 1;
                padding: 40px;
                width: 90%;
                margin: 0 auto;
                min-height: 600px;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .page-title {
                text-align: center;
                font-size: 36px;
                color: #1F4E79;
                margin-bottom: 30px;
                font-weight: bold;
            }
            .header {
                margin-bottom: 20px;
                text-align: center;
            }
            .header h2 {
                color: #1F4E79;
                font-size: 28px;
                margin: 0;
            }
            .debug {
                background: #ffe6e6;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ff9999;
                border-radius: 5px;
                font-size: 14px;
            }
            .no-data {
                background: white;
                padding: 40px;
                text-align: center;
                color: #888;
                border-radius: 10px;
                font-size: 18px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                margin-top: 20px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                display: table !important;
            }
            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }
            th {
                background-color: #1F4E79;
                color: white;
                font-weight: 600;
                font-size: 15px;
            }
            td {
                font-size: 14px;
                color: #333;
            }
            tr:hover {
                background-color: #f8f9fa;
            }
            table {
                font-size: 16px;
            }
            th, td {
                padding: 15px;
            }
            .message {
                margin-bottom: 20px;
                padding: 12px;
                border-radius: 5px;
                font-size: 14px;
                text-align: center;
            }
            .message.success {
                color: green;
                background-color: #e6ffe6;
                border: 1px solid #b2ffb2;
            }
            .wrapper {
                display: flex;
                min-height: 100vh;
                width: 100%;
            }
            .main-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                background-color: #f4f6f9;
                overflow-x: auto;
            }
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 16px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .user-menu {
                position: relative;
                font-size: 16px;
            }
            .user-toggle {
                cursor: pointer;
                color: white;
                font-weight: 500;
            }
            .user-dropdown {
                display: none;
                position: absolute;
                right: 0;
                top: 100%;
                background: white;
                border: 1px solid #ddd;
                border-radius: 6px;
                min-width: 180px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                z-index: 999;
            }
            .user-dropdown a {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: #333;
                font-size: 14px;
            }
            .user-dropdown a:hover {
                background-color: #f0f0f0;
            }
            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 8px;
                vertical-align: middle;
            }
            .action-btn {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                color: white;
                transition: background-color 0.2s;
            }
            .action-btn.pay {
                background-color: #f0ad4e;
            }
            .action-btn.pay:hover {
                background-color: #d99632;
            }
            .status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
            }
            .status.dang-hoc {
                color: white;
                background-color: #28a745;
            }
            .status.da-hoc {
                color: white;
                background-color: #dc3545;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="/views/parent/sidebar.jsp" %>
            <div class="main-area">

                <c:if test="${not empty sessionScope.message}">
                    <div class="message success">
                        <c:out value="${sessionScope.message}" />
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <div class="header" style="
                     background-color: #1F4E79;
                     color: white;
                     padding: 16px 30px;
                     margin: 0;
                     width: 100%;
                     box-sizing: border-box;
                     display: flex;
                     justify-content: space-between;
                     align-items: center;
                     border-radius: 0;
                     position: relative;
                     top: 0;
                     left: 0;
                     z-index: 999;
                     ">
                    <h2 style="margin: 0; color: white;">
                        <i class="fas fa-file-invoice-dollar" style="margin-right: 10px;"></i>
                        Thông tin học phí theo lớp
                    </h2>

                    <div class="user-menu">
                        <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
                            <span><strong>${phuHuynh.hoTen}</strong>
                                <img src="${pageContext.request.contextPath}/${phuHuynh.avatar}" class="user-avatar" alt="Avatar">
                                ☰
                            </span>
                        </div>
                        <div class="user-dropdown" id="userDropdown">
                            <a href="${pageContext.request.contextPath}/ResetPasswordServlet" onclick="openModal(); return false;">🔑 Đổi mật khẩu</a>
                            <a href="${pageContext.request.contextPath}/LogoutServlet">🚪 Đăng xuất</a>
                        </div>
                    </div>
                </div>
                <div class="main-content">
                    <h1 class="page-title">Thông Tin Học Phí Theo Lớp</h1>
                    <c:choose>
                        <c:when test="${not empty sessionScope.lophocs}">
                            <div class="data-table-wrapper">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Tên môn học</th>
                                            <th>Khối</th>
                                            <th>Tên lớp học</th>
                                            <th>Số tiền</th>
                                            <th>Sĩ số</th>
                                            <th>Tên giáo viên</th>
                                            <th>Ghi chú</th>
                                            <th>Trạng thái lớp</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="notificationTableBody">
                                        <c:forEach var="lop" items="${sessionScope.lophocs}">
                                            <tr>
                                                <td>${lop.getTenKhoaHoc()}</td>
                                                <td>${lop.getID_Khoi() + 5}</td>      
                                                <td>${lop.getTenLopHoc()}</td>
                                                <td>${lop.getSoTien()} VND</td>
                                                <td>${lop.getSiSo()}</td>
                                                <td>${lop.getHoTen()}</td>
                                                <td>${lop.getGhiChu()}</td>
                                                <td>
                                                    <span class="status ${lop.getTrangThai() eq 'Đang học' ? 'dang-hoc' : 'da-hoc'}">
                                                        ${lop.getTrangThai()}
                                                    </span>
                                                </td>
                                                <td class="action-buttons">
                                                    <a class="action-btn pay" href="${pageContext.request.contextPath}/ParentActionWithTuition?action=viewHP&idLop=${lop.getID_LopHoc()}&TenLopHoc=${lop.getTenLopHoc()}">
                                                        <i class="fas fa-money-bill-wave"></i> Xem chi tiết học phí các tháng trong lớp
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">
                                <c:if test="${not empty message}">
                                    <p style="color: red;">${message}</p>
                                </c:if>
                                <p>Không có dữ liệu lớp học để hiển thị.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <%@ include file="/views/parent/footer.jsp" %>
            </div>
        </div>
    </body>
</html>

