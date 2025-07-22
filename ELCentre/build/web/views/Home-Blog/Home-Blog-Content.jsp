<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body { font-family: 'Be Vietnam Pro', sans-serif; }
        .blog-box {
            border: 1px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            background-color: #fff;
            transition: box-shadow 0.3s ease-in-out;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .blog-box:hover { box-shadow: 0 8px 25px rgba(0,0,0,0.08); }
        .blog-img { width: 100%; height: 200px; object-fit: cover; border-radius: 8px; }
        .blog-content { flex-grow: 1; display: flex; flex-direction: column; }
        .blog-description { flex-grow: 1; }
        .blog-heading { font-weight: 700; margin: 10px 0; color: #212529; }
        .read-more { font-weight: 700; color: #0d6efd; text-decoration: none; }
        .read-more:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container py-5">

    <div class="text-center mb-4">
        <h2 class="fw-bold">Bài viết của chúng tôi</h2>
        <p class="text-muted">Cập nhật những tin tức và kiến thức mới nhất</p>
    </div>
    
    <form class="row justify-content-center g-3 my-4" method="get" action="HomePageBlog">
        <div class="col-md-4">
            <select class="form-select" name="keywordId">
                <option value="0">Lọc theo từ khóa...</option>
                <c:forEach var="kw" items="${allKeywords}">
                    <option value="${kw.ID_Keyword}" ${kw.ID_Keyword == selectedKeywordId ? "selected" : ""}>
                        ${kw.keyword}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4">
            <select class="form-select" name="keytagId">
                <option value="0">Lọc theo thẻ...</option>
                <c:forEach var="kt" items="${allKeytags}">
                    <option value="${kt.ID_KeyTag}" ${kt.ID_KeyTag == selectedKeytagId ? "selected" : ""}>
                        ${kt.keyTag}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" type="submit">Lọc</button>
        </div>
    </form>
    <div class="row">
        <c:if test="${empty blogs}">
            <div class="col-12">
                <p class="text-center fs-5 text-muted mt-5">Không tìm thấy bài viết nào phù hợp.</p>
            </div>
        </c:if>
        
        <c:forEach var="blog" items="${blogs}">
             <div class="col-lg-6 mb-4">
                <div class="blog-box row g-0">
                    <div class="col-md-5">
                        <img src="${pageContext.request.contextPath}/${blog.image}" 
                             alt="Blog Image" 
                             class="blog-img" />
                    </div>
                    <div class="col-md-7 d-flex flex-column p-3">
                        <div class="blog-content">
                             <div class="mb-2 text-muted small">
                                <i class="far fa-calendar-alt me-1"></i> ${blog.formattedDate}
                            </div>
                            <h5 class="blog-heading">${blog.blogTitle}</h5>
                            <p class="text-muted mb-3 blog-description" style="font-size: 0.9em;">${blog.blogDescription}</p>
                            <div>
                                <span class="badge bg-success me-2" ><a href="${pageContext.request.contextPath}/HomePageBlog?keywordId=${blog.getID_Keyword()}&keytagId=0" class="text-decoration-none text-white">  ${blog.keyWord}</a> </span>
                                <span class="badge bg-info text-dark me-2"><a href="${pageContext.request.contextPath}/HomePageBlog?keywordId=0&keytagId=${blog.getID_KeyTag()}"  class="text-decoration-none text-white">${blog.keyTag}</a></span>
                                <div style="margin-top:10px"><a href="BlogDetailServlet?id=${blog.ID_Blog}" class="read-more float-end">Đọc thêm →</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <nav aria-label="Blog pagination" class="mt-5">
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <c:url value="HomePageBlog" var="pageUrl">
                        <c:param name="page" value="${i}" />
                        <c:if test="${selectedKeywordId > 0}"><c:param name="keywordId" value="${selectedKeywordId}" /></c:if>
                        <c:if test="${selectedKeytagId > 0}"><c:param name="keytagId" value="${selectedKeytagId}" /></c:if>
                    </c:url>
                    <a class="page-link" href="${pageUrl}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>