<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.UUID" %>
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
    <style>
        /* General container styling */
        .content-container {
            padding: 20px;
            max-width: 100%;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Header styling */
        .header-row {
            text-align: center;
            margin-bottom: 20px;
            color: #003087;
        }
        .header-row h2 {
            font-size: 2rem;
            font-weight: 600;
        }

        /* Action and search row */
        .action-search-row {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .action-search-row .form-control,
        .action-search-row .form-select {
            border-radius: 8px;
            border: 1px solid #ced4da;
            box-shadow: none;
            transition: border-color 0.3s ease;
            height: 38px;
            font-size: 0.95rem;
        }
        .action-search-row .form-control:focus,
        .action-search-row .form-select:focus {
            border-color: #003087;
            box-shadow: 0 0 5px rgba(0, 48, 135, 0.3);
        }
        .action-search-row .btn-custom-action {
            height: 38px;
            display: flex;
            align-items: center;
            padding: 0 16px;
        }

        /* Custom button styling */
        .btn-custom-action {
            background-color: #003087;
            border-color: #003087;
            color: white;
            border-radius: 8px;
            font-size: 0.95rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-custom-action:hover {
            background-color: #00215a;
            border-color: #00215a;
            transform: translateY(-2px);
        }
        .btn-custom-action i {
            margin-right: 5px;
        }

        /* Table styling */
        .table-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
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
            min-width: 1400px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            font-size: 1rem;
        }
        .table thead {
            background-color: #2196F3;
        }
        .table thead th {
            padding: 15px 20px;
            vertical-align: middle;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 1.1rem;
            color: black;
            text-align: center;
        }
        .table tbody td {
            padding: 15px 20px;
            vertical-align: middle;
            text-align: center;
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
            padding: 5px 10px;
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
        .table th a.sort-link:focus {
            outline: none;
        }
        .table th a.sort-link:active {
            color: #0288d1;
            background-color: rgba(2, 136, 209, 0.3);
            border-color: #0288d1;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Action buttons in table */
        .table .btn-sm {
            margin-right: 5px;
            border-radius: 6px;
            font-size: 0.9rem;
            padding: 8px 12px;
            min-width: 80px;
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

        /* Pagination styling */
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            padding: 0 20px;
            width: 98%;
        }
        .pagination .page-item.active .page-link {
            background-color: #003087;
            border-color: #003087;
            color: white;
        }
        .pagination .page-link {
            border-radius: 6px;
            margin: 0 3px;
            color: #003087;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .pagination .page-link:hover {
            background-color: #e6f0fa;
            color: #00215a;
        }

        /* Alerts */
        .alert-custom-success {
            background-color: #22c55e;
            border-color: #22c55e;
            color: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .alert-custom-danger {
            background-color: #ef4444;
            border-color: #ef4444;
            color: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }

        /* Dashboard button */
        .dashboard-button {
            text-align: center;
            margin-top: 20px;
        }
        .dashboard-button .btn {
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 1rem;
        }

        /* Scroll to top button */
        #scrollToTopBtn {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            transition: background-color 0.3s ease;
        }
        #scrollToTopBtn:hover {
            background-color: #0056b3;
        }

        /* Modal styling */
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
        .modal-footer .btn {
            border-radius: 6px;
            padding: 8px 16px;
        }

        /* Image column */
        .teacher-column {
            width: 130px;
        }
        .table tbody tr {
            height: 160px;
        }
        .table td img {
            width: 100px !important;
            height: 130px !important;
            object-fit: cover;
            display: block;
            margin: 0 auto;
            border-radius: 4px;
            border: 2px solid lightblue;
            margin-bottom: 5px;
        }

        /* Status badge styling */
        .status-badge {
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 0.9rem;
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

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .content-container {
                padding: 15px;
                margin: 10px;
            }
            .header-row h2 {
                font-size: 1.5rem;
            }
            .action-search-row {
                flex-direction: column;
                align-items: flex-end;
                gap: 10px;
            }
            .action-search-row .form-control,
            .action-search-row .form-select,
            .action-search-row .btn-custom-action {
                width: 100%;
            }
            .table thead th,
            .table tbody td {
                padding: 10px 15px;
                font-size: 0.9rem;
            }
            .pagination-container {
                justify-content: center;
            }
            #scrollToTopBtn {
                bottom: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
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
                <form action="${pageContext.request.contextPath}/ManageClass" method="get" id="filterForm" style="display: flex; align-items: center; gap: 10px;">
                    <input type="hidden" name="action" value="search" />
                    <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                    <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                    <input type="hidden" name="page" value="${page != null ? page : 1}" />
                    <input type="hidden" name="sortColumn" value="${sortColumn != null ? sortColumn : 'TenLopHoc'}" />
                    <input type="hidden" name="sortOrder" value="${sortOrder != null ? sortOrder : 'asc'}" />
                    <input type="text" class="form-control" id="name" name="name" value="<c:out value='${searchName}'/>" placeholder="Nhập tên hoặc mã lớp học">
                    <select class="form-select" id="sortName" name="sortName" onchange="this.form.action.value = 'filterStatus'; this.form.submit();">
                        <option value="" ${sortName == null || sortName.isEmpty() ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="Đang học" ${sortName == 'Đang học' ? 'selected' : ''}>Đang học</option>
                        <option value="Kết thúc" ${sortName == 'Kết thúc' ? 'selected' : ''}>Kết thúc</option>
                        <option value="Chưa học" ${sortName == 'Chưa học' ? 'selected' : ''}>Chưa học</option>
                    </select>
                    <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Tìm</button>
                </form>
            </c:if>
        </div>

        <c:if test="${not empty ID_KhoaHoc && not empty ID_Khoi}">
            <p>Tổng số lớp học: ${totalItems != null ? totalItems : '0'}       Tổng số trang: ${totalPages != null ? totalPages : '0'}</p>
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
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=ClassCode&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'ClassCode' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp mã lớp học tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=ClassCode&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'ClassCode' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp mã lớp học giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'TenLopHoc' ? 'sorted' : ''}">
                                    Tên lớp học
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TenLopHoc' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp tên lớp học tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TenLopHoc' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp tên lớp học giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SiSo' ? 'sorted' : ''}">
                                    Sĩ số
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSo' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSo' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SiSoToiDa' ? 'sorted' : ''}">
                                    Sĩ số tối đa
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSoToiDa&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSoToiDa' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số tối đa tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSoToiDa&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SiSoToiDa' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp sĩ số tối đa giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SoTien' ? 'sorted' : ''}">
                                    Học phí
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SoTien&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SoTien' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp học phí tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SoTien&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'SoTien' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp học phí giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th>Thời gian học</th>
                                <th>Giáo viên</th>
                                <th class="${sortColumn == 'GhiChu' ? 'sorted' : ''}">
                                    Ghi chú
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=GhiChu&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'GhiChu' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp ghi chú tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=GhiChu&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'GhiChu' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp ghi chú giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'TrangThai' ? 'sorted' : ''}">
                                    Trạng thái
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp trạng thái tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp trạng thái giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'NgayTao' ? 'sorted' : ''}">
                                    Ngày khởi tạo
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=NgayTao&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'NgayTao' && sortOrder == 'asc' ? 'active' : ''}" aria-label="Sắp xếp ngày khởi tạo tăng dần"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=NgayTao&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link ${sortColumn == 'NgayTao' && sortOrder == 'desc' ? 'active' : ''}" aria-label="Sắp xếp ngày khởi tạo giảm dần"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="teacher-column">Ảnh giáo viên</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lopHoc" items="${danhSachLopHoc}">
                                <tr>
                                    <td>${lopHoc.classCode != null ? lopHoc.classCode : 'Chưa có'}</td>
                                    <td>${lopHoc.tenLopHoc != null ? lopHoc.tenLopHoc : 'Chưa có'}</td>
                                    <td>${lopHoc.siSo != null ? lopHoc.siSo : '0'}</td>
                                    <td>${lopHoc.siSoToiDa != null ? lopHoc.siSoToiDa : 'Chưa có'}</td>
                                    <td>${lopHoc.soTien != null ? lopHoc.soTien : '0'} VNĐ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty lopHoc.thoiGianHoc}">
                                                <ul style="margin: 0; padding-left: 20px;">
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
                                    <td>${lopHoc.tenGiaoVien != null ? lopHoc.tenGiaoVien : 'Chưa phân công'}</td>
                                    <td>${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Chưa có'}</td>
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
                                    <td>${lopHoc.ngayTao != null ? lopHoc.ngayTao : 'Chưa có'}</td>
                                    <td class="teacher-column">
                                        <c:choose>
                                            <c:when test="${not empty lopHoc.avatarGiaoVien}">
                                                <c:forEach var="avatar" items="${fn:split(lopHoc.avatarGiaoVien, ',')}">
                                                    <img src="${pageContext.request.contextPath}/${avatar.trim()}" alt="Ảnh giáo viên" style="width: 100px; height: 130px; object-fit: cover; border-radius: 4px; border: 2px solid lightblue; margin-bottom: 5px;" />
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span>Chưa có ảnh</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${lopHoc.idLopHoc}" aria-label="Xóa lớp học">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                        <a href="${pageContext.request.contextPath}/ManageClass?action=updateClass&ID_LopHoc=${lopHoc.idLopHoc}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-danger btn-sm" aria-label="Cập nhật lớp học">
                                            <i class="bi bi-pencil"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/ManageClassDetail?ID_LopHoc=${lopHoc.idLopHoc}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-secondary btn-sm" aria-label="Xem lớp học">
                                            <i class="bi bi-eye"></i> Xem danh sách lớp
                                        </a>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=1&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang đầu">
                                    <span aria-hidden="true">««</span>
                                </a>
                            </li>
                            <c:if test="${page > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page - 1}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang trước">
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
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${i}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${page < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page + 1}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang sau">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${totalPages}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Trang cuối">
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
    </script>
    <!-- Nút cuộn lên đầu trang -->
    <button id="scrollToTopBtn" onclick="scrollToTop()" aria-label="Cuộn lên đầu trang"><i class="bi bi-arrow-up"></i></button>
</body>
</html>