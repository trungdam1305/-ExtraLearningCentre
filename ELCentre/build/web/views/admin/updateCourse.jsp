<%-- 
    Document   : updateCourse
    Created on : May 27, 2025, 18:23:02 PM
    Author     : Vuh26
--%>
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
            input[type="number"],
            input[type="file"],
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

            input[type="file"] {
                padding: 3px;
            }

            input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
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

            img {
                max-width: 200px;
                margin-bottom: 10px;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>
        <div class="content-container">
            <h2>Cập nhật khóa học</h2>  
            <form action="${pageContext.request.contextPath}/ManageCourse" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="submitUpdateCourse" />
                <input type="hidden" name="ID_KhoaHoc" value="${khoaHoc.ID_KhoaHoc}" />

                <!-- Debug để kiểm tra khoaHoc -->
                <c:if test="${empty khoaHoc}">
                    <p style="color: red;">Không có dữ liệu khóa học để hiển thị!</p>
                </c:if>

                <label>ID khối học:</label>
                <input type="text" value="${khoaHoc.ID_Khoi} (Lớp ${khoaHoc.ID_Khoi + 5}${khoaHoc.ID_Khoi == 8 ? ' - Tổng ôn' : ''})" readonly />
                <input type="hidden" name="ID_Khoi" value="${khoaHoc.ID_Khoi}" /><br/>

                <label>Tên khóa học:</label>
                <input type="text" value="${khoaHoc.tenKhoaHoc}" readonly />
                <input type="hidden" name="TenKhoaHoc" value="${khoaHoc.tenKhoaHoc}" /><br/>

                <label>Mã khóa học:</label>
                <input type="text" id="courseCode" name="CourseCode" value="${khoaHoc.courseCode}" readonly /><br/>

                <label>Mô tả:</label>
                <textarea name="MoTa">${khoaHoc.moTa}</textarea><br/>

                <label>Thời gian bắt đầu:</label>
                <input type="date" name="ThoiGianBatDau" value="${khoaHoc.thoiGianBatDau}" min="${today}" /><br/>

                <label>Thời gian kết thúc:</label>
                <input type="date" name="ThoiGianKetThuc" value="${khoaHoc.thoiGianKetThuc}" /><br/>

                <label>Ghi chú:</label>
                <input type="text" name="GhiChu" value="${khoaHoc.ghiChu}" /><br/>

                <label>Trạng thái:</label>
                <select name="TrangThai" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="Đang hoạt động" ${khoaHoc.trangThai == 'Đang hoạt động' ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="Chưa hoạt động" ${khoaHoc.trangThai == 'Chưa hoạt động' ? 'selected' : ''}>Chưa hoạt động</option>
                    <option value="Chưa bắt đầu" ${khoaHoc.trangThai == 'Chưa bắt đầu' ? 'selected' : ''}>Chưa bắt đầu</option>
                    <option value="Đã kết thúc" ${khoaHoc.trangThai == 'Đã kết thúc' ? 'selected' : ''}>Đã kết thúc</option>
                </select><br/>

                <label>Hình ảnh hiện tại:</label>
                <c:if test="${not empty khoaHoc.image}">
                    <img src="${pageContext.request.contextPath}${khoaHoc.image}" alt="Hình ảnh khóa học" /><br/>
                </c:if>
                <c:if test="${empty khoaHoc.image}">
                    <p>Chưa có hình ảnh</p>
                </c:if>
                <label>Tải lên hình ảnh mới (tùy chọn):</label>
                <input type="file" name="Image" accept="image/jpeg,image/png" /><br/>

                <label>Thứ tự:</label>
                <input type="number" name="Order" value="${khoaHoc.order}" min="0" placeholder="Nhập thứ tự (tùy chọn)" /><br/>

                <button type="submit">Cập nhật</button>
            </form>

            <c:if test="${not empty err}">
                <p style="color: red;">${err}</p>
            </c:if>

            <c:if test="${not empty suc}">
                <p style="color: green;">${suc}</p>
            </c:if>

            <% 
                java.time.LocalDate today = java.time.LocalDate.now();
                pageContext.setAttribute("today", today.toString());
            %>

            <script>
                document.querySelector('input[name="Image"]').addEventListener('change', function (e) {
                    const file = e.target.files[0];
                    if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                        alert('Chỉ chấp nhận file .jpg hoặc .png!');
                        e.target.value = '';
                    }
                });

                document.querySelector('form').addEventListener('submit', function (e) {
                    const trangThai = document.querySelector('[name="TrangThai"]').value;
                    if (!["Đang hoạt động", "Chưa hoạt động", "Chưa bắt đầu", "Đã kết thúc"].includes(trangThai)) {
                        alert('Vui lòng chọn trạng thái hợp lệ!');
                        e.preventDefault();
                        return;
                    }
                    if (!confirm('Bạn có chắc muốn lưu khóa học này?')) {
                        e.preventDefault();
                    }
                });
            </script>
        </div>

        <div>
            <!-- Nút quay lại -->
            <form action="${pageContext.request.contextPath}/ManageCourse" method="get" style="margin-top: 10px;">
                <input type="hidden" name="action" value="refresh" />
                <input type="hidden" name="sortColumn" value="${sortColumn}" />
                <input type="hidden" name="sortOrder" value="${sortOrder}" />
                <input type="hidden" name="statusFilter" value="${statusFilter}" />
                <input type="hidden" name="name" value="${name}" />
                <input type="hidden" name="page" value="${pageNumber}" />
                <button type="submit">Quay lại</button>
            </form>
        </div>
    </body> 
</html>