<%-- 
    Document   : updateClass
    Created on : May 27, 2025, 18:23:02 PM
    Author     : Vuh26
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="model.LopHocInfoDTO, java.util.UUID, java.util.List, java.util.ArrayList, dal.LichHocDAO, model.LichHoc, dal.AdminDAO, model.Admin"%>
<%@ page import="dal.HocSinhDAO, model.HocSinh, dal.GiaoVienDAO, model.GiaoVien, dal.LopHocDAO, model.LopHoc, dal.UserLogsDAO, model.UserLogs, dal.HoTroDAO, model.HoTro, model.UserLogView, java.time.LocalDate"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật lớp học</title>
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
                border: 1px solid #ced4da;
                border-radius: 6px;
                font-size: 0.58rem !important;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus,
            input[type="number"]:focus,
            input[type="date"]:focus,
            select:focus,
            textarea:focus {
                border-color: #003087;
                box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
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
            input[readonly], select[disabled] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }
            textarea {
                resize: vertical;
                min-height: 60px;
            }
            .btn-custom-action {
                background-color: #003087;
                border-color: #003087;
                color: white;
                border-radius: 6px;
                padding: 6px 12px;
                font-size: 0.58rem;
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
            .btn-danger {
                background-color: #f97316;
                border-color: #f97316;
                color: white;
                border-radius: 6px;
                padding: 4px 6px;
                font-size: 0.5rem;
            }
            .btn-danger:hover {
                background-color: #ea580c;
                border-color: #ea580c;
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
                max-width: 600px;
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
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
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
            .schedule-row .btn-danger {
                font-size: 0.5rem;
                padding: 4px 6px;
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
            img {
                max-width: 150px;
                margin-bottom: 10px;
                border-radius: 6px;
                border: 2px solid lightblue;
            }
            .no-image {
                font-size: 0.58rem;
                color: #666;
                margin-bottom: 15px;
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
                    font-size: 0.38rem !important;
                    padding: 4px;
                    height: 26px;
                }
                input[type="file"] {
                    padding: 2px;
                }
                textarea {
                    min-height: 50px;
                }
                .btn-custom-action,
                .dashboard-button .btn {
                    font-size: 0.38rem;
                    padding: 4px 8px;
                }
                .btn-danger {
                    font-size: 0.33rem;
                    padding: 3px 5px;
                }
                .alert-custom-success,
                .alert-custom-danger {
                    font-size: 0.38rem;
                    padding: 6px;
                    margin-bottom: 8px;
                }
                p.info {
                    font-size: 0.38rem;
                }
                p.note {
                    font-size: 0.33rem;
                }
                img {
                    max-width: 100px;
                }
                .no-image {
                    font-size: 0.38rem;
                }
                .schedule-row {
                    gap: 4px;
                    margin-bottom: 6px;
                }
                .schedule-row select,
                .schedule-row input[type="date"] {
                    font-size: 0.38rem !important;
                }
                .schedule-row .btn-danger {
                    font-size: 0.33rem;
                    padding: 3px 5px;
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
        <%
            String idLopHoc = request.getParameter("ID_LopHoc");
            if (idLopHoc == null) idLopHoc = (String) session.getAttribute("idLopHoc");
            else session.setAttribute("idLopHoc", idLopHoc);

            String idKhoaHoc = request.getParameter("ID_KhoaHoc");
            if (idKhoaHoc == null) idKhoaHoc = (String) session.getAttribute("idKhoaHoc");
            else session.setAttribute("idKhoaHoc", idKhoaHoc);

            String idKhoi = request.getParameter("ID_Khoi");
            if (idKhoi == null) idKhoi = (String) session.getAttribute("idKhoi");
            else session.setAttribute("idKhoi", idKhoi);

            if (session.getAttribute("csrfToken") == null) {
                session.setAttribute("csrfToken", UUID.randomUUID().toString());
            }

            LopHocInfoDTO lopHoc = (LopHocInfoDTO) request.getAttribute("lopHoc");
            List<String> pastSchedules = new ArrayList<>();
            List<String> futureSchedules = new ArrayList<>();
            List<Integer> pastSlotHocs = new ArrayList<>();
            List<Integer> futureSlotHocs = new ArrayList<>();
            List<Integer> pastPhongHocs = new ArrayList<>();
            List<Integer> futurePhongHocs = new ArrayList<>();

            if (lopHoc != null && lopHoc.getIdLopHoc() > 0) {
                try {
                    LichHocDAO lichHocDAO = new LichHocDAO();
                    List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(lopHoc.getIdLopHoc());
                    LocalDate today = LocalDate.now();
                    for (LichHoc lichHoc : lichHocList) {
                        String ngayHocStr = lichHoc.getNgayHoc() != null ? lichHoc.getNgayHoc().toString() : "";
                        if (!ngayHocStr.isEmpty()) {
                            LocalDate ngayHoc = LocalDate.parse(ngayHocStr);
                            if (ngayHoc.isBefore(today)) {
                                pastSchedules.add(ngayHocStr);
                                pastSlotHocs.add(lichHoc.getID_SlotHoc());
                                pastPhongHocs.add(lichHoc.getID_PhongHoc());
                            } else {
                                futureSchedules.add(ngayHocStr);
                                futureSlotHocs.add(lichHoc.getID_SlotHoc());
                                futurePhongHocs.add(lichHoc.getID_PhongHoc());
                            }
                        }
                    }
                } catch (Exception e) {
                    // Bỏ qua để tránh treo
                }
            }
            pageContext.setAttribute("pastSchedules", pastSchedules);
            pageContext.setAttribute("futureSchedules", futureSchedules);
            pageContext.setAttribute("pastSlotHocs", pastSlotHocs);
            pageContext.setAttribute("futureSlotHocs", futureSlotHocs);
            pageContext.setAttribute("pastPhongHocs", pastPhongHocs);
            pageContext.setAttribute("futurePhongHocs", futurePhongHocs);
        %>

        <div class="header">
            <div class="left-title">
                Admin Dashboard <i class="fas fa-tachometer-alt"></i>
            </div>
            <div class="admin-profile" onclick="toggleDropdown()">
                <%
                    ArrayList<Admin> admins = (ArrayList) AdminDAO.getNameAdmin();
                    String adminAvatar = admins != null && !admins.isEmpty() ? admins.get(0).getAvatar() : "/img/default-avatar.png";
                    String adminName = admins != null && !admins.isEmpty() ? admins.get(0).getHoTen() : "Admin";
                %>
                <img src="<%= request.getContextPath() + adminAvatar %>" alt="Admin Photo" class="admin-img">
                <span><%= adminName %></span>
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
            <div class="form-container">
                <h2>Cập nhật lớp học</h2>

                <!-- Thông báo -->
                <c:if test="${not empty err}">
                    <div class="alert alert-custom-danger">${fn:escapeXml(err)}</div>
                </c:if>
                <c:if test="${not empty suc}">
                    <div class="alert alert-custom-success">${fn:escapeXml(suc)}</div>
                    <div class="dashboard-button">
                        <form action="${pageContext.request.contextPath}/ManageClass" method="get">
                            <input type="hidden" name="action" value="refresh" />
                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                            <button type="submit" class="btn"><i class="bi bi-arrow-left"></i> Quay lại danh sách lớp học</button>
                        </form>
                    </div>
                </c:if>
                <c:if test="${empty lopHoc}">
                    <div class="alert alert-custom-danger">Không có dữ liệu lớp học để hiển thị!</div>
                    <div class="dashboard-button">
                        <form action="${pageContext.request.contextPath}/ManageClass" method="get">
                            <input type="hidden" name="action" value="refresh" />
                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                            <button type="submit" class="btn"><i class="bi bi-arrow-left"></i> Quay lại danh sách lớp học</button>
                        </form>
                    </div>
                </c:if>

                <!-- Kiểm tra danh sách slot và phòng học -->
                <c:if test="${empty slotHocList || empty phongHocList}">
                    <div class="alert alert-custom-danger">
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
                    <div class="dashboard-button">
                        <form action="${pageContext.request.contextPath}/ManageClass" method="get">
                            <input type="hidden" name="action" value="refresh" />
                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                            <button type="submit" class="btn"><i class="bi bi-arrow-left"></i> Quay lại danh sách lớp học</button>
                        </form>
                    </div>
                </c:if>

                <!-- Form cập nhật lớp học -->
                <c:if test="${not empty lopHoc && not empty slotHocList && not empty phongHocList}">
                    <form action="${pageContext.request.contextPath}/ManageClass" method="post" id="updateClassForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="updateClass">
                        <input type="hidden" name="ID_LopHoc" value="${lopHoc.idLopHoc}">
                        <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                        <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                        <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

                        <div class="mb-3">
                            <label for="tenLopHoc" class="form-label required-label">Tên lớp học:</label>
                            <input type="text" class="form-control" id="tenLopHoc" name="tenLopHoc" value="${fn:escapeXml(lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : '')}" maxlength="100" readonly>
                            <p class="note">Tên lớp học tối đa 100 ký tự. Ví dụ: Lớp Toán Cao Cấp.</p>
                        </div>

                        <div class="mb-3">
                            <label for="classCode" class="form-label required-label">Mã lớp học:</label>
                            <input type="text" class="form-control" id="classCode" name="classCode" value="${fn:escapeXml(lopHoc.classCode != null ? lopHoc.classCode : '')}" maxlength="20" readonly>
                            <p class="note">Mã lớp học được tự động tạo từ tên lớp học và khối học (ví dụ: TCB12).</p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Khóa học:</label>
                            <p class="info">ID khóa học: <c:out value="${ID_KhoaHoc != null ? ID_KhoaHoc : 'Không xác định'}" /></p>
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
                            <input type="number" class="form-control" id="siSoToiDa" name="siSoToiDa" value="${not empty param.siSoToiDa ? param.siSoToiDa : lopHoc.siSoToiDa}" min="${lopHoc.siSo}" required>
                            <p class="note">Sĩ số tối đa phải lớn hơn hoặc bằng sĩ số hiện tại (${lopHoc.siSo}).</p>
                        </div>

                        <div class="mb-3">
                            <label for="siSoToiThieu" class="form-label required-label">Sĩ số tối thiểu:</label>
                            <input type="number" class="form-control" id="siSoToiThieu" name="siSoToiThieu" value="${not empty param.siSoToiThieu ? param.siSoToiThieu : lopHoc.siSoToiThieu}" min="0" required>
                            <p class="note">Sĩ số tối thiểu phải là số không âm và nhỏ hơn hoặc bằng sĩ số tối đa.</p>
                        </div>

                        <div class="mb-3">
                            <label for="ghiChu" class="form-label">Ghi chú:</label>
                            <textarea class="form-control" id="ghiChu" name="ghiChu" maxlength="500">${not empty param.ghiChu ? fn:escapeXml(param.ghiChu) : fn:escapeXml(lopHoc.ghiChu)}</textarea>
                            <p class="note">Ghi chú tối đa 500 ký tự.</p>
                        </div>

                        <div class="mb-3">
                            <label for="soTien" class="form-label">Học phí:</label>
                            <input type="number" class="form-control" id="soTien" name="soTien" value="${not empty param.soTien ? param.soTien : lopHoc.soTien}" min="0" step="1">
                            <p class="note">Học phí là số nguyên không âm, tối đa 10 chữ số.</p>
                        </div>

                        <div class="mb-3">
                            <label for="trangThai" class="form-label required-label">Trạng thái:</label>
                            <select class="form-select" id="trangThai" name="trangThai" required>
                                <option value="" ${lopHoc.trangThai == null ? 'selected' : ''}>-- Chọn trạng thái --</option>
                                <option value="Chưa học" ${not empty param.trangThai ? (param.trangThai == 'Chưa học' ? 'selected' : '') : (lopHoc.trangThai == 'Chưa học' ? 'selected' : '')}>Chưa học</option>
                                <option value="Đang học" ${not empty param.trangThai ? (param.trangThai == 'Đang học' ? 'selected' : '') : (lopHoc.trangThai == 'Đang học' ? 'selected' : '')}>Đang học</option>
                                <option value="Kết thúc" ${not empty param.trangThai ? (param.trangThai == 'Kết thúc' ? 'selected' : '') : (lopHoc.trangThai == 'Kết thúc' ? 'selected' : '')}>Kết thúc</option>
                            </select>
                            <p class="note">Chọn trạng thái phù hợp cho lớp học.</p>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">Ảnh đại diện lớp học hiện tại:</label>
                            <c:choose>
                                <c:when test="${not empty lopHoc.avatarGiaoVien}">
                                    <c:forEach var="avatar" items="${fn:split(lopHoc.avatarGiaoVien, ',')}">
                                        <img data-class-image="${pageContext.request.contextPath}/${avatar.trim()}" src="${pageContext.request.contextPath}/${avatar.trim()}" alt="Ảnh lớp học" />
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/150" alt="No Image" />
                                </c:otherwise>
                            </c:choose>
                            <label for="image" class="form-label">Tải lên ảnh mới (tùy chọn):</label>
                            <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/png">
                            <p class="note">Chỉ chấp nhận file ảnh .jpg hoặc .png, kích thước tối đa 3MB.</p>
                        </div>

                        <div class="mb-3">
                            <label for="order" class="form-label">Thứ tự ưu tiên:</label>
                            <input type="number" class="form-control" id="order" name="order" value="${not empty param.order ? param.order : (lopHoc.order != null ? lopHoc.order : '0')}" min="0" step="1">
                            <p class="note">Thứ tự phải là số không âm.</p>
                        </div>

                        <div class="mb-3">
                            <label class="form-label required-label">Lịch học:</label>
                            <p class="note">Chỉ lịch học trong tương lai (từ ngày ${today} trở đi) có thể chỉnh sửa hoặc xóa. Tối đa 10 lịch học.</p>
                            <div id="scheduleContainer">
                                <!-- Lịch học trong quá khứ (chỉ đọc) -->
                                <c:if test="${not empty pastSchedules && fn:length(pastSchedules) > 0}">
                                    <p class="info">Lịch học trong quá khứ (không thể chỉnh sửa):</p>
                                    <c:forEach var="i" begin="0" end="${fn:length(pastSchedules) - 1}">
                                        <div class="schedule-row">
                                            <input type="date" class="form-control" name="pastNgayHoc[]" value="${fn:escapeXml(pastSchedules[i])}" readonly>
                                            <select class="form-select" name="pastIdSlotHoc[]" disabled>
                                                <option value="">Chọn slot học</option>
                                                <c:forEach var="slot" items="${slotHocList}">
                                                    <option value="${slot.ID_SlotHoc}" ${pastSlotHocs[i] == slot.ID_SlotHoc ? 'selected' : ''}>${slot.slotThoiGian}</option>
                                                </c:forEach>
                                            </select>
                                            <select class="form-select" name="pastIdPhongHoc[]" disabled>
                                                <option value="">Chọn phòng học</option>
                                                <c:forEach var="phongHoc" items="${phongHocList}">
                                                    <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}" ${pastPhongHocs[i] == phongHoc.ID_PhongHoc ? 'selected' : ''}>${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </c:forEach>
                                </c:if>

                                <!-- Lịch học trong tương lai (có thể chỉnh sửa) -->
                                <p class="info">Lịch học trong tương lai (có thể chỉnh sửa):</p>
                                <c:choose>
                                    <c:when test="${not empty futureSchedules && fn:length(futureSchedules) > 0}">
                                        <c:forEach var="i" begin="0" end="${fn:length(futureSchedules) - 1}">
                                            <div class="schedule-row">
                                                <input type="date" class="form-control" name="ngayHoc[]" value="${not empty paramValues['ngayHoc[]'] && not empty paramValues['ngayHoc[]'][i] ? fn:escapeXml(paramValues['ngayHoc[]'][i]) : fn:escapeXml(futureSchedules[i])}" min="${today}" required>
                                                <select class="form-select" name="idSlotHoc[]" required>
                                                    <option value="">Chọn slot học</option>
                                                    <c:forEach var="slot" items="${slotHocList}">
                                                        <option value="${slot.ID_SlotHoc}" ${not empty paramValues['idSlotHoc[]'] && not empty paramValues['idSlotHoc[]'][i] ? (paramValues['idSlotHoc[]'][i] == slot.ID_SlotHoc ? 'selected' : '') : (futureSlotHocs[i] == slot.ID_SlotHoc ? 'selected' : '')}>${slot.slotThoiGian}</option>
                                                    </c:forEach>
                                                </select>
                                                <select class="form-select" name="idPhongHoc[]" required>
                                                    <option value="">Chọn phòng học</option>
                                                    <c:forEach var="phongHoc" items="${phongHocList}">
                                                        <option value="${phongHoc.ID_PhongHoc}" data-succhua="${phongHoc.sucChua}" ${not empty paramValues['idPhongHoc[]'] && not empty paramValues['idPhongHoc[]'][i] ? (paramValues['idPhongHoc[]'][i] == phongHoc.ID_PhongHoc ? 'selected' : '') : (futurePhongHocs[i] == phongHoc.ID_PhongHoc ? 'selected' : '')}>${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                                    </c:forEach>
                                                </select>
                                                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove(); validateForm()">Xóa</button>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="schedule-row">
                                            <input type="date" class="form-control" name="ngayHoc[]" min="${today}" required>
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
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <button type="button" class="btn btn-custom-action mt-2"><i class="bi bi-plus-circle"></i> Thêm lịch học</button>
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-custom-action"><i class="bi bi-save"></i> Cập nhật</button>
                        </div>
                    </form>
                </c:if>

                <!-- Nút quay lại -->
                <div class="dashboard-button">
                    <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>

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

            // Toggle dropdown menu
            function toggleDropdown() {
                const dropdown = document.getElementById('adminDropdown');
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            }

            // Thêm lịch học mới
            function addScheduleRow() {
                const container = document.getElementById('scheduleContainer');
                const row = document.createElement('div');
                row.className = 'schedule-row';
                row.innerHTML = `
                    <input type="date" class="form-control" name="ngayHoc[]" min="${today}" required>
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

            // Kiểm tra sự tồn tại của ảnh
            document.querySelectorAll('img[data-class-image]').forEach(img => {
                const imageUrl = img.getAttribute('data-class-image');
                const fallbackUrl = 'https://via.placeholder.com/150';
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

            // Validate form
            function validateForm() {
                const form = document.getElementById('updateClassForm');
                const siSoToiDa = document.getElementById('siSoToiDa');
                const siSoToiThieu = document.getElementById('siSoToiThieu');
                const soTien = document.getElementById('soTien');
                const order = document.getElementById('order');
                const ghiChu = document.getElementById('ghiChu');
                const trangThai = document.getElementById('trangThai');
                const ngayHocInputs = document.getElementsByName('ngayHoc[]');
                const idSlotHocSelects = document.getElementsByName('idSlotHoc[]');
                const idPhongHocSelects = document.getElementsByName('idPhongHoc[]');
                const siSoHienTai = parseInt('${lopHoc.siSo}' || '0');
                let isValid = true;

                // Validation cho sĩ số tối đa
                const siSoToiDaValue = parseInt(siSoToiDa.value);
                if (isNaN(siSoToiDaValue) || siSoToiDaValue < siSoHienTai) {
                    siSoToiDa.setCustomValidity(`Sĩ số tối đa phải lớn hơn hoặc bằng sĩ số hiện tại (${siSoHienTai}).`);
                    isValid = false;
                } else {
                    siSoToiDa.setCustomValidity('');
                }

                // Validation cho sĩ số tối thiểu
                const siSoToiThieuValue = parseInt(siSoToiThieu.value);
                if (isNaN(siSoToiThieuValue) || siSoToiThieuValue < 0) {
                    siSoToiThieu.setCustomValidity('Sĩ số tối thiểu phải là số không âm.');
                    isValid = false;
                } else if (!isNaN(siSoToiDaValue) && siSoToiThieuValue > siSoToiDaValue) {
                    siSoToiThieu.setCustomValidity('Sĩ số tối thiểu phải nhỏ hơn hoặc bằng sĩ số tối đa.');
                    isValid = false;
                } else {
                    siSoToiThieu.setCustomValidity('');
                }

                // Validation cho học phí
                const soTienValue = parseInt(soTien.value);
                if (soTien.value && (isNaN(soTienValue) || soTienValue < 0)) {
                    soTien.setCustomValidity('Học phí phải là số không âm.');
                    isValid = false;
                } else if (soTien.value && soTien.value.length > 10) {
                    soTien.setCustomValidity('Học phí không được dài quá 10 chữ số.');
                    isValid = false;
                } else {
                    soTien.setCustomValidity('');
                }

                // Validation cho thứ tự ưu tiên
                const orderValue = parseInt(order.value);
                if (order.value && (isNaN(orderValue) || orderValue < 0)) {
                    order.setCustomValidity('Thứ tự phải là số không âm.');
                    isValid = false;
                } else {
                    order.setCustomValidity('');
                }

                // Validation cho ghi chú
                if (ghiChu.value.length > 500) {
                    ghiChu.setCustomValidity('Ghi chú không được dài quá 500 ký tự.');
                    isValid = false;
                } else {
                    ghiChu.setCustomValidity('');
                }

                // Validation cho trạng thái
                if (!["Chưa học", "Đang học", "Kết thúc"].includes(trangThai.value)) {
                    trangThai.setCustomValidity('Vui lòng chọn trạng thái hợp lệ!');
                    isValid = false;
                } else {
                    trangThai.setCustomValidity('');
                }

                // Validation cho lịch học
                for (let i = 0; i < ngayHocInputs.length; i++) {
                    const ngayHoc = ngayHocInputs[i];
                    const idSlotHoc = idSlotHocSelects[i];
                    const idPhongHoc = idPhongHocSelects[i];

                    if (!ngayHoc.value || ngayHoc.value.trim() === '') {
                        ngayHoc.setCustomValidity('Ngày học không được để trống!');
                        isValid = false;
                    } else if (ngayHoc.value < today) {
                        ngayHoc.setCustomValidity('Ngày học trong tương lai không được trong quá khứ!');
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

                    if (!idSlotHoc.value || idSlotHoc.value.trim() === '') {
                        idSlotHoc.setCustomValidity('Slot học không được để trống!');
                        isValid = false;
                    } else {
                        idSlotHoc.setCustomValidity('');
                    }

                    if (!idPhongHoc.value || idPhongHoc.value.trim() === '') {
                        idPhongHoc.setCustomValidity('Phòng học không được để trống!');
                        isValid = false;
                    } else {
                        const sucChua = parseInt(idPhongHoc.selectedOptions[0].getAttribute('data-succhua') || '0');
                        if (sucChua > 0 && !isNaN(siSoToiDaValue) && siSoToiDaValue > sucChua) {
                            idPhongHoc.setCustomValidity(`Sĩ số tối đa (${siSoToiDaValue}) vượt quá sức chứa phòng học (${sucChua})!`);
                            isValid = false;
                        } else {
                            idPhongHoc.setCustomValidity('');
                        }
                    }
                }

                // Kiểm tra số lượng lịch học
                if (ngayHocInputs.length === 0) {
                    form.setCustomValidity('Phải có ít nhất 1 lịch học trong tương lai!');
                    isValid = false;
                } else if (ngayHocInputs.length > 10) {
                    form.setCustomValidity('Tối đa chỉ được phép có 10 lịch học!');
                    isValid = false;
                } else {
                    form.setCustomValidity('');
                }

                return isValid;
            }

            // Gắn sự kiện input để validate
            document.getElementById('siSoToiDa').addEventListener('input', validateForm);
            document.getElementById('siSoToiThieu').addEventListener('input', validateForm);
            document.getElementById('soTien').addEventListener('input', validateForm);
            document.getElementById('order').addEventListener('input', validateForm);
            document.getElementById('ghiChu').addEventListener('input', validateForm);
            document.getElementById('trangThai').addEventListener('change', validateForm);
            document.querySelectorAll('select[name="idPhongHoc[]"]').forEach(select => {
                select.addEventListener('change', validateForm);
            });
            document.querySelectorAll('input[name="ngayHoc[]"]').forEach(input => {
                input.addEventListener('input', validateForm);
            });
            document.querySelectorAll('select[name="idSlotHoc[]"]').forEach(select => {
                select.addEventListener('change', validateForm);
            });

            // Validate file upload
            document.getElementById('image').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                    alert('Chỉ chấp nhận file .jpg hoặc .png!');
                    e.target.value = '';
                }
            });

            // Confirm before submit
            document.getElementById('updateClassForm').addEventListener('submit', function (e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return;
                }
                if (!confirm('Bạn có chắc muốn cập nhật lớp học này?')) {
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>