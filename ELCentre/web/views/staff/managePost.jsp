<!--manage post jsp
Author : trungdam
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bài viết - EL CENTRE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        /* Giữ nguyên toàn bộ các style CSS đẹp mắt của bạn */
        body { margin: 0; font-family: Arial, sans-serif; display: flex; min-height: 100vh; background-color: #f8f9fa; }
        .header { background-color: #1F4E79; color: white; padding: 10px 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); position: fixed; width: calc(100% - 250px); margin-left: 250px; z-index: 1000; display: flex; align-items: center; justify-content: space-between; height: 60px; }
        .sidebar { width: 250px; background-color: #1F4E79; color: white; padding: 20px; box-shadow: 2px 0 5px rgba(0,0,0,0.1); display: flex; flex-direction: column; height: 100vh; position: fixed; overflow-y: auto; }
        .sidebar h4 { text-align: center; font-weight: bold; }
        .sidebar-logo { width: 60px; height: 60px; border-radius: 50%; object-fit: cover; margin: 15px auto; display: block; }
        ul.sidebar-menu { list-style: none; padding-left: 0; margin: 10px 0 0 0; }
        ul.sidebar-menu li a { color: white; text-decoration: none; display: flex; align-items: center; padding: 10px; border-radius: 5px; transition: background-color 0.3s ease; }
        ul.sidebar-menu li a:hover, ul.sidebar-menu li.active a { background-color: #163E5C; }
        ul.sidebar-menu li a i { margin-right: 10px; width: 20px; }
        .sidebar-section-title { font-weight: bold; margin-top: 20px; font-size: 14px; text-transform: uppercase; color: #B0C4DE; padding-bottom: 5px; }
        .main-content { margin-left: 250px; padding: 80px 20px 20px 20px; flex-grow: 1; width: calc(100% - 250px); }
        .admin-profile { position: relative; display: flex; align-items: center; cursor: pointer; }
        .admin-profile .admin-img { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; margin-right: 10px; }
        .dropdown-menu { display: none; position: absolute; top: 50px; right: 0; background: #fff; border-radius: 5px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); min-width: 200px; z-index: 1001; }
        .dropdown-menu.active { display: block; }
        .dropdown-menu a { display: block; padding: 10px 15px; color: #333; text-decoration: none; font-size: 14px; }
        .dropdown-menu a:hover { background-color: #f1f1f1; }
        .dropdown-menu a i { margin-right: 8px; }
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
            <li><a href="${pageContext.request.contextPath}/Staff_ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            <li><a href="${pageContext.request.contextPath}/StaffManageTimeTable"><i class="fas fa-calendar-alt"></i> Thời Khóa Biểu</a></li>
            <li><a href="${pageContext.request.contextPath}/StaffManageAttendance"><i class="fas fa-check-square"></i> Điểm danh</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý tài chính</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffGoToTuition"><i class="fas fa-money-check-alt"></i> Học phí</a></li>
        </ul>
        <div class="sidebar-section-title">Hỗ trợ</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffGetSupportRequests"><i class="fas fa-envelope-open-text"></i> Yêu cầu hỗ trợ</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-file-alt"></i> Tài Liệu</a></li> <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>
    
    <main class="main-content">
        <h1 class="mb-4">Quản lý Bài viết</h1>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list-alt"></i> Danh sách bài viết</h5>
                <a href="${pageContext.request.contextPath}/ManagePost?action=add" class="btn btn-success btn-sm">
                    <i class="fas fa-plus-circle me-1"></i> Thêm bài viết
                </a>
            </div>
            <div class="card-body">
                <c:if test="${param.message == 'add_success'}"><div class="alert alert-success">Thêm bài viết thành công!</div></c:if>
                <c:if test="${param.message == 'update_success'}"><div class="alert alert-success">Cập nhật bài viết thành công!</div></c:if>
                <c:if test="${param.message == 'delete_success'}"><div class="alert alert-success">Xóa bài viết thành công!</div></c:if>
                <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>

                <form action="${pageContext.request.contextPath}/ManagePost" method="GET" class="mb-4 p-3 bg-light border rounded">
                    <input type="hidden" name="action" value="list">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-5">
                            <label for="keywordId" class="form-label fw-bold">Lọc theo Keyword:</label>
                            <select class="form-select" id="keywordId" name="keywordId">
                                <option value="0">-- Tất cả Keywords --</option>
                                <c:forEach var="kw" items="${allKeywords}">
                                    <option value="${kw.ID_Keyword}" ${selectedKeywordId == kw.ID_Keyword ? 'selected' : ''}>${kw.keyword}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label for="keytagId" class="form-label fw-bold">Lọc theo KeyTag:</label>
                            <select class="form-select" id="keytagId" name="keytagId">
                                <option value="0">-- Tất cả KeyTags --</option>
                                <c:forEach var="tag" items="${allKeytags}">
                                    <option value="${tag.ID_KeyTag}" ${selectedKeytagId == tag.ID_KeyTag ? 'selected' : ''}>${tag.keyTag}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100"><i class="fas fa-filter"></i> Lọc</button>
                        </div>
                    </div>
                </form>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-light text-center">
                            <tr>
                                <th>ID</th>
                                <th>Tiêu đề</th>
                                <th>Keyword</th>
                                <th>KeyTag</th>
                                <th>Ngày đăng</th>
                                <th style="width: 120px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty blogList}">
                                    <tr><td colspan="7" class="text-center">Không có dữ liệu nào phù hợp.</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="blog" items="${blogList}">
                                        <tr>
                                            <td class="text-center">${blog.ID_Blog}</td>
                                            <td>${blog.blogTitle}</td>
                                            <td class="text-center"><span class="badge bg-success">${blog.keyWord}</span></td>
                                            <td class="text-center"><span class="badge bg-info text-dark">${blog.keyTag}</span></td>
                                            <td class="text-center">${blog.formattedDate}</td>
                                            <td class="text-center">
                                                <a href="${pageContext.request.contextPath}/ManagePost?action=edit&id=${blog.ID_Blog}" class="btn btn-warning btn-sm" title="Sửa"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/ManagePost?action=delete&id=${blog.ID_Blog}" class="btn btn-danger btn-sm" title="Xóa" onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này không?')"><i class="fas fa-trash"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:if test="${totalPages > 1}">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:url var="pageUrl" value="ManagePost">
                                    <c:param name="action" value="list"/>
                                    <c:param name="page" value="${i}"/>
                                    <c:if test="${selectedKeywordId > 0}"><c:param name="keywordId" value="${selectedKeywordId}"/></c:if>
                                    <c:if test="${selectedKeytagId > 0}"><c:param name="keytagId" value="${selectedKeytagId}"/></c:if>
                                </c:url>
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </main>
    
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