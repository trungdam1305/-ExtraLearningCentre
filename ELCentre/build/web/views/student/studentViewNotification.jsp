<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        .sidebar {
            width: 260px;
            background-color: #1F4E79;
            height: 100vh;
            padding: 20px;
            color: white;
        }
        .sidebar-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 25px;
        }
        .sidebar-section {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #a9c0dc;
            letter-spacing: 1px;
            border-top: 1px solid #3e5f87;
            padding-top: 10px;
        }
        .sidebar a {
            display: block;
            text-decoration: none;
            color: white;
            padding: 8px 0;
            font-size: 20px;
            transition: background-color 0.2s ease;
        }
        .sidebar a:hover {
            background-color: #294f78;
            padding-left: 10px;
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

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-title">STUDENT</div>
    <div class="sidebar-section">TỔNG QUAN</div>
    <a href="${pageContext.request.contextPath}/StudentDashboardServlet">Trang chủ</a>
    <div class="sidebar-section">HỌC TẬP</div>
    <a href="${pageContext.request.contextPath}/StudentEnrollClassServlet">Đăng ký học</a>
    <a href="${pageContext.request.contextPath}/StudentViewClassServlet">Lớp học</a>
    <a href="${pageContext.request.contextPath}/StudentViewScheduleServlet">Lịch học</a>
    <div class="sidebar-section">TÀI CHÍNH</div>
    <a href="${pageContext.request.contextPath}/StudentPaymentServlet">Học phí</a>
    <div class="sidebar-section">HỆ THỐNG</div>
    <a href="${pageContext.request.contextPath}/StudentViewNotificationServlet"><strong>Thông báo</strong></a>
    <a href="${pageContext.request.contextPath}/StudentEditProfileServlet">Tài khoản</a>
    <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
</div>

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
