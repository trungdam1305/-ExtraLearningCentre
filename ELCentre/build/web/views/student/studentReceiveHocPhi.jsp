<%-- 
    Document   : studentReceiveHocPhi
    Created on : Jul 25, 2025, 4:07:21 AM
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
            .payment-status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 14px;
                font-weight: 500;
            }
            .payment-status.paid {
                color: white;
                background-color: #28a745;
            }
            .payment-status.unpaid {
                color: white;
                background-color: #dc3545;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            function toggleUserMenu() {
                var dropdown = document.getElementById("userDropdown");
                dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
            }
        </script>
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="/views/student/sidebar.jsp" %>
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
                        <i class="fas fa-file-invoice-dollar" style="margin-right: 8px;"></i>
                        Thông tin học phí lớp - ${TenLopHoc}
                    </h2>

                    <div class="user-menu">
                        <div class="user-toggle" onclick="toggleUserMenu()" style="color: white;">
                            <span><strong>${fn:escapeXml(hocSinhInfo.hoTen)}</strong>
                                <img src="${pageContext.request.contextPath}/${fn:escapeXml(hocSinhInfo.avatar)}" class="user-avatar" alt="Avatar">
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
                    <h1 class="page-title">Thông Tin Học Phí Lớp - ${fn:escapeXml(TenLopHoc)}</h1>
                    <c:choose>
                        <c:when test="${not empty requestScope.hocphis}">
                            <div class="data-table-wrapper">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Mã Học Sinh</th>
                                            <th>Họ và Tên</th>
                                            <th>Tháng</th>
                                            <th>Năm</th>
                                            <th>Số buổi có mặt</th>
                                            <th>Học Phí Phải Đóng</th>
                                            <th>Tình trạng thanh toán</th>
                                            <th>Ngày thanh toán</th>
                                            <th>Ghi Chú</th>
                                        </tr>
                                    </thead>
                                    <tbody id="notificationTableBody">
                                        <c:forEach var="hp" items="${requestScope.hocphis}">
                                            <tr>
                                                <td>${hp.getMaHocSinh()}</td>
                                                <td>${hp.getHoTen()}</td>
                                                <td>${hp.getThang()}</td>
                                                <td>${hp.getNam()}</td>
                                                <td>${hp.getSoBuoi()}</td>
                                                <td>${hp.getHocPhiPhaiDong()} VND</td>
                                                <td>
                                                    <span class="payment-status ${hp.getTinhTrangThanhToan() eq 'Đã thanh toán' ? 'paid' : 'unpaid'}">
                                                        ${hp.getTinhTrangThanhToan()}
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty hp.ngayThanhToan}">
                                                            ${hp.ngayThanhToan}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Chưa đóng
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${hp.getGhiChu()}</td>
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
                                <p>Không có dữ liệu học phí của lớp học để hiển thị.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <%@ include file="/views/student/footer.jsp" %>
            </div>
        </div>
    </body>
</html>

