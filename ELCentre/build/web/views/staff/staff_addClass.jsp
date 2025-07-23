<%-- 
    Document   : staff_addClass
    Created on : Jul 24, 2025
    Author     : Vuh26
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="model.TaiKhoan"%>
<%@page import="dal.HocSinhDAO"%>
<%@page import="model.HocSinh"%>
<%@page import="dal.GiaoVienDAO"%>
<%@page import="model.GiaoVien"%>
<%@page import="dal.LopHocDAO"%>
<%@page import="model.LopHoc"%>
<%@page import="dal.UserLogsDAO"%>
<%@page import="model.UserLogs"%>
<%@page import="dal.HoTroDAO"%>
<%@page import="model.HoTro"%>
<%@page import="model.UserLogView"%>
<%@page import="java.time.LocalDate"%>
<%@page import="model.Staff"%>
<%@page import="dal.StaffDAO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm lớp học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

        /* Form styling */
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 1.33rem;
        }
        .form-container {
            max-width: 600px;
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
        .required-label::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 6px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 0.58rem;
            box-sizing: border-box;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
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
        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.58rem;
            margin-right: 10px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.58rem;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.5rem;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.58rem;
            text-align: center;
            padding: 10px;
        }
        .alert-danger {
            background-color: #ef4444;
            color: white;
            font-weight: bold;
        }
        .alert-success {
            background-color: #22c55e;
            color: white;
            font-weight: bold;
        }
        .schedule-row {
            display: flex;
            gap: 6px;
            margin-bottom: 8px;
            align-items: center;
        }
        .schedule-row select,
        .schedule-row input[type="date"] {
            flex: 1;
            font-size: 0.58rem !important;
        }
        .schedule-row .btn-danger.btn-sm {
            font-size: 0.5rem;
            padding: 4px 6px;
        }
        .back-button {
            text-align: center;
            margin-top: 15px;
        }
        .back-button a {
            color: white;
            text-decoration: none;
        }
        p.info {
            color: #333;
            font-size: 0.58rem;
            margin-bottom: 15px;
        }
        p.note {
            color: #666;
            font-size: 0.5rem;
            margin-top: -10px;
            margin-bottom: 15px;
        }
        .weekday-checkboxes {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        .weekday-checkboxes label {
            font-size: 0.58rem;
            display: flex;
            align-items: center;
            gap: 5px;
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
                font-size: 0.89rem;
            }
            .form-container {
                max-width: 100%;
                padding: 12px;
            }
            label {
                font-size: 0.38rem;
            }
            input[type="text"],
            input[type="number"],
            input[type="date"],
            select,
            textarea,
            input[type="file"] {
                font-size: 0.38rem;
                padding: 4px;
            }
            input[type="text"],
            input[type="number"],
            input[type="date"],
            select {
                height: 24px;
            }
            input[type="file"] {
                padding: 2px;
            }
            textarea {
                min-height: 50px;
            }
            .btn-primary,
            .btn-secondary {
                font-size: 0.38rem;
                padding: 4px 8px;
            }
            .btn-danger {
                font-size: 0.33rem;
                padding: 3px 5px;
            }
            .alert {
                font-size: 0.38rem;
                padding: 8px;
                margin-bottom: 10px;
            }
            p.info {
                font-size: 0.38rem;
            }
            p.note {
                font-size: 0.33rem;
            }
            .schedule-row {
                gap: 4px;
                margin-bottom: 6px;
            }
            .schedule-row select,
            .schedule-row input[type="date"] {
                font-size: 0.38rem !important;
            }
            .schedule-row .btn-danger.btn-sm {
                font-size: 0.33rem;
                padding: 3px 5px;
            }
            .back-button {
                margin-top: 10px;
            }
            .weekday-checkboxes {
                gap: 5px;
            }
            .weekday-checkboxes label {
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

    <!-- Main content -->
    <div class="content-container">
        <div class="form-container">
            <h2>Thêm lớp học</h2>

            <!-- Thông báo -->
            <c:if test="${not empty err}">
                <div class="alert alert-danger">${fn:escapeXml(err)}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-success">${fn:escapeXml(suc)}</div>
                <div class="back-button">
                    <a href="${pageContext.request.contextPath}/Staff_ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại danh sách lớp học</a>
                </div>
            </c:if>
            <c:if test="${khoaHoc == null && empty suc && empty err}">
                <div class="alert alert-danger">Không tìm thấy thông tin khóa học!</div>
            </c:if>

            <!-- Kiểm tra danh sách slot và phòng học -->
            <c:if test="${empty slotHocList || empty phongHocList}">
                <div class="alert alert-danger">
                    <c:choose>
                        <c:when test="${empty slotHocList && empty phongHocList}">
                            Không có slot học và phòng học nào trong hệ thống. Vui lòng thêm dữ liệu trước!
                        </c:when>
                        <c:when test="${empty slotHocList}">
                            Không có slot học nào trong hệ thống. Vui lòng thêm slot học trước!
                        </c:when>
                        <c:otherwise>
                            Không có phòng học nào khả dụng. Vui lòng thêm phòng học!
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="back-button">
                    <a href="${pageContext.request.contextPath}/Staff_ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại</a>
                </div>
            </c:if>

            <!-- Form thêm lớp học -->
            <c:if test="${not empty slotHocList && not empty phongHocList}">
                <form action="${pageContext.request.contextPath}/Staff_ManageClass" method="post" id="addClassForm" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addClass">
                    <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                    <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                    <input type="hidden" name="trangThai" value="Inactive">

                    <div class="mb-3">
                        <label for="tenLopHoc" class="form-label required-label">Tên lớp học:</label>
                        <input type="text" class="form-control" id="tenLopHoc" name="tenLopHoc" value="${tenLopHoc != null ? fn:escapeXml(tenLopHoc) : ''}" maxlength="100" required>
                        <p class="note">Tên lớp học tối đa 100 ký tự. Ví dụ: Lớp Toán Cao Cấp.</p>
                    </div>

                    <div class="mb-3">
                        <label for="classCode" class="form-label required-label">Mã lớp học:</label>
                        <input type="text" class="form-control" id="classCode" name="classCode" value="${classCode != null ? fn:escapeXml(classCode) : ''}" maxlength="20" required>
                        <p class="note">Mã lớp học chỉ chứa chữ cái và số, tối đa 20 ký tự (ví dụ: TCB12).</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Khóa học:</label>
                        <p class="info">
                            Tên khóa học: <c:out value="${khoaHoc.tenKhoaHoc != null ? khoaHoc.tenKhoaHoc : 'Không xác định'}" /><br>
                            ID khóa học: <c:out value="${ID_KhoaHoc != null ? ID_KhoaHoc : 'Không xác định'}" /><br>
                            Thời gian bắt đầu: <c:out value="${khoaHoc.thoiGianBatDau != null ? khoaHoc.thoiGianBatDau : 'Chưa xác định'}" /><br>
                            Thời gian kết thúc: <c:out value="${khoaHoc.thoiGianKetThuc != null ? khoaHoc.thoiGianKetThuc : 'Chưa xác định'}" />
                        </p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Khối học:</label>
                        <p class="info">Khối: 
                            <c:choose>
                                <c:when test="${not empty ID_Khoi and ID_Khoi >= 1 and ID_Khoi <= 7}">
                                    Lớp <c:out value="${ID_Khoi + 5}"/>
                                </c:when>
                                <c:otherwise>
                                    Tổng ôn
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <div class="mb-3">
                        <label for="siSoToiDa" class="form-label required-label">Sĩ số tối đa:</label>
                        <input type="number" class="form-control" id="siSoToiDa" name="siSoToiDa" value="${siSoToiDa != null && siSoToiDa != '' ? siSoToiDa : '0'}" min="1" required>
                        <p class="note">Sĩ số tối đa phải lớn hơn 0 và nhỏ hơn hoặc bằng sức chứa phòng học.</p>
                    </div>

                    <div class="mb-3">
                        <label for="siSoToiThieu" class="form-label required-label">Sĩ số tối thiểu:</label>
                        <input type="number" class="form-control" id="siSoToiThieu" name="siSoToiThieu" value="${siSoToiThieu != null && siSoToiThieu != '' ? siSoToiThieu : '0'}" min="0" required>
                        <p class="note">Sĩ số tối thiểu phải là số không âm và nhỏ hơn hoặc bằng sĩ số tối đa.</p>
                    </div>

                    <div class="mb-3">
                        <label for="ghiChu" class="form-label">Ghi chú:</label>
                        <textarea class="form-control" id="ghiChu" name="ghiChu" maxlength="500">${ghiChu != null ? fn:escapeXml(ghiChu) : ''}</textarea>
                        <p class="note">Ghi chú tối đa 500 ký tự.</p>
                    </div>

                    <div class="mb-3">
                        <label for="soTien" class="form-label">Học phí:</label>
                        <input type="number" class="form-control" id="soTien" name="soTien" value="${soTien != null && soTien != '' ? soTien : '0'}" min="0" step="1">
                        <p class="note">Học phí là số nguyên không âm, tối đa 10 chữ số.</p>
                    </div>

                    <div class="mb-3">
                        <label for="image" class="form-label">Ảnh đại diện lớp học:</label>
                        <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/png">
                        <p class="note">Chỉ chấp nhận file ảnh .jpg hoặc .png, kích thước tối đa 10MB.</p>
                    </div>

                    <div class="mb-3">
                        <label for="order" class="form-label">Thứ tự ưu tiên:</label>
                        <input type="number" class="form-control" id="order" name="order" value="${order != null ? order : '0'}" min="0" step="1">
                        <p class="note">Thứ tự phải là số không âm.</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label required-label">Lịch học:</label>
                        <p class="note">Chọn các thứ trong tuần để tự động tạo lịch học từ ngày bắt đầu đến ngày kết thúc của khóa học. Định dạng ngày: YYYY-MM-DD.</p>
                        <div class="weekday-checkboxes">
                            <label><input type="checkbox" name="weekdays" value="1"> Thứ Hai</label>
                            <label><input type="checkbox" name="weekdays" value="2"> Thứ Ba</label>
                            <label><input type="checkbox" name="weekdays" value="3"> Thứ Tư</label>
                            <label><input type="checkbox" name="weekdays" value="4"> Thứ Năm</label>
                            <label><input type="checkbox" name="weekdays" value="5"> Thứ Sáu</label>
                            <label><input type="checkbox" name="weekdays" value="6"> Thứ Bảy</label>
                            <label><input type="checkbox" name="weekdays" value="0"> Chủ Nhật</label>
                        </div>
                        <div class="mb-3">
                            <label for="startDate" class="form-label required-label">Ngày bắt đầu:</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" required>
                            <p class="note">Chọn ngày bắt đầu cho lịch học, phải nằm trong khoảng thời gian của khóa học.</p>
                        </div>
                        <div class="mb-3">
                            <label for="defaultSlotHoc" class="form-label required-label">Slot học mặc định:</label>
                            <select class="form-select" id="defaultSlotHoc" name="defaultSlotHoc" required>
                                <option value="">Chọn slot học</option>
                                <c:forEach var="slot" items="${slotHocList}">
                                    <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="defaultPhongHoc" class="form-label required-label">Phòng học mặc định:</label>
                            <select class="form-select" id="defaultPhongHoc" name="defaultPhongHoc" required>
                                <option value="">Chọn phòng học</option>
                                <c:forEach var="phongHoc" items="${phongHocList}">
                                    <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="button" class="btn btn-primary mt-2" onclick="generateSchedule()">Tạo lịch học tự động</button>
                        <div id="scheduleContainer" class="mt-3">
                            <c:if test="${not empty ngayHocs && fn:length(ngayHocs) > 0}">
                                <c:forEach var="i" begin="0" end="${fn:length(ngayHocs) - 1}">
                                    <div class="schedule-row">
                                        <input type="date" class="form-control" name="ngayHoc[]" value="${fn:escapeXml(ngayHocs[i])}" required>
                                        <select class="form-select" name="idSlotHoc[]" required>
                                            <option value="">Chọn slot học</option>
                                            <c:forEach var="slot" items="${slotHocList}">
                                                <option value="${slot.ID_SlotHoc}" ${idSlotHocs[i] == slot.ID_SlotHoc ? 'selected' : ''}>${slot.slotThoiGian}</option>
                                            </c:forEach>
                                        </select>
                                        <select class="form-select" name="idPhongHoc[]" required>
                                            <option value="">Chọn phòng học</option>
                                            <c:forEach var="phongHoc" items="${phongHocList}">
                                                <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}" ${idPhongHocs[i] == phongHoc.ID_PhongHoc ? 'selected' : ''}>${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                            </c:forEach>
                                        </select>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove(); validateForm()">Xóa</button>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty ngayHocs}">
                                <div class="schedule-row">
                                    <input type="date" class="form-control" name="ngayHoc[]" required>
                                    <select class="form-select" name="idSlotHoc[]" required>
                                        <option value="">Chọn slot học</option>
                                        <c:forEach var="slot" items="${slotHocList}">
                                            <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                                        </c:forEach>
                                    </select>
                                    <select class="form-select" name="idPhongHoc[]" required>
                                        <option value="">Chọn phòng học</option>
                                        <c:forEach var="phongHoc" items="${phongHocList}">
                                            <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove(); validateForm()">Xóa</button>
                                </div>
                            </c:if>
                        </div>
                        <button type="button" class="btn btn-primary mt-2" onclick="addScheduleRow()">Thêm lịch học thủ công</button>
                    </div>

                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary">Thêm</button>
                        <a href="${pageContext.request.contextPath}/Staff_ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </c:if>
        </div>
    </div>

    <!-- Footer content -->
    <div class="footer">
        <p>© 2025 EL CENTRE. Bản quyền thuộc về EL CENTRE.</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        // Hàm loại bỏ dấu tiếng Việt
        function removeVietnameseAccents(str) {
            return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '')
                    .replace(/đ/g, 'd').replace(/Đ/g, 'D');
        }

        // Hàm tạo mã lớp học tự động
        function generateClassCode(className, idKhoi) {
            if (!className)
                return '';
            className = removeVietnameseAccents(className).toLowerCase();
            let initials = className.split(/\s+/).map(word => word.charAt(0).toUpperCase()).join('');
            let grade = idKhoi >= 1 && idKhoi <= 7 ? (idKhoi + 5) : 0;
            let gradeStr = grade > 0 ? grade.toString().padStart(2, '0') : '';
            return initials + gradeStr;
        }

        // Cập nhật mã lớp học
        function updateClassCode() {
            const tenLopHoc = document.getElementById('tenLopHoc').value;
            const idKhoi = parseInt('${ID_Khoi}' || '0');
            const classCodeInput = document.getElementById('classCode');
            console.log('ID_Khoi:', idKhoi, 'tenLopHoc:', tenLopHoc); // Debug
            classCodeInput.value = generateClassCode(tenLopHoc, idKhoi);
        }

        // Gắn sự kiện input cho tenLopHoc
        document.getElementById('tenLopHoc').addEventListener('input', updateClassCode);

        // Cập nhật mã lớp học khi trang tải
        window.addEventListener('load', function () {
            console.log('Page loaded, calling updateClassCode');
            updateClassCode();
        });

        // Hàm tạo lịch học tự động dựa trên các thứ trong tuần
        function generateSchedule() {
            const container = document.getElementById('scheduleContainer');
            const startDateInput = document.getElementById('startDate').value;
            const defaultSlotHoc = document.getElementById('defaultSlotHoc').value;
            const defaultPhongHoc = document.getElementById('defaultPhongHoc').value;
            const weekdays = Array.from(document.querySelectorAll('input[name="weekdays"]:checked')).map(cb => parseInt(cb.value));
            const startKhoaHoc = '${khoaHoc.thoiGianBatDau}' || '2000-01-01';
            const endKhoaHoc = '${khoaHoc.thoiGianKetThuc}' || '2100-12-31';
            const today = new Date().toISOString().split('T')[0];

            console.log('generateSchedule:', {startDateInput, defaultSlotHoc, defaultPhongHoc, weekdays, startKhoaHoc, endKhoaHoc}); // Debug

            // Xóa các lịch học hiện có
            container.innerHTML = '';

            if (!startDateInput) {
                alert('Vui lòng chọn ngày bắt đầu!');
                return;
            }
            if (!defaultSlotHoc || !defaultPhongHoc) {
                alert('Vui lòng chọn slot học và phòng học mặc định!');
                return;
            }
            if (weekdays.length === 0) {
                alert('Vui lòng chọn ít nhất một thứ trong tuần!');
                return;
            }

            const startDate = new Date(startDateInput);
            if (isNaN(startDate)) {
                alert('Ngày bắt đầu không hợp lệ!');
                return;
            }
            if (startDate < new Date(today)) {
                alert('Ngày bắt đầu không được trong quá khứ!');
                return;
            }
            if (startKhoaHoc && startDate < new Date(startKhoaHoc)) {
                alert('Ngày bắt đầu phải sau hoặc bằng ngày bắt đầu khóa học (' + startKhoaHoc + ')!');
                return;
            }
            if (endKhoaHoc && startDate > new Date(endKhoaHoc)) {
                alert('Ngày bắt đầu phải trước hoặc bằng ngày kết thúc khóa học (' + endKhoaHoc + ')!');
                return;
            }

            let schedules = [];
            weekdays.forEach(weekday => {
                let currentDate = new Date(startDate);
                // Điều chỉnh currentDate đến đúng thứ trong tuần được chọn
                while (currentDate.getDay() !== weekday) {
                    currentDate.setDate(currentDate.getDate() + 1);
                }
                // Tạo lịch cho đến khi vượt quá thời gian kết thúc khóa học
                while (currentDate <= new Date(endKhoaHoc)) {
                    const scheduleDate = new Date(currentDate);
                    const dateStr = scheduleDate.toISOString().split('T')[0];
                    schedules.push({date: dateStr, slotHoc: defaultSlotHoc, phongHoc: defaultPhongHoc});
                    currentDate.setDate(currentDate.getDate() + 7); // Chuyển sang tuần tiếp theo
                }
            });

            // Sắp xếp lịch theo thứ tự ngày tăng dần
            schedules.sort((a, b) => new Date(a.date) - new Date(b.date));

            console.log('Generated schedules:', schedules); // Debug

            // Tạo các hàng lịch học
            schedules.forEach(schedule => {
                const row = document.createElement('div');
                row.className = 'schedule-row';
                row.innerHTML = `
                    <input type="date" class="form-control" name="ngayHoc[]" required>
                    <select class="form-select" name="idSlotHoc[]" required>
                        <option value="">Chọn slot học</option>
                        <c:forEach var="slot" items="${slotHocList}">
                            <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                        </c:forEach>
                    </select>
                    <select class="form-select" name="idPhongHoc[]" required>
                        <option value="">Chọn phòng học</option>
                        <c:forEach var="phongHoc" items="${phongHocList}">
                            <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                        </c:forEach>
                    </select>
                    <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove(); validateForm()">Xóa</button>
                `;
                container.appendChild(row);
                // Gán giá trị bằng JavaScript
                const dateInput = row.querySelector('input[name="ngayHoc[]"]');
                const slotSelect = row.querySelector('select[name="idSlotHoc[]"]');
                const phongHocSelect = row.querySelector('select[name="idPhongHoc[]"]');
                dateInput.value = schedule.date;
                slotSelect.value = schedule.slotHoc;
                phongHocSelect.value = schedule.phongHoc;
                console.log('Schedule row:', {date: schedule.date, slotHoc: schedule.slotHoc, phongHoc: schedule.phongHoc}); // Debug
                phongHocSelect.addEventListener('change', validateForm);
            });

            validateForm();
        }

        // Thêm lịch học thủ công
        function addScheduleRow() {
            const container = document.getElementById('scheduleContainer');
            const row = document.createElement('div');
            row.className = 'schedule-row';
            row.innerHTML = `
                <input type="date" class="form-control" name="ngayHoc[]" required>
                <select class="form-select" name="idSlotHoc[]" required>
                    <option value="">Chọn slot học</option>
                    <c:forEach var="slot" items="${slotHocList}">
                        <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                    </c:forEach>
                </select>
                <select class="form-select" name="idPhongHoc[]" required>
                    <option value="">Chọn phòng học</option>
                    <c:forEach var="phongHoc" items="${phongHocList}">
                        <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                    </c:forEach>
                </select>
                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove(); validateForm()">Xóa</button>
            `;
            container.appendChild(row);
            row.querySelector('select[name="idPhongHoc[]"]').addEventListener('change', validateForm);
            validateForm();
        }

        // Validation form
        function validateForm() {
            const form = document.getElementById('addClassForm');
            const tenLopHoc = document.getElementById('tenLopHoc');
            const classCode = document.getElementById('classCode');
            const siSoToiDa = document.getElementById('siSoToiDa');
            const siSoToiThieu = document.getElementById('siSoToiThieu');
            const soTien = document.getElementById('soTien');
            const order = document.getElementById('order');
            const ghiChu = document.getElementById('ghiChu');
            const ngayHocInputs = document.getElementsByName('ngayHoc[]');
            const idSlotHocSelects = document.getElementsByName('idSlotHoc[]');
            const idPhongHocSelects = document.getElementsByName('idPhongHoc[]');
            const startKhoaHoc = '${khoaHoc.thoiGianBatDau}' || '2000-01-01';
            const endKhoaHoc = '${khoaHoc.thoiGianKetThuc}' || '2100-12-31';
            const today = new Date().toISOString().split('T')[0];

            let isValid = true;

            // Validation cho tenLopHoc
            if (!tenLopHoc.value || tenLopHoc.value.trim() === '') {
                tenLopHoc.setCustomValidity('Tên lớp học không được để trống!');
                isValid = false;
            } else if (tenLopHoc.value.length > 100) {
                tenLopHoc.setCustomValidity('Tên lớp học không được dài quá 100 ký tự!');
                isValid = false;
            } else {
                tenLopHoc.setCustomValidity('');
            }

            // Validation cho classCode
            if (!classCode.value || classCode.value.trim() === '') {
                classCode.setCustomValidity('Mã lớp học không được để trống!');
                isValid = false;
            } else if (classCode.value.length > 20 || !/^[A-Za-z0-9]+$/.test(classCode.value)) {
                classCode.setCustomValidity('Mã lớp học chỉ được chứa chữ cái và số, tối đa 20 ký tự!');
                isValid = false;
            } else {
                classCode.setCustomValidity('');
            }

            // Validation cho siSoToiDa
            const siSoToiDaValue = parseInt(siSoToiDa.value);
            if (isNaN(siSoToiDaValue) || siSoToiDaValue <= 0) {
                siSoToiDa.setCustomValidity('Sĩ số tối đa phải lớn hơn 0!');
                isValid = false;
            } else {
                siSoToiDa.setCustomValidity('');
            }

            // Validation cho siSoToiThieu
            const siSoToiThieuValue = parseInt(siSoToiThieu.value);
            if (isNaN(siSoToiThieuValue) || siSoToiThieuValue < 0) {
                siSoToiThieu.setCustomValidity('Sĩ số tối thiểu phải là số không âm!');
                isValid = false;
            } else if (!isNaN(siSoToiDaValue) && !isNaN(siSoToiThieuValue) && siSoToiThieuValue > siSoToiDaValue) {
                siSoToiThieu.setCustomValidity('Sĩ số tối thiểu phải nhỏ hơn hoặc bằng sĩ số tối đa!');
                isValid = false;
            } else {
                siSoToiThieu.setCustomValidity('');
            }

            // Validation cho soTien
            const soTienValue = parseInt(soTien.value);
            if (soTien.value && (isNaN(soTienValue) || soTienValue < 0)) {
                soTien.setCustomValidity('Học phí phải là số không âm!');
                isValid = false;
            } else if (soTien.value && soTien.value.length > 10) {
                soTien.setCustomValidity('Học phí không được dài quá 10 chữ số!');
                isValid = false;
            } else {
                soTien.setCustomValidity('');
            }

            // Validation cho order
            const orderValue = parseInt(order.value);
            if (order.value && (isNaN(orderValue) || orderValue < 0)) {
                order.setCustomValidity('Thứ tự phải là số không âm!');
                isValid = false;
            } else {
                order.setCustomValidity('');
            }

            // Validation cho ghiChu
            if (ghiChu.value.length > 500) {
                ghiChu.setCustomValidity('Ghi chú không được dài quá 500 ký tự!');
                isValid = false;
            } else {
                ghiChu.setCustomValidity('');
            }

            // Validation cho lịch học
            for (let i = 0; i < ngayHocInputs.length; i++) {
                const ngayHoc = ngayHocInputs[i];
                const idSlotHoc = idSlotHocSelects[i];
                const idPhongHoc = idPhongHocSelects[i];

                // Kiểm tra ngày học
                if (!ngayHoc.value || ngayHoc.value.trim() === '') {
                    ngayHoc.setCustomValidity('Ngày học không được để trống!');
                    isValid = false;
                } else if (ngayHoc.value < today) {
                    ngayHoc.setCustomValidity('Ngày học không được trong quá khứ!');
                    isValid = false;
                } else if (startKhoaHoc && ngayHoc.value < startKhoaHoc) {
                    ngayHoc.setCustomValidity('Ngày học phải sau hoặc bằng ngày bắt đầu khóa học (' + startKhoaHoc + ')!');
                    isValid = false;
                } else if (endKhoaHoc && ngayHoc.value > endKhoaHoc) {
                    ngayHoc.setCustomValidity('Ngày học phải trước hoặc bằng ngày kết thúc khóa học (' + endKhoaHoc + ')!');
                    isValid = false;
                } else {
                    try {
                        new Date(ngayHoc.value);
                        ngayHoc.setCustomValidity('');
                    } catch (e) {
                        ngayHoc.setCustomValidity('Ngày học không đúng định dạng YYYY-MM-DD!');
                        isValid = false;
                    }
                }

                // Kiểm tra slot học
                if (!idSlotHoc.value || idSlotHoc.value.trim() === '') {
                    idSlotHoc.setCustomValidity('Slot học không được để trống!');
                    isValid = false;
                } else {
                    idSlotHoc.setCustomValidity('');
                }

                // Kiểm tra phòng học
                if (!idPhongHoc.value || idPhongHoc.value.trim() === '') {
                    idPhongHoc.setCustomValidity('Phòng học không được để trống!');
                    isValid = false;
                } else {
                    idPhongHoc.setCustomValidity('');
                }

                // Kiểm tra siSoToiDa so với sucChua của phòng học
                if (!isNaN(siSoToiDaValue) && idPhongHoc.value) {
                    const sucChua = parseInt(idPhongHoc.selectedOptions[0].getAttribute('data-succhua') || '0');
                    if (sucChua > 0 && siSoToiDaValue > sucChua) {
                        siSoToiDa.setCustomValidity('Sĩ số tối đa vượt quá sức chứa phòng học (' + sucChua + ')!');
                        isValid = false;
                    }
                }
            }

            // Kiểm tra số lượng lịch học
            if (ngayHocInputs.length === 0) {
                form.setCustomValidity('Phải có ít nhất 1 lịch học!');
                isValid = false;
            } else {
                form.setCustomValidity('');
            }

            return isValid;
        }

        // Gắn sự kiện input để validate
        document.getElementById('tenLopHoc').addEventListener('input', validateForm);
        document.getElementById('classCode').addEventListener('input', validateForm);
        document.getElementById('siSoToiDa').addEventListener('input', validateForm);
        document.getElementById('siSoToiThieu').addEventListener('input', validateForm);
        document.getElementById('soTien').addEventListener('input', validateForm);
        document.getElementById('order').addEventListener('input', validateForm);
        document.getElementById('ghiChu').addEventListener('input', validateForm);
        document.getElementById('startDate').addEventListener('input', validateForm);
        document.getElementById('defaultSlotHoc').addEventListener('change', validateForm);
        document.getElementById('defaultPhongHoc').addEventListener('change', validateForm);

        // Gắn sự kiện cho các select phòng học hiện có
        document.querySelectorAll('select[name="idPhongHoc[]"]').forEach(select => {
            select.addEventListener('change', validateForm);
        });

        // Gắn sự kiện submit để validate toàn bộ form
        document.getElementById('addClassForm').addEventListener('submit', function (event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });

        // Toggle dropdown menu
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