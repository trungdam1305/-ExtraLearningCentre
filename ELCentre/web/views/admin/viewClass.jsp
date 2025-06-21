<%-- 
    Document   : viewClass
    Created on : Jun 21, 2025, 6:00:04 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.LopHoc"%>
<%@page import="model.LichHoc"%>
<%@page import="model.GiaoVien"%>
<%@page import="model.HocSinh"%>
<%@page import="dal.GiaoVienDAO"%>
<%@page import="dal.HocSinhDAO"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="model.KhoaHoc"%>
<%@page import="java.util.List"%>
<%
    LopHoc lopHoc = (LopHoc) request.getAttribute("lopHoc");
    LichHoc lichHoc = (LichHoc) request.getAttribute("lichHoc");
    int idKhoaHoc = (Integer) request.getAttribute("ID_KhoaHoc");
    int idKhoi = (Integer) request.getAttribute("ID_Khoi");

    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    HocSinhDAO hocSinhDAO = new HocSinhDAO();
    GiaoVien giaoVien = null;
    List<HocSinh> hocSinhList = null;
    List<GiaoVien> availableTeachers = null;
    List<HocSinh> allStudents = null; // Danh sách tất cả học sinh
    if (lopHoc != null) {
        try {
            giaoVien = giaoVienDAO.getGiaoVienByLopHoc(lopHoc.getID_LopHoc());
            hocSinhList = hocSinhDAO.getHocSinhByLopHoc(lopHoc.getID_LopHoc());
            allStudents = HocSinhDAO.adminGetAllHocSinh(); // Lấy tất cả học sinh
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization(tenKhoaHoc);
            }
        } catch (Exception e) {
            System.out.println("Error fetching data: " + e.getMessage());
        }
    }
    pageContext.setAttribute("giaoVien", giaoVien);
    pageContext.setAttribute("hocSinhList", hocSinhList);
    pageContext.setAttribute("availableTeachers", availableTeachers);
    pageContext.setAttribute("allStudents", allStudents);
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết lớp học</title>
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .content-container {
                padding: 20px;
                max-width: 900px;
                margin: 0 auto;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .section-title {
                font-size: 1.5rem;
                color: #003087;
                margin-top: 20px;
                margin-bottom: 10px;
            }
            .detail-item {
                margin-bottom: 15px;
            }
            .detail-label {
                font-weight: bold;
                color: #003087;
            }
            .teacher-info {
                border: 1px solid #dee2e6;
                padding: 10px;
                border-radius: 4px;
                background-color: #f8f9fa;
            }
            .student-table, .teacher-table {
                width: 100%;
                margin-top: 10px;
            }
            .student-table th, .teacher-table th {
                background-color: #2196F3;
                color: white;
                font-weight: bold;
            }
            .student-table td, .student-table th, .teacher-table td, .teacher-table th {
                padding: 8px;
                text-align: left;
                border: 1px solid #dee2e6;
            }
            .back-button {
                margin-top: 20px;
            }
            .alert-custom-danger {
                background-color: #ff5733;
                border-color: #ff5733;
                color: white;
                margin-bottom: 20px;
            }
            .teacher-select, .student-select {
                margin-top: 10px;
            }
            .teacher-select .form-select, .student-select .form-select {
                width: 100%;
                max-width: 400px;
            }
            #teacherModal .modal-dialog, #studentModal .modal-dialog {
                max-width: 800px;
            }
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="content-container">
            <h2 class="text-center mb-4">Chi tiết lớp học</h2>

            <!-- Thông báo -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-success" role="alert">${suc}</div>
            </c:if>

            <c:if test="${lopHoc != null}">
                <!-- Thông tin lớp học -->
                <div class="section-title">Thông tin lớp học</div>
                <div class="detail-item">
                    <span class="detail-label">Tên lớp học:</span> ${lopHoc.tenLopHoc}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Sĩ số:</span> ${lopHoc.siSo}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Sĩ số tối đa:</span> ${lopHoc.siSoToiDa}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Ghi chú:</span> ${lopHoc.ghiChu != null ? lopHoc.ghiChu : 'Chưa có'}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Trạng thái:</span> ${lopHoc.trangThai}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Ngày khởi tạo:</span> ${lopHoc.ngayTao != null ? lopHoc.ngayTao : 'Chưa có'}
                </div>
                <div class="detail-item">
                    <span class="detail-label">Thời gian học:</span>
                    <c:if test="${lichHoc != null}">
                        ${lichHoc.slotThoiGian} (${lichHoc.ngayHoc})
                    </c:if>
                    <c:if test="${lichHoc == null}">
                        <span style="color: red;">Chưa có lịch học</span>
                    </c:if>
                </div>
                <c:if test="${not empty lopHoc.image}">
                    <div class="detail-item">
                        <span class="detail-label">Ảnh lớp học:</span>
                        <img src="${pageContext.request.contextPath}/${lopHoc.image}" alt="Class Image" style="max-width: 200px; max-height: 266px; object-fit: cover; border-radius: 4px; border: 2px solid lightblue;" />
                    </div>
                </c:if>
                <c:if test="${empty lopHoc.image}">
                    <div class="detail-item">
                        <span class="detail-label">Ảnh lớp học:</span> Chưa có ảnh
                    </div>
                </c:if>

                <!-- Thông tin giáo viên -->
                <div class="section-title">Thông tin giáo viên</div>
                <c:choose>
                    <c:when test="${giaoVien != null}">
                        <div class="teacher-info">
                            <div class="detail-item">
                                <span class="detail-label">Họ và tên:</span> ${giaoVien.hoTen}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Số điện thoại:</span> ${giaoVien.SDT != null ? giaoVien.SDT : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Chuyên môn:</span> ${giaoVien.chuyenMon != null ? giaoVien.chuyenMon : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Lương:</span> ${giaoVien.luong != null ? giaoVien.luong : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ghi chú:</span> ${giaoVien.ghiChu != null ? giaoVien.ghiChu : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Trạng thái:</span> ${giaoVien.trangThai != null ? giaoVien.trangThai : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ngày tạo:</span> ${giaoVien.ngayTao != null ? giaoVien.ngayTao : 'Chưa có'}
                            </div>
                            <c:if test="${not empty giaoVien.avatar}">
                                <div class="detail-item">
                                    <span class="detail-label">Ảnh đại diện:</span>
                                    <img src="${pageContext.request.contextPath}/${giaoVien.avatar}" alt="Teacher Avatar" style="max-width: 150px; max-height: 200px; object-fit: cover; border-radius: 4px; border: 2px solid lightblue;" />
                                </div>
                            </c:if>
                            <c:if test="${empty giaoVien.avatar}">
                                <div class="detail-item">
                                    <span class="detail-label">Ảnh đại diện:</span> Chưa có ảnh
                                </div>
                            </c:if>
                            <button id="changeTeacherBtn" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                                <i class="bi bi-pencil-square"></i> Thay đổi giáo viên
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning" role="alert">Chưa có giáo viên được phân công.</div>
                        <button id="changeTeacherBtn" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#teacherModal">
                            <i class="bi bi-person-plus"></i> Thêm giáo viên
                        </button>
                    </c:otherwise>
                </c:choose>

                <!-- Modal để thay đổi giáo viên -->
                <div class="modal fade" id="teacherModal" tabindex="-1" aria-labelledby="teacherModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="teacherModalLabel">Chọn giáo viên</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <c:choose>
                                    <c:when test="${availableTeachers != null and not empty availableTeachers}">
                                        <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                            <input type="hidden" name="action" value="assignTeacher">
                                            <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                            <div class="mb-3">
                                                <label for="teacherSelectModal" class="form-label">Chọn giáo viên:</label>
                                                <select name="ID_GiaoVien" id="teacherSelectModal" class="form-select" required>
                                                    <option value="">-- Chọn giáo viên --</option>
                                                    <c:forEach var="teacher" items="${availableTeachers}">
                                                        <option value="${teacher.ID_GiaoVien}">${teacher.hoTen} (Chuyên môn: ${teacher.chuyenMon})</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Thêm giáo viên</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-warning">Không có giáo viên nào phù hợp với khóa học.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Danh sách học sinh -->
                <div class="section-title">Danh sách học sinh</div>
                <c:choose>
                    <c:when test="${hocSinhList != null and not empty hocSinhList}">
                        <table class="student-table">
                            <thead>
                                <tr>
                                    <th>Mã học sinh</th>
                                    <th>Họ và tên</th>
                                    <th>Ngày sinh</th>
                                    <th>Giới tính</th>
                                    <th>Địa chỉ</th>
                                    <th>SĐT phụ huynh</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="hocSinh" items="${hocSinhList}">
                                    <tr>
                                        <td>${hocSinh.ID_HocSinh != null ? hocSinh.ID_HocSinh : 'Chưa có'}</td>
                                        <td>${hocSinh.hoTen != null ? hocSinh.hoTen : 'Chưa có'}</td>
                                        <td>${hocSinh.ngaySinh != null ? hocSinh.ngaySinh : 'Chưa có'}</td>
                                        <td>${hocSinh.gioiTinh != null ? hocSinh.gioiTinh : 'Chưa có'}</td>
                                        <td>${hocSinh.diaChi != null ? hocSinh.diaChi : 'Chưa có'}</td>
                                        <td>${hocSinh.SDT_PhuHuynh != null ? hocSinh.SDT_PhuHuynh : 'Chưa có'}</td>
                                        <td>${hocSinh.trangThai != null ? hocSinh.trangThai : 'Chưa có'}</td>
                                        <td>${hocSinh.ngayTao != null ? hocSinh.ngayTao : 'Chưa có'}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning" role="alert">Chưa có học sinh nào trong lớp.</div>
                    </c:otherwise>
                </c:choose>
                <button id="showStudentsBtn" class="btn btn-primary mt-2" data-bs-toggle="modal" data-bs-target="#studentModal">
                    <i class="bi bi-plus-circle"></i> Thêm học sinh
                </button>

                <!-- Modal để thêm học sinh -->
                <div class="modal fade" id="studentModal" tabindex="-1" aria-labelledby="studentModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="studentModalLabel">Thêm học sinh</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="studentSearch" class="form-label">Tìm kiếm học sinh:</label>
                                    <input type="text" id="studentSearch" class="form-control" placeholder="Nhập tên hoặc mã học sinh...">
                                </div>
                                <c:if test="${allStudents != null and not empty allStudents}">
                                    <table class="student-table" id="studentTable">
                                        <thead>
                                            <tr>
                                                <th>Mã học sinh</th>
                                                <th>Họ và tên</th>
                                                <th>Ngày sinh</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="student" items="${allStudents}">
                                                <tr>
                                                    <td>${student.ID_HocSinh != null ? student.ID_HocSinh : 'Chưa có'}</td>
                                                    <td>${student.hoTen != null ? student.hoTen : 'Chưa có'}</td>
                                                    <td>${student.ngaySinh != null ? student.ngaySinh : 'Chưa có'}</td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="addStudent">
                                                            <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                                            <input type="hidden" name="ID_HocSinh" value="${student.ID_HocSinh}">
                                                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                                            <button type="submit" class="btn btn-success btn-sm">Add</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>
                                <c:if test="${allStudents == null or empty allStudents}">
                                    <div class="alert alert-warning">Không có học sinh nào trong database.</div>
                                </c:if>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>

            </c:if>
            <c:if test="${lopHoc == null}">
                <div class="alert alert-warning" role="alert">Không tìm thấy thông tin lớp học.</div>
            </c:if>

            <!-- Nút quay lại -->
            <div class="back-button">
                <a href="${pageContext.request.contextPath}/ManageClass?ID_KhoaHoc=${ID_KhoaHoc}&ID_Khoi=${ID_Khoi}" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </div>

        <!-- Bootstrap 5 JS và Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Tìm kiếm học sinh trong modal
            document.getElementById('studentSearch').addEventListener('input', function () {
                let filter = this.value.toLowerCase();
                let table = document.getElementById('studentTable');
                let tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName('td')[1]; // Cột họ và tên
                    let txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = '';
                    } else {
                        tr[i].style.display = 'none';
                    }
                }
            });
        </script>
    </body>
</html>