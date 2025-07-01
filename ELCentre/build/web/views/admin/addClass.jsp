<%-- 
    Document   : addClass
    Created on : June 1, 2025, 10:33:02 PM
    Author     : Vuh26
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm lớp học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        .required-label::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea,
        input[type="file"] {
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
        .btn-primary {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-danger:hover {
            background-color: #b91c1c;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
            padding: 15px;
        }
        .alert-danger {
            background-color: #ef4444;
            color: white;
            font-weight: bold;
        }
        .alert-success {
            background-color: #22c55e;
            color: white;
            font-weight: bold;
        }
        .schedule-row {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
            align-items: center;
        }
        .schedule-row select,
        .schedule-row input[type="date"] {
            flex: 1;
        }
        .back-button {
            text-align: center;
            margin-top: 20px;
        }
        .back-button a {
            color: white;
            text-decoration: none;
        }
        p.info {
            color: #333;
            font-size: 14px;
            margin-bottom: 15px;
        }
        p.note {
            color: #666;
            font-size: 12px;
            margin-top: -10px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Thêm lớp học</h2>

        <!-- Thông báo -->
        <c:if test="${not empty err}">
            <div class="alert alert-danger">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-success">${suc}</div>
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại danh sách lớp học</a>
            </div>
        </c:if>

        <!-- Kiểm tra danh sách slot và phòng học -->
        <c:if test="${empty slotHocList || empty phongHocList}">
            <div class="alert alert-danger">
                <c:choose>
                    <c:when test="${empty slotHocList && empty phongHocList}">
                        Không có slot học và phòng học nào trong hệ thống. Vui lòng thêm dữ liệu trước!
                    </c:when>
                    <c:when test="${empty slotHocList}">
                        Không có slot học nào trong hệ thống. Vui lòng thêm slot học trước!
                    </c:when>
                    <c:otherwise>
                        Không có phòng học nào khả dụng. Vui lòng thêm phòng học!
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại</a>
            </div>
        </c:if>

        <!-- Form thêm lớp học -->
        <c:if test="${not empty slotHocList && not empty phongHocList}">
            <form action="${pageContext.request.contextPath}/ManageClass" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addClass">
                <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                <input type="hidden" name="trangThai" value="Inactive">

                <div class="mb-3">
                    <label for="tenLopHoc" class="form-label required-label">Tên lớp học:</label>
                    <input type="text" class="form-control" id="tenLopHoc" name="tenLopHoc" value="${tenLopHoc != null ? tenLopHoc : ''}" maxlength="100">
                    <p class="note">Tên lớp học tối đa 100 ký tự. Ví dụ: Lớp Toán Cao Cấp.</p>
                </div>

                <div class="mb-3">
                    <label for="classCode" class="form-label required-label">Mã lớp học:</label>
                    <input type="text" class="form-control" id="classCode" name="classCode" value="${classCode != null ? classCode : ''}" maxlength="20" readonly>
                    <p class="note">Mã lớp học được tự động tạo từ tên lớp học và khối học (ví dụ: Toán Cơ Bản khối 12 → TCB12).</p>
                </div>

                <div class="mb-3">
                    <label class="form-label">Khóa học:</label>
                    <p class="info">ID khóa học: <c:out value="${ID_KhoaHoc != null ? ID_KhoaHoc : 'Không xác định'}" /></p>
                </div>

                <div class="mb-3">
                    <label class="form-label">Khối học:</label>
                    <p class="info">Khối: 
                        <c:choose>
                            <c:when test="${not empty ID_Khoi and ID_Khoi >= 1 and ID_Khoi <= 7}">
                                Lớp <c:out value="${ID_Khoi + 5}"/>
                            </c:when>
                            <c:otherwise>
                                Tổng ôn
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="mb-3">
                    <label for="siSoToiDa" class="form-label required-label">Sĩ số tối đa:</label>
                    <input type="number" class="form-control" id="siSoToiDa" name="siSoToiDa" value="${siSoToiDa != null ? siSoToiDa : ''}" min="1">
                    <p class="note">Sĩ số tối đa phải lớn hơn 0 và nhỏ hơn sức chứa phòng học.</p>
                </div>

                <div class="mb-3">
                    <label for="siSoToiThieu" class="form-label required-label">Sĩ số tối thiểu:</label>
                    <input type="number" class="form-control" id="siSoToiThieu" name="siSoToiThieu" value="${siSoToiThieu != null ? siSoToiThieu : ''}" min="0">
                    <p class="note">Sĩ số tối thiểu phải là số không âm và nhỏ hơn hoặc bằng sĩ số tối đa.</p>
                </div>

                <div class="mb-3">
                    <label for="ghiChu" class="form-label">Ghi chú:</label>
                    <textarea class="form-control" id="ghiChu" name="ghiChu" maxlength="500">${ghiChu != null ? ghiChu : ''}</textarea>
                    <p class="note">Ghi chú tối đa 500 ký tự.</p>
                </div>

                <div class="mb-3">
                    <label for="soTien" class="form-label">Học phí:</label>
                    <input type="number" class="form-control" id="soTien" name="soTien" value="${soTien != null ? soTien : ''}" min="0" step="1">
                    <p class="note">Học phí là số nguyên không âm, tối đa 10 chữ số.</p>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">Ảnh đại diện lớp học:</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/png">
                    <p class="note">Chỉ chấp nhận file ảnh .jpg hoặc .png, kích thước tối đa 3MB.</p>
                </div>

                <div class="mb-3">
                    <label for="order" class="form-label">Thứ tự:</label>
                    <input type="number" class="form-control" id="order" name="order" value="${order != null ? order : '0'}" min="0" step="1">
                    <p class="note">Thứ tự phải là số không âm.</p>
                </div>

                <div class="mb-3">
                    <label class="form-label required-label">Lịch học:</label>
                    <p class="note">Định dạng ngày học: YYYY-MM-DD (ví dụ: 2025-06-30). Tối đa 10 lịch học.</p>
                    <div id="scheduleContainer">
                        <c:if test="${not empty ngayHocs && fn:length(ngayHocs) > 0}">
                            <c:forEach var="i" begin="0" end="${fn:length(ngayHocs) - 1}">
                                <div class="schedule-row">
                                    <input type="date" class="form-control" name="ngayHoc[]" value="${ngayHocs[i]}">
                                    <select class="form-select" name="idSlotHoc[]">
                                        <option value="">Chọn slot học</option>
                                        <c:forEach var="slot" items="${slotHocList}">
                                            <option value="${slot.ID_SlotHoc}" ${idSlotHocs[i] == slot.ID_SlotHoc ? 'selected' : ''}>${slot.slotThoiGian}</option>
                                        </c:forEach>
                                    </select>
                                    <select class="form-select" name="idPhongHoc[]">
                                        <option value="">Chọn phòng học</option>
                                        <c:forEach var="phongHoc" items="${phongHocList}">
                                            <option value="${phongHoc.ID_PhongHoc}" ${idPhongHocs[i] == phongHoc.ID_PhongHoc ? 'selected' : ''}>${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove()">Xóa</button>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty ngayHocs}">
                            <div class="schedule-row">
                                <input type="date" class="form-control" name="ngayHoc[]">
                                <select class="form-select" name="idSlotHoc[]">
                                    <option value="">Chọn slot học</option>
                                    <c:forEach var="slot" items="${slotHocList}">
                                        <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                                    </c:forEach>
                                </select>
                                <select class="form-select" name="idPhongHoc[]">
                                    <option value="">Chọn phòng học</option>
                                    <c:forEach var="phongHoc" items="${phongHocList}">
                                        <option value="${phongHoc.ID_PhongHoc}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                                    </c:forEach>
                                </select>
                                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove()">Xóa</button>
                            </div>
                        </c:if>
                    </div>
                    <button type="button" class="btn btn-primary mt-2" onclick="addScheduleRow()">Thêm lịch học</button>
                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Thêm</button>
                    <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${ID_Khoi}&ID_KhoaHoc=${ID_KhoaHoc}" class="btn btn-secondary">Quay lại</a>
                </div>
            </form>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        function removeVietnameseAccents(str) {
            return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '')
                .replace(/đ/g, 'd').replace(/Đ/g, 'D');
        }

        function generateClassCode(className, idKhoi) {
            if (!className) return '';
            
            // Loại bỏ dấu tiếng Việt và chuyển thành chữ thường
            className = removeVietnameseAccents(className).toLowerCase();
            
            // Lấy chữ cái đầu của mỗi từ
            let initials = className.split(/\s+/).map(word => word.charAt(0).toUpperCase()).join('');
            
            // Tính số khối (ID_Khoi từ 1 đến 7 tương ứng lớp 6 đến 12)
            let grade = idKhoi >= 1 && idKhoi <= 7 ? (idKhoi + 5) : 0;
            // Định dạng số khối thành 2 chữ số (ví dụ: 9 → "09", 12 → "12")
            let gradeStr = grade > 0 ? grade.toString().padStart(2, '0') : '';
            
            return initials + gradeStr;
        }

        function updateClassCode() {
            const tenLopHoc = document.getElementById('tenLopHoc').value;
            const idKhoi = parseInt('${ID_Khoi}' || '0');
            const classCodeInput = document.getElementById('classCode');
            classCodeInput.value = generateClassCode(tenLopHoc, idKhoi);
        }

        // Gắn sự kiện input cho tenLopHoc
        document.getElementById('tenLopHoc').addEventListener('input', updateClassCode);

        // Cập nhật mã lớp học khi trang tải
        window.addEventListener('load', updateClassCode);

        function addScheduleRow() {
            const container = document.getElementById('scheduleContainer');
            const row = document.createElement('div');
            row.className = 'schedule-row';
            row.innerHTML = `
                <input type="date" class="form-control" name="ngayHoc[]">
                <select class="form-select" name="idSlotHoc[]">
                    <option value="">Chọn slot học</option>
                    <c:forEach var="slot" items="${slotHocList}">
                        <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                    </c:forEach>
                </select>
                <select class="form-select" name="idPhongHoc[]">
                    <option value="">Chọn phòng học</option>
                    <c:forEach var="phongHoc" items="${phongHocList}">
                        <option value="${phongHoc.ID_PhongHoc}">${phongHoc.tenPhongHoc} (Sức chứa: ${phongHoc.sucChua})</option>
                    </c:forEach>
                </select>
                <button type="button" class="btn btn-danger btn-sm" onclick="this.parentElement.remove()">Xóa</button>
            `;
            container.appendChild(row);
        }

        // Validate siSoToiThieu <= siSoToiDa
        document.getElementById('siSoToiDa').addEventListener('input', function() {
            const siSoToiDa = parseInt(this.value);
            const siSoToiThieuInput = document.getElementById('siSoToiThieu');
            const siSoToiThieu = parseInt(siSoToiThieuInput.value);
            if (!isNaN(siSoToiDa) && !isNaN(siSoToiThieu) && siSoToiThieu > siSoToiDa) {
                siSoToiThieuInput.setCustomValidity('Sĩ số tối thiểu phải nhỏ hơn hoặc bằng sĩ số tối đa.');
            } else {
                siSoToiThieuInput.setCustomValidity('');
            }
        });

        document.getElementById('siSoToiThieu').addEventListener('input', function() {
            const siSoToiThieu = parseInt(this.value);
            const siSoToiDaInput = document.getElementById('siSoToiDa');
            const siSoToiDa = parseInt(siSoToiDaInput.value);
            if (!isNaN(siSoToiDa) && !isNaN(siSoToiThieu) && siSoToiThieu > siSoToiDa) {
                this.setCustomValidity('Sĩ số tối thiểu phải nhỏ hơn hoặc bằng sĩ số tối đa.');
            } else {
                this.setCustomValidity('');
            }
        });
    </script>
</body>
</html>