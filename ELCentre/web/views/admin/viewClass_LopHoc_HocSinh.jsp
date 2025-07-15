<%-- 
    Document   : viewClass_LopHoc_HocSinh
    Created on : June 27, 2025, 2:33:02 PM
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
<%@page import="java.time.LocalDate"%>
<%
    // Lấy dữ liệu từ request
    LopHoc lopHoc = (LopHoc) request.getAttribute("lopHoc");
    List<LichHoc> lichHocList = (List<LichHoc>) request.getAttribute("lichHocList");
    GiaoVien giaoVien = (GiaoVien) request.getAttribute("giaoVien");
    List<HocSinh> hocSinhList = (List<HocSinh>) request.getAttribute("hocSinhList");
    List<GiaoVien> availableTeachers = (List<GiaoVien>) request.getAttribute("availableTeachers");
    List<HocSinh> allStudents = (List<HocSinh>) request.getAttribute("allStudents");
    List<GiaoVien> previousTeachers = (List<GiaoVien>) request.getAttribute("previousTeachers");
    List<HocSinh> previousStudents = (List<HocSinh>) request.getAttribute("previousStudents");
    Integer idKhoaHoc = (Integer) request.getAttribute("ID_KhoaHoc");
    Integer idKhoi = (Integer) request.getAttribute("ID_Khoi");

    // Gán các biến vào pageContext
    pageContext.setAttribute("lopHoc", lopHoc);
    pageContext.setAttribute("lichHocList", lichHocList);
    pageContext.setAttribute("giaoVien", giaoVien);
    pageContext.setAttribute("hocSinhList", hocSinhList);
    pageContext.setAttribute("availableTeachers", availableTeachers);
    pageContext.setAttribute("allStudents", allStudents);
    pageContext.setAttribute("previousTeachers", previousTeachers);
    pageContext.setAttribute("previousStudents", previousStudents);
    pageContext.setAttribute("ID_KhoaHoc", idKhoaHoc);
    pageContext.setAttribute("ID_Khoi", idKhoi);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết lớp học</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                margin: 0;
                padding: 0;
                background-color: #f4f6f9;
                font-family: Arial, sans-serif;
            }

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

            .header-row {
                text-align: center;
                margin-bottom: 15px;
                color: #003087;
            }

            .header-row h2 {
                font-size: 1.07rem;
                font-weight: 600;
            }

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
                -webkit-overflow-scrolling: touch;
            }

            .student-table, .teacher-table, .schedule-table {
                width: 100%;
                border-collapse: collapse;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                font-size: 0.58rem;
            }

            .student-table thead, .teacher-table thead, .schedule-table thead {
                background-color: #2196F3;
            }

            .student-table th, .teacher-table th, .schedule-table th {
                padding: 8px 10px;
                vertical-align: middle;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.6rem;
                color: white;
                text-align: center;
                border: 1px solid #dee2e6;
            }

            .student-table td, .teacher-table td, .schedule-table td {
                padding: 8px 10px;
                vertical-align: middle;
                text-align: center;
                border: 1px solid #dee2e6;
                font-size: 0.58rem;
            }

            .action-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 2px;
                justify-content: center;
            }

            .btn-sm {
                margin-right: 4px;
                border-radius: 6px;
                font-size: 0.5rem;
                padding: 3px 5px;
                min-width: 50px;
                text-align: center;
                line-height: 1.2;
            }

            .btn-primary {
                background-color: #003087;
                border-color: #003087;
            }

            .btn-primary:hover {
                background-color: #00215a;
                border-color: #00215a;
            }

            .btn-danger {
                background-color: #f97316;
                border-color: #f97316;
            }

            .btn-danger:hover {
                background-color: #ea580c;
                border-color: #ea580c;
            }

            .btn-secondary {
                background-color: #6b7280;
                border-color: #6b7280;
            }

            .btn-secondary:hover {
                background-color: #4b5563;
                border-color: #4b5563;
            }

            .teacher-select, .student-select {
                margin-bottom: 10px;
            }

            .teacher-select .form-control, .student-select .form-control {
                border-radius: 8px;
                border: 1px solid #ced4da;
                box-shadow: none;
                transition: border-color 0.3s ease;
                height: 28px;
                font-size: 0.57rem;
                width: 110px;
            }

            .teacher-select .form-control:focus, .student-select .form-control:focus {
                border-color: #003087;
                box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
            }

            .modal-content {
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .modal-header {
                background-color: #003087;
                color: white;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .modal-header h5 {
                font-size: 0.8rem;
            }

            .modal-footer .btn {
                border-radius: 6px;
                padding: 4px 8px;
                font-size: 0.57rem;
            }

            .modal-dialog {
                max-width: 600px;
            }

            .details-content {
                display: flex;
                flex-wrap: wrap;
                gap: 12px;
                font-size: 0.67rem;
                margin-bottom: 10px;
            }

            .details-content div {
                flex: 1 1 45%;
            }

            .details-content div strong {
                color: #003087;
                font-weight: 600;
            }

            img {
                width: 50px;
                height: 50px;
                object-fit: cover;
                border-radius: 4px;
                border: 2px solid lightblue;
            }

            .no-image {
                font-size: 0.67rem;
                color: #666;
                margin-bottom: 10px;
            }

            .scroll-to-top {
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

            .scroll-to-top:hover {
                background-color: #0056b3;
            }

            .dashboard-button {
                margin-top: 8px;
            }
            .dashboard-button .btn {
                font-size: 0.48rem;
                padding: 4px 8px;
            }

            @media (max-width: 768px) {
                .content-container {
                    padding: 8px;
                    margin: 5px;
                    margin-left: 0;
                    margin-top: 50px;
                    padding-bottom: 30px;
                }

                .header, .footer {
                    width: 100%;
                    left: 0;
                }

                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                    box-shadow: none;
                    padding: 5px;
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

                .header-row h2 {
                    font-size: 0.8rem;
                }

                .student-table, .teacher-table, .schedule-table {
                    font-size: 0.5rem;
                }

                .student-table th, .teacher-table th, .schedule-table th,
                .student-table td, .teacher-table td, .schedule-table td {
                    padding: 5px 6px;
                    font-size: 0.5rem;
                }

                .btn-sm {
                    font-size: 0.48rem;
                    padding: 2px 4px;
                    min-width: 45px;
                }

                .alert-custom-success, .alert-custom-danger {
                    padding: 6px;
                    margin-bottom: 8px;
                    font-size: 0.38rem;
                }

                .teacher-select .form-control, .student-select .form-control {
                    height: 26px;
                    font-size: 0.38rem;
                    width: auto;
                }

                .modal-header h5 {
                    font-size: 0.6rem;
                }

                .modal-footer .btn {
                    padding: 3px 6px;
                    font-size: 0.38rem;
                }

                .details-content {
                    font-size: 0.45rem;
                }

                img {
                    width: 40px;
                    height: 40px;
                }

                .no-image {
                    font-size: 0.45rem;
                }

                .scroll-to-top {
                    bottom: 8px;
                    right: 8px;
                    width: 30px;
                    height: 30px;
                    font-size: 12px;
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
                <div class="dropdown-menu hidden" id="adminDropdown">
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
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i>Yêu cầu tư vấn</a></li>
                <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
                <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </div>

        <div class="content-container">
            <!-- Tiêu đề -->
            <div class="header-row">
                <h2>Chi tiết lớp học</h2>
            </div>

            <!-- Thông báo toàn cục -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-custom-success" role="alert">${suc}</div>
            </c:if>
            <c:if test="${not empty teacherSuc}">
                <div class="alert alert-custom-success" role="alert">${teacherSuc}</div>
            </c:if>
            <c:if test="${not empty studentSuc}">
                <div class="alert alert-custom-success" role="alert">${studentSuc}</div>
            </c:if>
            <c:if test="${not empty teacherErr}">
                <div class="alert alert-custom-danger" role="alert">${teacherErr}</div>
            </c:if>
            <c:if test="${not empty studentErr}">
                <div class="alert alert-custom-danger" role="alert">${studentErr}</div>
            </c:if>

            <c:if test="${lopHoc != null}">
                <!-- Thông tin lớp học -->
                <div class="section-title">Thông tin lớp học</div>
                <div class="details-content">
                    <div><strong>Tên lớp:</strong> ${lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : 'Chưa có'}</div>
                    <div><strong>Mã lớp:</strong> ${lopHoc.classCode != null ? lopHoc.classCode : 'Chưa có'}</div>
                    <div><strong>Sĩ số:</strong> ${lopHoc.siSo}/${lopHoc.siSoToiDa}</div>
                    <div><strong>Trạng thái:</strong> ${lopHoc.trangThai != null ? lopHoc.trangThai : 'Chưa có'}</div>
                    <div><strong>Ghi chú:</strong> ${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Không có'}</div>
                </div>

                <!-- Thông tin giáo viên -->
                <div class="section-title">Thông tin giáo viên</div>
                <c:choose>
                    <c:when test="${giaoVien != null}">
                        <div class="details-content">
                            <div><strong>Họ và tên:</strong> ${giaoVien.hoTen != null ? giaoVien.hoTen : 'Chưa có'}</div>
                            <div><strong>Số điện thoại:</strong> ${giaoVien.SDT != null ? giaoVien.SDT : 'Chưa có'}</div>
                            <div><strong>Chuyên môn:</strong> ${giaoVien.chuyenMon != null ? giaoVien.chuyenMon : 'Chưa có'}</div>
                            <div><strong>Bằng cấp:</strong> ${giaoVien.bangCap != null ? giaoVien.bangCap : 'Chưa có'}</div>
                            <div><strong>Lớp đang dạy trên trường:</strong> ${giaoVien.lopDangDayTrenTruong != null ? giaoVien.lopDangDayTrenTruong : 'Chưa có'}</div>
                            <div><strong>Trạng thái dạy:</strong> ${giaoVien.trangThaiDay != null ? giaoVien.trangThaiDay : 'Chưa có'}</div>
                            <div><strong>Trường học:</strong> ${giaoVien.tenTruongHoc != null ? giaoVien.tenTruongHoc : 'Chưa có'}</div>
                            <div>
                                <strong>Ảnh đại diện:</strong><br>
                                <c:choose>
                                    <c:when test="${not empty giaoVien.avatar}">
                                        <img src="${pageContext.request.contextPath}/${giaoVien.avatar}" alt="Teacher Avatar" data-class-image="${pageContext.request.contextPath}/${giaoVien.avatar}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-image">Chưa có ảnh</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <button id="changeTeacherBtn" class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                            <i class="bi bi-pencil-square"></i> Thay đổi giáo viên
                        </button>

                        <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="removeTeacher">
                            <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                            <input type="hidden" name="ID_GiaoVien" value="${giaoVien.ID_GiaoVien}">
                            <button type="submit" class="btn btn-danger btn-sm mt-2" 
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa giáo viên ${giaoVien.hoTen} khỏi lớp?');">
                                <i class="bi bi-trash"></i> Xóa giáo viên
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-custom-danger" role="alert">Chưa có giáo viên được phân công.</div>
                        <button id="changeTeacherBtn" class="btn btn-primary btn-sm mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                            <i class="bi bi-person-plus"></i> Thêm giáo viên
                        </button>
                    </c:otherwise>
                </c:choose>

                <!-- Modal để thay đổi giáo viên -->
                <div class="modal fade" id="teacherModal" tabindex="-1" aria-labelledby="teacherModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="teacherModalLabel">Chọn giáo viên</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Lịch sử giáo viên đã dạy -->
                                <div class="section-title">Lịch sử giáo viên đã dạy</div>
                                <c:choose>
                                    <c:when test="${not empty previousTeachers}">
                                        <div class="teacher-select mb-3">
                                            <label for="previousTeacherSearch" class="form-label">Tìm kiếm lịch sử giáo viên:</label>
                                            <input type="text" id="previousTeacherSearch" class="form-control" placeholder="Nhập tên giáo viên">
                                        </div>
                                        <div class="table-responsive">
                                            <table class="teacher-table" id="previousTeacherTable">
                                                <thead>
                                                    <tr>
                                                        <th>Mã giáo viên</th>
                                                        <th>Họ và tên</th>
                                                        <th>Chuyên môn</th>
                                                        <th>Lớp đang dạy</th>
                                                        <th>Số buổi dạy</th>
                                                        <th>Trường học</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="teacher" items="${previousTeachers}">
                                                        <tr>
                                                            <td>${teacher.ID_GiaoVien != null ? teacher.ID_GiaoVien : 'Chưa có'}</td>
                                                            <td>${teacher.hoTen != null ? teacher.hoTen : 'Chưa có'}</td>
                                                            <td>${teacher.chuyenMon != null ? teacher.chuyenMon : 'Chưa có'}</td>
                                                            <td>${teacher.lopDangDayTrenTruong != null ? teacher.lopDangDayTrenTruong : 'Chưa có'}</td>
                                                            <td>
                                                                <%
                                                                    GiaoVien teacher = (GiaoVien) pageContext.getAttribute("teacher");
                                                                    GiaoVienDAO dao = new GiaoVienDAO();
                                                                    int sessions = dao.getTeachingSessions1(teacher.getID_GiaoVien(), 
                                                                            ((LopHoc) request.getAttribute("lopHoc")).getID_LopHoc(), LocalDate.now());
                                                                    out.print(sessions);
                                                                %>
                                                            </td>
                                                            <td>${teacher.tenTruongHoc != null ? teacher.tenTruongHoc : 'Chưa có'}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-custom-danger">Chưa có giáo viên nào dạy lớp này trước đây.</div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Danh sách giáo viên có thể chọn -->
                                <div class="section-title">Chọn giáo viên mới</div>
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
                                            <div class="table-responsive">
                                                <table class="teacher-table" id="teacherTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Mã giáo viên</th>
                                                            <th>Họ và tên</th>
                                                            <th>Chuyên môn</th>
                                                            <th>Lớp đang dạy</th>
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
                                                                <td>${teacher.lopDangDayTrenTruong != null ? teacher.lopDangDayTrenTruong : 'Chưa có'}</td>
                                                                <td>${teacher.tenTruongHoc != null ? teacher.tenTruongHoc : 'Chưa có'}</td>
                                                                <td>
                                                                    <button type="submit" name="ID_GiaoVien" value="${teacher.ID_GiaoVien}" 
                                                                            class="btn btn-primary btn-sm">Chọn</button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-custom-danger">Không có giáo viên nào phù hợp với khóa học.</div>
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
                <c:out value="Tổng số học sinh: ${hocSinhList != null ? hocSinhList.size() : 'null'}"/>
                <c:choose>
                    <c:when test="${not empty hocSinhList}">
                        <div class="student-select mb-3">
                            <label for="currentStudentSearch" class="form-label">Tìm kiếm học sinh:</label>
                            <input type="text" id="currentStudentSearch" class="form-control" placeholder="Nhập tên học sinh">
                        </div>
                        <div class="table-responsive">
                            <table class="student-table">
                                <thead>
                                    <tr>
                                        <th>Mã học sinh</th>
                                        <th>Họ và tên</th>
                                        <th>Giới tính</th>
                                        <th>Ngày sinh</th>
                                        <th>Lớp trên trường</th>
                                        <th>SĐT phụ huynh</th>
                                        <th>Trường học</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="hocSinh" items="${hocSinhList}">
                                        <tr>
                                            <td>${hocSinh.maHocSinh != null ? hocSinh.maHocSinh : 'Chưa có'}</td>
                                            <td>${hocSinh.hoTen != null ? hocSinh.hoTen : 'Chưa có'}</td>
                                            <td>${hocSinh.gioiTinh != null ? hocSinh.gioiTinh : 'Chưa có'}</td>
                                            <td>${hocSinh.ngaySinh != null ? hocSinh.ngaySinh : 'Chưa có'}</td>
                                            <td>${hocSinh.lopDangHocTrenTruong != null ? hocSinh.lopDangHocTrenTruong : 'Chưa có'}</td>
                                            <td>${hocSinh.SDT_PhuHuynh != null ? hocSinh.SDT_PhuHuynh : 'Chưa có'}</td>
                                            <td>${hocSinh.tenTruongHoc != null ? hocSinh.tenTruongHoc : 'Chưa có'}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="moveOutStudent">
                                                    <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                                    <input type="hidden" name="ID_HocSinh" value="${hocSinh.ID_HocSinh}">
                                                    <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                                    <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                                    <button type="submit" class="btn btn-danger btn-sm" 
                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa học sinh ${hocSinh.hoTen} khỏi lớp?');">
                                                        <i class="bi bi-trash"></i> Xóa
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-custom-danger" role="alert">Chưa có học sinh nào trong lớp.</div>
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
                                <!-- Lịch sử học sinh đã tham gia -->
                                <div class="section-title">Lịch sử học sinh đã tham gia</div>
                                <c:choose>
                                    <c:when test="${not empty previousStudents}">
                                        <div class="student-select mb-3">
                                            <label for="previousStudentSearch" class="form-label">Tìm kiếm lịch sử học sinh:</label>
                                            <input type="text" id="previousStudentSearch" class="form-control" placeholder="Nhập tên học sinh">
                                        </div>
                                        <div class="table-responsive">
                                            <table class="student-table" id="previousStudentTable">
                                                <thead>
                                                    <tr>
                                                        <th>Mã học sinh</th>
                                                        <th>Họ và tên</th>
                                                        <th>Giới tính</th>
                                                        <th>Ngày sinh</th>
                                                        <th>Lớp trên trường</th>
                                                        <th>Trường học</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="student" items="${previousStudents}">
                                                        <tr>
                                                            <td>${student.maHocSinh != null ? student.maHocSinh : 'Chưa có'}</td>
                                                            <td>${student.hoTen != null ? student.hoTen : 'Chưa có'}</td>
                                                            <td>${student.gioiTinh != null ? student.gioiTinh : 'Chưa có'}</td>
                                                            <td>${student.ngaySinh != null ? student.ngaySinh : 'Chưa có'}</td>
                                                            <td>${student.lopDangHocTrenTruong != null ? student.lopDangHocTrenTruong : 'Chưa có'}</td>
                                                            <td>${student.tenTruongHoc != null ? student.tenTruongHoc : 'Chưa có'}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-custom-danger">Chưa có học sinh nào tham gia lớp này trước đây.</div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Danh sách học sinh có thể thêm -->
                                <div class="section-title">Chọn học sinh mới</div>
                                <c:if test="${not empty allStudents}">
                                    <div class="student-select mb-3">
                                        <label for="studentSearch" class="form-label">Tìm kiếm học sinh:</label>
                                        <input type="text" id="studentSearch" class="form-control" placeholder="Nhập tên học sinh" value="${param.studentSearch}">
                                    </div>
                                    <form id="addStudentForm" action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                        <input type="hidden" name="action" value="addStudent">
                                        <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                        <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                        <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                        <input type="hidden" name="studentSearch" id="hiddenStudentSearch">
                                        <div class="table-responsive">
                                            <table class="student-table" id="studentTable">
                                                <thead>
                                                    <tr>
                                                        <th>Mã học sinh</th>
                                                        <th>Họ và tên</th>
                                                        <th>Ngày sinh</th>
                                                        <th>Lớp trên trường</th>
                                                        <th>Trường học</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="student" items="${allStudents}">
                                                        <tr>
                                                            <td>${student.maHocSinh != null ? student.maHocSinh : 'Chưa có'}</td>
                                                            <td>${student.hoTen != null ? student.hoTen : 'Chưa có'}</td>
                                                            <td>${student.ngaySinh != null ? student.ngaySinh : 'Chưa có'}</td>
                                                            <td>${student.lopDangHocTrenTruong != null ? student.lopDangHocTrenTruong : 'Chưa có'}</td>
                                                            <td>${student.tenTruongHoc != null ? student.tenTruongHoc : 'Chưa có'}</td>
                                                            <td>
                                                                <button type="submit" name="ID_HocSinh" value="${student.ID_HocSinh}" 
                                                                        class="btn btn-primary btn-sm">Thêm</button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </form>
                                </c:if>
                                <c:if test="${empty allStudents}">
                                    <div class="alert alert-custom-danger">Không có học sinh nào trong database.</div>
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
                <div class="alert alert-custom-danger" role="alert">Không tìm thấy thông tin lớp học.</div>
            </c:if>

            <!-- Nút quay lại -->
            <div class="dashboard-button">
                <a href="${backUrl}" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Quay lại</a>
            </div>
        </div>

        <div class="scroll-to-top" id="scrollToTop">
            <i class="bi bi-arrow-up"></i>
        </div>

        <div class="footer">
            <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" 
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" 
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
                                                                // Tìm kiếm học sinh
                                                                document.getElementById('studentSearch')?.addEventListener('input', function () {
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
                                                                    document.getElementById('hiddenStudentSearch').value = this.value;
                                                                });

                                                                // Tìm kiếm giáo viên
                                                                document.getElementById('teacherSearch')?.addEventListener('input', function () {
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
                                                                    document.getElementById('hiddenTeacherSearch').value = this.value;
                                                                });

                                                                // Tìm kiếm lịch sử giáo viên
                                                                document.getElementById('previousTeacherSearch')?.addEventListener('input', function () {
                                                                    let filter = this.value.toLowerCase();
                                                                    let table = document.getElementById('previousTeacherTable');
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
                                                                });

                                                                // Tìm kiếm lịch sử học sinh
                                                                document.getElementById('previousStudentSearch')?.addEventListener('input', function () {
                                                                    let filter = this.value.toLowerCase();
                                                                    let table = document.getElementById('previousStudentTable');
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

                                                                // Xử lý dropdown admin
                                                                function toggleDropdown() {
                                                                    document.getElementById('adminDropdown').classList.toggle('hidden');
                                                                }

                                                                // Kiểm tra ảnh giáo viên
                                                                document.querySelectorAll('img[data-class-image]').forEach(img => {
                                                                    const imageUrl = img.getAttribute('data-class-image');
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


                                                                // Tìm kiếm học sinh trong danh sách hiện tại
                                                                document.getElementById('currentStudentSearch')?.addEventListener('input', function () {
                                                                    let filter = this.value.toLowerCase();
                                                                    let table = document.querySelector('.student-table'); // Bảng học sinh hiện tại
                                                                    let tr = table.getElementsByTagName('tr');
                                                                    for (let i = 1; i < tr.length; i++) {
                                                                        let td = tr[i].getElementsByTagName('td')[1]; // Cột "Họ và tên"
                                                                        let txtValue = td.textContent || td.innerText;
                                                                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                                                                            tr[i].style.display = '';
                                                                        } else {
                                                                            tr[i].style.display = 'none';
                                                                        }
                                                                    }
                                                                });
        </script>
    </body>
</html>