<%-- 
    Document   : staff_updateCourse
    Created on : Jul 24, 2025
    Author     : Vuh26
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.TaiKhoan"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Staff"%>
<%@page import="dal.StaffDAO"%>
<%@page import="java.util.UUID"%>

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
    <!-- Font Awesome for additional icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            font-size: 0.58rem;
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
        .header .admin-profile {
            position: relative;
            cursor: pointer;
        }
        .header .admin-img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 8px;
            vertical-align: middle;
        }
        .header .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            border-radius: 4px;
            min-width: 150px;
            z-index: 1000;
        }
        .header .dropdown-menu.active {
            display: block;
        }
        .header .dropdown-menu a {
            display: block;
            padding: 8px 12px;
            color: #333;
            text-decoration: none;
            font-size: 0.57rem;
        }
        . tracking-in-expand {
            -webkit-animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
                    animation: tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000) both;
        }
        @-webkit-keyframes tracking-in-expand {
            0% {
                letter-spacing: -0.5em;
                opacity: 0;
            }
            40% {
                opacity: 0.6;
            }
            100% {
                opacity: 1;
            }
        }
        @keyframes tracking-in-expand {
            0% {
                letter-spacing: -0.5em;
                opacity: 0;
            }
            40% {
                opacity: 0.6;
            }
            100% {
                opacity: 1;
            }
        }
        .header .dropdown-menu a:hover {
            background-color: #f4f6f9;
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
            overflow-y: auto;
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
            padding-bottom: 40px;
        }

        /* Header row styling */
        .header-row {
            text-align: center;
            margin-bottom: 15px;
            color: #003087;
        }
        .header-row h2 {
            font-size: 1.07rem;
            font-weight: 600;
        }

        /* Form styling */
        form {
            max-width: 600px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #003087;
            font-size: 0.6rem;
        }
        input[type="text"],
        input[type="date"],
        input[type="number"],
        input[type="file"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 0.58rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="number"]:focus,
        input[type="file"]:focus,
        textarea:focus,
        select:focus {
            border-color: #003087;
            box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
        }
        input[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }
        input[type="file"] {
            padding: 3px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        button {
            background-color: #003087;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.57rem;
            margin-right: 10px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        button:hover {
            background-color: #00215a;
            transform: translateY(-2px);
        }

        /* Alerts */
        .alert-custom-success {
            background-color: #22c55e;
            border-color: #22c55e;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.57rem;
        }
        .alert-custom-danger {
            background-color: #ef4444;
            border-color: #ef4444;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.57rem;
        }

        /* Image styling */
        img {
            max-width: 200px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 2px solid lightblue;
        }

        /* Scroll to Top Button */
        #scrollToTopBtn {
            display: none;
            position: fixed;
            bottom: 15px;
            right: 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: background-color 0.3s ease;
        }
        #scrollToTopBtn:hover {
            background-color: #0056b3;
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
            .header-row h2 {
                font-size: 0.8rem;
            }
            label {
                font-size: 0.5rem;
            }
            input[type="text"],
            input[type="date"],
            input[type="number"],
            input[type="file"],
            textarea,
            select {
                padding: 6px;
                margin-bottom: 10px;
                font-size: 0.5rem;
            }
            button {
                padding: 6px 12px;
                font-size: 0.48rem;
            }
            .alert-custom-success,
            .alert-custom-danger {
                padding: 6px;
                margin-bottom: 8px;
                font-size: 0.38rem;
            }
            img {
                max-width: 150px;
            }
            #scrollToTopBtn {
                bottom: 8px;
                right: 8px;
                width: 30px;
                height: 30px;
                font-size: 12px;
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
    <!-- Header content -->
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
                <a href="#"><i class="fas fa-key"></i> Đổi mật khẩu</a>
                <a href="#"><i class="fas fa-user-edit"></i> Cập nhật thông tin</a>
            </div>
        </div>
    </div>

    <!-- Sidebar content -->
    <div class="sidebar">
        <h4>EL CENTRE</h4>
        <img src="<%= request.getContextPath() %>/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
        <div class="sidebar-section-title">Tổng quan</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/staffGoToFirstPage"><i class="fas fa-chart-line"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-section-title">Quản lý học tập</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/Staff_ManageCourse"><i class="fas fa-book"></i> Khóa học</a></li>
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
            <li><a href="${pageContext.request.contextPath}/staffGetConsultationRequests"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
        </ul>
        <div class="sidebar-section-title">Khác</div>
        <ul class="sidebar-menu">
            <li><a href="${pageContext.request.contextPath}/ManagePost"><i class="fas fa-blog"></i> Bài Viết</a></li>
            <li><a href="${pageContext.request.contextPath}/ManageMaterial"><i class="fas fa-envelope-open-text"></i> Tài Liệu</a></li>                
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="content-container">
        <div class="header-row">
            <h2 class="tracking-in-expand">Cập nhật khóa học</h2>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty err}">
            <div class="alert alert-custom-danger" role="alert">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-custom-success" role="alert">${suc}</div>
        </c:if>
        <c:if test="${empty khoaHoc}">
            <div class="alert alert-custom-danger" role="alert">Không có dữ liệu khóa học để hiển thị!</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/Staff_ManageCourse" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="submitUpdateCourse" />
            <input type="hidden" name="ID_KhoaHoc" value="${khoaHoc.ID_KhoaHoc}" />

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

        <form action="${pageContext.request.contextPath}/Staff_ManageCourse" method="get" style="text-align: center; margin-top: 20px;">
            <input type="hidden" name="action" value="refresh" />
            <input type="hidden" name="sortColumn" value="${sortColumn}" />
            <input type="hidden" name="sortOrder" value="${sortOrder}" />
            <input type="hidden" name="statusFilter" value="${statusFilter}" />
            <input type="hidden" name="name" value="${name}" />
            <input type="hidden" name="page" value="${pageNumber}" />
            <button type="submit">Quay lại</button>
        </form>
    </div>

    <!-- Footer content -->
    <div class="footer">
        <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
    </div>

    <!-- Nút Scroll to Top -->
    <button id="scrollToTopBtn" onclick="scrollToTop()" title="Cuộn lên đầu trang">↑</button>

    <%-- Tính ngày hiện tại để dùng trong min của input date --%>
    <% 
        java.time.LocalDate today = java.time.LocalDate.now();
        pageContext.setAttribute("today", today.toString());
    %>

    <!-- Bootstrap 5 JS và Popper -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        // Hiển thị/n ẩn nút khi cuộn
        window.onscroll = function () {
            var scrollBtn = document.getElementById("scrollToTopBtn");
            if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                scrollBtn.style.display = "block";
            } else {
                scrollBtn.style.display = "none";
            }
        };

        // Hàm cuộn lên đầu trang
        function scrollToTop() {
            window.scrollTo({top: 0, behavior: "smooth"});
        }

        // Xử lý dropdown menu trong header
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

        // Kiểm tra định dạng file ảnh
        document.querySelector('input[name="Image"]').addEventListener('change', function (e) {
            const file = e.target.files[0];
            if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                alert('Chỉ chấp nhận file .jpg hoặc .png!');
                e.target.value = '';
            }
        });

        // Kiểm tra trạng thái và xác nhận submit
        document.querySelector('form').addEventListener('submit', function (e) {
            const trangThai = document.querySelector('[name="TrangThai"]').value;
            if (!["Đang hoạt động", "Chưa bắt đầu", "Đã kết thúc"].includes(trangThai)) {
                alert('Vui lòng chọn trạng thái hợp lệ!');
                e.preventDefault();
                return;
            }
            if (!confirm('Bạn có chắc muốn lưu khóa học này?')) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>