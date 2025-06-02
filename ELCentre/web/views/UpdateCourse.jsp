<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>

<html>
    <head><title>Cập nhật khóa học</title></head>
    <head>
        <title>Cập nhật khóa học</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            form {
                max-width: 600px;
                margin: 0 auto;
                background-color: #fff;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="date"],
            textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 18px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
                box-sizing: border-box;
            }

            textarea {
                resize: vertical;
                min-height: 80px;
            }

            button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-size: 14px;
            }

            button:hover {
                background-color: #218838;
            }

            p {
                text-align: center;
                font-size: 14px;
            }

            p[style*="red"] {
                color: red;
                font-weight: bold;
            }

            p[style*="green"] {
                color: green;
                font-weight: bold;
            }

            /* Nút "Quay lại" riêng biệt */
            form[action*="ManagerCourses2.jsp"] {
                text-align: center;
                margin-top: 20px;
            }

            form[action*="ManagerCourses2.jsp"] button {
                background-color: #6c757d;
            }

            form[action*="ManagerCourses2.jsp"] button:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <!-- Nút quay lại -->
    <form action="${pageContext.request.contextPath}/views/ManagerCourses2.jsp" method="get" style="margin-top: 10px;">
        <button type="submit">Quay lại</button>
    </form>
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
        String searchTenKhoaHoc = request.getParameter("searchTenKhoaHoc");

        List<KhoaHoc> khoaHocList;
        int totalCourses = 0;

        // Nếu có tìm kiếm theo tên
        if (searchTenKhoaHoc != null && !searchTenKhoaHoc.trim().isEmpty()) {
            if ("ASCTrang".equalsIgnoreCase(sortName)) {
                khoaHocList = KhoaHocDAO.getCoursesByTrangThaiVaTen("active", searchTenKhoaHoc, offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCoursesByTrangThaiVaTen("active", searchTenKhoaHoc);
            } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
                khoaHocList = KhoaHocDAO.getCoursesByTrangThaiVaTen("inactive", searchTenKhoaHoc, offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCoursesByTrangThaiVaTen("inactive", searchTenKhoaHoc);
            } else {
                // Mặc định khi có tên nhưng không lọc trạng thái rõ ràng
                khoaHocList = KhoaHocDAO.getCoursesByTen(searchTenKhoaHoc, offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCoursesByTen(searchTenKhoaHoc);
            }
        } else {
            // Không có tìm kiếm tên
            if ("ASCTrang".equalsIgnoreCase(sortName)) {
                khoaHocList = KhoaHocDAO.getCoursesByTrangThai("active", offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai("active");
            } else if ("DESCTrang".equalsIgnoreCase(sortName)) {
                khoaHocList = KhoaHocDAO.getCoursesByTrangThai("inactive", offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCoursesByTrangThai("inactive");
            } else if ("ASC".equalsIgnoreCase(sortName) || "DESC".equalsIgnoreCase(sortName)) {
                khoaHocList = KhoaHocDAO.getSortedKhoaHoc(offset, pageSize, sortName);
                totalCourses = KhoaHocDAO.getTotalCourses();
            } else {
                khoaHocList = KhoaHocDAO.getKhoaHoc(offset, pageSize);
                totalCourses = KhoaHocDAO.getTotalCourses();
            }
        }

        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

        request.setAttribute("defaultCourses", khoaHocList);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortName", sortName);
        request.setAttribute("searchTenKhoaHoc", searchTenKhoaHoc);
    %>


    <body>
        <h2>Cập nhật khóa học</h2>  
        <form action="${pageContext.request.contextPath}/ManagerCourse" method="post">
            <input type="hidden" name="action" value="submitUpdateCourse">
            <input type="hidden" name="ID_KhoaHoc" value="${khoaHoc.ID_KhoaHoc}" />

            <select name="TenKhoaHoc" required>
                <option value="">-- Chọn tên khóa học --</option>
                <option value="Toán">Toán</option>
                <option value="Ngữ văn">Ngữ văn</option>
                <option value="Vật lý">Vật lý</option>
                <option value="Hóa học">Hóa học</option>
                <option value="Sinh học">Sinh học</option>
                <option value="Tin học">Tin học</option>
                <option value="Lịch sử">Lịch sử</option>
                <option value="Địa lý">Địa lý</option>
                <option value="Giáo dục công dân">Giáo dục công dân</option>
                <option value="Tiếng Anh">Tiếng Anh</option>
                <option value="Công nghệ">Công nghệ</option>
            </select><br/>

            <label>Mô tả:</label>
            <textarea name="MoTa" ></textarea><br/>

            <label>Thời gian bắt đầu:</label>
            <input type="date" name="ThoiGianBatDau" min="${today}" /><br/>

            <label>Thời gian kết thúc:</label>
            <input type="date" name="ThoiGianKetThuc" /><br/>

            <label>Ghi chú:</label>
            <input type="text" name="GhiChu"  /><br/>

            <label>Trạng thái:</label>
            <select name="TrangThai" required>
                <option value="">-- Chọn trạng thái --</option>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select><br/>

            <label>ID khối học: </label>
            <input type="text" name="ID_Khoi" placeholder="Từ 1 đến 7 tương ứng với lớp 6-12"/><br/>


            <button type="submit">Cập nhật</button>
        </form>

        <c:if test="${not empty err}">
            <p style="color: red;">${err}</p>
        </c:if>

        <c:if test="${not empty suc}">
            <p style="color: green;">${suc}</p>
        </c:if>


    </body> 
</html>
