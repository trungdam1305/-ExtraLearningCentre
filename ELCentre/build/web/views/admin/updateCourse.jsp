<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>

<html>
    <head>
        <title>Cập nhật khóa học</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 20px;
            }

            .content-container {
                width: 100%;
                padding: 20px;
                box-sizing: border-box;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            form {
                max-width: 600px;
                margin: 0 auto;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="date"],
            textarea,
            select {
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

            form[action*="ManageCourse"] {
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="content-container">
            <!-- Nút quay lại -->
            <form action="${pageContext.request.contextPath}/ManageCourse" method="get" style="margin-top: 10px;">
                <input type="hidden" name="action" value="refresh" />
                <input type="hidden" name="sortColumn" value="${sortColumn}" />
                <input type="hidden" name="sortOrder" value="${sortOrder}" />
                <input type="hidden" name="sortName" value="${sortName}" />
                <input type="hidden" name="name" value="${name}" />
                <input type="hidden" name="page" value="${pageNumber}" />
                <button type="submit">Quay lại</button>
            </form>
            <h2>Cập nhật khóa học</h2>  
            <form action="${pageContext.request.contextPath}/ManageCourse" method="post">
                <input type="hidden" name="action" value="submitUpdateCourse" />
                <input type="hidden" name="ID_KhoaHoc" value="${khoaHoc.ID_KhoaHoc}" />

                <!-- Debug để kiểm tra khoaHoc -->
                <c:if test="${empty khoaHoc}">
                    <p style="color: red;">Không có dữ liệu khóa học để hiển thị!</p>
                </c:if>

                <label>Tên khóa học:</label>
                <select name="TenKhoaHoc" required>
                    <option value="">-- Chọn tên khóa học --</option>
                    <!-- Các khóa cơ bản -->
                    <option value="Toán" ${khoaHoc.getTenKhoaHoc() == 'Toán' ? 'selected' : ''}>Toán</option>
                    <option value="Ngữ văn" ${khoaHoc.getTenKhoaHoc() == 'Ngữ văn' ? 'selected' : ''}>Ngữ văn</option>
                    <option value="Vật lý" ${khoaHoc.getTenKhoaHoc() == 'Vật lý' ? 'selected' : ''}>Vật lý</option>
                    <option value="Hóa học" ${khoaHoc.getTenKhoaHoc() == 'Hóa học' ? 'selected' : ''}>Hóa học</option>
                    <option value="Sinh học" ${khoaHoc.getTenKhoaHoc() == 'Sinh học' ? 'selected' : ''}>Sinh học</option>
                    <option value="Tin học" ${khoaHoc.getTenKhoaHoc() == 'Tin học' ? 'selected' : ''}>Tin học</option>
                    <option value="Lịch sử" ${khoaHoc.getTenKhoaHoc() == 'Lịch sử' ? 'selected' : ''}>Lịch sử</option>
                    <option value="Địa lý" ${khoaHoc.getTenKhoaHoc() == 'Địa lý' ? 'selected' : ''}>Địa lý</option>
                    <option value="Giáo dục công dân" ${khoaHoc.getTenKhoaHoc() == 'Giáo dục công dân' ? 'selected' : ''}>Giáo dục công dân</option>
                    <option value="Tiếng Anh" ${khoaHoc.getTenKhoaHoc() == 'Tiếng Anh' ? 'selected' : ''}>Tiếng Anh</option>
                    <option value="Công nghệ" ${khoaHoc.getTenKhoaHoc() == 'Công nghệ' ? 'selected' : ''}>Công nghệ</option>
                    <!-- Các khóa tổng ôn -->
                    <option value="Khóa tổng ôn Toán" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Toán' ? 'selected' : ''}>Khóa tổng ôn Toán</option>
                    <option value="Khóa tổng ôn Ngữ văn" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Ngữ văn' ? 'selected' : ''}>Khóa tổng ôn Ngữ văn</option>
                    <option value="Khóa tổng ôn Vật lý" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Vật lý' ? 'selected' : ''}>Khóa tổng ôn Vật lý</option>
                    <option value="Khóa tổng ôn Hóa học" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Hóa học' ? 'selected' : ''}>Khóa tổng ôn Hóa học</option>
                    <option value="Khóa tổng ôn Sinh học" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Sinh học' ? 'selected' : ''}>Khóa tổng ôn Sinh học</option>
                    <option value="Khóa tổng ôn Tin học" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Tin học' ? 'selected' : ''}>Khóa tổng ôn Tin học</option>
                    <option value="Khóa tổng ôn Lịch sử" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Lịch sử' ? 'selected' : ''}>Khóa tổng ôn Lịch sử</option>
                    <option value="Khóa tổng ôn Địa lý" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Địa lý' ? 'selected' : ''}>Khóa tổng ôn Địa lý</option>
                    <option value="Khóa tổng ôn Giáo dục công dân" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Giáo dục công dân' ? 'selected' : ''}>Khóa tổng ôn Giáo dục công dân</option>
                    <option value="Khóa tổng ôn Tiếng Anh" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Tiếng Anh' ? 'selected' : ''}>Khóa tổng ôn Tiếng Anh</option>
                    <option value="Khóa tổng ôn Công nghệ" ${khoaHoc.getTenKhoaHoc() == 'Khóa tổng ôn Công nghệ' ? 'selected' : ''}>Khóa tổng ôn Công nghệ</option>
                </select><br/>
                
                <label>Mô tả:</label>
                <textarea name="MoTa">${khoaHoc.getMoTa()}</textarea><br/>

                <label>Thời gian bắt đầu:</label>
                <input type="date" name="ThoiGianBatDau" value="${khoaHoc.getThoiGianBatDau()}" min="${today}" /><br/>

                <label>Thời gian kết thúc:</label>
                <input type="date" name="ThoiGianKetThuc" value="${khoaHoc.getThoiGianKetThuc()}" /><br/>

                <label>Ghi chú:</label>
                <input type="text" name="GhiChu" value="${khoaHoc.getGhiChu()}" /><br/>

                <label>Trạng thái:</label>
                <select name="TrangThai" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Active" ${khoaHoc.getTrangThai() == 'Active' ? 'selected' : ''}>Active</option>
                    <option value="Inactive" ${khoaHoc.getTrangThai() == 'Inactive' ? 'selected' : ''}>Inactive</option>
                </select><br/>

                <label>ID khối học:</label>
                <select name="ID_Khoi">
                    <option value="">-- Chọn khối học --</option>
                    <option value="1" ${khoaHoc.ID_Khoi == 1 ? 'selected' : ''}>1 (Lớp 6)</option>
                    <option value="2" ${khoaHoc.ID_Khoi == 2 ? 'selected' : ''}>2 (Lớp 7)</option>
                    <option value="3" ${khoaHoc.ID_Khoi == 3 ? 'selected' : ''}>3 (Lớp 8)</option>
                    <option value="4" ${khoaHoc.ID_Khoi == 4 ? 'selected' : ''}>4 (Lớp 9)</option>
                    <option value="5" ${khoaHoc.ID_Khoi == 5 ? 'selected' : ''}>5 (Lớp 10)</option>
                    <option value="6" ${khoaHoc.ID_Khoi == 6 ? 'selected' : ''}>6 (Lớp 11)</option>
                    <option value="7" ${khoaHoc.ID_Khoi == 7 ? 'selected' : ''}>7 (Lớp 12)</option>
                    <option value="8" ${khoaHoc.ID_Khoi == 8 ? 'selected' : ''}>8 (Lớp tổng ôn)</option>
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

            <%-- Tính ngày hiện tại để dùng trong min của input date --%>
            <% 
                java.time.LocalDate today = java.time.LocalDate.now();
                pageContext.setAttribute("today", today.toString());
            %>
        </div>
    </body> 
</html>