<%-- Thêm thư viện 'fmt' để định dạng ngày tháng --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
        }
        .detail-card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .detail-header-image {
            width: 50%;
            height: 400px;
            object-fit: cover;
        }
        .detail-content {
            padding: 2rem 2.5rem;
        }
        .detail-title {
            font-weight: 700;
            color: #2c3e50;
        }
        .info-table td {
            padding: 0.75rem 0;
            border-bottom: 1px solid #e9ecef;
        }
        .info-table td:first-child {
            font-weight: 500;
            color: #6c757d;
            width: 30%;
        }
        .download-button {
            font-weight: 700;
            padding: 12px 30px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="detail-card">
                <c:if test="${not empty material}">
                    <img src="${pageContext.request.contextPath}/${material.image}" 
                         alt="${material.tenTaiLieu}" class="detail-header-image" style="display: block; margin-left: auto; margin-right: auto;"/>

                    <div class="detail-content">
                        <h1 class="detail-title mb-4" style="font-family: 'Times New Roman', Times, serif;" >${material.tenTaiLieu}</h1>

                        <table class="table table-borderless info-table">
                            <tbody>
                                <tr>
                                    <td>Môn học</td>
                                    <td><strong>${material.monHoc}</strong></td>
                                </tr>
                                <tr>
                                    <td>Loại tài liệu</td>
                                    <td><strong>${material.loaiTaiLieu}</strong></td>
                                </tr>
                                <tr>
                                    <td>Giá</td>
                                    <td><strong class="text-danger">${material.giaTien}</strong></td>
                                </tr>
                                </tbody>
                        </table>
                        
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/${material.duongDan}" 
                               class="btn btn-primary download-button" 
                               download>

                                <i class="fas fa-download"></i> Tải Về Tài Liệu
                            </a>
                             <a href="HomePageMaterial" class="btn btn-outline-secondary ms-2">Quay lại danh sách</a>
                        </div>
                    </div>

                </c:if>
                <c:if test="${empty material}">
                    <div class="p-5 text-center">
                        <h2>Không tìm thấy tài liệu</h2>
                        <p class="lead">Tài liệu bạn yêu cầu không tồn tại hoặc đã bị xóa.</p>
                        <a href="HomePageMaterial" class="btn btn-primary mt-3">Quay lại danh sách</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>