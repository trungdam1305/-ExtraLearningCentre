<%-- 
    Document   : updateClass
    Created on : June 21, 2025, 02:20 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LopHoc"%>
<%@page import="model.LichHoc"%>
<%@page import="dao.LichHocDAO"%>
<%@page import="java.util.*"%>
<%@page session="true" %> <!-- Bật session -->
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật lớp học</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .content-container {
                padding: 20px;
                max-width: 600px;
                margin: 0 auto;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 15px;
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
        </style>
    </head>
    <body>
        <%
            // Lưu hoặc lấy các tham số từ session
            String idLopHoc = request.getParameter("ID_LopHoc");
            if (idLopHoc == null) {
                idLopHoc = (String) session.getAttribute("idLopHoc");
            } else {
                session.setAttribute("idLopHoc", idLopHoc);
            }
            String idKhoaHoc = request.getParameter("ID_KhoaHoc");
            if (idKhoaHoc == null) {
                idKhoaHoc = (String) session.getAttribute("idKhoaHoc");
            } else {
                session.setAttribute("idKhoaHoc", idKhoaHoc);
            }
            String idKhoi = request.getParameter("ID_Khoi");
            if (idKhoi == null) {
                idKhoi = (String) session.getAttribute("idKhoi");
            } else {
                session.setAttribute("idKhoi", idKhoi);
            }

            LopHoc lopHoc = (LopHoc) request.getAttribute("lopHoc");
            LichHoc lichHoc = null;
            if (lopHoc != null && lopHoc.getID_Schedule() > 0) {
                try {
                    LichHocDAO lichHocDAO = new LichHocDAO();
                    lichHoc = lichHocDAO.getLichHocById(lopHoc.getID_Schedule());
                } catch (Exception e) {
                    System.out.println("Error fetching LichHoc: " + e.getMessage());
                    lichHoc = null; // Đảm bảo lichHoc không null gây lỗi
                }
            }
            pageContext.setAttribute("lichHoc", lichHoc);

            // Lấy giá trị từ request parameter để giữ dữ liệu đã nhập
            String tenLopHocParam = request.getParameter("TenLopHoc");
            String idSlotHocParam = request.getParameter("ID_SlotHoc");
            String ngayHocParam = request.getParameter("NgayHoc");
            String siSoParam = request.getParameter("SiSo");
            String siSoToiDaParam = request.getParameter("SiSoToiDa");
            String ghiChuParam = request.getParameter("GhiChu");
            String trangThaiParam = request.getParameter("TrangThai");
        %>

        <div class="content-container">
            <h2 class="text-center mb-4" style="color: #003087;">Cập nhật lớp học</h2>

            <!-- Thông báo -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-custom-success" role="alert">${suc}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/ManageClass" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="submitUpdateClass" />
                <input type="hidden" name="ID_LopHoc" value="${idLopHoc}" />
                <input type="hidden" name="ID_KhoaHoc" value="${idKhoaHoc}" />
                <input type="hidden" name="ID_Khoi" value="${idKhoi}" />

                <div class="form-group">
                    <label for="TenLopHoc">Tên lớp học:</label>
                    <input type="text" class="form-control" id="TenLopHoc" name="TenLopHoc" 
                           value="${not empty tenLopHocParam ? tenLopHocParam : lopHoc.tenLopHoc}" required>
                </div>

                <div class="form-group">
                    <label for="ID_SlotHoc">Thời gian học:</label>
                    <select class="form-select" id="ID_SlotHoc" name="ID_SlotHoc" required>
                        <c:forEach var="slot" items="${slotHocList}">
                            <option value="${slot.ID_SlotHoc}" 
                                    ${not empty idSlotHocParam ? idSlotHocParam == slot.ID_SlotHoc : (lichHoc != null && lichHoc.ID_SlotHoc == slot.ID_SlotHoc) ? 'selected' : ''}>
                                ${slot.slotThoiGian}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="NgayHoc">Ngày học:</label>
                    <input type="date" class="form-control" id="NgayHoc" name="NgayHoc" 
                           value="${not empty ngayHocParam ? ngayHocParam : (lichHoc != null ? lichHoc.ngayHoc : '')}" required>
                </div>

                <div class="form-group">
                    <label for="SiSo">Sĩ số:</label>
                    <input type="number" class="form-control" id="SiSo" name="SiSo" 
                           value="${not empty siSoParam ? siSoParam : lopHoc.siSo}" required>
                </div>

                <div class="form-group">
                    <label for="SiSoToiDa">Sĩ số tối đa:</label>
                    <input type="number" class="form-control" id="SiSoToiDa" name="SiSoToiDa" 
                           value="${not empty siSoToiDaParam ? siSoToiDaParam : lopHoc.siSoToiDa}" required>
                </div>

                <div class="form-group">
                    <label for="GhiChu">Ghi chú:</label>
                    <textarea class="form-control" id="GhiChu" name="GhiChu">${not empty ghiChuParam ? ghiChuParam : lopHoc.ghiChu}</textarea>
                </div>

                <div class="form-group">
                    <label for="TrangThai">Trạng thái:</label>
                    <select class="form-select" id="TrangThai" name="TrangThai" required>
                        <option value="Active" ${not empty trangThaiParam ? (trangThaiParam == 'Active' ? 'selected' : '') : (lopHoc.trangThai == 'Active' ? 'selected' : '')}>Đang hoạt động</option>
                        <option value="Inactive" ${not empty trangThaiParam ? (trangThaiParam == 'Inactive' ? 'selected' : '') : (lopHoc.trangThai == 'Inactive' ? 'selected' : '')}>Chưa hoạt động</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="Image">Ảnh lớp học:</label>
                    <input type="file" class="form-control" id="Image" name="Image" accept="image/*">
                    <c:if test="${not empty lopHoc.image}">
                        <img src="${pageContext.request.contextPath}/${lopHoc.image}" alt="Current Image" class="image-preview" />
                        <p class="text-muted mt-2">Chọn file mới để thay đổi ảnh hiện tại.</p>
                    </c:if>
                </div>

                <div>
                    <button type="submit" class="btn btn-custom mt-3">Cập nhật</button>

                </div>


            </form>
        </div>

        <!-- Nút quay lại -->
        <div style="display: flex; justify-content: center;">
            <button class="btn btn-secondary"
                    onclick="window.location.href = '${pageContext.request.contextPath}/ManageClass?action=refresh&ID_Khoi=<%= idKhoi != null ? idKhoi : "" %>&ID_KhoaHoc=<%= idKhoaHoc != null ? idKhoaHoc : "" %>'">
                Quay lại trang danh sách lớp học
            </button>
        </div>




        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>