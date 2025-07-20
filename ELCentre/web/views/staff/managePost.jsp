<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bài viết Blog - EL CENTRE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Your existing CSS styles go here. Ensure these styles are correctly applied. */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            min-height: 100vh;
            background-color: #f9f9f9;
        }

        .header {
            background-color: #1F4E79;
            color: white;
            padding: 5px 20px;
            text-align: left;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: fixed;
            width: calc(100% - 250px);
            margin-left: 250px;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 20px;
        }

        .header .left-title {
            font-size: 24px;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
        }

        .header .left-title i {
            margin-left: 10px;
        }

        .admin-profile {
            position: relative;
            display: flex;
            align-items: center;
            cursor: pointer;
            margin-right: 20px;
        }

        .admin-profile .admin-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #B0C4DE;
            margin-right: 10px;
        }

        .admin-profile span {
            font-size: 14px;
            color: #B0C4DE;
            font-weight: 600;
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .admin-profile i {
            color: #B0C4DE;
            margin-left: 10px;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 50px;
            right: 0;
            background: #163E5C;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            min-width: 180px;
            z-index: 1001;
        }

        .dropdown-menu.active {
            display: block;
        }

        .dropdown-menu a {
            display: block;
            padding: 10px 15px;
            color: white;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .dropdown-menu a:hover {
            background-color: #1F4E79;
        }

        .dropdown-menu a i {
            margin-right: 8px;
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
            overflow-y: auto;
        }

        .sidebar h4 {
            margin: 0 auto;
            font-weight: bold;
            letter-spacing: 1.5px;
            text-align: center;
            width: 230px;
        }

        .sidebar-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin: 15px auto;
            display: block;
            border: 3px solid #B0C4DE;
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
            font-size: 14px;
            display: flex;
            align-items: center;
            padding: 8px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        ul.sidebar-menu li a:hover {
            background-color: #163E5C;
        }

        ul.sidebar-menu li a i {
            margin-right: 10px;
        }

        .main-content {
            margin-left: 270px;
            padding: 80px 20px 20px 20px;
            flex: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-right: auto;
            max-width: calc(100% - 250px);
        }
        
        .data-table-container {
            background: linear-gradient(135deg, #ffffff, #f0f4f8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: left;
        }

        table th {
            background-color: #e2eaf0;
            color: #1F4E79;
        }

        p.no-data {
            color: red;
            font-weight: 600;
            text-align: center;
            padding: 15px 0;
        }
        
        .footer {
            background-color: #1F4E79;
            color: #B0C4DE;
            text-align: center;
            padding: 5px 0;
            position: fixed;
            width: calc(100% - 250px);
            bottom: 0;
            margin-left: 250px;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }
        .filter-container {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .filter-container .filter-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-container label {
            font-weight: bold;
            color: #333;
            white-space: nowrap;
        }

        .filter-container input,
        .filter-container select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            min-width: 150px;
        }

        .filter-container button {
            padding: 8px 15px;
            background-color: #1F4E79;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .filter-container button:hover {
            background-color: #163E5C;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 25px;
        }

        .pagination a {
            color: #555;
            text-decoration: none;
            padding: 6px 12px;
            margin: 0 2px;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
            border: 1px solid #ddd;
        }

        .pagination a.active {
            background-color: #1F4E79;
            color: white;
            border-color: #1F4E79;
            font-weight: bold;
        }

        .pagination a:hover:not(.active) {
            background-color: #e2eaf0;
            color: #1F4E79;
        }
    </style>
</head>
<body>
    
    <div class="header">
        <div class="left-title">
            Staff Dashboard <i class="fas fa-tachometer-alt"></i>
        </div>
        <div class="admin-profile" onclick="toggleDropdown()">
            <c:forEach var="staff" items="${staffs}">
                <img src="${staff.getAvatar()}" alt="Staff Photo" class="admin-img">
                <span>${staff.getHoTen()}</span>
            </c:forEach>
            <i class="fas fa-caret-down"></i>
            <div class="dropdown-menu" id="adminDropdown">
                <a href="${pageContext.request.contextPath}/staffChangePassword"><i class="fas fa-key"></i> Change Password</a>
                <a href="${pageContext.request.contextPath}/staffUpdateInfo"><i class="fas fa-user-edit"></i> Update Information</a>
                <a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>

    <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageTimeTable"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</a></li>
                <li><a href="${pageContext.request.contextPath}/StaffManageAttendance"><i class="fas fa-check-square"></i> Điểm danh</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý tài chính</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffViewSalary"><i class="fas fa-money-check-alt"></i> Học phí</a></li>
            </ul>
            <div class="sidebar-section-title">Hỗ trợ</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-envelope-open-text"></i> Yêu cầu hỗ trợ</a></li>
                <li><a href="${pageContext.request.contextPath}/staffGetConsultationRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
                <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-envelope-open-text"></i> Tài Liệu</a></li>                
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>
    <main class="main-content">
        <h1>Quản lý Bài viết Blog</h1>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3><i class="fas fa-blog"></i> Danh sách bài viết</h3>
                <a href="${pageContext.request.contextPath}/ManagePost?action=add" class="btn btn-success btn-sm">
                    <i class="fas fa-plus-circle me-2"></i> Thêm Blog mới
                </a>
            </div>
            <div class="card-body">
                <!--Error message-->
                <c:if test="${not empty param.message || not empty param.error}">
                    <c:if test="${param.message == 'add_success'}">
                        <div class="alert alert-success" role="alert">
                            <strong>Thành công!</strong> Đã thêm bài viết mới.
                        </div>
                    </c:if>
                    <c:if test="${param.message == 'update_success'}">
                        <div class="alert alert-success" role="alert">
                            <strong>Thành công!</strong> Đã cập nhật bài viết.
                        </div>
                    </c:if>
                    <c:if test="${param.message == 'delete_success'}">
                        <div class="alert alert-success" role="alert">
                            <strong>Thành công!</strong> Đã xóa bài viết.
                        </div>
                    </c:if>
                    <c:if test="${param.error == 'upload_failed'}">
                        <div class="alert alert-danger" role="alert">
                            <strong>Lỗi!</strong> Tải ảnh lên thất bại. Vui lòng thử lại.
                        </div>
                    </c:if>
                    <c:if test="${param.error == 'not_found'}">
                        <div class="alert alert-danger" role="alert">
                            <strong>Lỗi!</strong> Không tìm thấy bài viết.
                        </div>
                    </c:if>
                    <c:if test="${param.error == 'db_error'}">
                        <div class="alert alert-danger" role="alert">
                            <strong>Lỗi!</strong> Lỗi cơ sở dữ liệu. Vui lòng thử lại sau.
                        </div>
                    </c:if>
                </c:if>
                <!--Filter and Search Bar-->
                <form action="${pageContext.request.contextPath}/ManagePost" method="GET" class="mb-4">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-4">
                            <label for="keyword" class="form-label">Tìm kiếm theo tên:</label>
                            <input type="text" class="form-control" id="keyword" name="keyword" placeholder="Nhập từ khóa..." value="${keyword != null ? keyword : ''}">
                        </div>
                        <div class="col-md-3">
                            <label for="idKeyTag" class="form-label">Lọc theo KeyTag:</label>
                            <select class="form-select" id="idKeyTag" name="idKeyTag">
                                <option value="0">Tất cả KeyTags</option> 
                                <c:forEach var="tag" items="${availableKeyTags}">
                                    <option value="${tag.getID_KeyTag()}" ${selectedKeyTagId == tag.getID_KeyTag() ? 'selected' : ''}>${tag.getKeyTag()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label for="year" class="form-label">Lọc theo Năm:</label>
                            <select class="form-select" id="year" name="year">
                                <option value="">Tất cả Năm</option>
                                <c:forEach var="yr" items="${availableYears}">
                                    <option value="${yr}" ${selectedYear == yr ? 'selected' : ''}>${yr}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">Tìm kiếm & Lọc</button>
                        </div>
                    </div>
                </form>
                <!--List of Post-->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tiêu đề</th>
                                <th>Mô tả</th>
                                <th>Ngày đăng</th>
                                <th>KeyTag</th>
                                <th>Phân loại</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty blogList}">
                                    <tr>
                                        <td colspan="7" class="text-center">Không tìm thấy bài viết nào.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="blog" items="${blogList}">
                                        <tr>
                                            <td>${blog.ID_Blog}</td>
                                            <td>${blog.blogTitle}</td>
                                            <td>${blog.blogDescription}</td>
                                            <td>${blog.formattedDate}</td> <%-- Use formattedDate for display --%>
                                            <td>${blog.keyTag}</td> <%-- Display KeyTag Name (string) --%>
                                            <td>${blog.phanLoai}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/ManagePost?action=edit&id=${blog.ID_Blog}" class="btn btn-warning btn-sm me-1">Sửa</a>
                                                <a href="${pageContext.request.contextPath}/ManagePost?action=delete&id=${blog.ID_Blog}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?')">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <nav aria-label="Page navigation example" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:url var="basePaginationUrl" value="ManagePost">
                            <c:param name="keyword" value="${keyword}" />
                            <c:param name="idKeyTag" value="${selectedKeyTagId}" /> <%-- Use idKeyTag --%>
                            <c:param name="year" value="${selectedYear}" />
                            <c:param name="action" value="list" />
                        </c:url>

                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="${basePaginationUrl}&page=${currentPage - 1}" tabindex="-1" aria-disabled="${currentPage == 1 ? 'true' : 'false'}">Trước</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="${basePaginationUrl}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="${basePaginationUrl}&page=${currentPage + 1}" aria-disabled="${currentPage == totalPages ? 'true' : 'false'}">Tiếp</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </main>

    <div class="footer">
        <p>© 2025 EL CENTRE. All rights reserved. | Developed by EL CENTRE</p>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("adminDropdown").classList.toggle("active");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.admin-profile') && !event.target.matches('.admin-profile *')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('active')) {
                        openDropdown.classList.remove('active');
                    }
                }
            }
        }
    </script>
</body>
</html>