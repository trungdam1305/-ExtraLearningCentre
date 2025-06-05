<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách khóa học</title>
    </head>

    <style>
        table.c {
            width: auto;
            margin-left: auto;
            margin-right: 0;
            border-collapse: collapse;
            background-color: transparent;
        }

        table.c td {
            border: none;
            padding: 0 10px 0 0;
            vertical-align: middle;
        }

        table.c form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0;
        }

        table.c label {
            color: #1F4E79;
            margin: 0;
            font-size: 16px;
        }

        table.c input[type="text"],
        table.c select {
            padding: 8px;
            font-size: 16px;
            border: 1px solid #d0d7de;
            border-radius: 5px;
            background-color: #ffffff;
        }

        table.c input[type="submit"],
        table.c button {
            background-color: #1F4E79;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        table.c button {
            margin-top: 10px;
        }

        table.c input[type="submit"]:hover,
        table.c button:hover {
            background-color: #163b5c;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            color: #333;
            padding: 20px;
        }

        h1 {
            color: #1F4E79;
            margin-top: 20px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }

        th {
            background-color: #1F4E79;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        button {
            background-color: #1F4E79;
            color: white;
            border: none;
            padding: 6px 10px;
            margin: 2px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }

        button:hover {
            background-color: #163c5b;
        }

        .pagination {
            margin-left: auto; /* Đẩy phân trang sang phải */
            margin-right: 0; /* Đảm bảo sát lề phải */
            margin-top: 15px;
            width: auto; /* Chỉ chiếm không gian cần thiết */
            display: flex; /* Sử dụng flex để sắp xếp các liên kết */
            justify-content: flex-end; /* Căn phải các liên kết */
        }

        .pagination a {
            display: inline-block;
            padding: 8px 14px;
            margin: 0 4px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 6px;
            text-decoration: none;
            color: #007bff;
            background-color: #f8f9fa;
            transition: background-color 0.3s, color 0.3s;
        }

        .pagination a:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination a[style*="font-weight:bold"] {
            background-color: #007bff;
            color: white !important;
            border-color: #007bff;
            font-weight: bold;
        }

        .u {
            display: flex;
            justify-content: center;
            margin-top: 15px;
        }

        .u button {
            background-color: #1F4E79;
            color: white;
            border: none;
            padding: 15 px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .u button:hover {
            background-color: #163b5c;
        }

        body {
            padding: 20px;
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
            color: #333;
        }

        table {
            table {
                width: 100%;
                margin: 0 auto;
                border-collapse: collapse;
                table-layout: fixed; /* vẫn giữ để chia đều cột */
                background-color: #fff;
            }

            th, td {
                padding: 8px 12px;
                border: 1px solid #ccc;
                text-align: center;

                /* CHỈNH QUAN TRỌNG: */
                white-space: normal;           /* Cho phép xuống dòng */
                word-wrap: break-word;         /* Ngắt từ nếu quá dài */
                overflow-wrap: break-word;     /* Ngắt từ hiện đại hơn */
            }


            .col-id {
                width: 60px;
            }
            .col-name {
                width: 180px;
            }
            .col-desc {
                width: 250px;
            }
            .col-date {
                width: 145px;
            }
            .col-status {
                width: 130px;
            }
            .col-actions {
                width: 200px;
            }
            .col-idkhoi {
                width: 100px
            }


        </style>

        <script>


            function confirmDeleteAndRedirect(url) {
                if (confirm('Bạn có chắc muốn xóa khóa học này không?')) {
                    window.location.href = url;
                }
                return false; // chặn hành động mặc định
            }
        </script>    


        <h1>Trang quản lý khóa học</h1>

        <table class="c">
            <tr>
                <td><!-- Tìm kiếm -->
                    <form action="${pageContext.request.contextPath}/SearchCourse" method="get">
                        <label for="course">Tìm kiếm theo tên:</label>
                        <select name="name" id="course" required>
                            <option value="" disabled ${searchName == null ? "selected" : ""}>Chọn môn học</option>
                            <option value="Toán" ${"Toán".equals(searchName) ? "selected" : ""}>Toán</option>
                            <option value="Ngữ văn" ${"Ngữ văn".equals(searchName) ? "selected" : ""}>Ngữ văn</option>
                            <option value="Vật lý" ${"Vật lý".equals(searchName) ? "selected" : ""}>Vật lý</option>
                            <option value="Hóa học" ${"Hóa học".equals(searchName) ? "selected" : ""}>Hóa học</option>
                            <option value="Sinh học" ${"Sinh học".equals(searchName) ? "selected" : ""}>Sinh học</option>
                            <option value="Tin học" ${"Tin học".equals(searchName) ? "selected" : ""}>Tin học</option>
                            <option value="Lịch sử" ${"Lịch sử".equals(searchName) ? "selected" : ""}>Lịch sử</option>
                            <option value="Địa lý" ${"Địa lý".equals(searchName) ? "selected" : ""}>Địa lý</option>
                            <option value="Giáo dục công dân" ${"Giáo dục công dân".equals(searchName) ? "selected" : ""}>Giáo dục công dân</option>
                            <option value="Tiếng Anh" ${"Tiếng Anh".equals(searchName) ? "selected" : ""}>Tiếng Anh</option>
                            <option value="Công nghệ" ${"Công nghệ".equals(searchName) ? "selected" : ""}>Công nghệ</option>
                            <option value="Thể dục" ${"Thể dục".equals(searchName) ? "selected" : ""}>Thể dục</option>
                            <option value="Âm nhạc" ${"Âm nhạc".equals(searchName) ? "selected" : ""}>Âm nhạc</option>
                            <option value="Mỹ thuật" ${"Mỹ thuật".equals(searchName) ? "selected" : ""}>Mỹ thuật</option>
                            <option value="Quốc phòng và An ninh" ${"Quốc phòng và An ninh".equals(searchName) ? "selected" : ""}>Quốc phòng và An ninh</option>
                        </select>
                        <input type="submit" value="Tìm" />
                    </form>
                </td>
                <td> <!-- Bộ lọc sắp xếp -->
                    <form action="${pageContext.request.contextPath}/Sort" method="get" id="filterForm">
                        <input type="hidden" name="page" value="${pageNumber}" />
                        <td>Sắp xếp theo: </td>
                        <td>
                            <select name="sortName" onchange="document.getElementById('filterForm').submit();">
                                <option value="" ${param.sortName == null || param.sortName.isEmpty() ? "selected" : ""}>-- Mặc định --</option>
                                <option value="ASC" ${"ASC".equals(param.sortName) ? "selected" : ""}>Tên tăng dần</option>
                                <option value="DESC" ${"DESC".equals(param.sortName) ? "selected" : ""}>Tên giảm dần</option>
                                <option value="DESCTrang" ${"DESCTrang".equals(param.sortName) ? "selected" : ""}>Trạng thái chưa hoạt động</option>
                                <option value="ASCTrang" ${"ASCTrang".equals(param.sortName) ? "selected" : ""}>Trạng thái đang hoạt động</option>
                            </select>
                        </td>
                    </form>
                </td>
                <td>  <!-- Thêm mới -->
                    <button style="margin-top: 2px" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/views/AddCourse.jsp'">
                            Thêm khóa học mới
                        </button>
                    </td>
                </tr>
            </table>









            <%
        int pageSize = 10;
        int pageNumber = 1;
        try {
         pageNumber = Integer.parseInt(request.getParameter("page"));
         if (pageNumber < 1) pageNumber = 1;
        } catch (Exception e) {
         pageNumber = 1;
        }

        int offset = (pageNumber - 1) * pageSize;
        String sortName = request.getParameter("sortName");

        List<KhoaHoc> khoaHocList;
        int totalCourses = 0;

        if (sortName != null && !sortName.isEmpty()) {
         if ("ASCTrang".equalsIgnoreCase(sortName)) {
             // "Đang hoạt động"
             khoaHocList = KhoaHocDAO.getCoursesByTrangThai("active", offset, pageSize);
             totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai("active");
         } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
             // "Chưa hoạt động"
             khoaHocList = KhoaHocDAO.getCoursesByTrangThai("inactive", offset, pageSize);
             totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai("inactive");
         } else if ("ASC".equalsIgnoreCase(sortName) || "DESC".equalsIgnoreCase(sortName)) {
             // Sắp xếp theo tên
             khoaHocList = KhoaHocDAO.getSortedKhoaHoc(offset, pageSize, sortName);
             totalCourses = KhoaHocDAO.getTotalCourses();
         } else {
             // Mặc định fallback
             khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
             totalCourses = KhoaHocDAO.getTotalCourses();
         }
        } else {
         // Mặc định không sort
         khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
         totalCourses = KhoaHocDAO.getTotalCourses();
        }

        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

        request.setAttribute("defaultCourses", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortName", sortName);
            %>




            <div>
                <%String err = (String) request.getAttribute("err");%>
                <%if (err != null){%>
                <span style="color:red;"><%= err%></span>
            <%}%>
            <c:if test="${param.message == 'deleted'}">
                <p style="color: green;">Xóa khóa học thành công!</p>
            </c:if>
        </div>

        <!-- Nút lọc hiển thị các khóa học "chưa bắt đầu" -->


        <!-- Danh sách khóa học -->

        <p>Tổng số khóa học: <%= totalCourses %>.   &nbsp;&nbsp;      &nbsp; Tổng số trang: <%= totalPages %>.</p>
        <p></p>

        <table>
            <thead>
                <tr>
                    <th class="col-id">ID</th>
                    <th class="col-name">Tên khóa học</th>
                    <th class="col-desc">Mô tả</th>
                    <th class="col-date">Ngày bắt đầu</th>
                    <th class="col-date">Ngày kết thúc</th>
                    <th class="col-note">Ghi chú</th>
                    <th class="col-status">Trạng thái</th>
                    <th class="col-date">Ngày tạo</th>
                    <th class="col-idkhoi">ID Khối</th> <!-- Thêm cột mới -->
                    <th class="col-action">Action</th>
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
                                <td>${course.thoiGianBatDauFormatted}</td>
                                <td>${course.thoiGianKetThucFormatted}</td>

                                <td>${course.getGhiChu()}</td>
                                <td>${course.getTrangThai()}</td>
                                <td>${course.getNgayTaoFormatted()}</td>
                                <td>${course.getID_Khoi()}</td> <!-- Hiển thị ID_Khoi -->
                                <td>
                                    <button type="button" onclick="return confirmDeleteAndRedirect('${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.ID_KhoaHoc}')">DELETE</button>
                                    <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_Khoi=${course.ID_Khoi}'">View</button>
                                    <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=UpdateCourse&ID_KhoaHoc=${course.ID_KhoaHoc}'">Update</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="course" items="${requestScope.list}">
                            <tr>
                                <td>${course.getID_KhoaHoc()}</td>
                                <td>${course.getTenKhoaHoc()}</td>
                                <td>${course.getMoTa()}</td>
                                <td>${course.thoiGianBatDauFormatted}</td>
                                <td>${course.thoiGianKetThucFormatted}</td>

                                <td>${course.getGhiChu()}</td>
                                <td>${course.getTrangThai()}</td>
                                <td>${course.getNgayTaoFormatted()}</td>
                                <td>${course.getID_Khoi()}</td> <!-- Hiển thị ID_Khoi -->
                                <td>
                                    <button type="button" onclick="return confirmDeleteAndRedirect('${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.ID_KhoaHoc}')">DELETE</button>
                                 <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_Khoi=${course.ID_Khoi}'">View</button>
                                    <button on  click="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=UpdateCourse&ID_KhoaHoc=${course.ID_KhoaHoc}'">Update</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- Phân trang -->
        <div class="pagination" style="margin-top: 15px;">
            <c:if test="${pageNumber > 1}">
                <a href="${pageContext.request.contextPath}/Sort?page=${pageNumber - 1}&sortName=${sortName}">« Trước</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="${pageContext.request.contextPath}/Sort?page=${i}&sortName=${sortName}"
                   style="margin: 0 3px;
                   text-decoration: none; ${i == pageNumber ? 'font-weight:bold; color:red;' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <c:if test="${pageNumber < totalPages}">
                <a href="${pageContext.request.contextPath}/Sort?page=${pageNumber + 1}&sortName=${sortName}">Tiếp »</a>
            </c:if>
        </div>
        <div class="u">
            <form action="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp" method="get">
                <button type="submit">Quay lại dashboard</button>
            </form>
        </div>


    </body>
</html>
