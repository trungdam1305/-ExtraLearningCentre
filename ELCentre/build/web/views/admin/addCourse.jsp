<%-- 
    Document   : addCourse
    Created on : May 27, 2025, 11:33:02 PM
    Author     : Vuh26
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.TaiKhoan"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Admin"%>
<%@page import="dal.AdminDAO"%>
<%@page import="java.util.UUID"%>
<%
    // Kiểm tra session và vai trò người dùng
    TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Giả sử bạn lưu thông tin người dùng trong session với key là "user"

    // Nếu người dùng chưa đăng nhập (user == null) hoặc không phải là Admin (ID_VaiTro != 1)
    if (user == null || user.getID_VaiTro() != 1) {
        // Gửi thông báo lỗi về trang đăng nhập
        session.setAttribute("error", "Bạn không có quyền truy cập trang này. Vui lòng đăng nhập với tài khoản Admin.");
        response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Hoặc trang đăng nhập của bạn
        return; // Dừng việc xử lý trang hiện tại
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm khóa học</title>
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

            /* Form styling */
            h2 {
                text-align: center;
                color: #003087;
                margin-bottom: 15px;
                font-size: 1.07rem;
                font-weight: 600;
            }
            form {
                max-width: 500px;
                margin: 0 auto;
                background-color: #fff;
                padding: 16px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
                font-size: 0.58rem;
            }
            input[type="text"],
            input[type="date"],
            input[type="number"],
            input[type="file"],
            textarea,
            select {
                width: 100%;
                padding: 6px;
                margin-bottom: 15px;
                border: 1px solid #ced4da;
                border-radius: 6px;
                font-size: 0.58rem;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus,
            input[type="date"]:focus,
            input[type="number"]:focus,
            select:focus,
            textarea:focus {
                border-color: #003087;
                box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
            }
            input[type="text"],
            input[type="date"],
            input[type="number"],
            select {
                height: 28px;
            }
            input[type="file"] {
                padding: 2px;
            }
            input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            textarea {
                resize: vertical;
                min-height: 60px;
            }
            button {
                background-color: #003087;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 6px;
                cursor: pointer;
                font-size: 0.58rem;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            button:hover {
                background-color: #00215a;
                transform: translateY(-2px);
            }
            .alert-custom-success {
                background-color: #22c55e;
                border-color: #22c55e;
                color: white;
                border-radius: 8px;
                padding: 8px;
                margin-bottom: 10px;
                font-size: 0.57rem;
                text-align: center;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
            }
            .alert-custom-danger {
                background-color: #ef4444;
                border-color: #ef4444;
                color: white;
                border-radius: 8px;
                padding: 8px;
                margin-bottom: 10px;
                font-size: 0.57rem;
                text-align: center;
                max-width: 500px;
                margin-left: auto;
                margin-right: auto;
            }
            .dashboard-button {
                text-align: center;
                margin-top: 10px;
            }
            .dashboard-button .btn {
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 0.57rem;
                background-color: #003087;
                border-color: #003087;
                color: white;
            }
            .dashboard-button .btn:hover {
                background-color: #00215a;
                border-color: #00215a;
                transform: translateY(-2px);
            }
            .dashboard-button .btn i {
                margin-right: 4px;
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
                    font-size: 0.8rem;
                }
                form {
                    max-width: 100%;
                    padding: 12px;
                }
                label {
                    font-size: 0.38rem;
                }
                input[type="text"],
                input[type="date"],
                input[type="number"],
                input[type="file"],
                textarea,
                select {
                    font-size: 0.38rem;
                    padding: 4px;
                    height: 26px;
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
                .alert-custom-success,
                .alert-custom-danger {
                    font-size: 0.38rem;
                    padding: 6px;
                    margin-bottom: 8px;
                }
                .dashboard-button .btn {
                    font-size: 0.38rem;
                    padding: 4px 8px;
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
                <li><a href="${pageContext.request.contextPath}/adminGoToFirstPage"><i class="bi bi-house-door"></i> Dashboard</a></li>
            </ul>
            <div class="sidebar-section-title">Quản lý người dùng</div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocsinh">Học sinh</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=giaovien">Giáo viên</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=taikhoan">Tài khoản</a></li>
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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="content-container">
            <!-- Tạo CSRF token nếu chưa tồn tại -->
            <c:if test="${empty sessionScope.csrfToken}">
                <% 
                    String csrfToken = UUID.randomUUID().toString();
                    session.setAttribute("csrfToken", csrfToken);
                %>
            </c:if>

            <h2>Thêm khóa học</h2>  

            <!-- Thông báo -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-custom-success" role="alert">${suc}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/ManageCourse" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addKhoaHoc" />
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}" />
                <label for="ID_Khoi">ID khối học:<span style="color: red;">*</span></label>
                <select name="ID_Khoi" id="ID_Khoi" required>
                    <option value="">-- Chọn khối học --</option>
                    <option value="1">Lớp 6</option>
                    <option value="2">Lớp 7</option>
                    <option value="3">Lớp 8</option>
                    <option value="4">Lớp 9</option>
                    <option value="5">Lớp 10</option>
                    <option value="6">Lớp 11</option>
                    <option value="7">Lớp 12</option>
                    <option value="8">Tổng ôn</option>
                </select>
                <label for="TenKhoaHoc">Tên môn học:<span style="color: red;">*</span></label>
                <select name="TenKhoaHoc" id="TenKhoaHoc" required>
                    <option value="">-- Chọn tên khóa học --</option>
                    <!-- Các khóa cơ bản -->
                    <option value="Toán">Toán</option>
                    <option value="Ngữ văn">Ngữ văn</option>
                    <option value="Vật lý">Vật lý</option>
                    <option value="Hóa học">Hóa học</option>
                    <option value="Sinh học">Sinh học</option>
                    <option value="Tin học">Tin học</option>
                    <option value="Lịch sử">Lịch sử</option>
                    <option value="Địa lý">Địa lý</option>
                    <option value="Giáo dục công dân">Giáo dục công dân</option>
                    <option value="Tiếng Anh">Tiếng Anh</option>
                    <option value="Công nghệ">Công nghệ</option>
                    <!-- Các khóa tổng ôn -->
                    <option value="Khóa tổng ôn Toán">Khóa tổng ôn Toán</option>
                    <option value="Khóa tổng ôn Ngữ văn">Khóa tổng ôn Ngữ văn</option>
                    <option value="Khóa tổng ôn Vật lý">Khóa tổng ôn Vật lý</option>
                    <option value="Khóa tổng ôn Hóa học">Khóa tổng ôn Hóa học</option>
                    <option value="Khóa tổng ôn Sinh học">Khóa tổng ôn Sinh học</option>
                    <option value="Khóa tổng ôn Tin học">Khóa tổng ôn Tin học</option>
                    <option value="Khóa tổng ôn Lịch sử">Khóa tổng ôn Lịch sử</option>
                    <option value="Khóa tổng ôn Địa lý">Khóa tổng ôn Địa lý</option>
                    <option value="Khóa tổng ôn Giáo dục công dân">Khóa tổng ôn Giáo dục công dân</option>
                    <option value="Khóa tổng ôn Tiếng Anh">Khóa tổng ôn Tiếng Anh</option>
                    <option value="Khóa tổng ôn Công nghệ">Khóa tổng ôn Công nghệ</option>
                </select>
                <label for="courseCode">Mã khóa học (tự động):</label>
                <input type="text" id="courseCode" name="CourseCode" readonly />
                <label for="MoTa">Mô tả:</label>
                <textarea name="MoTa" id="MoTa"></textarea>
                <label for="ThoiGianBatDau">Thời gian bắt đầu:<span style="color: red;">*</span></label>
                <input type="date" name="ThoiGianBatDau" id="ThoiGianBatDau" min="${today}" required />
                <label for="ThoiGianKetThuc">Thời gian kết thúc:<span style="color: red;">*</span></label>
                <input type="date" name="ThoiGianKetThuc" id="ThoiGianKetThuc" min="${today}" required />
                <label for="GhiChu">Ghi chú:</label>
                <input type="text" name="GhiChu" id="GhiChu" />
                <label for="Image">Hình ảnh:</label>
                <input type="file" name="Image" id="Image" accept="image/jpeg,image/png" />
                <label for="Order">Thứ tự ưu tiên:</label>
                <input type="number" name="Order" id="Order" min="0" placeholder="Nhập thứ tự (tùy chọn)" />
                <button type="submit">Thêm</button>
            </form>

            <!-- Nút quay lại -->
            <div class="dashboard-button">
                <form action="${pageContext.request.contextPath}/ManageCourse" method="get">
                    <input type="hidden" name="action" value="refresh" />
                    <input type="hidden" name="sortColumn" value="${sortColumn}" />
                    <input type="hidden" name="sortOrder" value="${sortOrder}" />
                    <input type="hidden" name="sortName" value="${sortName}" />
                    <input type="hidden" name="name" value="${name}" />
                    <input type="hidden" name="page" value="${pageNumber}" />
                    <button type="submit" class="btn"><i class="bi bi-arrow-left"></i> Quay lại danh sách khóa học</button>
                </form>
            </div>
        </div>

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

            // Xóa dấu tiếng Việt
            function removeDiacritics(str) {
                return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
            }

            // Cập nhật mã khóa học tự động
            function updateCourseCode() {
                const ten = document.querySelector('[name="TenKhoaHoc"]').value;
                const khoi = document.querySelector('[name="ID_Khoi"]').value;
                const courseCodeField = document.querySelector('#courseCode');
                if (ten && khoi) {
                    let courseCode;
                    if (ten.startsWith("Khóa tổng ôn ")) {
                        courseCode = "TONG" + removeDiacritics(ten.replace("Khóa tổng ôn ", "")).toUpperCase().replace(/\s/g, "");
                    } else {
                        const prefix = removeDiacritics(ten.length >= 3 ? ten.substring(0, 3) : ten).toUpperCase();
                        const khoiNum = (parseInt(khoi) <= 7 ? parseInt(khoi) + 5 : 0).toString().padStart(2, '0');
                        courseCode = prefix + khoiNum;
                    }
                    if (!/^[A-Za-z0-9]+$/.test(courseCode)) {
                        courseCodeField.value = "";
                        alert("Mã khóa học chỉ được chứa chữ và số!");
                    } else {
                        courseCodeField.value = courseCode;
                    }
                } else {
                    courseCodeField.value = "";
                }
            }

            // Kiểm tra khóa tổng ôn và ID khối
            document.querySelector('[name="TenKhoaHoc"]').addEventListener('change', function () {
                const ten = this.value;
                const khoiSelect = document.querySelector('[name="ID_Khoi"]');
                if (ten.startsWith("Khóa tổng ôn ") && khoiSelect.value !== "8") {
                    alert("Khóa tổng ôn phải có ID khối học là 8!");
                    khoiSelect.value = "8";
                    updateCourseCode();
                }
                updateCourseCode();
            });

            document.querySelector('[name="ID_Khoi"]').addEventListener('change', updateCourseCode);

            // Kiểm tra định dạng file ảnh
            document.querySelector('input[name="Image"]').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                    alert('Chỉ chấp nhận file .jpg hoặc .png!');
                    e.target.value = '';
                }
            });

            // Kiểm tra ngày hợp lệ và xác nhận submit
            document.querySelector('form').addEventListener('submit', function (e) {
                const startDate = document.getElementById('ThoiGianBatDau').value;
                const endDate = document.getElementById('ThoiGianKetThuc').value;
                if (startDate && endDate && new Date(endDate) < new Date(startDate)) {
                    alert('Ngày kết thúc phải sau ngày bắt đầu!');
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