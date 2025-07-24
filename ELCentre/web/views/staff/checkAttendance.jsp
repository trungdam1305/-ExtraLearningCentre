<!--Check Attendance jsp
Author : trungdam
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thời Khóa Biểu - EL CENTRE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
            h1 {
            margin-top: 30px;
            color: #1F4E79; 
            text-align: center;
            font-size: 24px; 
            font-weight: bold; 
        }
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

            .teacher-profile {
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center; 
                cursor: pointer;
                margin-left: 20px; 
                margin-right: 100px; 
                
            }

            .teacher-profile .teacher-img {
                width: 40px;
                height: 40px;
                border-radius: 50%; 
                object-fit: cover;
                border: 2px solid #B0C4DE;
                margin-bottom: 5px;
                
            }

            .teacher-profile span {
                font-size: 14px;
                color: #B0C4DE;
                font-weight: 600;
                max-width: 250px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .teacher-profile i {
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
                min-width: 150px;
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

            .dashboard-stats {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                transform: translate(145px, 30px);
                
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

            .tables-wrapper {
                display: flex;
                gap: 20px;
                transform: translate(145px, 30px);
            }

            .tables-wrapper .data-table-container {
                background: linear-gradient(135deg, #ffffff, #f0f4f8);
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            }

            .tables-wrapper .data-table-container:first-child {
                flex: 7;
            }

            .tables-wrapper .data-table-container:last-child {
                flex: 3;
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
            <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-file-alt"></i> Tài Liệu</a></li> <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>
            
        
            <!--main content-->
        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-list-ul"></i> Danh sách lớp đang hoạt động</h3>
                </div>
                <!--Filter and Search Bar-->
                <div class="card-body">  
                    <form action="StaffManageAttendance" method="GET" class="filter-form" style="margin-bottom: 20px" >
                        <div class="row g-3 align-items-end">
                            <div class="col-md-3">
                                <label for="keyword" class="form-label">Tên hoặc Mã lớp</label>
                                <input type="text" id="keyword" name="keyword" class="form-control" value="${keyword}">
                            </div>
                            <div class="col-md-3">
                                <label for="courseId" class="form-label">Môn học</label>
                                <select id="courseId" name="courseId" class="form-select">
                                    <option value="">-- Tất cả --</option>
                                    <c:forEach var="c" items="${khoaHocList}">
                                        <option value="${c.ID_KhoaHoc}" ${c.ID_KhoaHoc == selectedCourseId ? 'selected' : ''}>${c.tenKhoaHoc}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="khoiId" class="form-label">Khối</label>
                                <select id="khoiId" name="khoiId" class="form-select">
                                    <option value="">-- Tất cả --</option>
                                    <c:forEach var="k" items="${khoiHocList}">
                                        <option value="${k.ID_Khoi}" ${k.ID_Khoi == selectedKhoiId ? 'selected' : ''}>${k.tenKhoi}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="creationYear" class="form-label">Năm tạo</label>
                                <select id="creationYear" name="creationYear" class="form-select">
                                    <option value="">-- Tất cả --</option>
                                    <c:forEach var="y" items="${yearList}">
                                        <option value="${y}" ${y == selectedYear ? 'selected' : ''}>Năm ${y}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">Lọc</button>
                            </div>
                        </div>
                    </form>
                    <!--List Class and Action-->        
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Mã Lớp</th><th>Tên Lớp</th><th>Giáo viên</th><th class="text-center">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lop" items="${activeClassList}">
                                <tr>
                                    <td>${lop.classCode}</td>
                                    <td>${lop.tenLopHoc}</td>
                                    <td>${lop.tenGiaoVien}</td>
                                    <td class="text-center">
                                        <a href="StaffManageAttendance?action=viewDetail&classId=${lop.ID_LopHoc}" class="btn btn-sm" style="background: linear-gradient(135deg, #E0F7FA, #B2EBF2)">
                                            <i class="fas fa-calendar-week"></i> Xem Điểm Danh
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                             <c:if test="${empty activeClassList}">
                                <tr><td colspan="4" class="text-center text-muted p-4">Không tìm thấy lớp học nào phù hợp.</td></tr>
                            </c:if>
                        </tbody>
                    </table>

                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">
                            <c:url var="paginationUrl" value="StaffManageAttendance">
                                <c:param name="keyword" value="${keyword}"/><c:param name="courseId" value="${selectedCourseId}"/>
                                <c:param name="khoiId" value="${selectedKhoiId}"/><c:param name="creationYear" value="${selectedYear}"/>
                            </c:url>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${paginationUrl}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
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
                const dropdown = document.getElementById('adminDropdown');
                dropdown.classList.toggle('active');
            }

            document.addEventListener('click', function (event) {
                const profile = document.querySelector('.admin-profile');
                const dropdown = document.getElementById('adminDropdown');
                if (!profile.contains(event.target)) {
                    dropdown.classList.remove('active');
                }
            });

    </script>
</body>
</html>