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
    <title>Thông báo của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f4f6f9;
        }
        .logout-link {
            margin-top: 30px;
            font-weight: bold;
            color: #ffcccc;
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
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        .notification-item:last-child {
            border-bottom: none;
        }
        .notification-time {
            font-size: 13px;
            color: #888;
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
        <h2>Thông báo</h2>
        <span>Xin chào ${sessionScope.user.email}</span>
    </div>

    <c:choose>
        <c:when test="${not empty dsThongBao}">
            <div class="notification-box">
                <c:forEach var="tb" items="${dsThongBao}">
                    <div class="notification-item">
                        <div>${tb.noiDung}</div>
                        <div class="notification-time">${tb.thoiGian}</div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="no-data">Bạn hiện không có thông báo nào.</div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
