<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<head>
    <title>Danh sách khóa học</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">

    <h2 class="mb-4">Danh sách khóa học</h2>

    <!-- Form tìm kiếm -->
    <form action="Search" method="get" class="row g-3 mb-4">
        <div class="col-auto">
            <input type="text" name="keyword" class="form-control" placeholder="Tìm kiếm...">
        </div>
        <div class="col-auto">
            <input type="submit" name="action" value="SEARCH" class="btn btn-primary">
        </div>
    </form>

    <!-- Form sắp xếp -->
    <form action="Sort" method="get" class="row g-3 mb-4">
        <div class="col-auto">
            <label for="sortField" class="form-label">Sắp xếp theo:</label>
            <select name="sortField" id="sortField" class="form-select">
                <option value="id">ID</option>
                <option value="name">Tên</option>
            </select>
        </div>
        <div class="col-auto">
            <label for="sortOrder" class="form-label">Thứ tự:</label>
            <select name="sortOrder" id="sortOrder" class="form-select">
                <option value="ASC">Tăng dần</option>
                <option value="DESC">Giảm dần</option>
            </select>
        </div>
        <div class="col-auto">
            <input type="submit" name="action" value="SORT" class="btn btn-secondary">
        </div>
    </form>

    <!-- Bảng hiển thị khóa học -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên khóa học</th>
            <th>Mô tả</th>
            <th>Bắt đầu</th>
            <th>Kết thúc</th>
            <th>Ghi chú</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="course" items="${defaultCourses}">
            <tr>
                <td>${course.getID_KhoaHoc()}</td>
                <td>${course.getTenKhoaHoc()}</td>
                <td>${course.getMoTa()}</td>
                <td>${course.getThoiGianBatDau()}</td>
                <td>${course.getThoiGianKetThuc()}</td>
                <td>${course.getGhiChu()}</td>
                <td>${course.getTrangThai()}</td>
                <td>${course.getNgayTao()}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Phân trang -->
    <div class="mt-3">
        <c:forEach var="i" begin="1" end="${totalPages}">
            <a class="btn btn-outline-primary btn-sm" href="?page=${i}">${i}</a>
        </c:forEach>
    </div>

</div>
</body>
</html>
