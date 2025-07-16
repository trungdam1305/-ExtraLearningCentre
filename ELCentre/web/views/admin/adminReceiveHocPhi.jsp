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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý học phí</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
 body {
    font-family: 'Segoe UI', Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f6f9;
    color: #333;
}

/* Sidebar */
.sidebar {
    width: 250px;
    background-color: #1F4E79;
    color: white;
    padding: 20px;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    overflow-y: auto;
}

.sidebar h4 {
    text-align: center;
    font-weight: bold;
    letter-spacing: 1.5px;
    margin: 0;
}

.sidebar-logo {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin: 15px auto;
    border: 3px solid #B0C4DE;
    display: block;
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
    margin: 10px 0;
}

ul.sidebar-menu li {
    margin: 10px 0;
}

ul.sidebar-menu li a {
    color: white;
    text-decoration: none;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

ul.sidebar-menu li a:hover {
    background-color: #163E5C;
}

ul.sidebar-menu li a i {
    margin-right: 10px;
}

/* Main Content */
.main-content {
    margin-left: 250px; /* Khoảng cách bằng sidebar */
    padding: 30px;
    max-width: calc(100% - 250px);
}

/* Header */
.header {
    margin-bottom: 20px;
    text-align: center;
}

.header h2 {
    color: #1F4E79;
    font-size: 28px;
}

/* Table */
table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 10px;
    margin-top: 20px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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

/* Messages */
.no-reports-message {
    text-align: center;
    font-size: 16px;
    padding: 15px;
    border: 1px solid #1F4E79;
    background-color: #e8f0fc;
    color: #1F4E79;
    max-width: 400px;
    margin: 20px auto;
    border-radius: 5px;
}

/* Back Button */
.back-button {
    text-align: center;
    margin-top: 30px;
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
    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="#"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý người dùng</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh"><i class="fas fa-user-graduate"></i> Học sinh</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien"><i class="fas fa-chalkboard-teacher"></i> Giáo viên</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan"><i class="fas fa-user"></i> Tài khoản</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageSchedule"><i class="fas fa-calendar-alt"></i> Lịch học</a></li>
        </ul>
        <div class="sidebar-section-title">Hệ thống</div>
        <ul class="sidebar-menu">
            <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
            <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <h2>Quản lý học phí</h2>
        </div>

        <c:if test="${not empty sessionScope.message}">
            <div class="no-reports-message">
                <p style="color: red;"><c:out value="${sessionScope.message}" /></p>
            </div>
            <c:remove var="message" scope="session" />
        </c:if>

        <c:choose>
            <c:when test="${not empty hocphis && fn:length(hocphis) > 0}">
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
                        <c:forEach var="hocphi" items="${hocphis}" varStatus="loop">
                            <tr>
                                <td><c:out value="${hocphi.ID_HocPhi != null ? hocphi.ID_HocPhi : 'N/A'}" /></td>
                                <td><c:out value="${hocphi.ID_HocSinh != null ? hocphi.ID_HocSinh : 'N/A'}" /></td>
                                <td><c:out value="${hocphi.ID_LopHoc != null ? hocphi.ID_LopHoc : 'N/A'}" /></td>
                                <td><c:out value="${hocphi.monHoc != null ? hocphi.monHoc : 'N/A'}" /></td>
                                <td><c:out value="${hocphi.phuongThucThanhToan != null ? hocphi.phuongThucThanhToan : 'N/A'}" /></td>
                                <td><c:out value="${hocphi.tinhTrangThanhToan != null ? hocphi.tinhTrangThanhToan : 'N/A'}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${hocphi.ngayThanhToan != null && hocphi.ngayThanhToan.getClass().getName() == 'java.util.Date'}">
                                            <fmt:formatDate value="${hocphi.ngayThanhToan}" pattern="dd/MM/yyyy" />
                                        </c:when>
                                        <c:otherwise>N/A</c:otherwise>
                                    </c:choose>
                                </td>
                                <td><c:out value="${hocphi.ghiChu != null ? hocphi.ghiChu : 'N/A'}" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-reports-message">
                    <c:if test="${not empty message}">
                        <p style="color: red;"><c:out value="${message}" /></p>
                    </c:if>
                    <p>Không có dữ liệu học phí để hiển thị.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="back-button">
            <a href="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp">Quay lại trang chủ</a>
        </div>
    </div>
</body>
</html>