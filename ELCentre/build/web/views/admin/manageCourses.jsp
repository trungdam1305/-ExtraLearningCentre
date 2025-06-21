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
            /* Tiêu đề bảng */
            .table thead {
                background-color: #003087; /* Giống màu nền của nút Tìm (btn-custom-action) */
                color: white;
                font-weight: bold;
                font-size: 1.1rem;
            }

            /* Nút hành động tùy chỉnh */
            .btn-custom-action {
                background-color: #003087; /* Xanh dương đậm */
                border-color: #003087;
                color: white;
            }
            .btn-custom-action:hover {
                background-color: #00215a;
                border-color: #00215a;
            }

            /* Phân trang */
            .pagination .page-item.active .page-link {
                background-color: #003087; /* Xanh dương đậm */
                border-color: #003087;
            }
            .pagination .page-link:hover {
                background-color: #e6f0fa; /* Xanh nhạt */
                color: #003087;
            }

            /* Thông báo */
            .alert-custom-danger {
                background-color: #ff5733; /* Cam */
                border-color: #ff5733;
                color: white;
            }
            .alert-custom-success {
                background-color: #28a745; /* Xanh lá */
                border-color: #28a745;
                color: white;
            }
            .alert-custom-warning {
                background-color: #ffc107; /* Vàng */
                border-color: #ffc107;
                color: white;
            }

            /* Sắp xếp */
            .table th.sorted-asc::after {
                content: " ↑";
            }
            .table th.sorted-desc::after {
                content: " ↓";
            }
            .table th a {
                color: white;
                text-decoration: none;
            }
            .table th a:hover {
                color: #d1e7ff;
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
                max-width: 97%;
                margin-left: auto;
                margin-right: auto;
            }
            .pagination-container {
                display: flex;
                justify-content: flex-end;
                margin-top: 10px;
                padding: 0 20px;
                width: 97%;
            }
            .dashboard-button {
                text-align: center;
                margin-top: 20px;
            }

            /* Style cho nút trượt lên */
            #scrollToTopBtn {
                display: none; /* Ẩn mặc định */
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
        </style>
    </head>
    <body>
        <div class="content-container">
            <!-- Tiêu đề -->
            <div class="header-row">
                <h2>Danh sách khóa học</h2>
            </div>

            <!-- Nút hành động và form tìm kiếm/lọc trên cùng 1 hàng -->
            <div class="action-search-row">
                <a href="${pageContext.request.contextPath}/views/admin/addCourse.jsp" class="btn btn-custom-action"><i class="bi bi-plus-circle"></i> Thêm khóa học mới</a>
                <a href="${pageContext.request.contextPath}/ManageCourse?action=refresh" class="btn btn-custom-action"><i class="bi bi-arrow-clockwise"></i> Refresh</a>
                <form action="${pageContext.request.contextPath}/ManageCourse" method="get" id="filterForm" style="display: flex; align-items: flex-end; gap: 10px;">
                    <input type="hidden" name="action" value="search" />
                    <input type="hidden" name="page" value="${pageNumber != null ? pageNumber : 1}" />
                    <input type="hidden" name="sortColumn" value="${sortColumn != null ? sortColumn : 'TenKhoaHoc'}" />
                    <input type="hidden" name="sortOrder" value="${sortOrder != null ? sortOrder : 'asc'}" />
                    <input type="text" class="form-control" id="name" name="name" value="${name != null ? name : ''}" placeholder="Nhập tên khóa học">
                    <select class="form-select" id="sortName" name="sortName" onchange="this.form.action.value = 'filterStatus'; this.form.submit();">
                        <option value="" ${sortName == null || sortName.isEmpty() ? "selected" : ""}>-- Tất cả --</option>
                        <option value="ASCTrang" ${"ASCTrang".equals(sortName) ? "selected" : ""}>Đang hoạt động</option>
                        <option value="DESCTrang" ${"DESCTrang".equals(sortName) ? "selected" : ""}>Chưa hoạt động</option>
                    </select>
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
                <p style="color: green;">${suc}</p>
            </c:if>
            <c:if test="${not empty err}">
                <p style="color: red;">${err}</p>
            </c:if>

            <p>Tổng số khóa học: ${totalCourses}  &nbsp;&nbsp;      &nbsp; Tổng số trang: ${totalPages} .</p>

            <!-- Bảng khóa học và phân trang -->
            <div class="table-container">
                <c:if test="${not empty list}">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th class="${sortColumn == 'TenKhoaHoc' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Tên khóa học
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TenKhoaHoc&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TenKhoaHoc&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'MoTa' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Mô tả
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=MoTa&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=MoTa&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'ThoiGianBatDau' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Ngày bắt đầu
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ThoiGianBatDau&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ThoiGianBatDau&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'ThoiGianKetThuc' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Ngày kết thúc
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ThoiGianKetThuc&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ThoiGianKetThuc&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'GhiChu' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Ghi chú
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=GhiChu&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=GhiChu&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'TrangThai' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Trạng thái
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TrangThai&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=TrangThai&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'NgayTao' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Ngày tạo
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=NgayTao&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=NgayTao&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th class="${sortColumn == 'ID_Khoi' ? (sortOrder == 'asc' ? 'sorted-asc' : 'sorted-desc') : ''}">
                                        Khối
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ID_Khoi&sortOrder=asc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-up-fill"></i></a>
                                        <a href="${pageContext.request.contextPath}/ManageCourse?action=sort&sortColumn=ID_Khoi&sortOrder=desc&name=${name}&page=${pageNumber}&sortName=${sortName}"><i class="bi bi-caret-down-fill"></i></a>
                                    </th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="course" items="${list}">
                                    <tr>
                                        <td>${course.getTenKhoaHoc()}</td>
                                        <td>${course.getMoTa()}</td>
                                        <td>${course.thoiGianBatDauFormatted}</td>
                                        <td>${course.thoiGianKetThucFormatted}</td>
                                        <td>${course.getGhiChu()}</td>
                                        <td>${course.getTrangThai()}</td>
                                        <td>${course.getNgayTaoFormatted()}</td>
                                        <td>${course.getLopTheoKhoi()}</td>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal" data-id="${course.ID_KhoaHoc}">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>

                                            <a href="${pageContext.request.contextPath}/ManageCourse?action=UpdateCourse&ID_KhoaHoc=${course.ID_KhoaHoc}" class="btn btn-danger btn-sm">
                                                <i class="bi bi-pencil"></i> Update
                                            </a>
                                            <a href="${pageContext.request.contextPath}/ManageCourse?action=ViewCourse&ID_Khoi=${course.ID_Khoi}&ID_KhoaHoc=${course.ID_KhoaHoc}" class="btn btn-secondary btn-sm">
                                                <i class="bi bi-eye"></i> View
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
                        <nav aria-label="Page navigation">
                            <ul class="pagination">
                                <!-- Nút quay về trang đầu tiên -->
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=1&sortName=${sortName}&name=${name}&sortColumn=${sortColumn}&sortOrder=${sortOrder}" aria-label="First">
                                        <span aria-hidden="true">««</span>
                                    </a>
                                </li>
                                <!-- Trang trước nếu có -->
                                <c:if test="${pageNumber > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${pageNumber - 1}&sortName=${sortName}&name=${name}&sortColumn=${sortColumn}&sortOrder=${sortOrder}" aria-label="Previous">
                                            <span aria-hidden="true">«</span>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- Hiển thị 4 trang gần trang hiện tại nhất -->
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
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${i}&sortName=${sortName}&name=${name}&sortColumn=${sortColumn}&sortOrder=${sortOrder}">${i}</a>
                                    </li>
                                </c:forEach>
                                <!-- Trang sau nếu có -->
                                <c:if test="${pageNumber < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${pageNumber + 1}&sortName=${sortName}&name=${name}&sortColumn=${sortColumn}&sortOrder=${sortOrder}" aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                </c:if>
                                <!-- Nút quay về trang cuối cùng -->
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/ManageCourse?action=paginate&page=${totalPages}&sortName=${sortName}&name=${name}&sortColumn=${sortColumn}&sortOrder=${sortOrder}" aria-label="Last">
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

        <!-- Nút trượt lên đầu trang -->
        <button id="scrollToTopBtn" onclick="scrollToTop()">↑</button>

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
        </script>

        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Cập nhật URL xóa trong modal
            const deleteModal = document.getElementById('deleteModal');
            deleteModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const id = button.getAttribute('data-id');
                const deleteUrl = '${pageContext.request.contextPath}/ManageCourse?action=deleteCourse&ID_KhoaHoc=' + id;
                document.getElementById('confirmDelete').setAttribute('href', deleteUrl);
            });
        </script>
    </body>
</html>