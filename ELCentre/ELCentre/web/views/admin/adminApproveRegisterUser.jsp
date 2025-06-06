<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phê duyệt đăng ký tư vấn</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            min-height: 100vh;
            background-color: #f9f9f9;
        }

        .sidebar {
            width: 250px;
            background-color: #1F4E79;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            height: 100vh;
            position: fixed;
        }

        .sidebar h4 {
            margin: 0 0 30px 0;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .sidebar-section-title {
            font-weight: bold;
            margin-top: 30px;
            font-size: 14px;
            text-transform: uppercase;
            color: #B0C4DE;
            border-bottom: 1px solid #B0C4DE;
            padding-bottom: 5px;
        }

        ul.sidebar-menu {
            list-style: none;
            padding-left: 0;
            margin: 10px 0 0 0;
        }

        ul.sidebar-menu li {
            margin: 10px 0;
        }

        ul.sidebar-menu li a {
            color: white;
            text-decoration: none;
            padding: 8px 12px;
            display: block;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        ul.sidebar-menu li a:hover {
            background-color: #163E5C;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px 40px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 30px;
            background-color: #f4f6f8;
        }

        h2 {
            color: #1F4E79;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px 12px;
            border: 1px solid #d0d7de;
            text-align: center;
        }

        th {
            background-color: #1F4E79;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f0f4f8;
        }

        tr:hover {
            background-color: #d9e4f0;
        }

        .no-data {
            text-align: center;
            margin: 30px;
            color: red;
        }

        .back-button {
            text-align: center;
            margin-top: 30px;
        }

        .back-button a {
            background-color: #1F4E79;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-button a:hover {
            background-color: #163b5c;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h4>EDU ADMIN</h4>

    <div class="sidebar-section-title">Tổng quan</div>
    <ul class="sidebar-menu">
        <li><a href="#">Dashboard</a></li>
    </ul>

    <div class="sidebar-section-title">Quản lý người dùng</div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
        
    </ul>

    <div class="sidebar-section-title">Quản lý tài chính</div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi">Học phí</a></li>
    </ul>

    <div class="sidebar-section-title">Quản lý học tập</div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=khoahoc">Khoá học</a></li>
    </ul>

    <div class="sidebar-section-title">Hệ thống</div>
    <ul class="sidebar-menu">
        <li><a href="#">Cài đặt</a></li>
    </ul>

    <div class="sidebar-section-title">Khác</div>
    <ul class="sidebar-menu">
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=pheduyettuvan">Phê duyệt tài khoản</a></li>
        <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao">Thông báo</a></li>
        <li><a href="#">Blog</a></li>
        <li><a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a></li>
    </ul>
</div>

<div class="main-content">
    <h2>Yêu cầu đăng ký tư vấn từ người dùng</h2>

    <c:choose>
        <c:when test="${not empty requestScope.tuvanList}">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nội dung tư vấn</th>
                    <th>Thời gian</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="tv" items="${requestScope.tuvanList}">
                    <tr>
                        <td>${tv.id}</td>
                        <td>${tv.noiDung}</td>
                        <td>${tv.thoiGian}</td>
                        <td>
                            <form action="approveAdvice" method="get">
                                <input type="hidden" name="id" value="${tv.id}"/>
                                <button type="submit">Cấp Account</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-data">
                <p>Không có yêu cầu đăng ký tư vấn nào.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="back-button">
        <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
    </div>
</div>
</body>
</html>
