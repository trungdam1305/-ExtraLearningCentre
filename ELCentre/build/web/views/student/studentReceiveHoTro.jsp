<%-- 
    Document   : studentReceiveHoTro
    Created on : Jul 17, 2025, 3:04:31 PM
    Author     : wrx_Chur04
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/views/student/sidebar.jsp" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông báo hỗ trợ</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
            }
            .main-content {
                flex: 1;
                padding: 30px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            .notification-box {
                background-color: white;
                border-radius: 10px;
                padding: 20px;
            }
            .notification-item {
                padding: 15px;
                border-bottom: 1px solid #ddd;
            }
            .notification-item:last-child {
                border-bottom: none;
            }
            .notification-time {
                font-size: 13px;
                color: #888;
                margin-top: 10px;
            }
            .notification-item h3 {
                margin: 0;
                color: #007bff;
            }
            .notification-item p {
                margin: 5px 0;
                font-size: 14px;
            }
            .no-data {
                background: white;
                border-radius: 10px;
                padding: 40px;
                text-align: center;
                font-size: 18px;
                color: #999;
            }
        </style>
    </head>
    <body>

        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h2>Thông báo hỗ trợ</h2>
                <div>
                    <span>Xin chào ${sessionScope.user.email}</span>
                    <a href="${pageContext.request.contextPath}/views/student/studentGuiYeuCauHoTro.jsp" 
                       style="margin-left: 20px; padding: 8px 16px; background-color: #007bff; color: white; border-radius: 5px; text-decoration: none;">
                        Gửi yêu cầu hỗ trợ
                    </a>
                </div>
            </div>


            <c:choose>
                <c:when test="${not empty sessionScope.hotros}">
                    <div class="notification-box">
                        <c:forEach var="ht" items="${sessionScope.hotros}">
                            <div class="notification-item">
                                <h3>${ht.tenHoTro}</h3>
                                <p><strong>Người gửi:</strong> ${ht.hoTen}</p>
                                <p><strong>Mô tả:</strong> ${ht.moTa}</p>
                                <p><strong>Trạng thái:</strong> ${ht.daDuyet}</p>
                                <c:if test="${not empty ht.phanHoi}">
                                    <p><strong>Phản hồi:</strong> ${ht.phanHoi}</p>
                                </c:if>
                                <div class="notification-time">${ht.thoiGian}</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">Bạn hiện không có yêu cầu hỗ trợ nào.</div> 
                </c:otherwise>
            </c:choose>

        </div>

    </body>
</html>