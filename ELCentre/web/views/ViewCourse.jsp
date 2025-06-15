<%-- 
    Document   : ViewCourse
    Created on : May 31, 2025, 10:33:02 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="model.LopHoc"%>
<%@page import="dal.LopHocDAO"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <style>

        .btn-delete {
            background-color: #dc3545; /* đỏ */
            color: white;
            width: 80px;
        }

        .btn-update {
            background-color: #007bff; /* xanh */
            color: white;
            width: 80px;
        }

        .btn-view {
            background-color: #6c757d; /* xám */
            color: white;
            width: 80px;
        }

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

        .pagination a, .pagination span {
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

        .pagination a.active {
            font-weight: bold;
            background-color: #007bff;
            color: white;
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            pointer-events: none;
            cursor: default;
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
        .col-siSo {
            width: 80px;
        }
        .col-date {
            width: 145px;
        }

        .col-ghiChu {
            width: 345px;
        }
        .col-status {
            width: 130px;
        }
        .col-action {
            width: 100px;
        }
        .col-anhGiaoVien {
            width: 130px
        }

        td img {
            width: 113px;
            height: 151px;
            object-fit: cover;
            display: block;
            margin: 0 auto;
            border-radius: 4px;
            border: 2px solid lightblue; /* kiểm tra áp dụng CSS */
        }

        table tr {
            height: 160px; /* Đảm bảo chiều cao đủ chứa ảnh */
        }

        thead tr {
            height: auto !important;
        }

        .sort-arrow {
            color: white;
            text-decoration: none; /* Không gạch dưới nếu muốn */
            font-weight: bold;
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

        <%
     String idKhoaHoc = request.getParameter("ID_KhoaHoc");
     if (idKhoaHoc == null) {
         idKhoaHoc = (String) request.getAttribute("ID_KhoaHoc");
     }

     String idKhoi = request.getParameter("ID_Khoi");
     if (idKhoi == null) {
         idKhoi = (String) request.getAttribute("ID_Khoi");
     }
     

         
         
        %>

        <script>
            function resetFilter() {
                // Redirect về servlet với chỉ ID_KhoaHoc và ID_Khoi
                const params = new URLSearchParams();
                params.append("ID_KhoaHoc", document.querySelector('input[name="ID_KhoaHoc"]').value);
                params.append("ID_Khoi", document.querySelector('input[name="ID_Khoi"]').value);

                // Chuyển hướng về trạng thái ban đầu
                window.location.href = "${pageContext.request.contextPath}/Class_SearchFilter?" + params.toString();
            }
        </script>


        <!-- Nút quay lại -->
        <form action="${pageContext.request.contextPath}/ManagerCourse" method="get" style="margin-top: 10px;">
            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}" />
            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}" />

            <button type="submit">Quay lại</button>
        </form>


        <div>
            <h1>Trang quản lý lớp học</h1>



            <table class="c">
                <tr>
                    <td>
                        <form action="${pageContext.request.contextPath}/Class_SearchFilter" method="get" style="margin: 20px 0;">
                            <input type="hidden" name="ID_KhoaHoc" value="<%= idKhoaHoc %>" />
                            <input type="hidden" name="ID_Khoi" value="<%= idKhoi %>" />
                            <input type="hidden" name="page" value="1" />

                            <label for="name">Tìm kiếm theo tên lớp: </label>
                            <input type="text" id="name" name="name" value="${param.name != null ? param.name : ''}" placeholder="Nhập tên lớp..." />

                            <label for="filterStatus" style="margin-left: 20px;">Lọc theo trạng thái: </label>
                            <select id="filterStatus" name="filterStatus">
                                <option value="">-- Tất cả --</option>
                                <option value="Active" ${param.filterStatus == 'Active' ? 'selected' : ''}>Đang mở</option>
                                <option value="Inactive" ${param.filterStatus == 'Inactive' ? 'selected' : ''}>Đã kết thúc</option>
                            </select>

                            <button type="submit" >Tìm kiếm</button>
                        </form> 
                    </td>
                    <td>
                                        <button type="button" onclick="resetFilter()">Refesh</button>

                    </td>


                <td>  <!-- Thêm mới -->
                    <button style="margin-top: 2px" type="button"
                            onclick="window.location.href = '<%= request.getContextPath() %>/views/AddClass.jsp?ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>'">
                        Thêm lớp học mới
                    </button>

                </td>
                </tr>
            </table>

            <%-- Kiểm tra và hiển thị thông báo --%>

            <c:if test="${not empty err}">
                <div style="color: red;">${err}</div>
            </c:if>

            <c:if test="${message == 'deleted'}">
                <script>
                    alert("Xóa lớp học thành công!");
                </script>
            </c:if>

            <c:if test="${message == 'Notdeleted'}">
                <script>
                    alert("Xóa lớp học không thành công do trạng thái không phù hợp!");
                </script>
            </c:if>

            <c:if test="${message == 'Notupdated'}">
                <script>
                    alert("Chỉnh sửa lớp học không thành công do trạng thái không phù hợp!");
                </script>
            </c:if>

            <c:set var="sortColumn" value="${sortColumn != null ? sortColumn : 'ID_LopHoc'}"/>
            <c:set var="sortOrder" value="${sortOrder != null ? sortOrder : 'asc'}"/>
            <c:set var="searchName" value="${searchName != null ? searchName : ''}"/>


            <c:if test="${not empty danhSachLopHoc}">
                <p>Tổng số lớp học: ${totalItems}   &nbsp;&nbsp;      &nbsp;Tổng số trang: ${totalPages}</p>
                <table>
                    <thead>
                        <tr>
                            <th class="col-id">ID 
                                <a class="sort-arrow" href="<%= request.getContextPath() %>/Class_SortAttribute?sortColumn=ID_LopHoc&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↑</a>

                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=ID_LopHoc&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>
                            <th class="col-name">Tên lớp học
                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=TenLopHoc&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↑</a>
                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=TenLopHoc&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>
                            <th class="col-siSo">Sĩ số
                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=SiSo&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↑</a>
                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=SiSo&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>
                            <th class="col-date">Thời gian học
                            </th>
                            <th class="col-ghiChu">Ghi chú
                                <a class="sort-arrow" href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=GhiChu&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↑</a>
                                <a class="sort-arrow"  href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=GhiChu&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>

                            <th class="col-status">Trạng thái
                                <a class="sort-arrow"  href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=TrangThai&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=<%= idKhoi %>">↑</a>
                                <a class="sort-arrow"  href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=TrangThai&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>
                            <th class="col-date">Ngày khởi tạo
                                <a class="sort-arrow"  href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=NgayTao&sortOrder=asc&name=${searchName}&page=1&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=<%= idKhoi %>">↑</a>
                                <a class="sort-arrow"  href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=NgayTao&sortOrder=desc&name=${searchName}&page=1&ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=<%= idKhoi %>">↓</a>
                            </th>
                            <th class="col-anhGiaoVien">Giáo viên

                            </th>
                            <th class="col-action">Action</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="lopHoc" items="${danhSachLopHoc}">
                            <tr>
                                <td class="col-id">${lopHoc.ID_LopHoc}</td>
                                <td class="col-name">${lopHoc.getTenLopHoc()}</td>
                                <td class="col-siSo">${lopHoc.getSiSo()}</td>
                                <td class="col-date">
                                    <c:forEach var="tg" items="${lopHoc.thoiGianHocFormatted}">
                                        ${tg}<br/>
                                    </c:forEach>
                                </td>
                                <td class="col-ghiChu">${lopHoc.getGhiChu()}</td>
                                <td class="col-status">${lopHoc.getTrangThai()}</td>
                                <td class="col-date">${lopHoc.getNgayTaoFormatted()}</td>
                                <td class="col-idkhoi"><img src="${pageContext.request.contextPath}/${lopHoc.image}" /></td>
                                <td class="col-action">
                                    <button class="btn-delete" type="button"
                                            onclick="return confirmDeleteAndRedirect('${pageContext.request.contextPath}/Class_ManagerClass?action=deleteClass&ID_LopHoc=${lopHoc.ID_LopHoc}&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>')">
                                        DELETE
                                    </button>
                                    <button class="btn-update" onclick="location.href = '${pageContext.request.contextPath}/Class_ManagerClass?action=updateClass&ID_LopHoc=${lopHoc.ID_LopHoc}&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>'">
                                        UPDATE
                                    </button>
                                    <button type="button" class="btn-view"
                                            onclick="location.href = '${pageContext.request.contextPath}/Class_ManagerClass?action=viewClass&ID_LopHoc=${lopHoc.ID_LopHoc}&ID_KhoaHoc=<%= idKhoaHoc %>&ID_Khoi=<%= idKhoi %>'">
                                        VIEW
                                    </button>




                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>


                <div class="pagination">

                    <c:if test="${page > 1}">
                        <a href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=${param.sortColumn}&sortOrder=${param.sortOrder}&name=${param.name}&page=${page - 1}&ID_KhoaHoc=${param.ID_KhoaHoc}&ID_Khoi=${param.ID_Khoi}">
                            &laquo; Previous
                        </a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i <= 5 || i == totalPages}">
                                <c:choose>
                                    <c:when test="${i == page}">
                                        <a class="active" href="#" style="font-weight:bold; background-color:#007bff; color:white;">${i}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=${param.sortColumn}&sortOrder=${param.sortOrder}&name=${param.name}&page=${i}&ID_KhoaHoc=${param.ID_KhoaHoc}&ID_Khoi=${param.ID_Khoi}">
                                            ${i}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:when test="${i == 6 && totalPages > 6}">
                                <span>...</span>
                            </c:when>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${page < totalPages}">
                        <a href="${pageContext.request.contextPath}/Class_SortAttribute?sortColumn=${param.sortColumn}&sortOrder=${param.sortOrder}&name=${param.name}&page=${page + 1}&ID_KhoaHoc=${param.ID_KhoaHoc}&ID_Khoi=${param.ID_Khoi}">
                            Next &raquo;
                        </a>
                    </c:if>

                </div>




            </c:if>


            <c:if test="${empty danhSachLopHoc}">
                <p style="margin-top: 20px;
                   color: #777;">Không có kết quả phù hợp để hiển thị.</p>
            </c:if>
            <hr>
        </div>

    </body>
</html>
