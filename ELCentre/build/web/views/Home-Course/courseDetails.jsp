<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết khóa học - ${course.tenKhoaHoc}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/your-main-style.css"> <%-- Link đến file CSS chung --%>
</head>
<body>
    <%-- Có thể include header và footer của trang chủ tại đây --%>
    
    <div class="container my-5">
        <div class="course-detail-header p-5 mb-4 bg-light rounded-3">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold">${course.tenKhoaHoc}</h1>
                <p class="col-md-8 fs-4">${course.moTa}</p>
            </div>
        </div>

        <h3 class="mb-3">Các lớp học hiện có</h3>
        <div class="card">
            <div class="card-body">
                <c:if test="${empty classList}">
                    <p class="text-muted">Hiện chưa có lớp nào cho khóa học này.</p>
                </c:if>
                <c:if test="${not empty classList}">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Mã Lớp</th>
                                <th>Tên Lớp</th>
                                <th>Sĩ Số</th>
                                <th>Phòng Học</th>
                                <th class="text-center">Hành Động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lop" items="${classList}">
                                <tr>
                                    <td>${lop.classCode}</td>
                                    <td>${lop.tenLopHoc}</td>
                                    <td>${lop.siSo}</td>
                                    <td>${lop.tenPhongHoc}</td>
                                    <td class="text-center">
                                        <a href="#" class="btn btn-sm btn-success">Đăng ký</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>
        <div class="mt-4">
            <a href="HomePageCourse" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách khóa học
            </a>
        </div>
    </div>
    
    <%-- Có thể include footer của trang chủ tại đây --%>
</body>
</html>