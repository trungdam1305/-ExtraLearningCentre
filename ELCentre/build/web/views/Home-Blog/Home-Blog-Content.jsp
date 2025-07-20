<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        /* ✅ ÁP DỤNG FONT CHỮ CHO TOÀN BỘ TRANG */
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
        }

        .equal-height {
            height: 65%;
        }

        .blog-box {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fff;
            transition: box-shadow 0.3s ease-in-out;
        }
        .blog-box:hover {
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .blog-img {
            width: 100%;
            height: 200px; /* Tăng chiều cao ảnh cho cân đối */
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
            font-weight: 700; /* Tăng độ đậm cho tiêu đề */
            margin: 10px 0;
            color: #212529;
        }

        .read-more {
            font-weight: 700;
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

    <div class="text-center mb-4">
        <h2 class="fw-bold" style="font-family: 'Times New Roman', Times, serif;">Bài viết của chúng tôi</h2>
        <p class="text-muted">Cập nhật những tin tức và kiến thức mới nhất</p>

        <form class="row justify-content-center g-3 my-4" method="get" action="HomePageBlog">
            <div class="col-md-3 col-sm-12">
                <select class="form-select form-select-lg" name="category">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="dm" items="${danhMucList}">
                        <option value="${dm.ID_PhanLoai}" ${dm.ID_PhanLoai == param.category ? "selected" : ""}>
                            ${dm.phanLoai}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-md-4 col-sm-12">
                <div class="input-group input-group-lg">
                    <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm bài viết..." value="${param.keyword}">
                    <button class="btn btn-primary" type="submit" style="height: 60% ">
                        <i class="fas fa-search" ></i>
                    </button>
                </div>
            </div>
        </form>
    </div>

    <div class="row">
        <c:if test="${empty blogs}">
            <p class="text-center">Không tìm thấy bài viết nào phù hợp.</p>
        </c:if>
        
        <c:forEach var="blog" items="${blogs}">
             <div class="col-lg-6">
                <div class="blog-box row g-0">
                    <div class="col-md-5">
                        <img src="${pageContext.request.contextPath}/img/blog_images/${blog.image}" 
                             alt="Blog Image" 
                             class="blog-img" />
                    </div>

                    <div class="col-md-7 d-flex flex-column p-3">
                        <div class="blog-meta mb-2 text-muted">
                            <i class="far fa-calendar-alt me-1"></i>
                            ${blog.formattedDate}
                        </div>
                        
                        <h5 class="blog-heading mb-2">${blog.blogTitle}</h5>
                        
                        <p class="mb-3 text-muted" style="flex-grow: 1; font-size: 0.9em;">${blog.blogDescription}</p>
                        
                        <div>
                             <span class="badge bg-secondary me-2 text-white">${blog.phanLoai}</span>
                             <a href="BlogDetailServlet?id=${blog.ID_Blog}" class="read-more">Đọc thêm →</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <nav aria-label="Blog pagination">
        <ul class="pagination justify-content-center mt-4">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <c:url value="HomePageBlog" var="pageUrl">
                        <c:param name="page" value="${i}" />
                        <c:if test="${not empty param.sort}"><c:param name="sort" value="${param.sort}" /></c:if>
                        <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
                        <c:if test="${not empty param.category}"><c:param name="category" value="${param.category}" /></c:if>
                    </c:url>
                    <a class="page-link" href="${pageUrl}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
<a href="#" id="toTop" style="display: none;"><span id="toTopHover"></span>To Top</a><div id="extension-mmplj"></div></body>
</body>
</html>


