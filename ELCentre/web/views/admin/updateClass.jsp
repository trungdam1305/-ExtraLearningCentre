<%-- 
    Document   : updateClass
    Created on : Jul 1, 2025, 8:01:20 AM
    Author     : Vuh26
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="model.LopHocInfoDTO, java.util.UUID, java.util.List, java.util.ArrayList, dal.LichHocDAO, model.LichHoc"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật lớp học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .content-container {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .required-label::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #003087;
            border-color: #003087;
            color: white;
        }
        .btn-custom:hover {
            background-color: #00215a;
            border-color: #00215a;
        }
        .alert-custom-danger {
            background-color: #ff5733;
            border-color: #ff5733;
            color: white;
            margin-bottom: 20px;
        }
        .alert-custom-success {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
            margin-bottom: 20px;
        }
        .image-preview {
            max-width: 200px;
            max-height: 266px;
            object-fit: cover;
            border-radius: 4px;
            border: 2px solid lightblue;
            margin-top: 10px;
        }
        .schedule-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }
        .schedule-row .form-control,
        .schedule-row .form-select {
            flex: 1;
        }
        .schedule-row .btn-remove {
            background-color: #dc2626;
            border-color: #dc2626;
            color: white;
        }
        .schedule-row .btn-remove:hover {
            background-color: #b91c1c;
            border-color: #b91c1c;
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
    <%
        String idLopHoc = request.getParameter("ID_LopHoc");
        if (idLopHoc == null) idLopHoc = (String) session.getAttribute("idLopHoc");
        else session.setAttribute("idLopHoc", idLopHoc);

        String idKhoaHoc = request.getParameter("ID_KhoaHoc");
        if (idKhoaHoc == null) idKhoaHoc = (String) session.getAttribute("idKhoaHoc");
        else session.setAttribute("idKhoaHoc", idKhoaHoc);

        String idKhoi = request.getParameter("ID_Khoi");
        if (idKhoi == null) idKhoi = (String) session.getAttribute("idKhoi");
        else session.setAttribute("idKhoi", idKhoi);

        if (session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }

        LopHocInfoDTO lopHoc = (LopHocInfoDTO) request.getAttribute("lopHoc");
        List<String> ngayHocs = new ArrayList<>();
        List<Integer> idSlotHocs = new ArrayList<>();
        List<Integer> idPhongHocs = new ArrayList<>();

        if (lopHoc != null && lopHoc.getIdLopHoc() > 0) {
            try {
                LichHocDAO lichHocDAO = new LichHocDAO();
                List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(lopHoc.getIdLopHoc());
                for (LichHoc lichHoc : lichHocList) {
                    ngayHocs.add(lichHoc.getNgayHoc() != null ? lichHoc.getNgayHoc().toString() : "");
                    idSlotHocs.add(lichHoc.getID_SlotHoc());
                    idPhongHocs.add(lichHoc.getID_PhongHoc());
                }
            } catch (Exception e) {
                // Bỏ qua để tránh treo
            }
        }
        pageContext.setAttribute("ngayHocs", ngayHocs);
        pageContext.setAttribute("idSlotHocs", idSlotHocs);
        pageContext.setAttribute("idPhongHocs", idPhongHocs);
    %>

    <div class="content-container">
        <h2 class="text-center mb-4" style="color: #003087;">Cập nhật lớp học</h2>

        <c:if test="${not empty err}">
            <div class="alert alert-custom-danger" role="alert">${err}</div>
        </c:if>
        <c:if test="${not empty suc}">
            <div class="alert alert-custom-success" role="alert">${suc}</div>
        </c:if>
        <c:if test="${empty idLopHoc || empty idKhoaHoc || empty idKhoi}">
            <div class="alert alert-custom-danger" role="alert">Thiếu tham số ID_LopHoc, ID_KhoaHoc hoặc ID_Khoi.</div>
        </c:if>
        <c:if test="${empty lopHoc}">
            <div class="alert alert-custom-danger" role="alert">Không tìm thấy thông tin lớp học.</div>
        </c:if>

        <c:if test="${not empty idLopHoc && not empty idKhoaHoc && not empty idKhoi && not empty lopHoc}">
            <form action="${pageContext.request.contextPath}/ManageClass" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updateClass" />
                <input type="hidden" name="ID_LopHoc" value="${idLopHoc}" />
                <input type="hidden" name="ID_KhoaHoc" value="${idKhoaHoc}" />
                <input type="hidden" name="ID_Khoi" value="${idKhoi}" />
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}" />

                <div class="form-group">
                    <label for="classCode" class="form-label">Mã lớp học:</label>
                    <input type="text" class="form-control" id="classCode" name="classCode" value="${lopHoc.classCode}" readonly>
                    <p class="note">Mã lớp học không thể chỉnh sửa.</p>
                </div>

                <div class="form-group">
                    <label for="tenLopHoc" class="form-label">Tên lớp học:</label>
                    <input type="text" class="form-control" id="tenLopHoc" name="tenLopHoc" value="${lopHoc.tenLopHoc}" readonly>
                    <p class="note">Tên lớp học không thể chỉnh sửa.</p>
                </div>

                <div class="form-group">
                    <label for="siSo" class="form-label">Sĩ số:</label>
                    <input type="number" class="form-control" id="siSo" name="siSo" value="${lopHoc.siSo}" readonly>
                    <p class="note">Sĩ số không thể chỉnh sửa trực tiếp.</p>
                </div>

                <div class="form-group">
                    <label for="siSoToiDa" class="form-label required-label">Sĩ số tối đa:</label>
                    <input type="number" class="form-control" id="siSoToiDa" name="siSoToiDa" value="${not empty param.siSoToiDa ? param.siSoToiDa : lopHoc.siSoToiDa}" min="1">
                    <p class="note">Sĩ số tối đa phải lớn hơn hoặc bằng sĩ số hiện tại (${lopHoc.siSo}).</p>
                </div>

                <div class="form-group">
                    <label for="soTien" class="form-label">Học phí:</label>
                    <input type="number" class="form-control" id="soTien" name="soTien" value="${not empty param.soTien ? param.soTien : lopHoc.soTien}" min="0" step="1">
                    <p class="note">Học phí là số nguyên không âm, tối đa 10 chữ số.</p>
                </div>

                <div class="form-group">
                    <label for="order" class="form-label">Thứ tự:</label>
                    <input type="number" class="form-control" id="order" name="order" value="${not empty param.order ? param.order : '0'}" min="0" step="1">
                    <p class="note">Thứ tự phải là số không âm.</p>
                </div>

                <div class="form-group">
                    <label class="form-label required-label">Lịch học:</label>
                    <p class="note">Định dạng ngày học: YYYY-MM-DD (ví dụ: 2025-06-30). Tối đa 10 lịch học.</p>
                    <div id="scheduleContainer">
                        <c:choose>
                            <c:when test="${not empty ngayHocs && fn:length(ngayHocs) > 0}">
                                <c:forEach var="i" begin="0" end="${fn:length(ngayHocs)-1}">
                                    <div class="schedule-row" id="scheduleRow${i}">
                                        <input type="date" class="form-control" name="ngayHoc[]" value="${not empty paramValues['ngayHoc[]'] && not empty paramValues['ngayHoc[]'][i] ? paramValues['ngayHoc[]'][i] : ngayHocs[i]}">
                                        <select class="form-select" name="idSlotHoc[]">
                                            <option value="">Chọn slot học</option>
                                            <c:forEach var="slot" items="${slotHocList}">
                                                <option value="${slot.ID_SlotHoc}" ${not empty paramValues['idSlotHoc[]'] && not empty paramValues['idSlotHoc[]'][i] ? (paramValues['idSlotHoc[]'][i] == slot.ID_SlotHoc ? 'selected' : '') : (idSlotHocs[i] == slot.ID_SlotHoc ? 'selected' : '')}>${slot.slotThoiGian}</option>
                                            </c:forEach>
                                        </select>
                                        <select class="form-select" name="idPhongHoc[]">
                                            <option value="">Chọn phòng học</option>
                                            <c:forEach var="phong" items="${phongHocList}">
                                                <option value="${phong.ID_PhongHoc}" ${not empty paramValues['idPhongHoc[]'] && not empty paramValues['idPhongHoc[]'][i] ? (paramValues['idPhongHoc[]'][i] == phong.ID_PhongHoc ? 'selected' : '') : (idPhongHocs[i] == phong.ID_PhongHoc ? 'selected' : '')}>${phong.tenPhongHoc} (Sức chứa: ${phong.sucChua})</option>
                                            </c:forEach>
                                        </select>
                                        <button type="button" class="btn btn-remove btn-sm" onclick="this.parentElement.remove()">Xóa</button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="schedule-row" id="scheduleRow0">
                                    <input type="date" class="form-control" name="ngayHoc[]">
                                    <select class="form-select" name="idSlotHoc[]">
                                        <option value="">Chọn slot học</option>
                                        <c:forEach var="slot" items="${slotHocList}">
                                            <option value="${slot.ID_SlotHoc}">${slot.slotThoiGian}</option>
                                        </c:forEach>
                                    </select>
                                    <select class="form-select" name="idPhongHoc[]">
                                        <option value="">Chọn phòng học</option>
                                        <c:forEach var="phong" items="${phongHocList}">
                                            <option value="${phong.ID_PhongHoc}">${phong.tenPhongHoc} (Sức chứa: ${phong.sucChua})</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn btn-remove btn-sm" onclick="this.parentElement.remove()">Xóa</button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <button type="button" class="btn btn-custom mt-2" onclick="addScheduleRow()">Thêm lịch học</button>
                </div>

                <div class="form-group">
                    <label for="ghiChu" class="form-label">Ghi chú:</label>
                    <textarea class="form-control" id="ghiChu" name="ghiChu">${not empty param.ghiChu ? param.ghiChu : lopHoc.ghiChu}</textarea>
                    <p class="note">Ghi chú tối đa 500 ký tự.</p>
                </div>

                <div class="form-group">
                    <label for="trangThai" class="form-label required-label">Trạng thái:</label>
                    <select class="form-select" id="trangThai" name="trangThai">
                        <option value="Inactive" ${not empty param.trangThai ? (param.trangThai == 'Inactive' ? 'selected' : '') : (lopHoc.trangThai == 'Chưa học' ? 'selected' : '')}>Chưa học</option>
                        <option value="Active" ${not empty param.trangThai ? (param.trangThai == 'Active' ? 'selected' : '') : (lopHoc.trangThai == 'Đang học' ? 'selected' : '')}>Đang học</option>
                        <option value="Finished" ${not empty param.trangThai ? (param.trangThai == 'Finished' ? 'selected' : '') : (lopHoc.trangThai == 'Kết thúc' ? 'selected' : '')}>Kết thúc</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="image" class="form-label">Ảnh lớp học:</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/png">
                    <c:if test="${not empty lopHoc.avatarGiaoVien}">
                        <img src="${pageContext.request.contextPath}/${lopHoc.avatarGiaoVien}" alt="Current Image" class="image-preview" />
                        <p class="note">Chọn file mới để thay đổi ảnh hiện tại. Chỉ chấp nhận .jpg hoặc .png, tối đa 3MB.</p>
                    </c:if>
                </div>

                <div class="form-group text-center">
                    <button type="submit" class="btn btn-custom mt-3">Cập nhật</button>
                </div>
            </form>
        </c:if>

        <div class="text-center mt-3">
            <c:if test="${not empty idKhoaHoc && not empty idKhoi}">
                <a href="${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=${idKhoi}&ID_KhoaHoc=${idKhoaHoc}" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách lớp học
                </a>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        function addScheduleRow() {
            const container = document.getElementById('scheduleContainer');
            const row = document.createElement('div');
            row.className = 'schedule-row';
            row.id = 'scheduleRow' + container.children.length;
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
                    <c:forEach var="phong" items="${phongHocList}">
                        <option value="${phong.ID_PhongHoc}">${phong.tenPhongHoc} (Sức chứa: ${phong.sucChua})</option>
                    </c:forEach>
                </select>
                <button type="button" class="btn btn-remove btn-sm" onclick="this.parentElement.remove()">Xóa</button>
            `;
            container.appendChild(row);
        }
    </script>
</body>
</html>
