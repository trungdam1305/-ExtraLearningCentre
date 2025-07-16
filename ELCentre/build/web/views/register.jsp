<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - Extra Learning Centre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function toggleRoleFields() {
            var role = document.getElementById("role").value;
            var hsSection = document.getElementById("hocSinhSection");
            hsSection.style.display = role === "HocSinh" ? "block" : "none";
        }
    </script>
</head>
<body class="container mt-5">
    <h2>Đăng ký tài khoản người dùng</h2>
    <form action="<%= request.getContextPath() %>/RegisterServlet" method="post">
        <!-- Thông tin chung -->
        <div class="mb-3">
            <label for="email" class="form-label">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required />
        </div>

        <div class="mb-3">
            <label for="soDienThoai" class="form-label">Số điện thoại:</label>
            <input type="text" class="form-control" id="soDienThoai" name="soDienThoai" required />
        </div>

        <div class="mb-3">
            <label for="hoTen" class="form-label">Họ tên:</label>
            <input type="text" class="form-control" id="hoTen" name="hoTen" required />
        </div>

        <!-- Chọn vai trò -->
        <div class="mb-3">
            <label for="role" class="form-label">Vai trò:</label>
            <select class="form-select" id="role" name="userType" onchange="toggleRoleFields()" required>
                <option value="">-- Chọn vai trò --</option>
                <option value="HocSinh">Học Sinh</option>
                <option value="GiaoVien">Giáo Viên</option>
                <option value="PhuHuynh">Phụ Huynh</option>
            </select>
        </div>

        <!-- Form mở rộng cho Học Sinh -->
        <div id="hocSinhSection" style="display: none;">
            <h5 class="mt-4">Thông tin học sinh</h5>

            <div class="mb-3">
                <label for="ngaySinh" class="form-label">Ngày sinh:</label>
                <input type="date" class="form-control" id="dob" name="dob" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Giới tính:</label><br/>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="nam" value="Nam" required />
                    <label class="form-check-label" for="nam">Nam</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" id="nu" value="Nữ" />
                    <label class="form-check-label" for="nu">Nữ</label>
                </div>
            </div>

            <div class="mb-3">
                <label for="diaChi" class="form-label">Địa chỉ:</label>
                <input type="text" class="form-control" id="address" name="address" required />
            </div>

            <div class="mb-3">
                <label for="tenTruongHoc" class="form-label">Tên trường học:</label>
                <input type="text" class="form-control" id="tenTruongHoc" name="tenTruongHoc" required />
            </div>

            <div class="mb-3">
                <label for="lopDangHoc" class="form-label">Lớp đang học:</label>
                <input type="text" class="form-control" id="lopDangHoc" name="lopDangHoc" placeholder="VD: 12A1" required />
            </div>
        </div>

        <button type="submit" class="btn btn-primary mt-3">Đăng ký</button>
    </form>
</body>
</html>
