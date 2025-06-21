<%-- 
    Document   : manageClass
    Created on : May 31, 2025, 10:33:02 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="model.LopHoc"%>
<%@page import="dal.LopHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.io.PrintWriter"%>
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
        /* Tiêu đề bảng */
        .table thead {
            background-color: #2196F3 !important; /* Màu xanh dương nhạt, dễ nhìn */
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
        }
        .table thead:hover {
            background-color: #1976D2 !important; /* Hiệu ứng hover nhạt hơn */
        }

        /* Nút hành động tùy chỉnh */
        .btn-custom-action {
            background-color: #003087;
            border-color: #003087;
            color: white;
        }
        .btn-custom-action:hover {
            background-color: #00215a;
            border-color: #00215a;
        }

        /* Phân trang */
        .pagination .page-item.active .page-link {
            background-color: #003087;
            border-color: #003087;
        }
        .pagination .page-link:hover {
            background-color: #e6f0fa;
            color: #003087;
        }

        /* Thông báo */
        .alert-custom-danger {
            background-color: #ff5733;
            border-color: #ff5733;
            color: white;
            margin-bottom: 20px;
        }
        .alert-custom-success {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            margin-bottom: 20px;
        }
        .alert-custom-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: white;
            margin-bottom: 20px;
        }

        /* Sắp xếp - Nổi bật cột được sort */
        .table th.sorted {
            border: 2px solid #d1e7ff; /* Viền nổi bật */
            background-color: #e6f0fa; /* Nền nhạt */
        }
        .table th.sorted-asc::after {
            content: " ↑"; /* Mũi tên lên */
            color: #007bff; /* Màu xanh */
            font-size: 1.8rem; /* Tăng kích thước */
            font-weight: bold; /* Đậm hơn */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3); /* Thêm bóng chữ */
            margin-left: 8px; /* Khoảng cách với nội dung */
            vertical-align: middle; /* Căn giữa theo chiều dọc */
            position: relative;
            top: -2px;
        }
        .table th.sorted-desc::after {
            content: " ↓"; /* Mũi tên xuống */
            color: #dc3545; /* Màu đỏ */
            font-size: 1.8rem; /* Tăng kích thước */
            font-weight: bold; /* Đậm hơn */
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3); /* Thêm bóng chữ */
            margin-left: 8px; /* Khoảng cách với nội dung */
            vertical-align: middle; /* Căn giữa theo chiều dọc */
            position: relative;
            top: -2px;
        }
        .table th a {
            color: white;
            text-decoration: none;
            display: inline-block; /* Đảm bảo a nằm trong flow của th */
            padding: 5px 10px; /* Tăng padding để dễ nhấp */
            border: 1px solid transparent; /* Viền ẩn mặc định */
            border-radius: 4px; /* Bo góc nhẹ */
            transition: all 0.3s ease; /* Hiệu ứng mượt mà */
        }
        .table th a:hover {
            color: #ffeb3b; /* Màu vàng nhạt khi hover */
            background-color: rgba(255, 235, 59, 0.2); /* Nền nhạt khi hover */
            border-color: #ffeb3b; /* Viền khi hover */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Bóng nhẹ khi hover */
        }
        .table th a:focus {
            outline: none; /* Loại bỏ viền mặc định khi focus */
        }
        .table th a:active {
            color: #0288d1; /* Màu xanh đậm khi nhấp */
            background-color: rgba(2, 136, 209, 0.3); /* Nền khi nhấp */
            border-color: #0288d1; /* Viền khi nhấp */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Bóng rõ hơn khi nhấp */
        }

        /* Tùy chỉnh bố cục */
        .content-container {
            padding: 20px;
            max-width: 100%;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header-row {
            text-align: center;
            margin-bottom: 20px;
            color: #003087;
        }
        .action-search-row {
            display: flex;
            align-items: flex-end;
            gap: 10px;
            margin-bottom: 20px;
        }
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
            min-width: 1200px;
        }
        .pagination-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
            padding: 0 20px;
            width: 98%;
        }
        .dashboard-button {
            text-align: center;
            margin-top: 20px;
        }

        /* Nút trượt lên */
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 1000;
        }
        #scrollToTopBtn:hover {
            background-color: #0056b3;
        }

        /* Fix image display */
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
        }
        .table-responsive {
            overflow: visible;
        }

        /* Đổi màu nút Delete và Update */
        .btn-primary { /* Nút Update, đổi thành xanh */
            background-color: #007bff !important;
            border-color: #007bff !important;
        }
        .btn-primary:hover {
            background-color: #0056b3 !important;
            border-color: #0056b3 !important;
        }
        .btn-danger { /* Nút Delete, đổi thành đỏ */
            background-color: #dc3545 !important;
            border-color: #dc3545 !important;
        }
        .btn-danger:hover {
            background-color: #c82333 !important;
            border-color: #c82333 !important;
        }

        /* Debug info */
        .debug-info {
            background-color: #f8f9fa;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <%
        String idKhoaHoc = request.getParameter("ID_KhoaHoc");
        if (idKhoaHoc == null) {
            Object idKhoaHocObj = request.getAttribute("ID_KhoaHoc");
            idKhoaHoc = idKhoaHocObj != null ? idKhoaHocObj.toString() : null;
        }

        String idKhoi = request.getParameter("ID_Khoi");
        if (idKhoi == null) {
            Object idKhoiObj = request.getAttribute("ID_Khoi");
            idKhoi = idKhoiObj != null ? idKhoiObj.toString() : null;
        }

        // Log để debug
        System.out.println("Debug: idKhoaHoc = " + idKhoaHoc + ", idKhoi = " + idKhoi);
    %>

    <div class="content-container">
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

        <!-- Debug danh sách lớp học -->
        <div class="debug-info">
            <p>danhSachLopHoc size: ${danhSachLopHoc != null ? danhSachLopHoc.size() : 'null'}</p>
            <c:forEach var="lopHoc" items="${danhSachLopHoc}">
                <p>ID: ${lopHoc.getID_LopHoc()}, Tên: ${lopHoc.getTenLopHoc()}, ID_Schedule: ${lopHoc.getID_Schedule()}, SiSoToiDa: ${lopHoc.getSiSoToiDa()}, SiSo: ${lopHoc.getSiSo()}, GhiChu: ${lopHoc.getGhiChu()}, TrangThai: ${lopHoc.getTrangThai()}, Image: ${lopHoc.getImage()}</p>
            </c:forEach>
            <c:if test="${danhSachLopHoc == null || danhSachLopHoc.size() == 0}">
                <p style="color: red;">Không có dữ liệu lớp học để hiển thị. Kiểm tra Servlet hoặc DAO. idKhoaHoc: ${idKhoaHoc}, idKhoi: ${idKhoi}</p>
            </c:if>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty err}">
            <div class="alert alert-custom-danger" role="alert">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-custom-success" role="alert">${suc}</div>
        </c:if>
        <c:if test="${not empty Notdelete}">
            <div class="alert alert-custom-warning" role="alert">${Notdelete}</div>
        </c:if>
        <c:if test="${message == 'deleted'}">
            <div class="alert alert-custom-success" role="alert">Xóa lớp học thành công!</div>
        </c:if>
        <c:if test="${message == 'Notdeleted'}">
            <div class="alert alert-custom-warning" role="alert">Xóa lớp học không thành công do trạng thái không phù hợp!</div>
        </c:if>
        <c:if test="${message == 'Notupdated'}">
            <div class="alert alert-custom-warning" role="alert">Chỉnh sửa lớp học không thành công do trạng thái không phù hợp!</div>
        </c:if>
        <c:if test="${message == 'notFound'}">
            <div class="alert alert-custom-danger" role="alert">Không tìm thấy lớp học!</div>
        </c:if>
        <c:if test="${message == 'error'}">
            <div class="alert alert-custom-danger" role="alert">Lỗi: ID lớp học không hợp lệ!</div>
        </c:if>

        <!-- Nút hành động và form tìm kiếm/lọc -->
        <div class="action-search-row">
            <a href="${pageContext.request.contextPath}/ManageClass?action=showAddClass&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-custom-action">
                <i class="bi bi-plus-circle"></i> Thêm lớp học mới
            </a>
            <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-custom-action">
                <i class="bi bi-arrow-clockwise"></i> Làm mới
            </a>
            <form action="${pageContext.request.contextPath}/ManageClass" method="get" id="filterForm" style="display: flex; align-items: flex-end; gap: 10px; margin-bottom: 20px;">
                <input type="hidden" name="action" value="search" />
                <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
                <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />
                <input type="hidden" name="page" value="${page != null ? page : 1}" />
                <input type="hidden" name="sortColumn" value="${sortColumn != null ? sortColumn : 'TenLopHoc'}" />
                <input type="hidden" name="sortOrder" value="${sortOrder != null ? sortOrder : 'asc'}" />
                <input type="text" class="form-control" id="name" name="name" value="${searchName != null ? searchName : ''}" placeholder="Nhập tên lớp học">
                <select class="form-select" id="sortName" name="sortName"
                        onchange="document.querySelector('input[name=action]').value = 'filterStatus'; this.form.submit();">
                    <option value="" ${sortName == null || sortName.isEmpty() ? 'selected' : ''}>Tất cả các lớp</option>
                    <option value="ASCTrang" ${sortName == 'ASCTrang' ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="DESCTrang" ${sortName == 'DESCTrang' ? 'selected' : ''}>Chưa hoạt động</option>
                </select>
                <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Tìm</button>
            </form>
        </div>

        <p>Tổng số lớp học: ${totalItems}     Tổng số trang: ${totalPages}</p>

        <!-- Bảng danh sách -->
        <div class="table-container">
            <c:if test="${danhSachLopHoc != null and not empty danhSachLopHoc}">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover align-middle">
                        <thead>
                            <tr>
                                <th class="${sortColumn == 'TenLopHoc' ? 'sorted' : ''} ${sortColumn == 'TenLopHoc' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Tên lớp học
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TenLopHoc&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SiSo' ? 'sorted' : ''} ${sortColumn == 'SiSo' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Sĩ số
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSo&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'SiSoToiDa' ? 'sorted' : ''} ${sortColumn == 'SiSoToiDa' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Sĩ số tối đa
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSoToiDa&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=SiSoToiDa&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th>Thời gian học</th>
                                <th class="${sortColumn == 'GhiChu' ? 'sorted' : ''} ${sortColumn == 'GhiChu' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Ghi chú
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=GhiChu&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=GhiChu&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'TrangThai' ? 'sorted' : ''} ${sortColumn == 'TrangThai' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Trạng thái
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=TrangThai&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="${sortColumn == 'NgayTao' ? 'sorted' : ''} ${sortColumn == 'NgayTao' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                    Ngày khởi tạo
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=NgayTao&sortOrder=asc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-up-fill"></i></a>
                                    <a href="${pageContext.request.contextPath}/ManageClass?action=sort&sortColumn=NgayTao&sortOrder=desc&name=${searchName}&page=${page}&sortName=${sortName}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="sort-link"><i class="bi bi-caret-down-fill"></i></a>
                                </th>
                                <th class="teacher-column">Ảnh lớp học</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lopHoc" items="${danhSachLopHoc}">
                                <tr>
                                    <td>${lopHoc.getTenLopHoc() != null ? lopHoc.getTenLopHoc() : 'Chưa có'}</td>
                                    <td>${lopHoc.getSiSo() != null ? lopHoc.getSiSo() : 'Chưa có'}</td>
                                    <td>${lopHoc.getSiSoToiDa() != null ? lopHoc.getSiSoToiDa() : 'Chưa có'}</td>
                                    <td>
                                        <%
                                            LopHoc lh = (LopHoc) pageContext.getAttribute("lopHoc");
                                            int idSchedule = (lh != null) ? lh.getID_Schedule() : 0;
                                            System.out.println("Debug: idSchedule = " + idSchedule); // Log để debug
                                            if (idSchedule > 0) {
                                                try {
                                                    dal.LichHocDAO lichHocDAO = new dal.LichHocDAO();
                                                    model.LichHoc lichHoc = lichHocDAO.getLichHocById(idSchedule);
                                                    pageContext.setAttribute("lichHoc", lichHoc);
                                                } catch (Exception e) {
                                                    System.out.println("Error fetching LichHoc: " + e.getMessage());
                                                    pageContext.setAttribute("lichHoc", null);
                                                }
                                            } else {
                                                pageContext.setAttribute("lichHoc", null);
                                            }
                                        %>
                                        <c:if test="${lichHoc != null}">
                                            ${lichHoc.getSlotThoiGian() != null ? lichHoc.getSlotThoiGian() : 'Chưa có'} (${lichHoc.getNgayHoc() != null ? lichHoc.getNgayHoc() : 'Chưa có'})
                                        </c:if>
                                        <c:if test="${lichHoc == null}">
                                            <span style="color: red;">Chưa có lịch học</span>
                                        </c:if>
                                    </td>
                                    <td>${lopHoc.getGhiChu() != null ? lopHoc.getGhiChu() : 'Chưa có'}</td>
                                    <td>${lopHoc.getTrangThai() != null ? lopHoc.getTrangThai() : 'Chưa có'}</td>
                                    <td>${lopHoc.getNgayTao() != null ? lopHoc.getNgayTao() : 'Chưa có'}</td>
                                    <td class="teacher-column">
                                        <c:if test="${not empty lopHoc.getImage()}">
                                            <img src="${pageContext.request.contextPath}/${lopHoc.getImage()}" alt="Class Image" style="width: 100px; height: 130px; object-fit: cover; border-radius: 4px; border: 2px solid lightblue;" />
                                        </c:if>
                                        <c:if test="${empty lopHoc.getImage()}">
                                            <span>Chưa có ảnh</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${lopHoc.getID_LopHoc()}">
                                            <i class="bi bi-trash"></i> Delete
                                        </button>
                                        <a href="${pageContext.request.contextPath}/ManageClass?action=updateClass&ID_LopHoc=${lopHoc.getID_LopHoc()}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-primary btn-sm">
                                            <i class="bi bi-pencil"></i> Update
                                        </a>
                                        <a href="${pageContext.request.contextPath}/ManageClass?action=viewClass&ID_LopHoc=${lopHoc.getID_LopHoc()}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-secondary btn-sm">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${danhSachLopHoc == null || empty danhSachLopHoc}">
                <div class="alert alert-warning" role="alert">
                    Không có dữ liệu lớp học để hiển thị. Vui lòng kiểm tra lại dữ liệu hoặc bộ lọc. idKhoaHoc: ${idKhoaHoc}, idKhoi: ${idKhoi}
                </div>
            </c:if>
            <c:if test="${totalPages > 1}">
                <div class="pagination-container">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <!-- Trang đầu -->
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=1&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="First">
                                    <span aria-hidden="true">««</span>
                                </a>
                            </li>
                            <!-- Trang trước -->
                            <c:if test="${page > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page - 1}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                            </c:if>
                            <!-- Các trang gần trang hiện tại -->
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
                            <!-- Trang sau -->
                            <c:if test="${page < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${page + 1}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                            <!-- Trang cuối -->
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/ManageClass?action=paginate&page=${totalPages}&sortName=${sortName}&name=${searchName}&sortColumn=${sortColumn}&sortOrder=${sortOrder}&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" aria-label="Last">
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
                    <button type="button" class="btn btn-custom-action" id="confirmDelete">Xóa</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Nút trượt lên đầu trang -->
    <button id="scrollToTopBtn" onclick="scrollToTop()">↑</button>

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

        // Xử lý xóa lớp học
        const deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const confirmDeleteBtn = document.getElementById('confirmDelete');
            confirmDeleteBtn.onclick = function () {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '${pageContext.request.contextPath}/ManageClass';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteClass';
                form.appendChild(actionInput);

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'ID_LopHoc';
                idInput.value = id;
                form.appendChild(idInput);

                const khoaHocInput = document.createElement('input');
                khoaHocInput.type = 'hidden';
                khoaHocInput.name = 'ID_KhoaHoc';
                khoaHocInput.value = '${ID_KhoaHoc}';
                form.appendChild(khoaHocInput);

                const khoiInput = document.createElement('input');
                khoiInput.type = 'hidden';
                khoiInput.name = 'ID_Khoi';
                khoiInput.value = '${ID_Khoi}';
                form.appendChild(khoiInput);

                document.body.appendChild(form);
                form.submit();
            };
        });
    </script>
</body>
</html>