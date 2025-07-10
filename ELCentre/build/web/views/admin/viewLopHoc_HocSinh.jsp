<%-- 
    Document   : viewLopHoc_HocSinh
    Created on : Jul 10, 2025, 1:04:02 AM
    Author     : Vuh26
--%>

<%-- 
    Document   : viewLopHoc_GiaoVien
    Created on : Jul 10, 2025, 12:10:44 AM
    Author     : Vuh26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dal.AdminDAO" %>
<%@ page import="model.Admin" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Lớp Học Giáo Viên</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Font Awesome -->
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

            /* Header styling */
            .header-row {
                text-align: center;
                margin-bottom: 15px;
                color: #003087;
            }
            .header-row h2 {
                font-size: 1.07rem;
                font-weight: 600;
            }

            /* Action and search row */
            .action-search-row {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 6px;
                margin-bottom: 15px;
                flex-wrap: nowrap;
            }
            .action-search-row .form-control,
            .action-search-row .form-select {
                border-radius: 8px;
                border: 1px solid #ced4da;
                box-shadow: none;
                transition: border-color 0.3s ease;
                height: 28px;
                font-size: 0.57rem;
                width: 110px;
            }
            .action-search-row .form-control:focus,
            .action-search-row .form-select:focus {
                border-color: #003087;
                box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
            }
            .action-search-row .btn-custom-action {
                height: 28px;
                display: flex;
                align-items: center;
                padding: 0 8px;
                white-space: nowrap;
                font-size: 0.57rem;
            }

            /* Custom button styling */
            .btn-custom-action {
                background-color: #003087;
                border-color: #003087;
                color: white;
                border-radius: 8px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-custom-action:hover {
                background-color: #00215a;
                border-color: #00215a;
                transform: translateY(-2px);
            }
            .btn-custom-action i {
                margin-right: 4px;
            }

            /* Table styling */
            .table-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 15px;
                max-width: 98%;
                margin-left: auto;
                margin-right: auto;
            }
            .table-responsive {
                width: 100%;
                overflow-x: auto;
            }
            .table {
                width: 100%;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                font-size: 0.58rem;
            }
            .table thead {
                background-color: #2196F3;
            }
            .table thead th {
                padding: 8px 10px;
                vertical-align: middle;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.6rem;
                color: black;
                text-align: center;
                min-width: 120px;
            }
            .table tbody td {
                padding: 8px 10px;
                vertical-align: middle;
                text-align: center;
                font-size: 0.58rem;
            }
            .description-column {
                max-width: 280px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .description-column:hover {
                overflow: visible;
                white-space: normal;
                background-color: #f8f9fa;
                z-index: 1;
                position: relative;
            }

            /* Action buttons in table */
            .table .action-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 2px;
                justify-content: center;
            }
            .table .btn-sm {
                margin-right: 4px;
                border-radius: 6px;
                font-size: 0.5rem;
                padding: 3px 5px;
                min-width: 50px;
                text-align: center;
                line-height: 1.2;
            }
            .btn-info {
                background-color: #17a2b8;
                border-color: #17a2b8;
            }
            .btn-info:hover {
                background-color: #117a8b;
                border-color: #117a8b;
            }

            /* Status badge styling */
            .status-badge {
                padding: 2px 4px;
                border-radius: 12px;
                font-size: 0.5rem;
                font-weight: 500;
            }
            .status-dang-hoc {
                background-color: #22c55e;
                color: white;
            }
            .status-ket-thuc {
                background-color: #ef4444;
                color: white;
            }
            .status-chua-hoc {
                background-color: #6b7280;
                color: white;
            }

            /* Collapsible row styling */
            .details-row {
                display: none; /* Ẩn hàng chi tiết mặc định */
                background-color: #f8f9fa;
            }
            .details-row td {
                padding: 12px;
                border-top: 1px solid #dee2e6;
            }
            .details-content {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
            }
            .details-content div {
                flex: 1 1 45%;
                font-size: 0.58rem;
            }
            .details-content div strong {
                color: #003087;
            }
            .details-content img {
                width: 50px !important;
                height: 50px !important;
                object-fit: cover;
                border-radius: 4px;
                border: 2px solid lightblue;
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

            /* Scroll to Top */
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
                .action-search-row {
                    flex-direction: column;
                    align-items: flex-end;
                    gap: 6px;
                }
                .action-search-row .form-control,
                .action-search-row .form-select,
                .action-search-row .btn-custom-action {
                    width: auto;
                    font-size: 0.38rem;
                    height: 26px;
                }
                .action-search-row .btn-custom-action {
                    padding: 0 6px;
                }
                .table thead th,
                .table tbody td {
                    padding: 5px 6px;
                    font-size: 0.5rem;
                }
                .table .btn-sm {
                    font-size: 0.48rem;
                    padding: 2px 4px;
                    min-width: 45px;
                }
                .status-badge {
                    padding: 2px 4px;
                    font-size: 0.48rem;
                }
                .details-content div {
                    flex: 1 1 100%;
                    font-size: 0.54rem;
                }
                .details-content img {
                    width: 40px !important;
                    height: 40px !important;
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

            .course-stats {
                font-size: 0.67rem !important;
                margin: 8px 0;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
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

        <!-- Sidebar -->
        <div class="sidebar">
            <h4>EL CENTRE</h4>
            <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
            <div class="sidebar-section-title">Tổng quan</div>
            <ul class="sidebar-menu">
                <li><a href="#"><i class="fas fa-chart-line"></i> Dashboard</a></li>
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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content-container">
            <!-- Tạo CSRF token nếu chưa tồn tại -->
            <c:if test="${empty sessionScope.csrfToken}">
                <% 
                    String csrfToken = UUID.randomUUID().toString();
                    session.setAttribute("csrfToken", csrfToken);
                %>
            </c:if>

            <!-- Tiêu đề -->
            <div class="header-row">
                <h2>Danh Sách Lớp Học Hiẹn Tại Của Học Sinh</h2>
            </div>

            <!-- Thông báo -->
            <c:if test="${not empty error}">
                <div class="alert alert-custom-danger" role="alert">${error}</div>
            </c:if>



            <input type="text" class="form-control" id="searchInput" placeholder="Tìm theo mã hoặc tên lớp" onkeyup="searchClasses()">
            <!-- Bảng danh sách -->

            <div class="table-container">
                <c:if test="${not empty lopHocs}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Mã Lớp</th>
                                    <th>Tên Lớp</th>
                                    <th>Khóa Học</th>
                                    <th>Sĩ Số</th>
                                    <th>Trạng Thái</th>
                                    <th>Số Tiền</th>
                                    <th>Thứ Tự</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="lopHoc" items="${lopHocs}">
                                    <tr>
                                        <td>${lopHoc.classCode != null ? lopHoc.classCode : 'Chưa có'}</td>
                                        <td>${lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : 'Chưa có'}</td>
                                        <td>${lopHoc.idKhoaHoc != null ? lopHoc.idKhoaHoc : 'Chưa có'}</td>
                                        <td>${lopHoc.siSo != null ? lopHoc.siSo : '0'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${lopHoc.trangThai == 'Đang hoạt động'}">
                                                    <span class="status-badge status-dang-hoc">Đang hoạt động</span>
                                                </c:when>
                                                <c:when test="${lopHoc.trangThai == 'Đã kết thúc'}">
                                                    <span class="status-badge status-ket-thuc">Đã kết thúc</span>
                                                </c:when>
                                                <c:when test="${lopHoc.trangThai == 'Chưa bắt đầu'}">
                                                    <span class="status-badge status-chua-hoc">Chưa bắt đầu</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>${lopHoc.trangThai != null ? lopHoc.trangThai : 'Chưa có'}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${lopHoc.soTien != null ? lopHoc.soTien : '0'} VND</td>
                                        <td>${lopHoc.order != null ? lopHoc.order : '0'}</td>
                                        <td class="action-buttons">
                                            <button type="button" class="btn btn-info btn-sm toggle-details" data-id="${lopHoc.idLopHoc}">
                                                <i class="bi bi-info-circle"></i> Xem chi tiết
                                            </button>
                                            <a href="${pageContext.request.contextPath}/ManageClassDetail?ID_LopHoc=${lopHoc.idLopHoc}&ID_KhoaHoc=${lopHoc.idKhoaHoc}&ID_Khoi=${lopHoc.idKhoi}&ClassCode=${lopHoc.classCode}" class="btn btn-secondary btn-sm" aria-label="Xem danh sách lớp">
                                                <i class="bi bi-eye"></i> Danh sách học sinh
                                            </a>
                                        </td>
                                    </tr>
                                    <tr class="details-row" id="details-${lopHoc.idLopHoc}">
                                        <td colspan="8">
                                            <div class="details-content">
                                                <div><strong>Sĩ Số Tối Đa:</strong> ${lopHoc.siSoToiDa != null ? lopHoc.siSoToiDa : '0'}</div>
                                                <div><strong>Sĩ Số Tối Thiểu:</strong> ${lopHoc.siSoToiThieu != null ? lopHoc.siSoToiThieu : '0'}</div>
                                                <div><strong>Ngày Tạo:</strong> ${lopHoc.ngayTao != null ? lopHoc.ngayTao : 'Chưa có'}</div>
                                                <div><strong>Ghi Chú:</strong> ${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Chưa có'}</div>
                                                <div>
                                                    <strong>Hình Ảnh Lớp:</strong><br>
                                                    <c:choose>
                                                        <c:when test="${not empty lopHoc.avatarGiaoVien}">
                                                            <img src="${pageContext.request.contextPath}/images/${lopHoc.avatarGiaoVien}" alt="Hình lớp" width="50" style="max-height: 50px; object-fit: cover;" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="https://via.placeholder.com/50" alt="No Image" width="50" style="max-height: 50px; object-fit: cover;" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>

            <!-- Nút hành động -->
            <div class="action-search-row">
                <a href="${pageContext.request.contextPath}/views/admin/adminReceiveHocSinh.jsp" class="btn btn-custom-action">
                    <i class="bi bi-arrow-left"></i> Quay lại bảng học sinh
                </a>
            </div>

        </div>

        <!-- Footer -->
        <div class="footer">
            <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
        </div>

        <!-- Nút Scroll to Top -->
        <button id="scrollToTopBtn" onclick="scrollToTop()" title="Cuộn lên đầu trang">↑</button>

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

            // Kiểm tra sự tồn tại của ảnh
            document.querySelectorAll('img[data-course-image]').forEach(img => {
                const imageUrl = img.getAttribute('data-course-image');
                const fallbackUrl = 'https://via.placeholder.com/50';
                const testImage = new Image();
                testImage.src = imageUrl;
                testImage.onload = () => {
                    img.src = imageUrl;
                };
                testImage.onerror = () => {
                    img.src = fallbackUrl;
                    img.onerror = null;
                };
            });

            // Toggle hàng chi tiết
            document.querySelectorAll('.toggle-details').forEach(button => {
                button.addEventListener('click', function () {
                    const id = this.getAttribute('data-id');
                    const detailsRow = document.getElementById('details-' + id);
                    const isVisible = detailsRow.style.display === 'table-row';
                    detailsRow.style.display = isVisible ? 'none' : 'table-row';
                    this.innerHTML = isVisible
                            ? '<i class="bi bi-info-circle"></i> Xem chi tiết'
                            : '<i class="bi bi-x-circle"></i> Ẩn chi tiết';
                });
            });

            // Đảm bảo tất cả hàng chi tiết ẩn khi tải trang
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.details-row').forEach(row => {
                    row.style.display = 'none';
                });
            });
            
            function searchClasses() {
    const input = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('.table tbody tr:not(.details-row)');
    rows.forEach(row => {
        const classCode = row.cells[0].textContent.toLowerCase();
        const className = row.cells[1].textContent.toLowerCase();
        row.style.display = (classCode.includes(input) || className.includes(input)) ? '' : 'none';
    });
}
        </script>
    </body>
</html>