<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết khóa học - ${course.tenKhoaHoc}</title>
<<<<<<< HEAD
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: #f8f9fa; /* Thêm màu nền cho đẹp hơn */
        }
        
        .course-detail-header {
            background-image: linear-gradient(to right, #6a11cb 0%, #2575fc 100%);
            color: white;
            border-radius: 1rem !important;
        }
        
        .section-title {
            font-weight: 700;
            color: #343a40;
            position: relative;
            padding-bottom: 10px;
            margin-bottom: 1.5rem; /* Tăng khoảng cách dưới tiêu đề */
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: #0d6efd;
        }

        .class-card {
            border: 1px solid #dee2e6;
            border-radius: 0.75rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        .class-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }
        
        .class-card .card-body {
             display: flex;
             flex-direction: column;
             flex-grow: 1;
        }

        .class-info {
            list-style: none;
            padding-left: 0;
            flex-grow: 1;
        }
        .class-info li {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            color: #495057;
        }
        .class-info i {
            color: #0d6efd;
            width: 25px;
            text-align: center;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <%-- Bạn có thể include header chung của trang web tại đây --%>
    
    <div class="container py-5">
        <div class="course-detail-header p-4 mb-4 text-white">
            <div class="container-fluid py-3">
                <h1 class="display-5 fw-bold" style="font-family: 'Times New Roman', Times, serif;">${course.tenKhoaHoc}</h1>
                <p class="col-md-10 fs-5">${course.moTa}</p>
            </div>
        </div>

        <div class="card">
            <div class="card-body p-4">
                <form action="CourseDetailsServlet" method="GET" class="row g-3 align-items-end mb-4">
                    <input type="hidden" name="courseId" value="${course.ID_KhoaHoc}">
                    <div class="col-md-9">
                        <h3 class="mb-4 section-title" style="font-family: 'Times New Roman', Times, serif;">Các lớp học hiện có</h3>
                    </div>
                    <div class="col-md-3">
                        <label for="teacherFilter" class="form-label">Lọc theo giáo viên:</label>
                        <select id="teacherFilter" name="teacherId" class="form-select" onchange="this.form.submit()">
                            <option value="0">Tất cả giáo viên</option>
                            <c:forEach var="teacher" items="${teacherList}">
                                <option value="${teacher.ID_GiaoVien}" ${teacher.ID_GiaoVien == selectedTeacherId ? 'selected' : ''}>
                                    ${teacher.hoTen}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
                <c:if test="${empty classList}">
                    <div class="alert alert-info">Hiện chưa có lớp nào cho khóa học này.</div>
                </c:if>

                <c:if test="${not empty classList}">
                    <div class="row">
                        <c:forEach var="lop" items="${classList}">
                            <div class="col-lg-6 mb-4">
                                <div class="card class-card h-100">
                                    <div class="card-body">
                                        <h4 class="card-title fw-bold mb-3" style="font-family: 'Times New Roman', Times, serif;">${lop.tenLopHoc}</h4>
                                        <ul class="class-info">
                                            <li><i class="fas fa-barcode"></i> <strong>Mã lớp:</strong>&nbsp; ${lop.classCode}</li>
                                            <li><i class="fas fa-users"></i> <strong>Sĩ số hiện tại:</strong>&nbsp; ${lop.siSo}</li>
                                            <li><i class="fas fa-map-marker-alt"></i> <strong>Phòng học:</strong>&nbsp; ${lop.tenPhongHoc}</li>
                                            <li><i class="fas fa-chalkboard-teacher"></i> <strong>Giáo viên:</strong>&nbsp; ${lop.tenGiaoVien}</li>
                                        </ul>
                                        <a href="${pageContext.request.contextPath}/ClassDetailsServlet?classId=${lop.ID_LopHoc}" class="btn btn-success fw-bold w-100 mt-auto py-2">
                                            <i class="fas fa-check-circle"></i> Xem Chi Tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <div class="mt-4 pt-3 border-top">
                    <a href="HomePageCourse" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách khóa học
                    </a>
                </div>

            </div>
        </div>
        </div>
    
    <%-- Bạn có thể include footer chung của trang web tại đây --%>
=======
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
>>>>>>> 942ba0eced369676945c15812aa61113d7de5a14
</body>
</html>