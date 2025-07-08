<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký học</title>

        <!-- 📚 CSS chính của hệ thống -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">

        <!-- 📚 Thư viện jQuery và phân trang -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/jquery.simplePagination.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-pagination.js@1.6/simplePagination.css">

        <!-- 🎨 Custom Style -->
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
                padding: 40px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border-radius: 10px;
                overflow: hidden;
            }

            th, td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                font-size: 15px;
            }

            th {
                background-color: #1F4E79;
                color: white;
            }

            .no-data {
                background-color: white;
                padding: 40px;
                text-align: center;
                color: #888;
                border-radius: 10px;
                font-size: 18px;
            }

            .action-btn {
                padding: 6px 14px;
                border: none;
                border-radius: 4px;
                font-size: 14px;
                font-weight: bold;
                cursor: pointer;
                color: white;
                background-color: #1F4E79;
            }

            .action-btn:hover {
                background-color: #163d5c;
            }

            /* 🎯 Phân trang */
            #pagination-container {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end; /* Căn phải */
            }

            .pagination {
                list-style: none;
                padding-left: 0;
                margin: 0;
                display: flex;
                gap: 6px;
            }

            .pagination li {
                display: inline;
            }

            .pagination li a,
            .pagination li span {
                display: inline-block;
                padding: 6px 14px;
                font-size: 14px;
                font-weight: bold;
                border-radius: 4px;
                background-color: #1F4E79;
                color: #fff;
                text-decoration: none;
                transition: background-color 0.2s ease;
                border: none;
            }

            .pagination li a:hover,
            .pagination li span:hover {
                background-color: #163d5c;
            }

            .pagination li.active span {
                background-color: #163d5c;
            }
        </style>
    </head>
    
    <body>
        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-title">STUDENT</div>
            <div class="sidebar-section">TỔNG QUAN</div>
            <a href="${pageContext.request.contextPath}/StudentDashboardServlet">Trang chủ</a>
            <div class="sidebar-section">HỌC TẬP</div>
            <a href="${pageContext.request.contextPath}/StudentEnrollClassServlet"><strong>Đăng ký học</strong></a>
            <a href="${pageContext.request.contextPath}/StudentViewClassServlet">Lớp học</a>
            <a href="${pageContext.request.contextPath}/StudentViewScheduleServlet">Lịch học</a>
            <div class="sidebar-section">TÀI CHÍNH</div>
            <a href="${pageContext.request.contextPath}/StudentPaymentServlet">Học phí</a>
            <div class="sidebar-section">HỆ THỐNG</div>
            <a href="${pageContext.request.contextPath}/StudentViewNotificationServlet">Thông báo</a>
            <a href="${pageContext.request.contextPath}/StudentEditProfileServlet">Tài khoản</a>
            <a href="${pageContext.request.contextPath}/StudentSupportServlet">Hỗ trợ</a>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout-link">Đăng xuất</a>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <div class="header">
                <h2>Danh sách khóa học</h2>
                <span>Xin chào ${sessionScope.user.email}</span>
            </div>

            <!-- 🔍 FORM tìm kiếm -->
            <div style="text-align: right; margin-bottom: 20px;">
                <form method="get" style="display: inline-block;">
                    <input id="searchInput" type="text" name="keyword" placeholder="Tìm kiếm..." value="${param.keyword}" style="padding: 8px; font-size: 14px; width: 300px;">
                    <button type="submit" class="action-btn">Tìm</button>
                </form>
            </div>

            <!-- 📋 BẢNG DANH SÁCH KHÓA HỌC -->
            <c:choose>
                <c:when test="${not empty dsKhoaHoc}">
                    <table id="courseTable">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên khóa học</th>
                                <th>Tên Khối</th>
                                <th>Mô tả</th>
                                <th>Thời gian</th>
                                <th>Ghi chú</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody id="tableBody">
                            <c:forEach var="khoa" items="${dsKhoaHoc}" varStatus="loop">
                                <c:if test="${empty param.keyword 
                                    or fn:containsIgnoreCase(khoa.tenKhoaHoc, param.keyword)
                                    or fn:containsIgnoreCase(khoa.tenKhoi, param.keyword)
                                    or fn:containsIgnoreCase(khoa.moTa, param.keyword)
                                    or fn:containsIgnoreCase(khoa.ghiChu, param.keyword)
                                    or fn:containsIgnoreCase(khoa.thoiGianBatDau, param.keyword)
                                    or fn:containsIgnoreCase(khoa.thoiGianKetThuc, param.keyword)
                                }">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${khoa.tenKhoaHoc}</td>
                                        <td>${khoa.tenKhoi}</td>
                                        <td>${khoa.moTa}</td>
                                        <td>${khoa.thoiGianBatDau} đến ${khoa.thoiGianKetThuc}</td>
                                        <td>${khoa.ghiChu}</td>
                                        <td>
                                            <form action="StudentViewLopTrongKhoaServlet" method="get">
                                                <input type="hidden" name="idKhoaHoc" value="${khoa.ID_KhoaHoc}">
                                                <button class="action-btn" type="submit">Xem lớp</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 📌 Phân trang hiển thị tại đây -->
                    <div id="pagination-container"></div>
                </c:when>
                <c:otherwise>
                    <div class="no-data">Không có khóa học nào đang mở để đăng ký.</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ⚙️ SCRIPT PHÂN TRANG -->
        <script>
            $(document).ready(function () {
                var itemsPerPage = 5;
                var items = $("#tableBody tr");
                var numItems = items.length;

                function showPage(items, page) {
                    var start = (page - 1) * itemsPerPage;
                    var end = start + itemsPerPage;
                    items.hide().slice(start, end).show();
                }

                if (numItems > 0) {
                    showPage(items, 1);
                    $('#pagination-container').pagination({
                        items: numItems,
                        itemsOnPage: itemsPerPage,
                        onPageClick: function (pageNumber) {
                            showPage(items, pageNumber);
                        }
                    });
                }
            });
        </script>
    </body>
</html>