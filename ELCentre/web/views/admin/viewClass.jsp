<%-- 
    Document   : viewClass
    Created on : June 16, 2025, 10:33:02 PM
    Author     : Vuh26
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.LopHoc"%>
<%@page import="model.LichHoc"%>
<%@page import="model.GiaoVien"%>
<%@page import="model.HocSinh"%>
<%@page import="dal.GiaoVienDAO"%>
<%@page import="dal.HocSinhDAO"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="model.KhoaHoc"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dal.AdminDAO"%>
<%@page import="model.Admin"%>
<%
    // Lấy dữ liệu từ request
    LopHoc lopHoc = (LopHoc) request.getAttribute("lopHoc");
    List<LichHoc> lichHocList = (List<LichHoc>) request.getAttribute("lichHocList");
    Integer idKhoaHoc = (Integer) request.getAttribute("ID_KhoaHoc");
    Integer idKhoi = (Integer) request.getAttribute("ID_Khoi");

    // Khởi tạo các biến mặc định
    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    HocSinhDAO hocSinhDAO = new HocSinhDAO();
    GiaoVien giaoVien = null;
    List<HocSinh> hocSinhList = new ArrayList<>();
    List<GiaoVien> availableTeachers = new ArrayList<>();
    List<HocSinh> allStudents = new ArrayList<>();

    // Lấy dữ liệu nếu lopHoc không null
    if (lopHoc != null && idKhoaHoc != null) {
        try {
            giaoVien = giaoVienDAO.getGiaoVienByLopHoc(lopHoc.getID_LopHoc());
            hocSinhList = hocSinhDAO.getHocSinhByLopHoc(lopHoc.getID_LopHoc());
            allStudents = HocSinhDAO.adminGetAllHocSinh1();
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization(tenKhoaHoc);
                System.out.println("Available teachers size: " + availableTeachers.size()); // Debug
            } else {
                System.out.println("KhoaHoc is null for ID: " + idKhoaHoc); // Debug
            }
        } catch (Exception e) {
            System.out.println("Error fetching data: " + e.getMessage());
            e.printStackTrace();
        }
    } else {
        System.out.println("LopHoc or ID_KhoaHoc is null"); // Debug
    }

    // Gán các biến vào pageContext
    pageContext.setAttribute("lopHoc", lopHoc);
    pageContext.setAttribute("lichHocList", lichHocList);
    pageContext.setAttribute("giaoVien", giaoVien);
    pageContext.setAttribute("hocSinhList", hocSinhList);
    pageContext.setAttribute("availableTeachers", availableTeachers);
    pageContext.setAttribute("allStudents", allStudents);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết lớp học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

        /* Content styling */
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 1.33rem; /* Reduced from ~2rem (2/3) */
        }
        .section-title {
            font-size: 1rem; /* Reduced from 1.5rem (2/3) */
            color: #003087;
            margin-top: 15px;
            margin-bottom: 8px;
        }
        .detail-item {
            margin-bottom: 10px;
            font-size: 0.58rem; /* Reduced from ~1rem (2/3) */
        }
        .detail-label {
            font-weight: bold;
            color: #003087;
            font-size: 0.58rem; /* Reduced from ~1rem (2/3) */
        }
        .teacher-info {
            border: 1px solid #dee2e6;
            padding: 8px; /* Reduced from 10px */
            border-radius: 4px;
            background-color: #f8f9fa;
        }
        .student-table, .teacher-table, .schedule-table {
            width: 100%;
            margin-top: 8px;
            font-size: 0.58rem; /* Reduced from ~1rem (2/3) */
        }
        .student-table th, .teacher-table th, .schedule-table th {
            background-color: #2196F3;
            color: white;
            font-weight: bold;
            padding: 5px 8px; /* Reduced from 8px */
            text-align: left;
            border: 1px solid #dee2e6;
        }
        .student-table td, .teacher-table td, .schedule-table td {
            padding: 5px 8px; /* Reduced from 8px */
            text-align: left;
            border: 1px solid #dee2e6;
        }
        .back-button {
            margin-top: 15px; /* Reduced from 20px */
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 15px; /* Reduced from 20px */
            font-size: 0.58rem; /* Reduced from 14px (~0.875rem, 2/3) */
            text-align: center;
            padding: 10px; /* Reduced from 15px */
        }
        .alert-custom-danger {
            background-color: #ff5733;
            border-color: #ff5733;
            color: white;
        }
        .alert-success {
            background-color: #22c55e;
            color: white;
            font-weight: bold;
        }
        .alert-warning {
            background-color: #ffc107;
            color: #333;
            font-weight: bold;
        }
        .teacher-select, .student-select {
            margin-top: 8px;
        }
        .teacher-select .form-control, .student-select .form-control {
            width: 100%;
            max-width: 300px; /* Reduced from 400px */
            height: 28px; /* Match manageCourses.jsp */
            font-size: 0.58rem; /* Reduced from ~1rem (2/3) */
        }
        #teacherModal .modal-dialog, #studentModal .modal-dialog {
            max-width: 600px; /* Reduced from 800px */
        }
        .modal-header {
            background-color: #003087;
            color: white;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .modal-header h5 {
            font-size: 0.8rem; /* Match manageCourses.jsp */
        }
        .modal-footer .btn {
            font-size: 0.58rem; /* Reduced from ~1rem (2/3) */
            padding: 4px 8px; /* Reduced from default */
        }
        .btn-sm {
            font-size: 0.5rem; /* Adjusted to match .btn-sm in manageCourses.jsp */
            padding: 4px 6px; /* Match .btn-sm */
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
            border-color: #b91c1c;
        }
        .hidden {
            display: none;
        }
        img {
            max-width: 100px; /* Reduced from 150px */
            max-height: 130px; /* Reduced from 200px */
            object-fit: cover;
            border-radius: 4px;
            border: 2px solid lightblue;
        }
        .no-image {
            font-size: 0.58rem; /* Match other text */
            color: #666;
            margin-bottom: 10px;
        }
        .scroll-to-top {
            position: fixed;
            bottom: 15px; /* Reduced from 20px */
            right: 15px; /* Reduced from 20px */
            display: none;
            width: 40px; /* Reduced from 50px */
            height: 40px; /* Reduced from 50px */
            background-color: #2196F3;
            color: white;
            border-radius: 50%;
            text-align: center;
            line-height: 40px;
            font-size: 14px; /* Reduced from 24px */
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.3s;
            z-index: 1000;
        }
        .scroll-to-top:hover {
            opacity: 1;
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
            .section-title {
                font-size: 0.67rem; /* Reduced from 1rem (2/3) */
                margin-top: 10px;
                margin-bottom: 6px;
            }
            .detail-item {
                font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
                margin-bottom: 8px;
            }
            .detail-label {
                font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
            }
            .teacher-info {
                padding: 6px;
            }
            .student-table, .teacher-table, .schedule-table {
                font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
                margin-top: 6px;
            }
            .student-table th, .teacher-table th, .schedule-table th,
            .student-table td, .teacher-table td, .schedule-table td {
                padding: 4px 6px; /* Reduced from 5px 8px */
            }
            .back-button {
                margin-top: 10px;
            }
            .alert {
                font-size: 0.38rem;
                padding: 8px;
                margin-bottom: 10px;
            }
            .teacher-select .form-control, .student-select .form-control {
                max-width: 100%;
                height: 24px;
                font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
            }
            .modal-header h5 {
                font-size: 0.53rem; /* Reduced from 0.8rem (2/3) */
            }
            .modal-footer .btn {
                font-size: 0.38rem;
                padding: 3px 6px;
            }
            .btn-sm {
                font-size: 0.33rem; /* Reduced from 0.5rem (2/3) */
                padding: 3px 5px;
            }
            img {
                max-width: 60px; /* Reduced from 100px */
                max-height: 80px; /* Reduced from 130px */
            }
            .no-image {
                font-size: 0.38rem; /* Reduced from 0.58rem (2/3) */
            }
            .scroll-to-top {
                width: 30px;
                height: 30px;
                line-height: 30px;
                font-size: 12px; /* Reduced from 14px */
                bottom: 8px;
                right: 8px;
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
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=hocphi"><i class="fas fa-money-bill-wave"></i> Học phí</a></li>
        </ul>
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
        <h2 class="text-center mb-4">Chi tiết lớp học</h2>

        <!-- Thông báo toàn cục -->
        <c:if test="${not empty err}">
            <div class="alert alert-custom-danger" role="alert">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-success" role="alert">${suc}</div>
        </c:if>

        <c:if test="${lopHoc != null}">
            <!-- Thông tin lớp học -->
            <div class="section-title">Thông tin lớp học</div>
            <div class="detail-item">
                <span class="detail-label">Tên lớp:</span> ${lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : 'Chưa có'}
            </div>
            <div class="detail-item">
                <span class="detail-label">Mã lớp:</span> ${lopHoc.classCode != null ? lopHoc.classCode : 'Chưa có'}
            </div>
            <div class="detail-item">
                <span class="detail-label">Sĩ số:</span> ${lopHoc.siSo != 0 ? lopHoc.siSo : 0}
            </div>
            <div class="detail-item">
                <span class="detail-label">Sĩ số tối đa:</span> ${lopHoc.siSoToiDa != 0 ? lopHoc.siSoToiDa : 0}
            </div>
            <div class="detail-item">
                <span class="detail-label">Sĩ số tối thiểu:</span> ${lopHoc.siSoToiThieu != 0 ? lopHoc.siSoToiThieu : 0}
            </div>
            <div class="detail-item">
                <span class="detail-label">Ghi chú:</span> ${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Chưa có'}
            </div>
            <div class="detail-item">
                <span class="detail-label">Trạng thái:</span> ${lopHoc.trangThai != null ? lopHoc.trangThai : 'Chưa có'}
            </div>

            <!-- Thông tin lịch học -->
            <div class="section-title">Thông tin lịch học</div>
            <c:choose>
                <c:when test="${not empty lichHocList}">
                    <table class="schedule-table">
                        <thead>
                            <tr>
                                <th>Ngày học</th>
                                <th>Slot học</th>
                                <th>Phòng học</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lichHoc" items="${lichHocList}">
                                <tr>
                                    <td>${lichHoc.ngayHoc != null ? lichHoc.ngayHoc : 'Chưa có'}</td>
                                    <td>${lichHoc.slotThoiGian != null ? lichHoc.slotThoiGian : 'Chưa có'}</td>
                                    <td>${lichHoc.getID_PhongHoc() != null ? lichHoc.getID_PhongHoc() : 'Chưa có'}</td>
                                    <td>${lichHoc.ghiChu != null ? lichHoc.ghiChu : 'Chưa có'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning" role="alert">Chưa có lịch học nào cho lớp này.</div>
                </c:otherwise>
            </c:choose>

            <!-- Thông tin giáo viên -->
            <div class="section-title">Thông tin giáo viên</div>
            <c:choose>
                <c:when test="${giaoVien != null}">
                    <div class="teacher-info">
                        <div class="detail-item">
                            <span class="detail-label">Họ và tên:</span> ${giaoVien.hoTen != null ? giaoVien.hoTen : 'Chưa có'}
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Số điện thoại:</span> ${giaoVien.SDT != null ? giaoVien.SDT : 'Chưa có'}
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Chuyên môn:</span> ${giaoVien.chuyenMon != null ? giaoVien.chuyenMon : 'Chưa có'}
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Trường học:</span> ${giaoVien.tenTruongHoc != null ? giaoVien.tenTruongHoc : 'Chưa có'}
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Ảnh đại diện:</span>
                            <c:if test="${not empty giaoVien.avatar}">
                                <img src="${pageContext.request.contextPath}/${giaoVien.avatar}" alt="Teacher Avatar" />
                            </c:if>
                            <c:if test="${empty giaoVien.avatar}">
                                <span class="no-image">Chưa có ảnh</span>
                            </c:if>
                        </div>
                        <button id="changeTeacherBtn" class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                            <i class="bi bi-pencil-square"></i> Thay đổi giáo viên
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning" role="alert">Chưa có giáo viên được phân công.</div>
                    <button id="changeTeacherBtn" class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                        <i class="bi bi-person-plus"></i> Thêm giáo viên
                    </button>
                </c:otherwise>
            </c:choose>

            <!-- Thông báo liên quan đến giáo viên và học sinh -->
            <c:if test="${not empty teacherSuc}">
                <div class="alert alert-success">${teacherSuc}</div>
            </c:if>
            <c:if test="${not empty studentSuc}">
                <div class="alert alert-success">${studentSuc}</div>
            </c:if>
            <c:if test="${not empty teacherErr}">
                <div class="alert alert-danger">${teacherErr}</div>
            </c:if>
            <c:if test="${not empty studentErr}">
                <div class="alert alert-danger">${studentErr}</div>
            </c:if>

            <!-- Modal để thay đổi giáo viên -->
            <div class="modal fade" id="teacherModal" tabindex="-1" aria-labelledby="teacherModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="teacherModalLabel">Chọn giáo viên</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <c:choose>
                                <c:when test="${not empty availableTeachers}">
                                    <div class="teacher-select mb-3">
                                        <label for="teacherSearch" class="form-label">Tìm kiếm giáo viên:</label>
                                        <input type="text" id="teacherSearch" class="form-control" placeholder="Nhập tên giáo viên" value="${param.teacherSearch}">
                                    </div>
                                    <form id="assignTeacherForm" action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                        <input type="hidden" name="action" value="assignTeacher">
                                        <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                        <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                        <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                        <input type="hidden" name="teacherSearch" id="hiddenTeacherSearch">
                                        <table class="teacher-table" id="teacherTable">
                                            <thead>
                                                <tr>
                                                    <th>Mã giáo viên</th>
                                                    <th>Họ và tên</th>
                                                    <th>Chuyên môn</th>
                                                    <th>Trường học</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="teacher" items="${availableTeachers}">
                                                    <tr>
                                                        <td>${teacher.ID_GiaoVien != null ? teacher.ID_GiaoVien : 'Chưa có'}</td>
                                                        <td>${teacher.hoTen != null ? teacher.hoTen : 'Chưa có'}</td>
                                                        <td>${teacher.chuyenMon != null ? teacher.chuyenMon : 'Chưa có'}</td>
                                                        <td>${teacher.tenTruongHoc != null ? teacher.tenTruongHoc : 'Chưa có'}</td>
                                                        <td>
                                                            <button type="submit" name="ID_GiaoVien" value="${teacher.ID_GiaoVien}" class="btn btn-success btn-sm">Chọn</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning">Không có giáo viên nào phù hợp với khóa học.</div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Danh sách học sinh -->
            <div class="section-title">Danh sách học sinh</div>
            <c:out value="HocSinhList size: ${hocSinhList != null ? hocSinhList.size() : 'null'}"/>
            <c:choose>
                <c:when test="${not empty hocSinhList}">
                    <table class="student-table">
                        <thead>
                            <tr>
                                <th>Họ và tên</th>
                                <th>Giới tính</th>
                                <th>SĐT phụ huynh</th>
                                <th>Trường học</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="hocSinh" items="${hocSinhList}">
                                <tr>
                                    <td>${hocSinh.hoTen != null ? hocSinh.hoTen : 'Chưa có'}</td>
                                    <td>${hocSinh.gioiTinh != null ? hocSinh.gioiTinh : 'Chưa có'}</td>
                                    <td>${hocSinh.SDT_PhuHuynh != null ? hocSinh.SDT_PhuHuynh : 'Chưa có'}</td>
                                    <td>${hocSinh.tenTruongHoc != null ? hocSinh.tenTruongHoc : 'Chưa có'}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="moveOutStudent">
                                            <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                            <input type="hidden" name="ID_HocSinh" value="${hocSinh.ID_HocSinh}">
                                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa học sinh ${hocSinh.hoTen} khỏi lớp?');">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning" role="alert">Chưa có học sinh nào trong lớp.</div>
                </c:otherwise>
            </c:choose>
            <button id="showStudentsBtn" class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#studentModal">
                <i class="bi bi-plus-circle"></i> Thêm học sinh
            </button>

            <!-- Modal để thêm học sinh -->
            <div class="modal fade" id="studentModal" tabindex="-1" aria-labelledby="studentModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="studentModalLabel">Thêm học sinh</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="student-select mb-3">
                                <label for="studentSearch" class="form-label">Tìm kiếm học sinh:</label>
                                <input type="text" id="studentSearch" class="form-control" placeholder="Nhập tên học sinh" value="${param.studentSearch}">
                            </div>
                            <c:if test="${not empty allStudents}">
                                <form id="addStudentForm" action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                    <input type="hidden" name="action" value="addStudent">
                                    <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                    <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                    <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                    <input type="hidden" name="studentSearch" id="hiddenStudentSearch">
                                    <table class="student-table" id="studentTable">
                                        <thead>
                                            <tr>
                                                <th>Mã học sinh</th>
                                                <th>Họ và tên</th>
                                                <th>Ngày sinh</th>
                                                <th>Trường học</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${allStudents}">
                                                <tr>
                                                    <td>${student.ID_HocSinh != null ? student.ID_HocSinh : 'Chưa có'}</td>
                                                    <td>${student.hoTen != null ? student.hoTen : 'Chưa có'}</td>
                                                    <td>${student.ngaySinh != null ? student.ngaySinh : 'Chưa có'}</td>
                                                    <td>${student.tenTruongHoc != null ? student.tenTruongHoc : 'Chưa có'}</td>
                                                    <td>
                                                        <button type="submit" name="ID_HocSinh" value="${student.ID_HocSinh}" class="btn btn-success btn-sm">Thêm</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </form>
                            </c:if>
                            <c:if test="${empty allStudents}">
                                <div class="alert alert-warning">Không có học sinh nào trong database.</div>
                            </c:if>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${lopHoc == null}">
            <div class="alert alert-warning" role="alert">Không tìm thấy thông tin lớp học.</div>
        </c:if>

        <!-- Nút quay lại -->
        <div class="back-button">
            <a href="${pageContext.request.contextPath}/ManageClass?ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-secondary btn-sm">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Nút trượt lên đầu trang -->
    <div class="scroll-to-top" id="scrollToTop">
        <i class="bi bi-arrow-up"></i>
    </div>

    <div class="footer">
        <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        // Tìm kiếm học sinh
        document.getElementById('studentSearch').addEventListener('input', function () {
            let filter = this.value.toLowerCase();
            let table = document.getElementById('studentTable');
            let tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let td = tr[i].getElementsByTagName('td')[1];
                let txtValue = td.textContent || td.innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
            // Lưu giá trị tìm kiếm vào input ẩn
            document.getElementById('hiddenStudentSearch').value = this.value;
        });

        // Tìm kiếm giáo viên
        document.getElementById('teacherSearch').addEventListener('input', function () {
            let filter = this.value.toLowerCase();
            let table = document.getElementById('teacherTable');
            let tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let td = tr[i].getElementsByTagName('td')[1];
                let txtValue = td.textContent || td.innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    tr[i].style.display = '';
                } else {
                    tr[i].style.display = 'none';
                }
            }
            // Lưu giá trị tìm kiếm vào input ẩn
            document.getElementById('hiddenTeacherSearch').value = this.value;
        });

        // Khôi phục trạng thái tìm kiếm
        window.addEventListener('load', function () {
            let teacherSearch = document.getElementById('teacherSearch');
            let studentSearch = document.getElementById('studentSearch');
            if (teacherSearch && teacherSearch.value) {
                teacherSearch.dispatchEvent(new Event('input'));
            }
            if (studentSearch && studentSearch.value) {
                studentSearch.dispatchEvent(new Event('input'));
            }
        });

        // Xử lý nút trượt lên đầu trang
        const scrollToTopBtn = document.getElementById('scrollToTop');
        window.addEventListener('scroll', function () {
            if (window.scrollY > 100) {
                scrollToTopBtn.style.display = 'block';
            } else {
                scrollToTopBtn.style.display = 'none';
            }
        });
        scrollToTopBtn.addEventListener('click', function () {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    </script>
</body>
</html>