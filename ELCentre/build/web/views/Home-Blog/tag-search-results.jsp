<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Kết quả cho tag: ${selectedTag}</title>
    </head>
<body>
    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Các bài viết với chủ đề: "${selectedTag}"</h2>
        </div>

        <div class="row">
            <c:if test="${empty blogs}">
                <p class="text-center">Không tìm thấy bài viết nào phù hợp.</p>
            </c:if>
            
            <c:forEach var="blog" items="${blogs}">
                <div class="col-lg-6">
                    <div class="blog-box row g-0">
                        <a href="blog-detail?id=${blog.ID_Blog}" class="read-more">Đọc thêm →</a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <nav aria-label="Blog pagination">
            <ul class="pagination justify-content-center mt-4">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="search-by-tag?tag=${selectedTag}&page=${i}">${i}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</body>
</html>