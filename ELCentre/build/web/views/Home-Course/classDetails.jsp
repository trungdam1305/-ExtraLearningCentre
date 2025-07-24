<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lớp: ${lopHoc.tenLopHoc}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; 
               font-family: 'Be Vietnam Pro', sans-serif; }
        .info-card { background-color: white; 
                    border-radius: 1rem; 
                    box-shadow: 0 4px 25px rgba(0,0,0,0.1); }
        .info-card .card-header { 
            background-color: #1F4E79; 
            color: white; 
            border-top-left-radius: 1rem; 
            border-top-right-radius: 1rem; }
        .info-list { 
            list-style: none; 
            padding-left: 0; }
        .info-list li { 
            display: flex; 
            align-items: flex-start; 
            padding: 12px 0; 
            border-bottom: 1px solid #f0f0f0; }
        .info-list li:last-child { 
            border-bottom: none; }
        .info-list i { 
            font-size: 1.1rem; 
            color: #0d6efd; 
            width: 30px; 
            text-align: center; 
            margin-top: 3px; }
        .info-list .info-label { 
            font-weight: 500; 
            color: #6c757d; 
            min-width: 120px; }
        .info-list .info-value { 
            color: #212529; }
        .course-image { 
            width: 100%; 
            height: 300px; 
            object-fit: cover; 
            border-radius: 1rem; }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-4">
                <img src="${pageContext.request.contextPath}/${lopHoc.image}" class="img-fluid rounded shadow-sm course-image mb-3" alt="${lopHoc.tenLopHoc}">
                <div class="d-grid gap-2">
                    <a href="#" class="btn btn-success btn-lg fw-bold"><i class="fas fa-user-plus"></i> Đăng ký ngay</a>
                    <a href="${pageContext.request.contextPath}/CourseDetailsServlet?courseId=${lopHoc.ID_KhoaHoc}" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i> Quay lại khóa học
                    </a>
                </div>
            </div>
            <!--Class's information-->            
            <div class="col-lg-8">
                <div class="card info-card">
                    <div class="card-header">
                        <h1 class="h3 mb-0" style="font-family: 'Be Vietnam Pro'">${lopHoc.tenLopHoc}</h1>
                    </div>
                    <div class="card-body p-4">
                        <ul class="info-list">
                            <li><i class="fas fa-barcode"></i><span class="info-label">Mã lớp:</span> <span class="info-value">${lopHoc.classCode}</span></li>
                            <li><i class="fas fa-book"></i><span class="info-label">Thuộc khóa học:</span> <span class="info-value">${lopHoc.tenKhoaHoc}</span></li>
                            <li><i class="fas fa-chalkboard-teacher"></i><span class="info-label">Giáo viên:</span> <span class="info-value">${lopHoc.tenGiaoVien}</span></li>
                            <li><i class="fas fa-users"></i><span class="info-label">Sĩ số:</span> <span class="info-value">${lopHoc.siSo} / ${lopHoc.siSoToiDa} (Tối thiểu: ${lopHoc.siSoToiThieu})</span></li>
                            <li><i class="fas fa-map-marker-alt"></i><span class="info-label">Phòng học:</span> <span class="info-value">${lopHoc.tenPhongHoc}</span></li>
                            <li><i class="fas fa-info-circle"></i><span class="info-label">Trạng thái:</span> <span class="info-value"><span class="badge bg-primary">${lopHoc.trangThai}</span></span></li>
                            <li><i class="fas fa-pen"></i><span class="info-label">Ghi chú:</span> <span class="info-value">${lopHoc.ghiChu}</span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>