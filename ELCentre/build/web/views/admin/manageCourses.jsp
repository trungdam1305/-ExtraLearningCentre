<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách khóa học</title>
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
                flex-wrap: nowrap; /* Prevent wrapping to keep all elements in one row */
            }
            .action-search-row .form-control,
            .action-search-row .form-select {
                border-radius: 8px;
                border: 1px solid #ced4da;
                box-shadow: none;
                transition: border-color 0.3s ease;
                height: 38px;
                font-size: 0.95rem;
                width: 150px; /* Fixed width for consistency */
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
                white-space: nowrap; /* Prevent text wrapping in buttons */
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
                min-width: 100px;
            }
            .table tbody td {
                padding: 15px 20px;
                vertical-align: middle;
                text-align: center;
            }
            /* Cột Mô tả: Giới hạn chiều rộng và hiển thị ellipsis */
            .description-column {
                max-width: 200px;
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
                padding: 20px;
                border-top: 1px solid #dee2e6;
            }
            .details-content {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }
            .details-content div {
                flex: 1 1 45%;
                font-size: 0.95rem;
            }
            .details-content div strong {
                color: #003087;
            }

            /* Pagination, Alerts, Modal, Scroll to Top */
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
            .alert-custom-success {
                background-color: #22c55e;
                border-color: #22c55e;
                color: white;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 20px;
            }
            .alert-custom-warning {
                background-color: #facc15;
                border-color: #facc15;
                color: #1f2a44;
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
                .description-column {
                    max-width: 150px;
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
                .details-content div {
                    flex: 1 1 100%;
                }
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
        </style>
    </head>
    <body>
        <div class="content-container">
            <!-- Tiêu đề -->
            <div class="header-row">
                <h2>Danh sách khóa học</h2>
            </div>

            <!-- Nút hành động và form tìm kiếm/lọc -->
            <div class="action-search-row">
                <a href="${pageContext.request.contextPath}/views/admin/addCourse.jsp" class="btn btn-custom-action"><i class="bi bi-plus-circle"></i> Thêm khóa học mới</a>
                <a href="${pageContext.request.contextPath}/ManageCourse?action=refresh" class="btn btn-custom-action"><i class="bi bi-arrow-clockwise"></i> Refresh</a>
                <form action="${pageContext.request.contextPath}/ManageCourse" method="get" id="filterForm" style="display: flex; align-items: center; gap: 10px; flex-wrap: nowrap;">
                    <input type="hidden" name="action" value="filterByStatusAndName" />
                    <input type="hidden" name="page" value="${pageNumber != null ? pageNumber : 1}" />
                    <input type="text" class="form-control" id="name" name="name" value="${name != null ? name : ''}" placeholder="Nhập tên khóa học">
                    <select class="form-select" id="statusFilter" name="statusFilter" onchange="this.form.submit();">
                        <option value="" ${statusFilter == null || statusFilter.isEmpty() ? "selected" : ""}>-- Tất cả trạng thái --</option>
                        <option value="Đang hoạt động" ${"Đang hoạt động".equals(statusFilter) ? "selected" : ""}>Đang hoạt động</option>
                        <option value="Chưa hoạt động" ${"Chưa hoạt động".equals(statusFilter) ? "selected" : ""}>Chưa hoạt động</option>
                        <option value="Chưa bắt đầu" ${"Chưa bắt đầu".equals(statusFilter) ? "selected" : ""}>Chưa bắt đầu</option>
                        <option value="Đã kết thúc" ${"Đã kết thúc".equals(statusFilter) ? "selected" : ""}>Đã kết thúc</option>
                    </select>
                    <select class="form-select" id="khoiFilter" name="khoiFilter" onchange="this.form.submit();">
                        <option value="" ${khoiFilter == null || khoiFilter.isEmpty() ? "selected" : ""}>-- Tất cả khối --</option>
                        <option value="1" ${"1".equals(khoiFilter) ? "selected" : ""}>Lớp 6</option>
                        <option value="2" ${"2".equals(khoiFilter) ? "selected" : ""}>Lớp 7</option>
                        <option value="3" ${"3".equals(khoiFilter) ? "selected" : ""}>Lớp 8</option>
                        <option value="4" ${"4".equals(khoiFilter) ? "selected" : ""}>Lớp 9</option>
                        <option value="5" ${"5".equals(khoiFilter) ? "selected" : ""}>Lớp 10</option>
                        <option value="6" ${"6".equals(khoiFilter) ? "selected" : ""}>Lớp 11</option>
                        <option value="7" ${"7".equals(khoiFilter) ? "selected" : ""}>Lớp 12</option>
                        <option value="8" ${"8".equals(khoiFilter) ? "selected" : ""}>Lớp tổng ôn</option>
                    </select>
                    <select class="form-select" id="orderFilter" name="orderFilter" onchange="this.form.submit();">
                        <option value="" ${orderFilter == null || orderFilter.isEmpty() ? "selected" : ""}>-- Tất cả thứ tự ưu tiên --</option>
                        <c:forEach var="i" begin="0" end="10">
                            <option value="${i}" ${orderFilter == i && orderFilter != null && !orderFilter.isEmpty() ? "selected" : ""}>${i}</option>
                        </c:forEach>
                    </select>
                    <input type="date" class="form-control" id="startDate" name="startDate" value="${startDate != null ? startDate : ''}" placeholder="Từ ngày">
                    <input type="date" class="form-control" id="endDate" name="endDate" value="${endDate != null ? endDate : ''}" placeholder="Đến ngày">
                    <button type="submit" class="btn btn-custom-action"><i class="bi bi-search"></i> Tìm</button>
                </form>
            </div>

            <!-- Thông báo -->
            <c:if test="${param.message == 'deleted'}">
                <div class="alert alert-custom-success" role="alert">Xóa khóa học thành công!</div>
            </c:if>
            <c:if test="${empty list && empty err}">
                <div class="alert alert-custom-warning" role="alert">Không có khóa học nào để hiển thị. Kiểm tra dữ liệu hoặc tham số.</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-custom-success" role="alert">${suc}</div>
            </c:if>
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${list == null}">
                <div class="alert alert-custom-danger" role="alert">Danh sách khóa học (list) chưa được khởi tạo. Kiểm tra servlet ManageCourse.</div>
            </c:if>

            <p>Tổng số khóa học: ${totalCourses != null ? totalCourses : '0'} &nbsp;&nbsp;&nbsp; Tổng số trang: ${totalPages != null ? totalPages : '0'}.</p>

            <!-- Bảng khóa học và phân trang -->
            <div class="table-container">
                <c:if test="${not empty list}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th class="${sortColumn == 'CourseCode' ? 'sorted' : ''}">
                                        Mã khóa học
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=CourseCode&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'CourseCode' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=CourseCode&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'CourseCode' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'TenKhoaHoc' ? 'sorted' : ''}">
                                        Tên khóa học
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TenKhoaHoc&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'TenKhoaHoc' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TenKhoaHoc&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'TenKhoaHoc' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'MoTa' ? 'sorted' : ''}">
                                        Mô tả
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=MoTa&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'MoTa' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=MoTa&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'MoTa' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'ID_Khoi' ? 'sorted' : ''}">
                                        Khối
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ID_Khoi&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'ID_Khoi' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ID_Khoi&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'ID_Khoi' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'Order' ? 'sorted' : ''}">
                                        Thứ tự ưu tiên
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=Order&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'Order' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=Order&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'Order' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'TrangThai' ? 'sorted' : ''}">
                                        Trạng thái
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TrangThai&sortOrder=asc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'asc' ? 'active' : ''}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TrangThai&sortOrder=desc&name=${name}&page=${pageNumber}&statusFilter=${statusFilter}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" class="sort-link ${sortColumn == 'TrangThai' && sortOrder == 'desc' ? 'active' : ''}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th>Ảnh khóa học</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="course" items="${list}">
                                    <tr>
                                        <td>${course.getCourseCode()}</td>
                                        <td>${course.getTenKhoaHoc()}</td>
                                        <td class="description-column" title="${course.getMoTa()}">${course.getMoTa()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${course.getID_Khoi() == 1}">Lớp 6 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 2}">Lớp 7 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 3}">Lớp 8 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 4}">Lớp 9 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 5}">Lớp 10 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 6}">Lớp 11 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 7}">Lớp 12 (ID: ${course.getID_Khoi()})</c:when>
                                                <c:when test="${course.getID_Khoi() == 8}">Lớp tổng ôn (ID: ${course.getID_Khoi()})</c:when>
                                                <c:otherwise>Không xác định (ID: <c:out value="${course.getID_Khoi()}" />)</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${course.getOrder()}</td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${course.trangThai == 'Đang hoạt động'}">
                                                    <span class="status-badge status-dang-hoc">Đang hoạt động</span>
                                                </c:when>
                                                <c:when test="${course.trangThai == 'Đã kết thúc'}">
                                                    <span class="status-badge status-ket-thuc">Đã kết thúc</span>
                                                </c:when>
                                                <c:when test="${course.trangThai == 'Đã kết thúc'}">
                                                    <span class="status-badge status-chua-hoc">Đã kết thúc</span>
                                                </c:when>
                                                <c:when test="${course.trangThai == 'Chưa bắt đầu'}">
                                                    <span class="status-badge status-chua-hoc">Chưa bắt đầu</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>${course.trangThai != null ? course.trangThai : 'Chưa có'}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty course.image}">
                                                    <img data-course-image="${pageContext.request.contextPath}${course.image}" src="${pageContext.request.contextPath}${course.image}" alt="${course.tenKhoaHoc}" width="100" style="max-height: 100px; object-fit: cover;" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/100" alt="No Image" width="100" style="max-height: 100px; object-fit: cover;" />
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm toggle-details" data-id="${course.ID_KhoaHoc}">
                                                <i class="bi bi-info-circle"></i> Xem chi tiết
                                            </button>
                                            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${course.ID_KhoaHoc}">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                            <a href="${pageContext.request.contextPath}/ManageCourse?action=updateCourse&ID_KhoaHoc=${course.ID_KhoaHoc}" class="btn btn-danger btn-sm">
                                                <i class="bi bi-pencil"></i> Sửa
                                            </a>
                                            <c:choose>
                                                <c:when test="${course.ID_Khoi != null}">
                                                    <a href="${pageContext.request.contextPath}/ManageCourse?action=ViewCourse&ID_Khoi=${course.ID_Khoi}&ID_KhoaHoc=${course.ID_KhoaHoc}" class="btn btn-secondary btn-sm">
                                                        <i class="bi bi-eye"></i> Xem lớp
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-secondary btn-sm" disabled title="Không thể xem lớp vì thiếu ID_Khoi">
                                                        <i class="bi bi-eye"></i> Xem lớp
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <!-- Hàng chi tiết (ẩn mặc định) -->
                                    <tr class="details-row" id="details-${course.ID_KhoaHoc}">
                                        <td colspan="8">
                                            <div class="details-content">
                                                <div><strong>Ngày bắt đầu:</strong> ${course.thoiGianBatDau != null ? course.thoiGianBatDau : 'Chưa xác định'}</div>
                                                <div><strong>Ngày kết thúc:</strong> ${course.thoiGianKetThuc != null ? course.thoiGianKetThuc : 'Chưa xác định'}</div>
                                                <div><strong>Ghi chú:</strong> ${course.getGhiChu() != null ? course.getGhiChu() : 'Không có'}</div>
                                                <div><strong>Ngày tạo:</strong> ${course.getNgayTao() != null ? course.getNgayTao() : 'Chưa xác định'}</div>
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
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=1&statusFilter=${statusFilter}&name=${name}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" aria-label="First">
                                        <span aria-hidden="true">««</span>
                                    </a>
                                </li>
                                <c:if test="${pageNumber > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${pageNumber - 1}&statusFilter=${statusFilter}&name=${name}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:set var="startPage" value="${pageNumber - 2}"/>
                                <c:set var="endPage" value="${pageNumber + 2}"/>
                                <c:if test="${startPage < 1}">
                                    <c:set var="startPage" value="1"/>
                                    <c:set var="endPage" value="${endPage > totalPages ? totalPages : endPage + (2 - (pageNumber - startPage))}"/>
                                </c:if>
                                <c:if test="${endPage > totalPages}">
                                    <c:set var="endPage" value="${totalPages}"/>
                                    <c:set var="startPage" value="${startPage < (totalPages - 4) ? (totalPages - 4) : startPage}"/>
                                    <c:if test="${startPage < 1}">
                                        <c:set var="startPage" value="1"/>
                                    </c:if>
                                </c:if>
                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <li class="page-item ${i == pageNumber ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${i}&statusFilter=${statusFilter}&name=${name}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${pageNumber < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${pageNumber + 1}&statusFilter=${statusFilter}&name=${name}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${totalPages}&statusFilter=${statusFilter}&name=${name}&khoiFilter=${khoiFilter}&orderFilter=${orderFilter}&startDate=${startDate}&endDate=${endDate}" aria-label="Last">
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
                <form action="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp" method="get">
                    <button type="submit" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Quay lại dashboard</button>
                </form>
            </div>
        </div>

        <!-- Nút Scroll to Top -->
        <button id="scrollToTopBtn" onclick="scrollToTop()" title="Cuộn lên đầu trang">↑</button>

        <!-- Modal xác nhận xóa -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc muốn xóa khóa học này không?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <a id="confirmDelete" href="#" class="btn btn-primary">Xóa</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

        <script>
            // Hiển thị/n ẩn nút khi cuộn
            window.addEventListener('scroll', function () {
                var scrollBtn = document.getElementById("scrollToTopBtn");
                if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                    scrollBtn.style.display = "block";
                } else {
                    scrollBtn.style.display = "none";
                }
            });

            // Hàm cuộn lên đầu trang
            function scrollToTop() {
                window.scrollTo({top: 0, behavior: "smooth"});
            }

            // Cập nhật URL xóa trong modal
            const deleteModal = document.getElementById('deleteModal');
            deleteModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const deleteUrl = '${pageContext.request.contextPath}/ManageCourse?action=deleteCourse&ID_KhoaHoc=' + id;
                document.getElementById('confirmDelete').setAttribute('href', deleteUrl);
            });

            // Quản lý trạng thái active cho nút sort
            document.querySelectorAll('.sort-link').forEach(link => {
                link.addEventListener('click', function (e) {
                    document.querySelectorAll('.sort-link').forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Xóa trạng thái active khi bấm nút Refresh hoặc Tìm
            document.querySelectorAll('.btn-custom-action').forEach(button => {
                button.addEventListener('click', function () {
                    document.querySelectorAll('.sort-link').forEach(l => l.classList.remove('active'));
                });
            });

            // Kiểm tra sự tồn tại của ảnh
            document.querySelectorAll('img[data-course-image]').forEach(img => {
                const imageUrl = img.getAttribute('data-course-image');
                const fallbackUrl = 'https://via.placeholder.com/100';
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

            // Kiểm tra khoảng thời gian hợp lệ
            document.querySelector('form').addEventListener('submit', function (e) {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;
                if (startDate && endDate && new Date(endDate) < new Date(startDate)) {
                    alert('Ngày kết thúc phải sau ngày bắt đầu!');
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>