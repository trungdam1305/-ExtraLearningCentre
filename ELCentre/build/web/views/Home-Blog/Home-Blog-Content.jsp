<%-- 
    Document   : Home-Blog-Content
    Created on : Jun 23, 2025, 11:31:53 AM
    Author     : admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .equal-height {
            height: 65%;
        }

        .blog-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fff;
        }

        .blog-img {
            width: 100%;
            height: 150px;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #adb5bd;
            font-size: 24px;
            border-radius: 8px;
            object-fit: cover;
        }

        .blog-meta {
            font-size: 14px;
            color: #6c757d;
        }

        .blog-heading {
            font-weight: bold;
            margin: 5px 0;
        }

        .read-more {
            font-weight: 500;
            color: #0d6efd;
            text-decoration: none;
        }

        .read-more:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container py-5">

    <!-- Header -->
    <div class="text-center mb-4">
        <h5 class="mb-1">Blog của chúng tôi</h5>
        <p class="text-muted"></p>

        <!-- Navigation Bar -->
        <form class="row justify-content-center g-2 my-4" method="get" action="HomePageBlog">
            <div class="col-md-3 col-sm-12">
                <select class="form-select" name="category">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="dm" items="${danhMucList}">
                        <option value="${dm.ID_PhanLoai}" ${dm.ID_PhanLoai == category ? "selected" : ""}>
                            ${dm.phanLoai}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-4 col-sm-12">
                <div class="input-group">
                    <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm..." value="${keyword}">
                    <button class="btn btn-primary" type="submit" style="height:46.6px">
                        <i class="fas fa-search text-white"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Blog Items -->
    <c:forEach var="blog" items="${blogs}">
        <div class="blog-box row align-items-center blog-item" data-category="${blog.ID_PhanLoai}" data-date="${blog.blogDate}">
            <!-- image -->
            <div class="col-md-4">
                <img src="${pageContext.request.contextPath}/img/avatar/${blog.image}" 
                     alt="Blog Image" 
                     class="img-fluid rounded blog-img" 
                     style="height: 200px; width: 100%;" />
            </div>

            <!-- content -->
            <div class="col-md-8">
                <!-- Ngày tạo -->
                <div class="blog-meta mb-1 text-muted">
                    <i class="far fa-calendar-alt me-1"></i>
                    ${blog.formattedDate}
                </div>

                <!-- title -->
                <h5 class="blog-heading mb-1">${blog.blogTitle}</h5>

                <!-- description -->
                <p class="mb-2">${blog.blogDescription}</p>

                <!-- Phân loại -->
                <span class="badge bg-secondary me-2 text-white">${blog.phanLoai}</span>

                <!-- view detail -->
                <a href="blog-detail.jsp?id=${blog.ID_Blog}" class="read-more">Đọc thêm →</a>
            </div>
        </div>
    </c:forEach>

    <!-- Pagination -->
    <nav aria-label="Blog pagination">
        <ul class="pagination justify-content-center mt-4">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link"
                       href="HomePageBlog?page=${i}&sort=${sort}&keyword=${keyword}">
                        ${i}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </nav>

</div>

<!-- JS Filter Category -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const filterSelect = document.getElementById("categoryFilter");
        const blogItems = document.querySelectorAll(".blog-item");

        filterSelect.addEventListener("change", function () {
            const selectedCategory = this.value.trim();

            blogItems.forEach(item => {
                const itemCategory = item.getAttribute("data-category").trim();

                if (!selectedCategory || itemCategory === selectedCategory) {
                    item.style.display = "flex"; // 
                } else {
                    item.style.display = "none";
                }
            });
        });
    });
</script>
<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


