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
            background-color: #f4f6f9;
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
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
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
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }

        button:hover {
            background-color: #0056b3;
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

        /* Form quay lại tách biệt */
        form[action*="ManagerCourses2.jsp"] {
            text-align: center;
            margin-top: 20px;
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

                <!-- Các khóa cơ bản -->
                <option value="Toán">Khóa Toán</option>
                <option value="Ngữ văn">Khóa Ngữ văn</option>
                <option value="Vật lý">Khóa Vật lý</option>
                <option value="Hóa học">Khóa Hóa học</option>
                <option value="Sinh học">Khóa Sinh học</option>
                <option value="Tin học">Khóa Tin học</option>
                <option value="Lịch sử">Khóa Lịch sử</option>
                <option value="Địa lý">Khóa Địa lý</option>
                <option value="Giáo dục công dân">Khóa Giáo dục công dân</option>
                <option value="Tiếng Anh">Khóa Tiếng Anh</option>
                <option value="Công nghệ">Khóa Công nghệ</option>

                <!-- Các khóa tổng ôn -->
                <option value="Khóa tổng ôn Toán">Khóa tổng ôn Toán</option>
                <option value="Khóa tổng ôn Ngữ văn">Khóa tổng ôn Ngữ văn</option>
                <option value="Khóa tổng ôn Vật lý">Khóa tổng ôn Vật lý</option>
                <option value="Khóa tổng ôn Hóa học">Khóa tổng ôn Hóa học</option>
                <option value="Khóa tổng ôn Sinh học">Khóa tổng ôn Sinh học</option>
                <option value="Khóa tổng ôn Tin học">Khóa tổng ôn Tin học</option>
                <option value="Khóa tổng ôn Lịch sử">Khóa tổng ôn Lịch sử</option>
                <option value="Khóa tổng ôn Địa lý">Khóa tổng ôn Địa lý</option>
                <option value="Khóa tổng ôn Giáo dục công dân">Khóa tổng ôn Giáo dục công dân</option>
                <option value="Khóa tổng ôn Tiếng Anh">Khóa tổng ôn Tiếng Anh</option>
                <option value="Khóa tổng ôn Công nghệ">Khóa tổng ôn Công nghệ</option>
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
            <select name="ID_Khoi">
                <option value="">-- Chọn khối học --</option>
                <option value="1">1 (Lớp 6)</option>
                <option value="2">2 (Lớp 7)</option>
                <option value="3">3 (Lớp 8)</option>
                <option value="4">4 (Lớp 9)</option>
                <option value="5">5 (Lớp 10)</option>
                <option value="6">6 (Lớp 11)</option>
                <option value="7">7 (Lớp 12)</option>
                <option value="8">8 (Lớp tổng ôn)</option>
            </select>
            <br/>
            <br>
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
