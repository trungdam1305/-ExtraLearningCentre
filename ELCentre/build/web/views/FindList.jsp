<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách khóa học</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
        <link rel='stylesheet' id='bp-parent-css-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/css/buddypress9d27.css?ver=7.1.0' type='text/css' media='screen' />
        <link rel='stylesheet' id='default-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/style9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-skin-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/skins/dark-blue/style9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-gutenberg-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/css/gutenbergd7b7.css?ver=4.3' type='text/css' media='all' />
        <link rel='stylesheet' id='dt-sc-css-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/designthemes-core-features/shortcodes/css/shortcodes9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='layerslider-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/LayerSlider/assets/static/layerslider/css/layersliderce67.css?ver=6.11.2' type='text/css' media='all' />
        <link rel='stylesheet' id='ls-google-fonts-css' href='https://fonts.googleapis.com/css?family=Lato:100,300,regular,700,900%7COpen+Sans:300%7CIndie+Flower:regular%7COswald:300,regular,700&amp;subset=latin%2Clatin-ext' type='text/css' media='all' />
        <link rel='stylesheet' id='wp-block-library-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-includes/css/dist/block-library/style.min9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='bbp-default-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/bbpress/templates/default/css/bbpress.mind7ad.css?ver=2.6.6' type='text/css' media='all' />
        <link rel='stylesheet' id='contact-form-7-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/contact-form-7/includes/css/styles9dff.css?ver=5.3.2' type='text/css' media='all' />
        <link rel='stylesheet' id='resmap-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/responsive-maps-plugin/includes/css/resmap.min4906.css?ver=4.7' type='text/css' media='all' />
        <link rel='stylesheet' id='wp-postratings-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/wp-postratings/css/postratings-css40d5.css?ver=1.89' type='text/css' media='all' />
        <link rel='stylesheet' id='woocommerce_prettyPhoto_css-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/plugins/woocommerce/assets/css/prettyPhoto9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-shortcode-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/css/shortcode9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-responsive-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/css/responsive9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-woo-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/framework/woocommerce/css/style9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='guru-sensei-css' href='${pageContext.request.contextPath}/dtguru.wpenginepowered.com/wp-content/themes/guru/sensei/css/style9704.css?ver=6.7.1' type='text/css' media='all' />
        <link rel='stylesheet' id='mytheme-google-fonts-css' href='https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|Droid+Serif:400,400italic,700,700italic|Pacifico|Patrick+Hand|Crete+Round:400' type='text/css' media='all' />


        <style id='classic-theme-styles-inline-css' type='text/css'>
            /*! This file is auto-generated */
            .wp-block-button__link{
                color:#fff;
                background-color:#32373c;
                border-radius:9999px;
                box-shadow:none;
                text-decoration:none;
                padding:calc(.667em + 2px) calc(1.333em + 2px);
                font-size:1.125em
            }
            .wp-block-file__button{
                background:#32373c;
                color:#fff;
                text-decoration:none
            }
        </style>

        <style>
            table {
                margin-left: 0; /* Remove any left margin */
                width: auto; /* Adjust width to fit content */
            }

            td {
                padding: 5px 10px; /* Reduced padding for a tighter layout */
            }

            select {
                margin-right: 5px; /* Small spacing between elements */
            }


            #id {
                width: 120px;  /* Adjust the width value as needed */
            }

            .pagination {
                margin-top: 20px;
                text-align: right; /* Đưa các nút sang phải */
            }

            .pagination a {
                display: inline-block;
                padding: 8px 12px;
                margin-left: 5px;
                background-color: #007bff; /* Màu nền */
                color: white;
                border-radius: 4px;
                text-decoration: none;
                transition: background-color 0.3s;
                font-weight: bold;
            }

            .pagination a:hover {
                background-color: #0056b3; /* Màu hover */
            }

            .pagination a.active {
                background-color: #28a745; /* Màu nền của trang đang chọn */
                pointer-events: none; /* Không cho click lại */
                cursor: default;
            }

        </style>
    </head>

    <body>
        <div class="main-content">
            <!-- Header -->
            <jsp:include page="Home-Header.jsp"></jsp:include>


           
                <!-- Bộ lọc sắp xếp -->
                <form action="Sort" method="get" id="filterForm">
                    <table>
                        <tr>
                            <td>Sắp xếp theo ID:</td>
                            <td>
                                <select name="sortId" onchange="document.getElementById('filterForm').submit();">
                                    <option value="ASC" ${param.sortId == 'ASC' ? 'selected' : ''}>Tăng dần</option>
                                <option value="DES" ${param.sortId == 'DES' ? 'selected' : ''}>Giảm dần</option>
                            </select>
                        </td>

                        <td>Sắp xếp theo tên:</td>
                        <td>
                            <select name="sortName" onchange="document.getElementById('filterForm').submit();">
                                <option value="ASC" ${param.sortName == 'ASC' ? 'selected' : ''}>A-Z</option>
                                <option value="DES" ${param.sortName == 'DES' ? 'selected' : ''}>Z-A</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </form>

            <!-- Thêm mới -->
            <form action="AddCourse.jsp" method="get" style="margin-top: 10px;">
                <input type="submit" value="Thêm khóa học mới" />
            </form>

            <!-- Tìm kiếm -->
            <form action="SearchCourse" method="get" style="margin-top: 10px;">
                Tìm kiếm: 
                <input type="text" name="keyword" placeholder="Nhập tên hoặc ID khóa học" />
                <input type="submit" value="Tìm" />
            </form>

            <h3 style="margin-top: 20px;">Danh sách khóa học</h3>

            <%
    int pageSize = 10; // Số lượng khóa học trên mỗi trang
    int pageNumber = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int offset = (pageNumber - 1) * pageSize;

    List<KhoaHoc> khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
    request.setAttribute("defaultCourses", khoaHocList);

    // Lấy tổng số khóa học để tính số trang
    int totalCourses = KhoaHocDAO.getTotalCourses(); // Phương thức này cần được tạo trong DAO
    int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

    // Đặt biến vào request scope để JSTL sử dụng
    request.setAttribute("pageNumber", pageNumber);
    request.setAttribute("totalPages", totalPages);

    // In ra giá trị để kiểm tra (debug)
    System.out.println("Page Number: " + pageNumber);
    System.out.println("Total Pages: " + totalPages);
            %>

            <!-- Danh sách khóa học -->
            <table border="1" cellpadding="8" cellspacing="0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên khóa học</th>
                        <th>Mô tả</th>
                        <th>Ngày bắt đầu</th>
                        <th>Ngày kết thúc</th>
                        <th>Ghi chú</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty requestScope.list}">
                            <c:forEach var="course" items="${defaultCourses}">
                                <tr>
                                    <td>${course.getID_KhoaHoc()}</td>
                                    <td>${course.getTenKhoaHoc()}</td>
                                    <td>${course.getMoTa()}</td>
                                    <td>${course.getThoiGianBatDau()}</td>
                                    <td>${course.getThoiGianKetThuc()}</td>
                                    <td>${course.getGhiChu()}</td>
                                    <td>${course.getTrangThai()}</td>
                                    <td>${course.getNgayTao()}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="course" items="${requestScope.list}">
                                <tr>
                                    <td>${course.getID_KhoaHoc()}</td>
                                    <td>${course.getTenKhoaHoc()}</td>
                                    <td>${course.getMoTa()}</td>
                                    <td>${course.getThoiGianBatDau()}</td>
                                    <td>${course.getThoiGianKetThuc()}</td>
                                    <td>${course.getGhiChu()}</td>
                                    <td>${course.getTrangThai()}</td>
                                    <td>${course.getNgayTao()}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- Phân trang -->
            <div class="pagination">
                <c:if test="${pageNumber > 1}">
                    <a href="?page=${pageNumber - 1}">« Previous</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="?page=${i}" class="${i == pageNumber ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${pageNumber < totalPages}">
                    <a href="?page=${pageNumber + 1}">Next »</a>
                </c:if>
            </div>

        </div>
    </body>
    <jsp:include page="Home-Footer.jsp"></jsp:include>
</html>