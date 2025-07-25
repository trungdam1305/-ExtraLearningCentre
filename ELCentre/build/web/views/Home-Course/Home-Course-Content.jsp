<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Khóa học</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body, h1, h2, h3, h4, h5, h6, p, a, span, li, button, input, select, label {
            font-family: 'Be Vietnam Pro', sans-serif !important;
        }
    </style>

    </head>
    <!--Content-->
    <body class="bp-legacy page-template-default page page-id-2385 page-child parent-pageid-45 wp-embed-responsive theme-guru woocommerce-js tribe-js js">
        <div id="yith-wcwl-popup-message" style="display: none;">
            <div id="yith-wcwl-message"></div>
        </div>

        <div class="content">
            <div class="container">
                <section class="with-left-sidebar" id="primary">
                    <article id="post-2385" class="post-2385 page type-page status-publish hentry">
                        <!--List of Course -->
                        <div class="woocommerce columns-4">
                            <ul class="products columns-4" style="display: flex; flex-wrap: wrap; ; list-style: none;">
                                <c:if test="${empty khoaHocList}">
                                    <p style="width: 100%; text-align: center;">Không tìm thấy khóa học nào phù hợp.</p>
                                </c:if>
                                <c:forEach var="khoaHoc" items="${khoaHocList}">
                                    <li class="post product type-product"
                                        style="flex: 0 0 25%; 
                                           border: 1px solid #e0e0e0; 
                                           border-radius: 8px; 
                                           overflow: hidden; 
                                           background-color: #ffffff;
                                           box-shadow: 0 4px 8px rgba(0,0,0,0.05);
                                           display: flex;
                                           flex-direction: column;
                                               ">
                                        <div class="product-wrapper" style="display: flex; flex-direction: column; height: 100%;">
                                            <div class="product-thumb">
                                                <a href="${pageContext.request.contextPath}/CourseDetailsServlet?courseId=${khoaHoc.ID_KhoaHoc}">
                                                    <img src="${pageContext.request.contextPath}/${khoaHoc.image}"
                                                         alt="${khoaHoc.tenKhoaHoc}"
                                                         style="width: 100%; height: 200px; object-fit: cover; border-bottom: 1px solid #e0e0e0;" />
                                                </a>
                                            </div>
                                            <div class="product-title" style="padding: 15px; flex-grow: 1;">
                                                <h2 class="woocommerce-loop-product__title" style="font-size: 1.1em; margin: 0; line-height: 1.4; font-weight: 700;">
                                                    <a href="${pageContext.request.contextPath}/CourseDetailsServlet?courseId=${khoaHoc.ID_KhoaHoc}" style="text-decoration: none; color: #333;">
                                                        ${khoaHoc.tenKhoaHoc}
                                                    </a>
                                                </h2>
                                            </div>
                                            <div class="product-details" style="padding: 0 15px 15px 15px; border-top: 1px solid #f5f5f5;">
                                                <p style="font-size: 0.9em; color: #555; height: 55px; overflow: hidden; line-height: 1.5;">
                                                    ${khoaHoc.moTa}
                                                </p>      
                                                <span class="price" style="margin-top: 15px; display: block; text-align: center;">
                                                    <a href="${pageContext.request.contextPath}/CourseDetailsServlet?courseId=${khoaHoc.ID_KhoaHoc}"
                                                       style="text-decoration: none; 
                                                              background-color: #007bff; 
                                                              color: white; 
                                                              padding: 8px 16px; 
                                                              border-radius: 5px; 
                                                              font-weight: 500; 
                                                              font-size: 0.9em;">
                                                        Xem Chi Tiết
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>

                            <div class="pagination" style="width: 100%; text-align: center; margin-top: 40px;">
                                <c:forEach begin="1" end="${totalPage}" var="i">
                                    <c:url value="HomePageCourse" var="pageUrl">
                                        <c:param name="page" value="${i}" />
                                        <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
                                        <c:if test="${not empty param.ID_Khoi}"><c:param name="ID_Khoi" value="${param.ID_Khoi}" /></c:if>
                                    </c:url>
                                    <a href="${pageUrl}"
                                       style="display: inline-block;
                                              margin: 0 5px;
                                              padding: 8px 16px;
                                              background-color: ${i == currentPage ? '#007bff' : '#f0f0f0'};
                                              color: ${i == currentPage ? 'white' : 'black'};
                                              text-decoration: none;
                                              border-radius: 4px;
                                              font-weight: 700;">
                                        ${i}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </article>
                </section>

                <!--Filter and Search Bar-->
                <section class="left-sidebar" id="secondary">
                    <aside class="widget" style="background-color: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                        <h3 style="margin-top: 0; font-weight: 700;">Tìm kiếm & Lọc</h3>
                        <form method="get" action="HomePageCourse">
                            <label for="search-keyword" style="font-weight: 500; display: block; margin-bottom: 5px;">Tên khóa học:</label>
                            <input id="search-keyword" type="text" name="keyword" placeholder="Nhập từ khóa..." value="${param.keyword}" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;"/>
                            <label for="khoi-filter" style="font-weight: 500; display: block; margin-top: 15px; margin-bottom: 5px;">Khối học:</label>
                            <select id="khoi-filter" name="ID_Khoi" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
                                <option value="">-- Tất Cả Khối Học --</option>
                                <c:forEach var="khoi" items="${allKhoi}">
                                    <option value="${khoi.ID_Khoi}" ${param.ID_Khoi == khoi.ID_Khoi ? 'selected' : ''}>
                                        ${khoi.tenKhoi}
                                    </option>
                                </c:forEach>
                            </select>
                            <button type="submit" style="margin-top: 20px; width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 5px; font-weight: 700; cursor: pointer; font-size: 1em;">Lọc</button>
                        </form>
                    </aside>

                            <!--Show number of classes per subject-->                
                    <aside id="woocommerce_product_categories-7" class="widget woocommerce widget_product_categories" style="background-color: #f9f9f9; padding: 20px; border-radius: 8px;">
                        <div class="widget-title">
                            <h3 style="margin-top: 0; font-weight: 700;">Phân loại môn học</h3>
                            <div class="title-sep"><span></span></div>
                        </div>
                        <ul class="product-categories" style="list-style: none; padding-left: 0;">
                            <li>
                                <a href="HomePageCourse" title="Xem tất cả">Tất cả khóa học</a>
                            </li>
                            <c:forEach var="category" items="${subjectCategories}">
                                <c:if test="${category.courseCount > 0}">
                                    <li>
                                        <a href="HomePageCourse?keyword=${category.subjectName}" title="Các khóa học môn ${category.subjectName}">
                                            ${category.subjectName} <span>(${category.courseCount})</span>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </aside>
                </section>
            </div>
        </div>
    </body>

		
</html>
    