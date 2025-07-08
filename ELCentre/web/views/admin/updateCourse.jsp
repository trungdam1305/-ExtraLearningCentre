<%-- 
    Document   : updateCourse
    Created on : May 27, 2025, 18:23:02 PM
    Author     : Vuh26
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Admin"%>
<%@page import="dal.AdminDAO"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật khóa học</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
            }

            /* General container styling */
            .content-container {
                padding: 6px;
                max-width: 100%;
                margin: 0 auto;
                margin-left: 160px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-top: 60px;
                padding-bottom: 40px; /* Prevent footer overlap */
            }

            /* Form styling */
            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
                font-size: 1.33rem; /* Reduced from ~2rem (2/3) */
            }
            form {
                max-width: 500px; /* Reduced from 600px */
                margin: 0 auto;
                background-color: #fff;
                padding: 16px; /* Reduced from 20px */
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
                font-size: 0.58rem; /* Reduced from 14px (~0.875rem, 2/3) */
            }
            input[type="text"],
            input[type="date"],
            input[type="number"],
            input[type="file"],
            textarea,
            select {
                width: 100%;
                padding: 6px; /* Reduced from 10px */
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 0.58rem; /* Reduced from 14px (~0.875rem, 2/3) */
                box-sizing: border-box;
            }
            input[type="text"],
            input[type="date"],
            input[type="number"],
            select {
                height: 28px; /* Match manageCourses.jsp */
            }
            input[type="file"] {
                padding: 2px; /* Reduced from 3px */
            }
            input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            textarea {
                resize: vertical;
                min-height: 60px; /* Reduced from 80px */
            }
            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 6px 12px; /* Reduced from 10px 20px */
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.58rem; /* Reduced from 14px (~0.875rem, 2/3) */
                margin-right: 10px;
            }
            button:hover {
                background-color: #0056b3;
            }
            p {
                text-align: center;
                font-size: 0.58rem; /* Reduced from 14px (~0.875rem, 2/3) */
            }
            p[style*="red"] {
                color: red;
                font-weight: bold;
            }
            p[style*="green"] {
                color: green;
                font-weight: bold;
            }
            form[action*="ManageCourse"] {
                text-align: center;
                margin-top: 10px;
            }
            img {
                max-width: 150px; /* Reduced from 200px */
                margin-bottom: 10px;
                border-radius: 6px;
            }

            /* Header styling */
            .header {
                background-color: #1F4E79;
                color: white;
                padding: 4px 8px;
                text-align: left;
                position: fixed;
                width: calc(100% - 160px);
                left: 160px;
                right: 0;
                top: 0;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .header .left-title {
                font-size: 0.83rem;
                letter-spacing: 1px;
                display: flex;
                align-items: center;
            }
            .header .left-title i {
                margin-right: 8px;
            }

            /* Footer styling */
            .footer {
                background-color: #1F4E79;
                color: #B0C4DE;
                text-align: center;
                padding: 3px 0;
                position: fixed;
                width: calc(100% - 160px);
                left: 160px;
                right: 0;
                bottom: 0;
                z-index: 1000;
            }
            .footer p {
                margin: 0;
                font-size: 0.5rem;
            }

            /* Sidebar styling */
            .sidebar {
                width: 160px;
                background-color: #1F4E79;
                color: white;
                padding: 6px;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
                height: 100vh;
                position: fixed;
                left: 0;
                top: 0;
                z-index: 1001;
            }
            .sidebar h4 {
                margin: 0 auto;
                font-weight: bold;
                letter-spacing: 1.5px;
                text-align: center;
                font-size: 0.9rem;
            }
            .sidebar-logo {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                object-fit: cover;
                margin: 5px auto;
                display: block;
                border: 3px solid #B0C4DE;
            }
            .sidebar-section-title {
                font-weight: bold;
                margin-top: 15px;
                font-size: 11px;
                text-transform: uppercase;
                color: #B0C4DE;
                border-bottom: 1px solid #B0C4DE;
                padding-bottom: 3px;
            }
            ul.sidebar-menu {
                list-style: none;
                padding-left: 0;
                margin: 4px 0 0 0;
            }
            ul.sidebar-menu li {
                margin: 4px 0;
            }
            ul.sidebar-menu li a {
                color: white;
                text-decoration: none;
                padding: 4px 6px;
                display: flex;
                align-items: center;
                border-radius: 5px;
                font-size: 0.75rem;
                transition: background-color 0.3s ease;
            }
            ul.sidebar-menu li a:hover {
                background-color: #163E5C;
            }
            ul.sidebar-menu li a i {
                margin-right: 5px;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .content-container {
                    padding: 8px;
                    margin: 5px;
                    margin-left: 0;
                    margin-top: 50px;
                    padding-bottom: 30px;
                }
                h2 {
                    font-size: 0.89rem; /* Reduced from 1.33rem (2/3) */
                }
                form {
                    max-width: 100%;
                    padding: 12px;
                }
                label {
                    font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
                }
                input[type="text"],
                input[type="date"],
                input[type="number"],
                input[type="file"],
                textarea,
                select {
                    font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
                    padding: 4px;
                }
                input[type="text"],
                input[type="date"],
                input[type="number"],
                select {
                    height: 24px;
                }
                input[type="file"] {
                    padding: 2px;
                }
                textarea {
                    min-height: 50px;
                }
                button {
                    font-size: 0.38rem;
                    padding: 4px 8px;
                }
                p {
                    font-size: 0.38rem;
                }
                img {
                    max-width: 100px; /* Reduced from 150px */
                }
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    box-shadow: none;
                    padding: 5px;
                }
                .header, .footer {
                    width: 100%;
                    margin-left: 0;
                    left: 0;
                    right: 0;
                }
                .sidebar h4 {
                    font-size: 0.85rem;
                }
                .sidebar-logo {
                    width: 50px;
                    height: 50px;
                    margin: 5px auto;
                }
                .sidebar-section-title {
                    margin-top: 12px;
                    font-size: 10px;
                    padding-bottom: 3px;
                }
                ul.sidebar-menu {
                    margin: 4px 0 0 0;
                }
                ul.sidebar-menu li {
                    margin: 4px 0;
                }
                ul.sidebar-menu li a {
                    padding: 3px 5px;
                    font-size: 0.7rem;
                }
                ul.sidebar-menu li a i {
                    margin-right: 5px;
                }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="left-title">
                Admin Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                    ArrayList<Admin> admins = (ArrayList) AdminDAO.getNameAdmin();
                %>
                <img src="<%= admins.get(0).getAvatar() %>" alt="Admin Photo" class="admin-img">
                <span><%= admins.get(0).getHoTen() %></span>
                <i class="fas fa-caret-down"></i>
                <div class="dropdown-menu" id="adminDropdown">
                    <a href="#"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                    <a href="#"><i class="fas fa-user-edit"></i> Cập nhật thông tin</a>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li></ul>
            <div class="sidebar-section-title">Quản lý học tập</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/ManageCourse"><i class="fas fa-book"></i> Khoá học</a></li>
            </ul>
            <div class="sidebar-section-title">Hệ thống</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-cog"></i> Cài đặt</a></li>
            </ul>
            <div class="sidebar-section-title">Khác</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
            </ul>
        </div>

        <div class="content-container">
            <h2>Cập nhật khóa học</h2>  
            <form action="${pageContext.request.contextPath}/ManageCourse" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="submitUpdateCourse" />
                <input type="hidden" name="ID_KhoaHoc" value="${khoaHoc.ID_KhoaHoc}" />

                <!-- Debug để kiểm tra khoaHoc -->
                <c:if test="${empty khoaHoc}">
                    <p style="color: red;">Không có dữ liệu khóa học để hiển thị!</p>
                </c:if>

                <label>ID khối học:</label>
                <input type="text" value="${khoaHoc.ID_Khoi} (Lớp ${khoaHoc.ID_Khoi + 5}${khoaHoc.ID_Khoi == 8 ? ' - Tổng ôn' : ''})" readonly />
                <input type="hidden" name="ID_Khoi" value="${khoaHoc.ID_Khoi}" />

                <label>Tên khóa học:</label>
                <input type="text" value="${khoaHoc.tenKhoaHoc}" readonly />
                <input type="hidden" name="TenKhoaHoc" value="${khoaHoc.tenKhoaHoc}" />

                <label>Mã khóa học:</label>
                <input type="text" id="courseCode" name="CourseCode" value="${khoaHoc.courseCode}" readonly />

                <label>Mô tả:</label>
                <textarea name="MoTa">${khoaHoc.moTa}</textarea>

                <label>Thời gian bắt đầu:</label>
                <input type="date" name="ThoiGianBatDau" value="${khoaHoc.thoiGianBatDau}" min="${today}" />

                <label>Thời gian kết thúc:</label>
                <input type="date" name="ThoiGianKetThuc" value="${khoaHoc.thoiGianKetThuc}" />

                <label>Ghi chú:</label>
                <input type="text" name="GhiChu" value="${khoaHoc.ghiChu}" />

                <label>Trạng thái:</label>
                <select name="TrangThai" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Đang hoạt động" ${khoaHoc.trangThai == 'Đang hoạt động' ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="Chưa hoạt động" ${khoaHoc.trangThai == 'Chưa hoạt động' ? 'selected' : ''}>Chưa hoạt động</option>
                    <option value="Chưa bắt đầu" ${khoaHoc.trangThai == 'Chưa bắt đầu' ? 'selected' : ''}>Chưa bắt đầu</option>
                    <option value="Đã kết thúc" ${khoaHoc.trangThai == 'Đã kết thúc' ? 'selected' : ''}>Đã kết thúc</option>
                </select>

                <label>Hình ảnh hiện tại:</label>
                <c:if test="${not empty khoaHoc.image}">
                    <img src="${pageContext.request.contextPath}${khoaHoc.image}" alt="Hình ảnh khóa học" />
                </c:if>
                <c:if test="${empty khoaHoc.image}">
                    <p>Chưa có hình ảnh</p>
                </c:if>
                <label>Tải lên hình ảnh mới (tùy chọn):</label>
                <input type="file" name="Image" accept="image/jpeg,image/png" />

                <label>Thứ tự:</label>
                <input type="number" name="Order" value="${khoaHoc.order}" min="0" placeholder="Nhập thứ tự (tùy chọn)" />

                <button type="submit">Cập nhật</button>
            </form>

            <c:if test="${not empty err}">
                <p style="color: red;">${err}</p>
            </c:if>
            <c:if test="${not empty suc}">
                <p style="color: green;">${suc}</p>
            </c:if>

            <!-- Nút quay lại -->
            <form action="${pageContext.request.contextPath}/ManageCourse" method="get" style="margin-top: 10px;">
                <input type="hidden" name="action" value="refresh" />
                <input type="hidden" name="sortColumn" value="${sortColumn}" />
                <input type="hidden" name="sortOrder" value="${sortOrder}" />
                <input type="hidden" name="statusFilter" value="${statusFilter}" />
                <input type="hidden" name="name" value="${name}" />
                <input type="hidden" name="page" value="${pageNumber}" />
                <button type="submit">Quay lại</button>
            </form>
        </div>

        <div class="footer">
            <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
        </div>

        <% 
            java.time.LocalDate today = java.time.LocalDate.now();
            pageContext.setAttribute("today", today.toString());
        %>

        <script>
            document.querySelector('input[name="Image"]').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                    alert('Chỉ chấp nhận file .jpg hoặc .png!');
                    e.target.value = '';
                }
            });

            document.querySelector('form').addEventListener('submit', function (e) {
                const trangThai = document.querySelector('[name="TrangThai"]').value;
                if (!["Đang hoạt động", "Chưa hoạt động", "Chưa bắt đầu", "Đã kết thúc"].includes(trangThai)) {
                    alert('Vui lòng chọn trạng thái hợp lệ!');
                    e.preventDefault();
                    return;
                }
                if (!confirm('Bạn có chắc muốn lưu khóa học này?')) {
                    e.preventDefault();
                }
            });
        </script>

        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>