<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký tài khoản - Extra Learning Centre</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!-- Có 2 cách dùng var và const. Đặc điểm cần lưu ý là const thì chỉ dùng trong block hiện tại còn vả thì có thể mở rộng  -->
        <script>
            function toggleRoleFields() {
                var role = document.getElementById("role").value;
                var hsSection = document.getElementById("hocSinhSection");
                var phSection = document.getElementById("phuHuynhSection");
                var gvSection = document.getElementById("giaoVienSection");
                hsSection.style.display = role === "HocSinh" ? "block" : "none";
                phSection.style.display = role === "PhuHuynh" ? "block" : "none";
                gvSection.style.display = role === "GiaoVien" ? "block" : "none";
                
                // Disable các thẻ đang dùng required để submit form đăng kí
                if (role === "HocSinh") {
                    hsSection.style.display = "block";
                    phSection.style.display = "none";
                    gvSection.style.display = "none";
                    setInputsDisabled(hsSection, false);
                    setInputsDisabled(phSection, true);
                    setInputsDisabled(gvSection, true);
                } else if (role === "PhuHuynh") {
                    hsSection.style.display = "none";
                    phSection.style.display = "block";
                    gvSection.style.display = "none";
                    setInputsDisabled(hsSection, true);
                    setInputsDisabled(phSection, false);
                    setInputsDisabled(gvSection, true);
                } else if (role === "GiaoVien") {
                    hsSection.style.display = "none";
                    phSection.style.display = "none";
                    gvSection.style.display = "block";
                    setInputsDisabled(hsSection, true);
                    setInputsDisabled(phSection, true);
                    setInputsDisabled(gvSection, false);     
                    
                } else {
                    hsSection.style.display = "none";
                    phSection.style.display = "none";
                    gvSection.style.display = "none";
                    setInputsDisabled(hsSection, true);
                    setInputsDisabled(phSection, true);
                    setInputsDisabled(gvSection, true);
                }
            }
            
            // Hàm disable các thẻ input required
            function setInputsDisabled(container, disabled) {
                var inputs = container.querySelectorAll("input, select, textarea");
                inputs.forEach(function(input) {
                    input.disabled = disabled;
                });
            }
        </script>
        
        <style>
            body {
                font-family: 'Segoe UI', 'Roboto', sans-serif;
                background-color: #f8f9fa;
                color: #212529;
                line-height: 1.6;
            }

            h2 {
                text-align: center;
                margin-bottom: 2rem;
                color: #0d6efd;
            }

            label {
                font-weight: 500;
            }

            input, select, textarea {
                border-radius: 8px !important;
                padding: 10px !important;
                border: 1px solid #ced4da;
                transition: box-shadow 0.3s ease;
            }

            input:focus, select:focus, textarea:focus {
                outline: none;
                box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
            }

            .form-control::placeholder {
                color: #6c757d;
            }

            .form-check-label {
                margin-left: 4px;
            }

            #hocSinhSection, #phuHuynhSection, #giaoVienSection {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 0 8px rgba(0, 0, 0, 0.03);
                margin-bottom: 20px;
            }

            button[type="submit"] {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }

            button[type="submit"]:hover {
                background-color: #0b5ed7;
            }
        </style>
  
    </head>
    
    <body class="container mt-5">
        <h2>Đăng ký tài khoản người dùng</h2>
        <form action="<%= request.getContextPath() %>/RegisterServlet" method="post" enctype="multipart/form-data">
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
                    <label for="diaChiHS" class="form-label">Địa chỉ:</label>
                    <input type="text" class="form-control" id="addressHS" name="address" required />
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

            <!-- Form mở rộng cho Phụ Huynh -->
            <div id="phuHuynhSection" style="display: none;">
                <div class="mb-3">
                    <label for="diaChiPH" class="form-label">Địa chỉ:</label>
                    <input type="text" class="form-control" id="addressPH" name="address" required />
                </div>
            </div>
            
            <!-- Form mở rộng cho Giáo Viên -->
            <div id="giaoVienSection" style="display: none;">
                <div class="mb-3">
                    <label for="chuyenMon" class="form-label">Chuyên môn:</label>
                    <input type="text" class="form-control" id="chuyenMon" name="chuyenMon" required />
                </div>

                <div class="mb-3">
                    <label for="bangCap" class="form-label">Bằng cấp:</label>
                    <input type="text" class="form-control" id="bangCap" name="bangCap" required />
                </div>

                <div class="mb-3">
                    <label for="diaChiGV" class="form-label">Địa chỉ:</label>
                    <input type="text" class="form-control" id="diaChiGV" name="address" required />
                </div>

                <div class="mb-3">
                    <label for="tenTruongHocGV" class="form-label">Tên trường dạy:</label>
                    <input type="text" class="form-control" id="tenTruongHocGV" name="tenTruongHoc" required />
                </div>

                <div class="mb-3">
                    <label for="lopDangDay" class="form-label">Lớp đang dạy:</label>
                    <input type="text" class="form-control" id="lopDangDay" name="lopDangDay" placeholder="VD: 12A2" required />
                </div>

                <div class="mb-3">
                    <label for="fileDinhKem" class="form-label">File bằng cấp / hồ sơ (PDF, ảnh, Word):</label>
                    <input type="file" class="form-control" id="fileDinhKem" name="fileDinhKem" accept=".pdf,.doc,.docx,.jpg,.png" required />
                </div>
            </div>

            <button type="submit" class="btn btn-primary mt-3">Đăng ký</button>
        </form>
    </body>
</html>
