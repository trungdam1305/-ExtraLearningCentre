<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${blog.blogTitle}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background-color: #f8f9fa;
        }
        .blog-header-image {
            width: 100%;
            height: 450px;
            object-fit: cover;
            border-radius: 1rem;
        }
        .blog-content-wrapper {
            background-color: #fff;
            border-radius: 1rem;
            box-shadow: 0 8px 25px rgba(0,0,0,0.07);
            margin-top: -80px; /* Kéo nội dung lên trên ảnh một chút */
            position: relative;
            z-index: 10;
        }
        .blog-meta {
            color: #6c757d;
            font-size: 0.9em;
        }
        .blog-meta span {
            margin-right: 1.5rem;
        }
        .blog-title {
            font-weight: 700;
            color: #2c3e50;
        }
        .blog-full-content {
            line-height: 1.8;
            font-size: 1.1em;
            color: #343a40;
        }
        /* Style cho nội dung từ CKEditor */
        .blog-full-content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
    <%-- Có thể include header tại đây --%>

    <div class="container my-5">
        <c:if test="${not empty blog}">
            <div class="row">
                <div class="col-12">
                    <img src="${pageContext.request.contextPath}/${blog.image}" alt="${blog.blogTitle}" class="blog-header-image"/>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="blog-content-wrapper p-4 p-md-5">
                        
                        <h1 class="blog-title mb-3">${blog.blogTitle}</h1>
                        <div class="blog-meta mb-4 pb-3 border-bottom">
                            <span><i class="fas fa-calendar-alt me-2"></i>${blog.formattedDate}</span>
                            <span><i class="fas fa-tag me-2"></i>${blog.phanLoai}</span>
                            <%-- Có thể thêm tác giả ở đây nếu có --%>
                        </div>
                        
                        <div class="blog-full-content mt-4">
                            <%-- Dùng escapeXml="false" để hiển thị HTML từ CKEditor --%>
                            <c:out value="${blog.noiDung}" escapeXml="false" />
                        </div>
                        
                        <div class="mt-5 pt-4 border-top">
                            <strong>Tags:</strong>
                            <c:if test="${not empty blog.keyTag}">
                                <span class="badge bg-primary ms-2">${blog.keyTag}</span>
                            </c:if>
                            <c:if test="${not empty blog.keyWord}">
                                <span class="badge bg-info ms-2">${blog.keyWord}</span>
                            </c:if>
                        </div>
                        
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                 <a href="HomePageBlog" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Quay lại trang Blog</a>
            </div>

        </c:if>

        <c:if test="${empty blog}">
            <div class="text-center p-5">
                <h2>Không tìm thấy bài viết</h2>
                <p class="lead">Bài viết bạn yêu cầu không tồn tại hoặc đã bị xóa.</p>
                <a href="HomePageBlog" class="btn btn-primary mt-3">Quay lại trang Blog</a>
            </div>
        </c:if>
    </div>

    <%-- Có thể include footer tại đây --%>
</body>
</html>