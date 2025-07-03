<%-- 
    Document   : manageClass
    Created on : May 30, 2025, 10:33:02 PM
    Author     : Vuh26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.UUID" %>
<%@ page import="dal.LopHocInfoDTODAO" %>
<%@ page import="dal.GiaoVienDAO" %>
<%@ page import="model.LopHocInfoDTO" %>
<%@ page import="model.GiaoVien" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dal.HocSinhDAO" %>
<%@ page import="model.HocSinh" %>
<%@ page import="dal.LopHocDAO" %>
<%@ page import="model.LopHoc" %>
<%@ page import="dal.UserLogsDAO" %>
<%@ page import="model.UserLogs" %>
<%@ page import="dal.HoTroDAO" %>
<%@ page import="model.HoTro" %>
<%@ page import="model.UserLogView" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="model.Admin" %>
<%@ page import="dal.AdminDAO" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý lớp học</title>
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
            padding-bottom: 40px; /* Prevent footer overlap */
        }

        /* Header styling */
        .header-row {
            text-align: center;
            margin-bottom: 15px;
            color: #003087;
        }
        .header-row h2 {
            font-size: 1.33rem;
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
            font-size: 0.63rem;
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
            font-size: 0.63rem;
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
            font-size: 0.67rem;
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
            font-size: 0.73rem;
            color: black;
            text-align: center;
            min-width: 120px;
        }
        .table tbody td {
            padding: 8px 10px;
            vertical-align: middle;
            text-align: center;
            font-size: 0.67rem;
        }

        /* Sort styling */
        .table th.sorted {
            border: 3px solid #2563eb;
            background-color: #bfdbfe;
        }
        .table th a.sort-link {
            color: black;
            text-decoration: none;
            display: inline-block;
            padding: 3px 6px;
            border: 1px solid transparent;
            border-radius: 4px;
            transition: all 0.3s ease;
        }
        .table th a.sort-link:hover {
            color: #ffeb3b;
            background-color: rgba(255, 235, 59, 0.2);
            border-color: #ffeb3b;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .table th a.sort-link.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        /* Action buttons in table */
        .table .btn-sm {
            margin-right: 4px;
            border-radius: 6px;
            font-size: 0.6rem;
            padding: 4px 6px;
            min-width: 50px;
            text-align: center;
            line-height: 1.2;
        }
        .btn-primary {
            background-color: #dc2626;
            border-color: #dc2626;
        }
        .btn-primary:hover {
            background-color: #b91c1c;
            border-color: #b91c1c;
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
        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
        }
        .btn-info:hover {
            background-color: #117a8b;
            border-color: #117a8b;
        }

        /* Collapsible row styling */
        .details-row {
            display: none;
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
            font-size: 0.67rem;
        }
        .details-content div strong {
            color: #003087;
        }
        .details-content img {
            width: 60px !important;
            height: 80px !important;
            object-fit: cover;
            border-radius: 4px;
            border: 2px solid lightblue;
        }

        /* Pagination, Alerts, Modal, Scroll to Top */
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 8px;
            padding: 0 12px;
            width: 98%;
        }
        .pagination .page-item.active .page-link {
            background-color: #003087;
            border-color: #003087;
            color: white;
        }
        .pagination .page-link {
            border-radius: 6px;
            margin: 0 2px;
            color: #003087;
            font-size: 0.67rem;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .pagination .page-link:hover {
            background-color: #e6f0fa;
            color: #00215a;
        }
        .alert-custom-success {
            background-color: #22c55e;
            border-color: #22c55e;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.67rem;
        }
        .alert-custom-danger {
            background-color: #ef4444;
            border-color: #ef4444;
            color: white;
            border-radius: 8px;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 0.67rem;
        }
        .dashboard-button {
            text-align: center;
            margin-top: 10px;
        }
        .dashboard-button .btn {
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 0.67rem;
        }
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
            font-size: 0.58rem;
        }

        /* Status badge styling */
        .status-badge {
            padding: 3px 6px;
            border-radius: 12px;
            font-size: 0.6rem;
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

        /* Course stats styling */
        .course-stats {
            font-size: 0.67rem;
            margin: 8px 0;
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
                font-size: 0.89rem;
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
                font-size: 0.42rem;
                height: 24px;
            }
            .action-search-row .btn-custom-action {
                padding: 0 6px;
            }
            .table thead th,
            .table tbody td {
                padding: 5px 6px;
                font-size: 0.45rem;
            }
            .table .btn-sm {
                font-size: 0.4rem;
                padding: 3px 5px;
                min-width: 45px;
            }
            .status-badge {
                padding: 2px 4px;
                font-size: 0.4rem;
            }
            .pagination-container {
                justify-content: center;
            }
            .pagination .page-link {
                font-size: 0.45rem;
            }
            .alert-custom-success,
            .alert-custom-danger {
                padding: 6px;
                margin-bottom: 8px;
                font-size: 0.45rem;
            }
            .details-content div {
                flex: 1 1 100%;
                font-size: 0.45rem;
            }
            .details-content img {
                width: 40px !important;
                height: 50px !important;
            }
            .dashboard-button {
                margin-top: 8px;
            }
            .dashboard-button .btn {
                font-size: 0.45rem;
                padding: 4px 8px;
            }
            #scrollToTopBtn {
                bottom: 8px;
                right: 8px;
                width: 30px;
                height: 30px;
                font-size: 12px;
            }
            .modal-footer .btn {
                padding: 3px 6px;
                font-size: 0.38rem;
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
        <img src="${pageContext.request.contextPath}/img/SieuLogo-xoaphong.png" alt="Center Logo" class="sidebar-logo">
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
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=yeucautuvan"><i class="fas fa-blog"></i> Yêu cầu tư vấn</a></li>
            <li><a href="${pageContext.request.contextPath}/adminGetFromDashboard?action=thongbao"><i class="fas fa-bell"></i> Thông báo</a></li>
            <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/LogoutServlet"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
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

        <!-- Tiêu đề -->
        <div class="header-row">
            <c:choose>
                <c:when test="${ID_Khoi >= 1 && ID_Khoi <= 7}">
                    <h2>Trang quản lý lớp học cho khối lớp: ${ID_Khoi + 5}</h2>
                </c:when>
                <c:otherwise>
                    <h2>Trang quản lý lớp học cho khối lớp: Tổng ôn</h2>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty err}">
            <div class="alert alert-custom-danger" role="alert">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-custom-success" role="alert">${suc}</div>
        </c:if>
        <c:if test="${empty ID_KhoaHoc || empty ID_Khoi}">
            <div class="alert alert-custom-danger" role="alert">Thiếu tham số ID_KhoaHoc hoặc ID_Khoi. Vui lòng kiểm tra lại.</div>
        </c:if>
        <c:if test="${danhSachLopHoc == null && not empty ID_KhoaHoc && not empty ID_Khoi}">
            <div class="alert alert-custom-danger" role="alert">Danh sách lớp học chưa được khởi tạo. Kiểm tra servlet ManageClass hoặc dữ liệu cơ sở dữ liệu.</div>
        </c:if>
        <c:if test="${empty danhSachLopHoc && danhSachLopHoc != null}">
            <div class="alert alert-custom-danger" role="alert">Không có lớp học nào để hiển thị cho khóa học này.</div>
        </c:if>

        <!-- Nút hành động và form tìm kiếm/lọc -->
        <div class="action-search-row">
            <c:if test="${not empty ID_KhoaHoc && not empty ID_Khoi}">
                <a href="${pageContext.request.contextPath}/ManageClass?action=showAddClass&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-custom-action">
                    <i class="bi bi-plus-circle"></i> Thêm lớp học mới
                </a>
                <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-custom-action">
                    <i class="bi bi-arrow-clockwise"></i> Làm mới
                </a>
                <form action="${pageContext.request.contextPath}/ManageClass" method="get" id="filterForm" style="display: flex; align-items: center; gap: 6px; flex-wrap: nowrap;">
                    <input type="hidden" name="action" value="filter" />
                    <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                    <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                    <input type="hidden" name="page" value="${page != null ? page : 1}" />
                    <input type="hidden" name="sortColumn" value="${sortColumn != null ? sortColumn : 'TenLopHoc'}" />
                    <input type="hidden" name="sortOrder" value="${sortOrder != null ? sortOrder : 'asc'}" />
                    <input type="text" class="form-control" id="searchQuery" name="searchQuery" value="<c:out value='${searchQuery}'/>" placeholder="Nhập tên hoặc mã lớp học">
                    <select class="form-select" id="sortName" name="sortName" onchange="this.form.submit();">
                        <option value="" ${sortName == null || sortName.isEmpty() ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="Đang học" ${sortName == 'Đang học' ? 'selected' : ''}>Đang học</option>
                        <option value="Kết thúc" ${sortName == 'Kết thúc' ? 'selected' : ''}>Kết thúc</option>
                        <option value="Chưa học" ${sortName == 'Chưa học' ? 'selected' : ''}>Chưa học</option>
                    </select>
                    <select class="form-select" id="teacherFilter" name="teacherFilter" onchange="this.form.submit();">
                        <option value="" ${teacherFilter == null || teacherFilter.isEmpty() ? 'selected' : ''}>Tất cả giáo viên</option>
                        <c:forEach var="teacher" items="${teacherList}">
                            <option value="${teacher.ID_GiaoVien}" ${teacherFilter == teacher.ID_GiaoVien ? 'selected' : ''}>${teacher.hoTen}</option>
                        </c:forEach>
                    </select>
                    <select class="form-select" id="feeFilter" name="feeFilter" onchange="this.form.submit();">
                        <option value="" ${feeFilter == null || feeFilter.isEmpty() ? 'selected' : ''}>Tất cả học phí</option>
                        <option value="0-50000" ${feeFilter == '0-50000' ? 'selected' : ''}>0 - 50,000</option>
                        <option value="50000-100000" ${feeFilter == '50000-100000' ? 'selected' : ''}>50,000 - 100,000</option>
                        <option value="100000-200000" ${feeFilter == '100000-200000' ? 'selected' : ''}>100,000 - 200,000</option>
                    </select>
                    <select class="form-select" id="orderFilter" name="orderFilter" onchange="this.form.submit();">
                        <option value="" ${orderFilter == null || orderFilter.isEmpty() ? 'selected' : ''}>Tất cả thứ tự</option>
                        <option value="1" ${orderFilter == '1' ? 'selected' : ''}>1</option>
                        <option value="2" ${orderFilter == '2' ? 'selected' : ''}>2</option>
                        <option value="3" ${orderFilter == '3' ? 'selected' : ''}>3</option>
                        <option value="4" ${orderFilter == '4' ? 'selected' : ''}>4</option>
                        <option value="5" ${orderFilter == '5' ? 'selected' : ''}>5</option>
                    </select>
                    <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Tìm</button>
                </form>
            </c:if>
        </div>

        <c:if test="${not empty ID_KhoaHoc && not empty ID_Khoi}">
            <p class="course-stats">Tổng số lớp học: ${totalItems != null ? totalItems : '0'} &nbsp;&nbsp;&nbsp;&nbsp; Tổng số trang: ${totalPages != null ? totalPages : '0'}</p>
        </c:if>

        <!-- Bảng danh sách -->
        <div class="table-container">
            <c:if test="${not empty danhSachLopHoc}">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover align-middle">
                        <thead>
                            <tr>
                                <th class="${sortColumn == 'ClassCode' ? 'sorted' : ''}">
                                    Mã lớp học
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=ClassCode&sortOrder=asc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'ClassCode' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp mã lớp học tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=ClassCode&sortOrder=desc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'ClassCode' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp mã lớp học giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'TenLopHoc' ? 'sorted' : ''}">
                                    Tên lớp học
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=asc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TenLopHoc' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp tên lớp học tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=desc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TenLopHoc' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp tên lớp học giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SiSo' ? 'sorted' : ''}">
                                    Sĩ số
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=asc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSo' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=desc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSo' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th>
                                    Thời gian học
                                </th>
                                <th class="${sortColumn == 'Order' ? 'sorted' : ''}">
                                    Thứ tự ưu tiên
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=Order&sortOrder=asc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'Order' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp thứ tự tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=Order&sortOrder=desc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'Order' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp thứ tự giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'TrangThai' ? 'sorted' : ''}">
                                    Trạng thái
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=asc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp trạng thái tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=desc&searchQuery=${searchQuery}&page=${page}&sortName=${sortName}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp trạng thái giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lopHoc" items="${danhSachLopHoc}">
                                <tr>
                                    <td>${lopHoc.classCode != null ? lopHoc.classCode : 'Chưa có'}</td>
                                    <td>${lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : 'Chưa có'}</td>
                                    <td>${lopHoc.siSo != null ? lopHoc.siSo : '0'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty lopHoc.thoiGianHoc}">
                                                <ul style="margin: 0; padding-left: 15px;">
                                                    <c:forEach var="thoiGian" items="${fn:split(lopHoc.thoiGianHoc, ';')}">
                                                        <li>${thoiGian.trim()}</li>
                                                    </c:forEach>
                                                </ul>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: red;">Chưa có lịch học</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${lopHoc.order != null ? lopHoc.order : '0'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${lopHoc.trangThai == 'Đang học'}">
                                                <span class="status-badge status-dang-hoc">Đang học</span>
                                            </c:when>
                                            <c:when test="${lopHoc.trangThai == 'Kết thúc'}">
                                                <span class="status-badge status-ket-thuc">Kết thúc</span>
                                            </c:when>
                                            <c:when test="${lopHoc.trangThai == 'Chưa học'}">
                                                <span class="status-badge status-chua-hoc">Chưa học</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>${lopHoc.trangThai != null ? lopHoc.trangThai : 'Chưa có'}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-info btn-sm toggle-details" data-id="${lopHoc.idLopHoc}">
                                            <i class="bi bi-info-circle"></i> Xem chi tiết
                                        </button>
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${lopHoc.idLopHoc}" aria-label="Xóa lớp học">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                        <a href="${pageContext.request.contextPath}/ManageClass?action=updateClass&ID_LopHoc=${lopHoc.idLopHoc}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-danger btn-sm" aria-label="Cập nhật lớp học">
                                            <i class="bi bi-pencil"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/ManageClassDetail?ID_LopHoc=${lopHoc.idLopHoc}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-secondary btn-sm" aria-label="Xem danh sách lớp">
                                            <i class="bi bi-eye"></i> Danh sách học sinh
                                        </a>
                                    </td>
                                </tr>
                                <!-- Hàng chi tiết (ẩn mặc định) -->
                                <tr class="details-row" id="details-${lopHoc.idLopHoc}">
                                    <td colspan="7">
                                        <div class="details-content">
                                            <div><strong>Sĩ số tối đa:</strong> ${lopHoc.siSoToiDa != null ? lopHoc.siSoToiDa : 'Chưa có'}</div>
                                            <div><strong>Sĩ số tối thiểu:</strong> ${lopHoc.siSoToiThieu != null ? lopHoc.siSoToiThieu : 'Chưa có'}</div>
                                            <div><strong>Học phí:</strong> ${lopHoc.soTien != null ? lopHoc.soTien : '0'} VNĐ</div>
                                            <div>
                                                <strong>Giáo viên:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty lopHoc.tenGiaoVien}">
                                                        ${fn:split(lopHoc.tenGiaoVien, ',')[0].trim()}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Chưa phân công
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div><strong>Ghi chú:</strong> ${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Chưa có'}</div>
                                            <div><strong>Ngày khởi tạo:</strong> ${lopHoc.ngayTao != null ? lopHoc.ngayTao : 'Chưa có'}</div>
                                            <div>
                                                <strong>Ảnh giáo viên:</strong><br>
                                                <c:choose>
                                                    <c:when test="${not empty lopHoc.avatarGiaoVien}">
                                                        <img src="${pageContext.request.contextPath}/${fn:split(lopHoc.avatarGiaoVien, ',')[0].trim()}" alt="Ảnh giáo viên" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span>Chưa có ảnh</span>
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
            <c:if test="${totalPages > 1}">
                <div class="pagination-container">
                    <nav aria-label="Phân trang">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=1&sortName=${sortName}&searchQuery=${searchQuery}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang đầu">
                                    <span aria-hidden="true">««</span>
                                </a>
                            </li>
                            <c:if test="${page > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page - 1}&sortName=${sortName}&searchQuery=${searchQuery}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang trước">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:set var="startPage" value="${page - 2}"/>
                            <c:set var="endPage" value="${page + 2}"/>
                            <c:if test="${startPage < 1}">
                                <c:set var="startPage" value="1"/>
                                <c:set var="endPage" value="${endPage > totalPages ? totalPages : endPage + (2 - (page - startPage))}"/>
                            </c:if>
                            <c:if test="${endPage > totalPages}">
                                <c:set var="endPage" value="${totalPages}"/>
                                <c:set var="startPage" value="${startPage < (totalPages - 4) ? (totalPages - 4) : startPage}"/>
                                <c:if test="${startPage < 1}">
                                    <c:set var="startPage" value="1"/>
                                </c:if>
                            </c:if>
                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${i}&sortName=${sortName}&searchQuery=${searchQuery}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${page < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page + 1}&sortName=${sortName}&searchQuery=${searchQuery}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang sau">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${totalPages}&sortName=${sortName}&searchQuery=${searchQuery}&teacherFilter=${teacherFilter}&feeFilter=${feeFilter}&orderFilter=${orderFilter}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang cuối">
                                    <span aria-hidden="true">»»</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>

        <!-- Nút quay lại dashboard -->
        <div class="dashboard-button">
            <form action="${pageContext.request.contextPath}/ManageCourse">
                <button type="submit" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Quay lại trang quản lý khối</button>
            </form>
        </div>
    </div>

    <!-- Modal xác nhận xóa -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc muốn xóa lớp học này không?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form action="${pageContext.request.contextPath}/ManageClass" method="post" id="deleteForm">
                        <input type="hidden" name="action" value="deleteClass">
                        <input type="hidden" name="ID_LopHoc" id="deleteClassId">
                        <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                        <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                        <button type="submit" class="btn btn-primary">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Nút cuộn lên đầu trang -->
    <button id="scrollToTopBtn" onclick="scrollToTop()" aria-label="Cuộn lên đầu trang"><i class="bi bi-arrow-up"></i></button>

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

        // Cập nhật ID lớp học trong modal xóa
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            document.getElementById('deleteClassId').value = id;
        });

        // Quản lý trạng thái active cho nút sort
        document.querySelectorAll('.sort-link').forEach(link => {
            link.addEventListener('click', function(e) {
                document.querySelectorAll('.sort-link').forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Xóa trạng thái active khi bấm nút Refresh hoặc Tìm
        document.querySelectorAll('.btn-custom-action').forEach(button => {
            button.addEventListener('click', function() {
                document.querySelectorAll('.sort-link').forEach(l => l.classList.remove('active'));
            });
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
    </script>
</body>
</html>