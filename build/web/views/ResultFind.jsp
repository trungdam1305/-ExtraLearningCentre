<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
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
            margin-left: auto;
            margin-right: 0;
            margin-top: 15px;
            width: auto;
            display: flex;
            justify-content: flex-end;
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
            padding: 15px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .u button:hover {
            background-color: #163b5c;
        }



        th {
            background-color: #1F4E79; /* màu nền xanh đậm như cũ */
            color: white;
            padding: 8px;
            text-align: center;
            position: relative;
            font-weight: bold;
        }

        th a {
            color: white;          /* mũi tên màu trắng */
            font-size: 18px;       /* mũi tên to hơn */
            margin-left: 6px;      /* cách chữ và mũi tên */
            text-decoration: none;
            vertical-align: middle;
            font-weight: bold;
        }

        th a:hover {
            color: #FFD700;        /* đổi sang vàng kim khi hover */
            text-decoration: underline;
        }

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
    <body>
        <div class="main-content">
            <h1>Danh sách các khóa học bạn tìm</h1>
            <table class="c">
                <tr>
                    <td>
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
                        </form></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/SortForResultFind" method="get" id="filterForm">
                            <input type="hidden" name="page" value="${pageNumber != null ? pageNumber : 1}" />
                            <input type="hidden" name="name" value="${searchName != null ? searchName : ''}" />
                            <label for="sortName">Sắp xếp theo:</label>
                            <select name="sortName" id="sortName" onchange="document.getElementById('filterForm').submit();">
                                <option value="" ${sortName == null || sortName.isEmpty() ? "selected" : ""}>-- Mặc định --</option>
                                <option value="DESCTrang" ${"DESCTrang".equals(sortName) ? "selected" : ""}>Trạng thái chưa hoạt động</option>
                                <option value="ASCTrang" ${"ASCTrang".equals(sortName) ? "selected" : ""}>Trạng thái đang hoạt động</option>
                            </select>
                        </form>
                    </td>

                    <td>
                        <!-- Thêm mới -->
                        <button style="margin-top: 2px" type="button" onclick="window.location.href = '${pageContext.request.contextPath}/views/AddCourse.jsp'">
                            Thêm khóa học mới
                        </button>
                    </td>
                </tr>
            </table>

            <div>
                <c:if test="${not empty err}">
                    <span style="color:red;">${err}</span>
                </c:if>
            </div>

            <c:if test="${totalCourses != null}">
                <p style="margin-top:10px; font-weight: bold;">
                    Tổng số khóa học tìm được: ${totalCourses}
                </p>
            </c:if>
            <c:if test="${not empty list}">
    <table>
        <thead>
            <tr>
                <th class="col-id">ID
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ID_KhoaHoc&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ID_KhoaHoc&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-name">Tên khóa học
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=TenKhoaHoc&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=TenKhoaHoc&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-desc">Mô tả
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=MoTa&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=MoTa&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-date">Ngày bắt đầu
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ThoiGianBatDau&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ThoiGianBatDau&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-date">Ngày kết thúc
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ThoiGianKetThuc&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ThoiGianKetThuc&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-note">Ghi chú
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=GhiChu&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=GhiChu&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-status">Trạng thái
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=TrangThai&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=TrangThai&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-date">Ngày tạo
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=NgayTao&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=NgayTao&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-idkhoi">ID Khối
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ID_Khoi&sortOrder=asc&name=${searchName}">↑</a>
                    <a href="${pageContext.request.contextPath}/SortAttribute?sortColumn=ID_Khoi&sortOrder=desc&name=${searchName}">↓</a>
                </th>
                <th class="col-action">Action</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="course" items="${list}">
                <tr>
                    <td class="col-id">${course.getID_KhoaHoc()}</td>
                    <td class="col-name">${course.getTenKhoaHoc()}</td>
                    <td class="col-desc">${course.getMoTa()}</td>
                    <td class="col-date">${course.thoiGianBatDauFormatted}</td>
                    <td class="col-date">${course.thoiGianKetThucFormatted}</td>
                    <td class="col-note">${course.getGhiChu()}</td>
                    <td class="col-status">${course.getTrangThai()}</td>
                    <td class="col-date">${course.getNgayTaoFormatted()}</td>
                    <td class="col-idkhoi">${course.getID_Khoi()}</td>
                    <td class="col-action">
                        <button type="button" onclick="return confirmDeleteAndRedirect('${pageContext.request.contextPath}/ManagerCourse?action=deleteCourse&ID_KhoaHoc=${course.ID_KhoaHoc}')">DELETE</button>
                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=ViewCourse&ID_Khoi=${course.ID_Khoi}'">View</button>
                        <button onclick="location.href = '${pageContext.request.contextPath}/ManagerCourse?action=UpdateCourse&ID_KhoaHoc=${course.ID_KhoaHoc}'">Update</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

<c:if test="${empty list}">
    <p style="margin-top: 20px; color: #777;">Không có kết quả phù hợp để hiển thị.</p>
</c:if>



            <!-- Phân trang -->
            <c:if test="${totalPages != null && totalPages > 1}">
                <div class="pagination" style="margin-top: 15px;">
                    <c:if test="${pageNumber > 1}">
                        <a href="${pageContext.request.contextPath}/SearchCourse?page=${pageNumber - 1}&sortName=${sortName}&name=${searchName}">« Trước</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/SearchCourse?page=${i}&sortName=${sortName}&name=${searchName}"
                           style="margin: 0 3px; text-decoration: none; ${i == pageNumber ? 'font-weight:bold; color:red;' : ''}">
                            ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${pageNumber < totalPages}">
                        <a href="${pageContext.request.contextPath}/SearchCourse?page=${pageNumber + 1}&sortName=${sortName}&name=${searchName}">Tiếp »</a>
                    </c:if>
                </div>
            </c:if>

        </div>
        <div class="u">
            <form action="${pageContext.request.contextPath}/views/admin/adminDashboard.jsp" method="get">
                <button type="submit">Quay lại dashboard</button>
            </form>
        </div>
        <script>
            function confirmDelete(url) {
                if (confirm("Bạn có chắc chắn muốn xóa khóa học này không?")) {
                    window.location.href = url;
                }
                return false; // Ngăn nút tiếp tục hành động nếu hủy
            }
        </script>
    </body>
</html>
