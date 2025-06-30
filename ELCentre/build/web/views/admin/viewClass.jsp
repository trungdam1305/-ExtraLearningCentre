<%-- 
    Document   : manageClass
    Created on : June 16, 2025, 10:33:02 PM
    Author     : Vuh26
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.LopHoc"%>
<%@page import="model.LichHoc"%>
<%@page import="model.GiaoVien"%>
<%@page import="model.HocSinh"%>
<%@page import="dal.GiaoVienDAO"%>
<%@page import="dal.HocSinhDAO"%>
<%@page import="dal.KhoaHocDAO"%>
<%@page import="model.KhoaHoc"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    // Lấy dữ liệu từ request
    LopHoc lopHoc = (LopHoc) request.getAttribute("lopHoc");
    LichHoc lichHoc = (LichHoc) request.getAttribute("lichHoc");
    Integer idKhoaHoc = (Integer) request.getAttribute("ID_KhoaHoc");
    Integer idKhoi = (Integer) request.getAttribute("ID_Khoi");

    // Khởi tạo các biến mặc định
    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    HocSinhDAO hocSinhDAO = new HocSinhDAO();
    GiaoVien giaoVien = null;
    List<HocSinh> hocSinhList = new ArrayList<>();
    List<GiaoVien> availableTeachers = new ArrayList<>();
    List<HocSinh> allStudents = new ArrayList<>();

    // Lấy dữ liệu nếu lopHoc không null
    if (lopHoc != null && idKhoaHoc != null) {
        try {
            giaoVien = giaoVienDAO.getGiaoVienByLopHoc(lopHoc.getID_LopHoc());
            hocSinhList = hocSinhDAO.getHocSinhByLopHoc(lopHoc.getID_LopHoc());
            allStudents = HocSinhDAO.adminGetAllHocSinh1();
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            KhoaHoc khoaHoc = khoaHocDAO.getKhoaHocById(idKhoaHoc);
            if (khoaHoc != null) {
                String tenKhoaHoc = khoaHoc.getTenKhoaHoc().toLowerCase();
                availableTeachers = giaoVienDAO.getTeachersBySpecialization(tenKhoaHoc);
                System.out.println("Available teachers size: " + availableTeachers.size()); // Debug
            } else {
                System.out.println("KhoaHoc is null for ID: " + idKhoaHoc); // Debug
            }
        } catch (Exception e) {
            System.out.println("Error fetching data: " + e.getMessage());
            e.printStackTrace();
        }
    } else {
        System.out.println("LopHoc or ID_KhoaHoc is null"); // Debug
    }

    // Gán các biến vào pageContext
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
            /* CSS cho nút trượt lên đầu trang */
            .scroll-to-top {
                position: fixed;
                bottom: 20px;
                right: 20px;
                display: none;
                width: 50px;
                height: 50px;
                background-color: #2196F3;
                color: white;
                border-radius: 50%;
                text-align: center;
                line-height: 50px;
                font-size: 24px;
                cursor: pointer;
                opacity: 0.8;
                transition: opacity 0.3s;
                z-index: 1000;
            }
            .scroll-to-top:hover {
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <div class="content-container">
            <h2 class="text-center mb-4">Chi tiết lớp học</h2>

            <!-- Thông báo toàn cục -->
            <c:if test="${not empty err}">
                <div class="alert alert-custom-danger" role="alert">${err}</div>
            </c:if>
            <c:if test="${not empty suc}">
                <div class="alert alert-success" role="alert">${suc}</div>
            </c:if>

            <c:if test="${lopHoc != null}">


                <!-- Thông tin giáo viên -->
                <div class="section-title">Thông tin giáo viên</div>
                <!-- Debug trạng thái giáo viên -->

                <c:choose>
                    <c:when test="${giaoVien != null}">
                        <div class="teacher-info">
                            <div class="detail-item">
                                <span class="detail-label">Họ và tên:</span> ${giaoVien.hoTen != null ? giaoVien.hoTen : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Số điện thoại:</span> ${giaoVien.SDT != null ? giaoVien.SDT : 'Chưa có'}
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Chuyên môn:</span> ${giaoVien.chuyenMon != null ? giaoVien.chuyenMon : 'Chưa có'}
                            </div>

                            <div class="detail-item">
                                <span class="detail-label">Trường học:</span> ${giaoVien.tenTruongHoc != null ? giaoVien.tenTruongHoc : 'Chưa có'}
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


                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <%-- Success messages --%>
                <c:if test="${not empty teacherSuc}">
                    <div class="alert alert-success">${teacherSuc}</div>
                </c:if>
                <c:if test="${not empty studentSuc}">
                    <div class="alert alert-success">${studentSuc}</div>
                </c:if>
                <%-- Error messages --%>
                <c:if test="${not empty teacherErr}">
                    <div class="alert alert-danger">${teacherErr}</div>
                </c:if>
                <c:if test="${not empty studentErr}">
                    <div class="alert alert-danger">${studentErr}</div>
                </c:if>

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
                                    <c:when test="${not empty availableTeachers}">
                                        <div class="mb-3">
                                            <label for="teacherSearch" class="form-label">Tìm kiếm giáo viên:</label>
                                            <input type="text" id="teacherSearch" class="form-control" placeholder="Nhập tên giáo viên" value="${param.teacherSearch}">
                                        </div>
                                        <form id="assignTeacherForm" action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                            <input type="hidden" name="action" value="assignTeacher">
                                            <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                            <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                            <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                            <input type="hidden" name="teacherSearch" id="hiddenTeacherSearch">
                                            <table class="teacher-table" id="teacherTable">
                                                <thead>
                                                    <tr>
                                                        <th>Mã giáo viên</th>
                                                        <th>Họ và tên</th>
                                                        <th>Chuyên môn</th>
                                                        <th>Trường học</th>
                                                        <th>Hành động</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="teacher" items="${availableTeachers}">
                                                        <tr>
                                                            <td>${teacher.ID_GiaoVien != null ? teacher.ID_GiaoVien : 'Chưa có'}</td>
                                                            <td>${teacher.hoTen != null ? teacher.hoTen : 'Chưa có'}</td>
                                                            <td>${teacher.chuyenMon != null ? teacher.chuyenMon : 'Chưa có'}</td>
                                                            <td>${teacher.tenTruongHoc != null ? teacher.tenTruongHoc : 'Chưa có'}</td>
                                                            <td>
                                                                <button type="submit" name="ID_GiaoVien" value="${teacher.ID_GiaoVien}" class="btn btn-success btn-sm">Chọn</button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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
                <!-- Debug kích thước danh sách học sinh -->
                <c:out value="HocSinhList size: ${hocSinhList != null ? hocSinhList.size() : 'null'}"/>
               <c:choose>
    <c:when test="${not empty hocSinhList}">
        <table class="student-table">
            <thead>
                <tr>
                    <th>Họ và tên</th>
                    <th>Giới tính</th>
                    <th>SĐT phụ huynh</th>
                    <th>Trường học</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="hocSinh" items="${hocSinhList}">
                    <tr>
                        <td>${hocSinh.hoTen != null ? hocSinh.hoTen : 'Chưa có'}</td>
                        <td>${hocSinh.gioiTinh != null ? hocSinh.gioiTinh : 'Chưa có'}</td>
                        <td>${hocSinh.SDT_PhuHuynh != null ? hocSinh.SDT_PhuHuynh : 'Chưa có'}</td>
                        <td>${hocSinh.tenTruongHoc != null ? hocSinh.tenTruongHoc : 'Chưa có'}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/ManageClassDetail" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="moveOutStudent">
                                <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                <input type="hidden" name="ID_HocSinh" value="${hocSinh.ID_HocSinh}">
                                <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa học sinh ${hocSinh.hoTen} khỏi lớp?');">
                                    <i class="bi bi-trash"></i> Xóa
                                </button>
                            </form>
                        </td>
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
                                    <input type="text" id="studentSearch" class="form-control" placeholder="Nhập tên học sinh" value="${param.studentSearch}">
                                </div>
                                <c:if test="${not empty allStudents}">
                                    <form id="addStudentForm" action="${pageContext.request.contextPath}/ManageClassDetail" method="post">
                                        <input type="hidden" name="action" value="addStudent">
                                        <input type="hidden" name="ID_LopHoc" value="${lopHoc.ID_LopHoc}">
                                        <input type="hidden" name="ID_KhoaHoc" value="${ID_KhoaHoc}">
                                        <input type="hidden" name="ID_Khoi" value="${ID_Khoi}">
                                        <input type="hidden" name="studentSearch" id="hiddenStudentSearch">
                                        <table class="student-table" id="studentTable">
                                            <thead>
                                                <tr>
                                                    <th>Mã học sinh</th>
                                                    <th>Họ và tên</th>
                                                    <th>Ngày sinh</th>
                                                    <th>Trường học</th> 
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="student" items="${allStudents}">
                                                    <tr>
                                                        <td>${student.ID_HocSinh != null ? student.ID_HocSinh : 'Chưa có'}</td>
                                                        <td>${student.hoTen != null ? student.hoTen : 'Chưa có'}</td>
                                                        <td>${student.ngaySinh != null ? student.ngaySinh : 'Chưa có'}</td>
                                                        <td>${student.tenTruongHoc != null ? student.tenTruongHoc : 'Chưa có'}</td> <!-- Hiển thị Trường học -->
                                                        <td>
                                                            <button type="submit" name="ID_HocSinh" value="${student.ID_HocSinh}" class="btn btn-success btn-sm">Thêm</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </form>
                                </c:if>
                                <c:if test="${empty allStudents}">
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

        <!-- Nút trượt lên đầu trang -->
        <div class="scroll-to-top" id="scrollToTop">
            <i class="bi bi-arrow-up"></i>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script>
            // Tìm kiếm học sinh
            document.getElementById('studentSearch').addEventListener('input', function () {
                let filter = this.value.toLowerCase();
                let table = document.getElementById('studentTable');
                let tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName('td')[1];
                    let txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = '';
                    } else {
                        tr[i].style.display = 'none';
                    }
                }
                // Lưu giá trị tìm kiếm vào input ẩn
                document.getElementById('hiddenStudentSearch').value = this.value;
            });

            // Tìm kiếm giáo viên
            document.getElementById('teacherSearch').addEventListener('input', function () {
                let filter = this.value.toLowerCase();
                let table = document.getElementById('teacherTable');
                let tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName('td')[1];
                    let txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = '';
                    } else {
                        tr[i].style.display = 'none';
                    }
                }
                // Lưu giá trị tìm kiếm vào input ẩn
                document.getElementById('hiddenTeacherSearch').value = this.value;
            });

            // Khôi phục trạng thái tìm kiếm
            window.addEventListener('load', function () {
                let teacherSearch = document.getElementById('teacherSearch');
                let studentSearch = document.getElementById('studentSearch');
                if (teacherSearch.value) {
                    teacherSearch.dispatchEvent(new Event('input'));
                }
                if (studentSearch.value) {
                    studentSearch.dispatchEvent(new Event('input'));
                }
            });

            // Xử lý nút trượt lên đầu trang
            const scrollToTopBtn = document.getElementById('scrollToTop');
            window.addEventListener('scroll', function () {
                if (window.scrollY > 100) {
                    scrollToTopBtn.style.display = 'block';
                } else {
                    scrollToTopBtn.style.display = 'none';
                }
            });
            scrollToTopBtn.addEventListener('click', function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        </script>
    </body>
</html>