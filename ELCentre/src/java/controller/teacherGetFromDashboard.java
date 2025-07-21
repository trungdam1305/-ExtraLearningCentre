
package controller;

import dal.HocSinhDAO;
import dal.DiemDanhDAO;
import dal.GiaoVienDAO;
import dal.HoTroDAO;
import dal.KhoaHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.NopBaiTapDAO;
import dal.TaiBaiTapDAO;
import dal.ThongBaoDAO;
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
import model.HoTro;
import model.HocSinh;
import model.KhoaHoc;
import model.LichHoc;
import model.LopHoc;
import model.NopBaiTapInfo;
import model.TaiKhoan;
import model.TaoBaiTap;
import model.ThongBao;

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
            response.sendRedirect("views/login.jsp"); 
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
                showAssignmentPage(request, response); 
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
                showThongBao(request, response) ;
                break;
            case "blog":
                break;
            case "hotro":
                showHoTro(request, response) ; 
                break;
            default:
                response.sendRedirect("TeacherDashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get action parameter
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
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
                doGet(request, response);
                break;
        }
    }

    private void showHoTro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();     
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        ArrayList<HoTro> hotros = HoTroDAO.getHoTroByIdTaiKhoan(user.getID_TaiKhoan()) ; 
        if (hotros == null ) {
            request.setAttribute("message", "Không có yêu cầu hỗ trợ nào đã được gửi!");
            request.getRequestDispatcher("/views/teacher/teacherReceiveHoTro.jsp").forward(request, response);
        } else {
            session.setAttribute("hotros",hotros );
            request.getRequestDispatcher("/views/teacher/teacherReceiveHoTro.jsp").forward(request, response);
        }
    }
    
    private void showThongBao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();     
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
       
        List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(user.getID_TaiKhoan());
            request.setAttribute("dsThongBao", dsThongBao);
        if (dsThongBao == null ) {
            request.setAttribute("message", "Không có yêu cầu hỗ trợ nào đã được gửi!");
            request.getRequestDispatcher("/views/teacher/teacherReceiveThongBao.jsp").forward(request, response);
        } else {
            session.setAttribute("hotros",dsThongBao );
            request.getRequestDispatcher("/views/teacher/teacherReceiveThongBao.jsp").forward(request, response);
        }
    }
    
    private void showClassAttendanceReport(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        //get parameter classId
        int classId = Integer.parseInt(request.getParameter("classId"));
        
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId);//get lophoc
        List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId); //get list student
        List<LichHoc> scheduleList = lichHocDAO.getAllSchedulesForClass(classId); //get schedule
        Map<String, DiemDanh> attendanceMap = diemDanhDAO.getAttendanceMapForClass(classId); //diemdanh
        
        //set Attribute 
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleList", scheduleList);
        request.setAttribute("attendanceMap", attendanceMap);
        
        //request to the new page
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

    //get request
    String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
    String courseParam = request.getParameter("courseId") == null ? "0" : request.getParameter("courseId");
    String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
    String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");

    try {
        int courseId = Integer.parseInt(courseParam);
        int creationYear = Integer.parseInt(yearParam);
        int currentPage = Integer.parseInt(pageStr);
        int itemsPerPage = 10;

        // get data from DAO
        int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear);
        List<LopHoc> classList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage);
        
        // get data for dropdown
        KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
        List<KhoaHoc> courseList = khoaHocDAO.adminGetAllKhoaHoc();
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears();
        
        // pagination
        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
        
        // set attribute
        request.setAttribute("classList", classList);
        request.setAttribute("courseList", courseList);
        request.setAttribute("yearList", yearList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("selectedYear", creationYear);
        
        //request to jsp
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
        
        //get class's information
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

        //check null
        if (lopHoc == null) {
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=class_not_found");
            return;
        }

        // if class existed, get lists
        List<TaoBaiTap> assignmentList = taiBaiTapDAO.getAssignmentsByClassId(classId);
        
        request.setAttribute("assignmentList", assignmentList);
        request.setAttribute("lopHoc", lopHoc);
        
        request.getRequestDispatcher("/views/teacher/assignmentManagement.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
    }
}
        
    //Create Assignment for each class
        private void createAssignment(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
            HttpSession session = request.getSession();
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            GiaoVienDAO gvDao = new GiaoVienDAO();

            try {
                //get data from form
                String classIdStr = request.getParameter("classId");
                int classId = Integer.parseInt(classIdStr);
                String tenBaiTap = request.getParameter("tenBaiTap");
                String moTa = request.getParameter("moTa");
                LocalDate deadline = LocalDate.parse(request.getParameter("deadline"));
                int teacherId = gvDao.getGiaoVienByID(user.getID_TaiKhoan()).getID_GiaoVien();

                //execute file
                String fileName = null;
                Part filePart = request.getPart("assignmentFile");
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + "uploads";
                    Path uploadDirPath = Paths.get(uploadPath);
                    if (!Files.exists(uploadDirPath)) {
                        Files.createDirectories(uploadDirPath);
                    }
                    filePart.write(uploadPath + "/" + fileName);
                }

                //create object newAssignment
                TaoBaiTap newAssignment = new TaoBaiTap();
                newAssignment.setID_LopHoc(classId);
                newAssignment.setTenBaiTap(tenBaiTap);
                newAssignment.setMoTa(moTa);
                newAssignment.setDeadline(deadline);
                newAssignment.setID_GiaoVien(teacherId);
                newAssignment.setNgayTao(LocalDate.now());
                newAssignment.setFileName(fileName);

                //add assignment to db
                taiBaiTapDAO.addAssignment(newAssignment);

                //requests
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

            // get studentList from DAO and db
            List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId);
            
            // get infor to display name
            LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

            // set attribute
            request.setAttribute("studentList", studentList);
            request.setAttribute("lopHoc", lopHoc);
            
            // request to jsp
            request.getRequestDispatcher("/views/teacher/viewStudentList.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // if classId invalid
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
        }
    }
    
    private void updateScheduleNote(HttpServletRequest request, HttpServletResponse response) throws IOException {
    try {
        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        String noteText = request.getParameter("noteText");
        
        LichHocDAO lichHocDAO = new LichHocDAO();
        lichHocDAO.updateNote(scheduleId, noteText);
        
        response.setStatus(HttpServletResponse.SC_OK); // set ok
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Wrong");
    }
} 
    
    
    private void showAttendancePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            
            //get schedule from db
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);
            
            //if schedule == null => fail
            if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
                response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=not_today");
                return;
            }
            //get studentList from db
            List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);
            
            //set Attribute
            request.setAttribute("studentList", studentList);
            request.setAttribute("scheduleId", scheduleId);
            request.setAttribute("currentNotes", schedule.getGhiChu());
            
            //request jsp
            request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("WRONG ScheduleID");
            response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=invalid_id");
        }
    }

    
    private void saveAttendance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String saveStatus = "error"; // Initialize status for saving attendance
        int scheduleId = 0; // Initialize schedule ID

        try {
            scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID from request
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId); // Fetch schedule details

            // Validate: Ensure schedule exists and is for today's date
            if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
                response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=save_forbidden"); // Redirect on invalid schedule/date
                return; 
            }

            String scheduleNotes = request.getParameter("scheduleNotes"); // Get notes from form
            String[] studentIds = request.getParameterValues("studentId"); // Get array of student IDs

            if (studentIds != null) { // Process if student IDs are present
                List<DiemDanh> attendanceList = new ArrayList<>(); // List to store attendance records
                for (String studentIdStr : studentIds) { // Loop through each student ID
                    int studentId = Integer.parseInt(studentIdStr); 
                    String status = request.getParameter("status_" + studentId); // Get attendance status for student
                    DiemDanh record = new DiemDanh(null, studentId, scheduleId, status, ""); // Create attendance record
                    attendanceList.add(record); // Add to list
                }

                // Save attendance records
                for (DiemDanh record : attendanceList) {
                    diemDanhDAO.saveOrUpdateAttendance(record); 
                }

                lichHocDAO.updateNote(scheduleId, scheduleNotes); // Update schedule notes in DB
                lichHocDAO.markAttendanceAsCompleted(scheduleId); // Mark attendance as complete for this schedule

                saveStatus = "success"; // Set status to success
            }

        } catch (Exception e) {
            saveStatus = "error"; // Set status to error if exception occurs
            e.printStackTrace(); 
        } finally {
            if (scheduleId != 0) { // If schedule ID is valid
                request.setAttribute("saveStatus", saveStatus); // Set save status for JSP

                // Reload and set attributes for the JSP
                List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId); 
                LichHoc updatedSchedule = lichHocDAO.getLichHocById(scheduleId); 

                request.setAttribute("studentList", studentList); // Set student list
                request.setAttribute("scheduleId", scheduleId); // Set schedule ID
                request.setAttribute("currentNotes", updatedSchedule.getGhiChu()); // Set updated notes

                request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response); // Forward to JSP
            }
        }
    }

    private void getLopHocList(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession(); 
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Retrieve user object from session

        if (user == null) { // Check if user is logged in
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login if not
            return; // Stop execution
        }

        // Get filter/pagination parameters from request, provide default empty/zero values
        String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
        String courseParam = request.getParameter("course") == null ? "0" : request.getParameter("course");
        String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
        String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");

        int courseId = 0; // Initialize course ID
        int currentPage = 1; // Initialize current page for pagination
        int creationYear = 0; // Initialize creation year filter
        int itemsPerPage = 10; // Define items per page for pagination

        try {
            courseId = Integer.parseInt(courseParam); // Parse course ID
            currentPage = Integer.parseInt(pageStr); // Parse current page
            creationYear = Integer.parseInt(yearParam); // Parse creation year
        } catch (NumberFormatException e) {
            System.err.println("Parameter parsing error: " + e.getMessage()); // Log parsing errors
        }

        int idTaiKhoan = user.getID_TaiKhoan(); // Get user's account ID

        GiaoVien_TruongHoc gv = giaoVienDAO.getGiaoVienByID(idTaiKhoan); 
        if (gv == null) { // Check if teacher info is found
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=user_info_not_found"); // Redirect if not
            return; // Stop execution
        }

        // Call DAO methods with all filter and pagination parameters
        int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear); // Get total count of filtered classes
        List<LopHoc> lopHocList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage); // Get filtered class list for current page

        // Get data for filter dropdowns
        List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc(); // Get all courses for filter dropdown
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears(); // Get distinct creation years for filter dropdown

        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); // Calculate total pages
        if (totalPages == 0) totalPages = 1; // Ensure at least 1 page if no items

        request.setAttribute("gv", gv); // Set teacher object
        request.setAttribute("lopHocList", lopHocList); // Set filtered class list
        request.setAttribute("khoaHocList", khoaHocList); // Set course list for filter
        request.setAttribute("yearList", yearList); // Set year list for filter
        request.setAttribute("currentPage", currentPage); // Set current page for pagination
        request.setAttribute("totalPages", totalPages); // Set total pages for pagination

        // Set filter values back to request to pre-fill form on JSP
        request.setAttribute("keyword", keyword); // Set keyword
        request.setAttribute("selectedCourse", courseId); // Set selected course ID
        request.setAttribute("selectedYear", creationYear); // Set selected creation year

        // Forward to JSP 
        request.getRequestDispatcher("views/teacher/viewAttendedClasses.jsp").forward(request, response); // Forward to JSP to display classes
    }
}