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
    <title>Thông tin học phí của con cái</title>
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
            width: 100%;
        }
        .main-content {
            flex: 1;
            padding: 40px;
            width: 90%;
            margin: 0 auto;
            min-height: 600px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }
        .header {
            background-color: #1F4E79;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            box-sizing: border-box;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .header h2 {
            margin: 0;
            font-size: 28px;
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
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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
        .child-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .child-card:hover {
            transform: translateY(-2px);
        }
        .child-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .child-details {
            font-size: 16px;
            color: #333;
        }
        .child-details strong {
            font-size: 18px;
            color: #1F4E79;
        }
        .child-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e0e0e0;
        }
        .child-action a {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            color: white;
            background-color: #f0ad4e;
            transition: background-color 0.2s;
        }
        .child-action a:hover {
            background-color: #d99632;
        }
        /* Style cho trạng thái (nếu có sau này) */
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
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
                width: 95%;
            }
            .child-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .child-action {
                margin-top: 10px;
                width: 100%;
            }
            .child-action a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
    <script>
        function toggleUserMenu() {
            var dropdown = document.getElementById("userDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }
    </script>
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
            <div class="header">
                <h2>Thông tin học phí theo con cái</h2>
                <div class="user-menu">
                    <div class="user-toggle" onclick="toggleUserMenu()">
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
                <h3>Danh sách con</h3>
                <c:choose>
                    <c:when test="${not empty dsCon}">
                        <c:forEach var="child" items="${dsCon}">
                            <div class="child-card">
                                <div class="child-info">
                                    <img src="${pageContext.request.contextPath}/${child.avatar}" alt="avatar" class="child-avatar">
                                    <div class="child-details">
                                        <strong>${child.hoTen}</strong><br>
                                        Lớp: ${child.lopDangHocTrenTruong}<br>
                                        Ngày sinh: ${child.ngaySinh}
                                    </div>
                                </div>
                                <div class="child-action">
                                    <a href="${pageContext.request.contextPath}/ParentActionWithTuition?action=view&id=${child.ID_HocSinh}">Xem các lớp đang học và học phí chi tiết</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>Không có dữ liệu con cái để hiển thị.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@ include file="/views/parent/footer.jsp" %>
        </div>
    </div>
</body>
</html>