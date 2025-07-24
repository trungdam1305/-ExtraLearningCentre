<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Tài liệu</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        body, h1, h2, h3, h4, h5, h6, p, a, span, li, button, input, select, label {
            font-family: 'Be Vietnam Pro', sans-serif !important;
        }
    </style>
    
</head>

<body class="bp-legacy page-template-default page page-id-2385 page-child parent-pageid-45 wp-embed-responsive theme-guru woocommerce-js tribe-js js">
    <div id="yith-wcwl-popup-message" style="display: none;">
        <div id="yith-wcwl-message"></div>
    </div>

    <div class="content">
        <div class="container">
            <section class="with-left-sidebar" id="primary">
                <div class="woocommerce columns-4">

                    <ul class="products columns-4" style="display: flex; flex-wrap: wrap; padding: 10px; list-style: none;">      
                        <c:if test="${empty listTaiLieu}">
                            <p style="width: 100%; text-align: center;">Không tìm thấy tài liệu nào phù hợp.</p>
                        </c:if>
                        <!--Show brief information about Material-->
                        <c:forEach var="taiLieu" items="${listTaiLieu}">
                            <li class="post product type-product" 
                                style="flex: 0 0 25%; 
                                       border: 1px solid #e0e0e0; 
                                       border-radius: 8px; 
                                       overflow: hidden; 
                                       background-color: #ffffff;
                                       box-shadow: 0 4px 8px rgba(0,0,0,0.05);
                                       display: flex;
                                       flex-direction: column;">

                                <div class="product-wrapper" style="display: flex; flex-direction: column; height: 100%;">
                                    
                                    <div class="product-thumb">
                                        <a href="material-detail?id=${taiLieu.ID_Material}">
                                            <img src="${pageContext.request.contextPath}/${taiLieu.image}" 
                                                 alt="${taiLieu.tenTaiLieu}"
                                                 style="width: 100%; height: 200px; object-fit: cover; border-bottom: 1px solid #e0e0e0;" />
                                        </a>
                                    </div>
                                    <div class="product-title" style="padding: 15px; flex-grow: 1;">
                                        <h2 class="woocommerce-loop-product__title" style="font-size: 1.1em; margin: 0; line-height: 1.4; font-weight: 700;">
                                            <a href="material-detail?id=${taiLieu.ID_Material}" style="text-decoration: none; color: #333;">${taiLieu.tenTaiLieu}</a>
                                        </h2>
                                    </div>
                                    <div class="product-details" style="padding: 0 15px 15px 15px; border-top: 1px solid #f5f5f5;">
                                        <p style="margin: 8px 0; font-size: 0.9em; color: #555;"><b>Môn học:</b> ${taiLieu.monHoc}</p>
                                        <p style="margin: 8px 0; font-size: 0.9em; color: red;"><b>Loại:</b> ${taiLieu.loaiTaiLieu}</p>
                                        
                                        <span class="price" style="margin-top: 15px; display: block; text-align: center;">
                                            <a href="material-detail?id=${taiLieu.ID_Material}" 
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
                    <!--Pagination-->
                    <div class="pagination" style="width: 100%; text-align: center; margin-top: 40px;">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:url value="HomePageMaterial" var="pageUrl">
                                <c:param name="page" value="${i}" />
                                <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}" /></c:if>
                                <c:if test="${not empty selectedMonHocId}"><c:param name="monHocId" value="${selectedMonHocId}" /></c:if>
                                <c:if test="${not empty selectedLoaiTaiLieuId}"><c:param name="loaiTaiLieuId" value="${selectedLoaiTaiLieuId}" /></c:if>
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
            </section>
            <!--Filter by subject and type of material-->
            <section class="left-sidebar" id="secondary">
                <aside class="widget" style="background-color: #f9f9f9; padding: 20px; border-radius: 8px;">
                    <h3 style="margin-top: 0; font-weight: 700;">Tìm kiếm & Lọc</h3>
                    <form role="search" method="get" action="HomePageMaterial" class="woocommerce-product-search">
                        
                        <label for="search-keyword" style="font-weight: 500; display: block; margin-bottom: 5px;">Tên tài liệu:</label>
                        <input type="search" id="search-keyword" class="search-field" placeholder="Nhập từ khóa..." value="<c:out value='${keyword}'/>" name="keyword" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;">

                        <label for="monHocFilter" style="font-weight: 500; display: block; margin-top: 15px; margin-bottom: 5px;">Môn học:</label>
                        <select id="monHocFilter" name="monHocId" class="course-filter-select" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
                            <option value="">-- Tất Cả Môn Học --</option>
                            <c:forEach var="mh" items="${listMonHoc}">
                                <option value="${mh.ID_MonHoc}" ${mh.ID_MonHoc == selectedMonHocId ? 'selected' : ''}>
                                    ${mh.tenMonHoc}
                                </option>
                            </c:forEach>
                        </select>
                        
                        <label for="loaiTaiLieuFilter" style="font-weight: 500; display: block; margin-top: 15px; margin-bottom: 5px;">Loại tài liệu:</label>
                        <select id="loaiTaiLieuFilter" name="loaiTaiLieuId" class="course-filter-select" style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
                            <option value="">-- Tất Cả Loại Tài Liệu --</option>
                            <c:forEach var="ltl" items="${listLoaiTaiLieu}">
                                <option value="${ltl.ID_LoaiTaiLieu}" ${ltl.ID_LoaiTaiLieu == selectedLoaiTaiLieuId ? 'selected' : ''}>
                                    ${ltl.tenLoaiTaiLieu}
                                </option>
                            </c:forEach>
                        </select>

                        <button type="submit" value="Search" style="margin-top: 20px; width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 5px; font-weight: 700; cursor: pointer; font-size: 1em;">Lọc</button>
                    </form>
                </aside>
            </section>
        </div>
    </div>
    
</body>
</html>


    
