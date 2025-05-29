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

    <body>
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
            <option value="ASCTrang" ${"ASCTrang".equals(param.sortName) ? "selected" : ""}>Trạng thái chưa bắt đầu</option>
            <option value="DESCTrang" ${"DESCTrang".equals(param.sortName) ? "selected" : ""}>Trạng thái hoạt động</option>
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
             // Sắp xếp trạng thái tăng dần
             khoaHocList = KhoaHocDAO.getSortedByTrangThai("ASC", offset, pageSize);
             totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai();
         } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
             // Sắp xếp trạng thái giảm dần
             khoaHocList = KhoaHocDAO.getSortedByTrangThai("DESC", offset, pageSize);
             totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai();
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
                                    <td>${course.getThoiGianBatDau()}</td>
                                    <td>${course.getThoiGianKetThuc()}</td>
                                    <td>${course.getGhiChu()}</td>
                                    <td>${course.getTrangThai()}</td>
                                    <td>${course.getNgayTao()}</td>
                                    <td>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">DELETE</button>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">View</button>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=UpdateCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">Update</button>
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
                                    <td>${course.getThoiGianBatDau()}</td>
                                    <td>${course.getThoiGianKetThuc()}</td>
                                    <td>${course.getGhiChu()}</td>
                                    <td>${course.getTrangThai()}</td>
                                    <td>${course.getNgayTao()}</td>
                                    <td>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">DELETE</button>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">View</button>
                                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=UpdateCourse&ID_KhoaHoc=${course.getID_KhoaHoc()}'">Update</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                <a href="ManagerCourses2.jsp"></a>
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
