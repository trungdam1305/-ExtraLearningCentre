package controller;

import dal.HocSinhDAO;
import dal.DiemDanhDAO;
import dal.GiaoVienDAO;
import dal.KhoaHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.NopBaiTapDAO;
import dal.TaiBaiTapDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.DiemDanh;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.HocSinh;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;
import model.NopBaiTapInfo;
import model.TaiKhoan;
import model.TaoBaiTap;

@MultipartConfig 
public class teacherGetFromDashboard extends HttpServlet {
    private final KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
    private final NopBaiTapDAO nopBaiTapDAO = new NopBaiTapDAO();
    private LopHocDAO lopHocDAO = new LopHocDAO();
    private DiemDanhDAO diemDanhDAO = new DiemDanhDAO(); // Khởi tạo DAO
    private LichHocDAO lichHocDAO = new LichHocDAO();
    private HocSinhDAO hocSinhDAO = new HocSinhDAO();// Khởi tạo DAO
    private TaiBaiTapDAO taiBaiTapDAO = new TaiBaiTapDAO();
    private final GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("views/login.jsp"); // Hoặc trang đăng nhập của bạn
            return;
        }
        switch (action) {
            case "lophoc":
                getLopHocList(request, response);
                break;
            case "lichhoc":
                showAttendancePage(request, response);
                break;    
            case "viewStudents": 
                showStudentList(request, response);
                break;    
            case "assignments":
                showAssignmentPage(request, response); // Gọi phương thức hiển thị trang bài tập
                break;
            case "viewSubmissions":
                showSubmissionsPage(request, response);
                break;
            case "diemdanh":
                showAttendanceOverviewPage(request, response);
                break;
            case "viewClassAttendance":
            showClassAttendanceReport(request, response);
            break;
            case "thongbao":
                break;
            case "blog":
                break;
            case "hotro":
                break;              
            default:
                response.sendRedirect("TeacherDashboard");
                break;
        }
    }
    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số action, nếu null thì gán bằng chuỗi rỗng để tránh lỗi
    String action = request.getParameter("action");
    if (action == null) {
        action = "";
    }
    
    // Sử dụng switch-case để dễ dàng thêm các hành động POST khác trong tương lai
    switch (action) {
        case "submitAttendance":
            saveAttendance(request, response);
            break;
            
        case "updateNote":
            updateScheduleNote(request, response);
            break;

        case "createAssignment": 
            createAssignment(request, response);
            break;
        case "gradeSubmission":
            gradeSubmission(request, response);
            break;
        default:
            // Nếu không có action nào khớp, có thể gọi doGet hoặc báo lỗi
            // Gọi doGet là một lựa chọn phổ biến
            
            break;
    }
    }
    
    private void showClassAttendanceReport(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int classId = Integer.parseInt(request.getParameter("classId"));

        LopHoc lopHoc = lopHocDAO.getLopHocById(classId);
        List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId); // Giả sử có phương thức này
        List<LichHoc> scheduleList = lichHocDAO.getAllSchedulesForClass(classId);
        Map<String, DiemDanh> attendanceMap = diemDanhDAO.getAttendanceMapForClass(classId);

        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleList", scheduleList);
        request.setAttribute("attendanceMap", attendanceMap);
        
        request.getRequestDispatcher("/views/teacher/classAttendanceReport.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    private void showAttendanceOverviewPage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");
    int idTaiKhoan = user.getID_TaiKhoan();

    // 1. Lấy các tham số từ request
    String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
    String courseParam = request.getParameter("courseId") == null ? "0" : request.getParameter("courseId");
    String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
    String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");

    try {
        int courseId = Integer.parseInt(courseParam);
        int creationYear = Integer.parseInt(yearParam);
        int currentPage = Integer.parseInt(pageStr);
        int itemsPerPage = 10;

        // 2. Lấy dữ liệu từ DAO
        int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear);
        List<LopHoc> classList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage);
        
        // Lấy dữ liệu cho các dropdown bộ lọc
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
        List<KhoaHoc> courseList = khoaHocDAO.adminGetAllKhoaHoc();
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears();
        
        // 3. Tính toán phân trang
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

        // 4. Đặt thuộc tính cho JSP
        request.setAttribute("classList", classList);
        request.setAttribute("courseList", courseList);
        request.setAttribute("yearList", yearList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        // Giữ lại giá trị lọc của người dùng
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("selectedYear", creationYear);

        request.getRequestDispatcher("/views/teacher/attendanceOverview.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/TeacherDashboard");
    }
}
    
    private void showSubmissionsPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            List<NopBaiTapInfo> submissionList = nopBaiTapDAO.getSubmissionsByAssignmentId(assignmentId);
            TaoBaiTap assignment = taiBaiTapDAO.getAssignmentById(assignmentId);
            
            request.setAttribute("submissionList", submissionList);
            request.setAttribute("assignment", assignment);
            request.getRequestDispatcher("/views/teacher/viewSubmissions.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc");
        }
    }

    private void gradeSubmission(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String assignmentIdStr = request.getParameter("assignmentId");
        try {
            int assignmentId = Integer.parseInt(assignmentIdStr);
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            BigDecimal grade = new BigDecimal(request.getParameter("diem"));
            String comment = request.getParameter("nhanXet");
            
            nopBaiTapDAO.updateGradeAndComment(assignmentId, studentId, grade, comment);
            
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=viewSubmissions&assignmentId=" + assignmentId + "&grade=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=viewSubmissions&assignmentId=" + assignmentIdStr + "&grade=error");
        }
    }
    
    private void showAssignmentPage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int classId = Integer.parseInt(request.getParameter("classId"));
        
        // Lấy thông tin lớp học
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

        // ✅ KIỂM TRA NULL NGAY LẬP TỨC
        if (lopHoc == null) {
            // Nếu không tìm thấy lớp, không thể tiếp tục. Chuyển hướng về trang danh sách.
            System.err.println("Không tìm thấy lớp học với ID: " + classId);
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=class_not_found");
            return; // Dừng lại ngay lập tức
        }

        // Nếu lớp học tồn tại, mới tiếp tục lấy danh sách bài tập
        List<TaoBaiTap> assignmentList = taiBaiTapDAO.getAssignmentsByClassId(classId);
        
        request.setAttribute("assignmentList", assignmentList);
        request.setAttribute("lopHoc", lopHoc);
        
        request.getRequestDispatcher("/views/teacher/assignmentManagement.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
    }
}
    
    /**
     * ✅ THÊM PHƯƠNG THỨC MỚI
     * Xử lý việc tạo và lưu một bài tập mới.
     */
        private void createAssignment(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
            HttpSession session = request.getSession();
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            GiaoVienDAO gvDao = new GiaoVienDAO();

            try {
                // Lấy thông tin từ form
                String classIdStr = request.getParameter("classId");
                System.out.println("classId received: " + classIdStr); // Log
                int classId = Integer.parseInt(classIdStr);
                String tenBaiTap = request.getParameter("tenBaiTap");
                String moTa = request.getParameter("moTa");
                LocalDate deadline = LocalDate.parse(request.getParameter("deadline"));
                int teacherId = gvDao.getGiaoVienByID(user.getID_TaiKhoan()).getID_GiaoVien();

                // Xử lý file upload
                String fileName = null;
                Part filePart = request.getPart("assignmentFile");
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + "uploads";
                    Path uploadDirPath = Paths.get(uploadPath);
                    if (!Files.exists(uploadDirPath)) {
                        System.out.println("Creating directory: " + uploadDirPath); // Log
                        Files.createDirectories(uploadDirPath);
                    }
                    System.out.println("Writing file: " + fileName); // Log
                    filePart.write(uploadPath + "/" + fileName);
                }

                // Tạo đối tượng bài tập mới
                TaoBaiTap newAssignment = new TaoBaiTap();
                newAssignment.setID_LopHoc(classId);
                newAssignment.setTenBaiTap(tenBaiTap);
                newAssignment.setMoTa(moTa);
                newAssignment.setDeadline(deadline);
                newAssignment.setID_GiaoVien(teacherId);
                newAssignment.setNgayTao(LocalDate.now());
                newAssignment.setFileName(fileName);

                // Lưu thông tin bài tập
                System.out.println("Adding assignment: " + tenBaiTap); // Log
                taiBaiTapDAO.addAssignment(newAssignment);
                System.out.println("Assignment added successfully"); // Log

                // Chuyển hướng thành công
                response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=assignments&classId=" + classId + "&create=success");;

            } catch (Exception e) {
                e.printStackTrace();
                String classIdStr = request.getParameter("classId");
                if (classIdStr != null) {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=assignments&classId=" + classIdStr + "&create=error");
                } else {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
                }
            }
        }
    
    private void showStudentList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId"));

            // Lấy danh sách học sinh từ DAO
            List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId);
            
            // Lấy thông tin lớp học để hiển thị tên lớp
            LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

            // Đặt các thuộc tính vào request
            request.setAttribute("studentList", studentList);
            request.setAttribute("lopHoc", lopHoc);
            
            // Chuyển tiếp đến trang JSP hiển thị danh sách
            request.getRequestDispatcher("/views/teacher/viewStudentList.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Xử lý nếu classId không hợp lệ
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
        }
    }
    
    private void updateScheduleNote(HttpServletRequest request, HttpServletResponse response) throws IOException {
    try {
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        String noteText = request.getParameter("noteText");
        
        LichHocDAO lichHocDAO = new LichHocDAO();
        lichHocDAO.updateNote(scheduleId, noteText);
        
        response.setStatus(HttpServletResponse.SC_OK); // Trả về mã thành công
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server");
    }
} 
    
    /**
     * Hiển thị trang điểm danh với danh sách học sinh.
     */
    private void showAttendancePage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));

        // ✅ BƯỚC 1: KIỂM TRA NGÀY HỢP LỆ TRƯỚC
        // Lấy thông tin buổi học từ DB để có ngày học chính xác
        LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);

        // Nếu buổi học không tồn tại hoặc ngày học không phải hôm nay -> chặn
        if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
            // Chuyển hướng về trang lịch dạy với thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=not_today");
            return; // Dừng xử lý ngay lập tức
        }

        // Nếu ngày hợp lệ, mới tiếp tục lấy danh sách sinh viên
        // 2. Lấy danh sách học sinh và trạng thái điểm danh hiện tại từ DAO
        List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);

        // 3. Đặt dữ liệu vào request để JSP có thể sử dụng
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleId", scheduleId);

        // 4. Chuyển tiếp đến trang JSP để hiển thị
        request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        System.err.println("Lỗi: scheduleId không hợp lệ.");
        response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=invalid_id");
    }
}


private void saveAttendance(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String saveStatus = "error"; // Mặc định là lỗi
    int scheduleId = 0;

    try {
        scheduleId = Integer.parseInt(request.getParameter("scheduleId"));

        // ✅ BƯỚC 2: KIỂM TRA NGÀY HỢP LỆ TRƯỚC KHI LƯU
        // Đây là lớp bảo vệ quan trọng nhất
        LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);
        if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
            // Nếu không phải hôm nay, chuyển hướng về trang lịch dạy với thông báo lỗi
            response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=save_forbidden");
            return; // Dừng xử lý, không cho phép lưu
        }

        String[] studentIds = request.getParameterValues("studentId");

        if (studentIds != null) {
            List<DiemDanh> attendanceList = new ArrayList<>();
            for (String studentIdStr : studentIds) {
                int studentId = Integer.parseInt(studentIdStr);
                String status = request.getParameter("status_" + studentId);
                DiemDanh record = new DiemDanh(null, studentId, scheduleId, status, "");
                attendanceList.add(record);
            }

            // Lưu từng bản ghi điểm danh
            for (DiemDanh record : attendanceList) {
                diemDanhDAO.saveOrUpdateAttendance(record);
            }

            // Cập nhật trạng thái 'daDiemDanh' cho buổi học
            lichHocDAO.markAttendanceAsCompleted(scheduleId);

            // Nếu mọi thứ thành công, đổi trạng thái
            saveStatus = "success";
        }

    } catch (Exception e) {
        saveStatus = "error";
        e.printStackTrace();
    } finally {
        // Nếu scheduleId = 0 (do lỗi parse ban đầu), không làm gì cả để tránh lỗi
        if (scheduleId != 0) {
            // Đặt thuộc tính báo trạng thái thành công/thất bại
            request.setAttribute("saveStatus", saveStatus);
            // Tải lại danh sách sinh viên với trạng thái mới nhất
            List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);
            request.setAttribute("studentList", studentList);
            request.setAttribute("scheduleId", scheduleId);
            // Chuyển tiếp về trang JSP
            request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response);
        }
    }
}

    private void getLopHocList(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    // --- 1. Đọc và xử lý tham số ---
    String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
    String courseParam = request.getParameter("course") == null ? "0" : request.getParameter("course");
    String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
    String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");
    
    int courseId = 0;
    int currentPage = 1;
    int creationYear = 0;
    int itemsPerPage = 10;
    
    try {
        courseId = Integer.parseInt(courseParam);
        currentPage = Integer.parseInt(pageStr);
        creationYear = Integer.parseInt(yearParam);
    } catch (NumberFormatException e) {
        System.err.println("Lỗi parse tham số: " + e.getMessage());
        // Giữ lại giá trị mặc định nếu có lỗi
    }

    // --- 2. Truy vấn dữ liệu từ Database ---
    int idTaiKhoan = user.getID_TaiKhoan();
    
    GiaoVien_TruongHoc gv = giaoVienDAO.getGiaoVienByID(idTaiKhoan);
    if (gv == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=user_info_not_found");
        return;
    }

    // Gọi các phương thức DAO với đầy đủ tham số
    int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear);
    List<LopHoc> lopHocList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage);
    
    // Lấy dữ liệu cho các bộ lọc
    List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc();
    List<Integer> yearList = lopHocDAO.getDistinctCreationYears();

    // --- 3. Tính toán phân trang ---
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
    if (totalPages == 0) totalPages = 1;

    // --- 4. Gửi dữ liệu sang View (JSP) ---
    request.setAttribute("gv", gv);
    request.setAttribute("lopHocList", lopHocList);
    request.setAttribute("khoaHocList", khoaHocList);
    request.setAttribute("yearList", yearList);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    
    // Giữ lại các giá trị đã lọc để hiển thị trên form
    request.setAttribute("keyword", keyword);
    request.setAttribute("selectedCourse", courseId); // Đổi tên cho nhất quán
    request.setAttribute("selectedYear", creationYear);

    // --- 5. Chuyển tiếp đến JSP ---
    request.getRequestDispatcher("views/teacher/viewAttendedClasses.jsp").forward(request, response);
}
}