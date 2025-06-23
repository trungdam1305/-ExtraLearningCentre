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


        table.c {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 6px;
            overflow: hidden;
        }

        table.c thead {
            background-color: #007bff;
            color: white;
        }

        table.c th, table.c td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 14px;
        }

        table.c tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table.c tbody tr:hover {
            background-color: #eef6ff;
            transition: background-color 0.2s ease-in-out;
        }

        table.c button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 10px;
            margin: 2px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }

        table.c button:hover {
            background-color: #0056b3;
        }

        /* Responsive fix (optional) */
        @media (max-width: 768px) {
            table.c th, table.c td {
                font-size: 12px;
                padding: 8px;
            }

            table.c button {
                padding: 4px 8px;
                font-size: 12px;
            }
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

    <body>
        <form action="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp" method="get" style="margin-top: 10px;">
            <button type="submit">Quay lại dashboard   </button>
        </form>
        <div class="main-content">
            <!-- Bộ lọc sắp xếp -->
            <form action="${pageContext.request.contextPath}/Sort" method="get" id="filterForm">
                <input type="hidden" name="page" value="${pageNumber}" />
                <table>
                    <tr>
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
                    </tr>
                </table>
            </form>



            <!-- Tìm kiếm -->
            <form action="${pageContext.request.contextPath}/SearchCourse" method="get" style="margin-top: 10px;">
                <table>
                    <tr>
                        <td>Tìm kiếm: </td>
                        <td><input type="text" name="name" placeholder="Nhập tên khóa học" required /></td>
                        <td><input type="submit" value="Tìm" /></td>
                    </tr>
                </table>
            </form>

            <!-- Thêm mới -->
            <button type="button" onclick="window.location.href = '${pageContext.request.contextPath}/views/AddCourse.jsp'">
                Thêm khóa học mới
            </button>

            <h3 style="margin-top: 20px;">Danh sách khóa học</h3>

            <%
     int pageSize = 6;
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

            <table border="1" cellpadding="8" cellspacing="0" class="c">
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

                        <th>ID Khối</th> <!-- Thêm cột mới -->
                        <th>Action</th>
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
                                    <td>${course.getNgayTao()}</td>
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
                                    <td>${course.getNgayTao()}</td>
                                    <td>${course.getID_Khoi()}</td> <!-- Hiển thị ID_Khoi -->
                                    <td>
                                        <button type="button" onclick="return confirmDeleteAndRedirect('${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.ID_KhoaHoc}')">DELETE</button>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_KhoaHoc=${course.ID_KhoaHoc}'">View</button>
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
                       style="margin: 0 3px; text-decoration: none; ${i == pageNumber ? 'font-weight:bold; color:red;' : ''}">
                        ${i}
                    </a>
                </c:forEach>

                <c:if test="${pageNumber < totalPages}">
                    <a href="${pageContext.request.contextPath}/Sort?page=${pageNumber + 1}&sortName=${sortName}">Tiếp »</a>
                </c:if>
            </div>


        </div>
    </body>
</html>
