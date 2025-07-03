<%-- 
    Document   : addCourse
    Created on : May 27, 2025, 11:33:02 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.KhoaHoc"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>

<html>
    <head><title>Thêm khóa học</title></head>
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
    </style>
    <body>

        <h2>Thêm khóa học</h2>  
        <form action="${pageContext.request.contextPath}/ManageCourse" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addKhoaHoc" />

            <label>ID khối học:<span style="color: red;">*</span></label>
            <select name="ID_Khoi" required>
                <option value="">-- Chọn khối học --</option>
                <option value="1">1 (Lớp 6)</option>
                <option value="2">2 (Lớp 7)</option>
                <option value="3">3 (Lớp 8)</option>
                <option value="4">4 (Lớp 9)</option>
                <option value="5">5 (Lớp 10)</option>
                <option value="6">6 (Lớp 11)</option>
                <option value="7">7 (Lớp 12)</option>
                <option value="8">8 (Lớp tổng ôn)</option>
            </select><br/>

            <label>Tên môn học:<span style="color: red;">*</span></label>
            <select name="TenKhoaHoc" required>
                <option value="">-- Chọn tên khóa học --</option>
                <!-- Các khóa cơ bản -->
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

            <label>Mã khóa học (tự động):</label>
            <input type="text" id="courseCode" readonly /><br/>

            <label>Mô tả:</label>
            <textarea name="MoTa"></textarea><br/>

            <label>Thời gian bắt đầu:<span style="color: red;">*</span></label>
            <input type="date" name="ThoiGianBatDau" min="${today}" required /><br/>

            <label>Thời gian kết thúc:<span style="color: red;">*</span></label>
            <input type="date" name="ThoiGianKetThuc" min="${today}" required /><br/>

            <label>Ghi chú:</label>
            <input type="text" name="GhiChu" /><br/>

            <label>Hình ảnh:</label>
            <input type="file" name="Image" accept="image/jpeg,image/png" /><br/>

            <label>Thứ tự ưu tiên:</label>
            <input type="number" name="Order" min="0" placeholder="Nhập thứ tự (tùy chọn)" /><br/>

            <button type="submit">Thêm</button>
        </form>

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

        <script>
            function removeDiacritics(str) {
                return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
            }

            function updateCourseCode() {
                const ten = document.querySelector('[name="TenKhoaHoc"]').value;
                const khoi = document.querySelector('[name="ID_Khoi"]').value;
                const courseCodeField = document.querySelector('#courseCode');
                if (ten && khoi) {
                    let courseCode;
                    if (ten.startsWith("Khóa tổng ôn ")) {
                        courseCode = "TONG" + removeDiacritics(ten.replace("Khóa tổng ôn ", "")).toUpperCase().replace(/\s/g, "");
                    } else {
                        const prefix = removeDiacritics(ten.length >= 3 ? ten.substring(0, 3) : ten).toUpperCase();
                        const khoiNum = (parseInt(khoi) + 5).toString().padStart(2, '0');
                        courseCode = prefix + khoiNum;
                    }
                    if (!/^[A-Za-z0-9]+$/.test(courseCode)) {
                        courseCodeField.value = "";
                        alert("Mã khóa học chỉ được chứa chữ và số!");
                    } else {
                        courseCodeField.value = courseCode;
                    }
                } else {
                    courseCodeField.value = "";
                }
            }

            document.querySelector('[name="TenKhoaHoc"]').addEventListener('change', updateCourseCode);
            document.querySelector('[name="ID_Khoi"]').addEventListener('change', updateCourseCode);
            document.querySelector('[name="TenKhoaHoc"]').addEventListener('change', function () {
                const ten = this.value;
                const khoiSelect = document.querySelector('[name="ID_Khoi"]');
                if (ten.startsWith("Khóa tổng ôn ") && khoiSelect.value !== "8") {
                    alert("Khóa tổng ôn phải có ID khối học là 8!");
                    khoiSelect.value = "8";
                    updateCourseCode();
                }
            });

            document.querySelector('input[name="Image"]').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file && !['image/jpeg', 'image/png'].includes(file.type)) {
                    alert('Chỉ chấp nhận file .jpg hoặc .png!');
                    e.target.value = '';
                }
            });

            document.querySelector('form').addEventListener('submit', function (e) {
                if (!confirm('Bạn có chắc muốn lưu khóa học này?')) {
                    e.preventDefault();
                }
            });
        </script>
    </body> 
</html>