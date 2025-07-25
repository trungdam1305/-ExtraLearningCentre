// Author: trungdam
// Servlet: teacherGetFromDashboard
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
    private DiemDanhDAO diemDanhDAO = new DiemDanhDAO(); // Initialize DAO
    private LichHocDAO lichHocDAO = new LichHocDAO();
    private HocSinhDAO hocSinhDAO = new HocSinhDAO();// Initialize DAO
    private TaiBaiTapDAO taiBaiTapDAO = new TaiBaiTapDAO();
    private final GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = ""; // Default action if none specified

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Check if user is logged in and has the correct role (ID_VaiTro = 2, staff)
        if (user == null || user.getID_VaiTro() != 3) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Handle different actions based on the 'action' parameter
        switch (action) {
            case "lophoc":
                getLopHocList(request, response); // Display list of classes
                break;
            case "lichhoc":
                showAttendancePage(request, response); // Display attendance page for a specific schedule
                break;    
            case "viewStudents": 
                showStudentList(request, response); // Display list of students in a class
                break;    
            case "assignments":
                showAssignmentPage(request, response); // Display assignments for a class
                break;
            case "viewSubmissions":
                showSubmissionsPage(request, response); // Display submissions for an assignment
                break;
            case "diemdanh":
                showAttendanceOverviewPage(request, response); // Display attendance overview for teacher's classes
                break;
            case "viewClassAttendance":
                showClassAttendanceReport(request, response); // Display detailed class attendance report
                break;
            case "thongbao":
                showThongBao(request, response); // Display notifications
                break;
            case "blog":
                // This case is empty, implying no specific action for "blog" via GET in this servlet
                break;
            case "hotro":
                showHoTro(request, response); // Display support requests
                break;
            default:
                // Default action if 'action' parameter is not recognized, redirect to dashboard
                response.sendRedirect("TeacherDashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the action parameter for POST requests
        String action = request.getParameter("action");
        if (action == null) {
            action = ""; // Default empty action
        }

        // Handle different actions for POST requests
        switch (action) {
            case "submitAttendance":
                saveAttendance(request, response); // Save attendance records
                break;

            case "updateNote":
                updateScheduleNote(request, response); // Update schedule notes
                break;

            case "createAssignment":
                createAssignment(request, response); // Create a new assignment
                break;
            case "gradeSubmission":
                gradeSubmission(request, response); // Grade a student's submission
                break;
            default:
                // For any other action, fallback to doGet (idempotent behavior)
                doGet(request, response);
                break;
        }
    }

    /**
     * Displays the support requests relevant to the logged-in teacher.
     */
    private void showHoTro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();       
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        
        // Fetch support requests by the user's account ID
        ArrayList<HoTro> hotros = HoTroDAO.getHoTroByIdTaiKhoan(user.getID_TaiKhoan()); 
        
        if (hotros == null || hotros.isEmpty()) { // Check if no support requests were found
            request.setAttribute("message", "Không có yêu cầu hỗ trợ nào đã được gửi!"); // Set message if empty
        } 
        
        session.setAttribute("hotros",hotros); // Set support requests as session attribute
        request.getRequestDispatcher("/views/teacher/teacherReceiveHoTro.jsp").forward(request, response); // Forward to JSP
    }
    
    /**
     * Displays notifications relevant to the logged-in teacher.
     */
    private void showThongBao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();       
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        
        // Fetch notifications by the user's account ID
        List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(user.getID_TaiKhoan());
        request.setAttribute("dsThongBao", dsThongBao); // Set notifications as request attribute

        if (dsThongBao == null || dsThongBao.isEmpty()) { // Check if no notifications were found
            request.setAttribute("message", "Không có thông báo nào!"); // Set message if empty
        }
        
        session.setAttribute("thongbaos",dsThongBao); // Set notifications as session attribute (typo in original: hotros)
        request.getRequestDispatcher("/views/teacher/teacherReceiveThongBao.jsp").forward(request, response); // Forward to JSP
    }
    
    /**
     * Displays a detailed attendance report for a specific class.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showClassAttendanceReport(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Get classId parameter
        int classId = Integer.parseInt(request.getParameter("classId"));
        
        // Fetch class information, student list, schedule, and attendance map
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId); // Get class object
        List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId); // Get students in the class
        List<LichHoc> scheduleList = lichHocDAO.getAllSchedulesForClass(classId); // Get all schedules for the class
        Map<String, DiemDanh> attendanceMap = diemDanhDAO.getAttendanceMapForClass(classId); // Get attendance records
        
        // Set attributes for the JSP
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleList", scheduleList);
        request.setAttribute("attendanceMap", attendanceMap);
        
        request.getRequestDispatcher("/views/teacher/classAttendanceReport.jsp").forward(request, response); // Forward to JSP
    } catch (NumberFormatException e) {
        e.printStackTrace(); // Log error
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid class ID format.");
    } catch (Exception e) {
        e.printStackTrace(); // Log error
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading class attendance report.");
    }
}
    
    /**
     * Displays an overview of classes for attendance management, with filtering and pagination.
     */
    private void showAttendanceOverviewPage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        int idTaiKhoan = user.getID_TaiKhoan(); // Get teacher's account ID

        // Get filter and pagination parameters, providing default values if not present
        String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
        String courseParam = request.getParameter("courseId") == null ? "0" : request.getParameter("courseId");
        String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
        String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");

        try {
            int courseId = Integer.parseInt(courseParam);
            int creationYear = Integer.parseInt(yearParam);
            int currentPage = Integer.parseInt(pageStr);
            int itemsPerPage = 10; // Number of items per page

            // Fetch filtered classes and their total count from DAOs
            int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear);
            List<LopHoc> classList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage);
            
            // Fetch data for filter dropdowns (courses and years)
            KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
            List<KhoaHoc> courseList = khoaHocDAO.adminGetAllKhoaHoc();
            List<Integer> yearList = lopHocDAO.getDistinctCreationYears();
            
            // Calculate total pages for pagination
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            
            // Set attributes for the JSP
            request.setAttribute("classList", classList);
            request.setAttribute("courseList", courseList);
            request.setAttribute("yearList", yearList);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);
            
            // Set current filter values to maintain state in the JSP form
            request.setAttribute("keyword", keyword);
            request.setAttribute("selectedCourseId", courseId);
            request.setAttribute("selectedYear", creationYear);
            
            request.getRequestDispatcher("/views/teacher/attendanceOverview.jsp").forward(request, response); // Forward to JSP
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log error
            response.sendRedirect(request.getContextPath() + "/TeacherDashboard"); // Redirect on invalid number format
        } catch (Exception e) {
            e.printStackTrace(); // Log general error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading attendance overview.");
        }
    }
    
    /**
     * Displays a list of submissions for a given assignment.
     */
    private void showSubmissionsPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId")); // Get assignment ID
            List<NopBaiTapInfo> submissionList = nopBaiTapDAO.getSubmissionsByAssignmentId(assignmentId); // Get submissions
            TaoBaiTap assignment = taiBaiTapDAO.getAssignmentById(assignmentId); // Get assignment details
            
            request.setAttribute("submissionList", submissionList); // Set submission list
            request.setAttribute("assignment", assignment); // Set assignment details
            request.getRequestDispatcher("/views/teacher/viewSubmissions.jsp").forward(request, response); // Forward to JSP
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log error
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidAssignmentId"); // Redirect on invalid ID
        } catch (Exception e) {
            e.printStackTrace(); // Log general error
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=loadingSubmissionsFailed"); // Redirect on error
        }
    }

    /**
     * Handles grading a student's submission for an assignment.
     */
    private void gradeSubmission(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String assignmentIdStr = request.getParameter("assignmentId"); // Get assignment ID string
        try {
            int assignmentId = Integer.parseInt(assignmentIdStr);
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            BigDecimal grade = new BigDecimal(request.getParameter("diem")); // Parse grade
            String comment = request.getParameter("nhanXet"); // Get comment
            
            nopBaiTapDAO.updateGradeAndComment(assignmentId, studentId, grade, comment); // Update grade and comment in DB
            
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=viewSubmissions&assignmentId=" + assignmentId + "&grade=success"); // Redirect on success
        } catch (NumberFormatException e) {
            e.printStackTrace(); // Log error
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=viewSubmissions&assignmentId=" + assignmentIdStr + "&grade=error&message=invalid_grade_format"); // Redirect with error
        } catch (Exception e) {
            e.printStackTrace(); // Log general error
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=viewSubmissions&assignmentId=" + assignmentIdStr + "&grade=error&message=grading_failed"); // Redirect with error
        }
    }
    
    /**
     * Displays the assignment management page for a specific class.
     */
    private void showAssignmentPage(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId")); // Get class ID
            
            // Get class's information
            LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

            // Check if class exists
            if (lopHoc == null) {
                response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=class_not_found"); // Redirect if not found
                return;
            }

            // If class exists, get list of assignments for that class
            List<TaoBaiTap> assignmentList = taiBaiTapDAO.getAssignmentsByClassId(classId);
            
            request.setAttribute("assignmentList", assignmentList); // Set assignment list
            request.setAttribute("lopHoc", lopHoc); // Set class object
            
            request.getRequestDispatcher("/views/teacher/assignmentManagement.jsp").forward(request, response); // Forward to JSP

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId"); // Redirect on invalid ID
        } catch (Exception e) {
            e.printStackTrace(); // Log error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading assignment page.");
        }
    }
            
    /**
     * Handles creating a new assignment for a class, including file upload.
     */
    private void createAssignment(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
            HttpSession session = request.getSession();
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            GiaoVienDAO gvDao = new GiaoVienDAO();

            try {
                // Get data from form
                String classIdStr = request.getParameter("classId");
                int classId = Integer.parseInt(classIdStr);
                String tenBaiTap = request.getParameter("tenBaiTap");
                String moTa = request.getParameter("moTa");
                LocalDate deadline = LocalDate.parse(request.getParameter("deadline"));
                // Get teacher ID from logged-in user's account ID
                int teacherId = gvDao.getGiaoVienByID(user.getID_TaiKhoan()).getID_GiaoVien();

                // Handle file upload
                String fileName = null;
                Part filePart = request.getPart("assignmentFile"); // Get the file part
                if (filePart != null && filePart.getSize() > 0) {
                    // Extract filename and create upload path
                    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + "uploads";
                    Path uploadDirPath = Paths.get(uploadPath);
                    if (!Files.exists(uploadDirPath)) {
                        Files.createDirectories(uploadDirPath); // Create directories if they don't exist
                    }
                    filePart.write(uploadPath + "/" + fileName); // Write file to server
                }

                // Create newAssignment object
                TaoBaiTap newAssignment = new TaoBaiTap();
                newAssignment.setID_LopHoc(classId);
                newAssignment.setTenBaiTap(tenBaiTap);
                newAssignment.setMoTa(moTa);
                newAssignment.setDeadline(deadline);
                newAssignment.setID_GiaoVien(teacherId);
                newAssignment.setNgayTao(LocalDate.now()); // Set creation date to today
                newAssignment.setFileName(fileName); // Set the uploaded file name

                // Add assignment to database
                taiBaiTapDAO.addAssignment(newAssignment);

                response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=assignments&classId=" + classId + "&create=success"); // Redirect on success

            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log error
                String classIdStr = request.getParameter("classId");
                if (classIdStr != null) {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=assignments&classId=" + classIdStr + "&create=error&message=invalid_input"); // Redirect with error
                } else {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId"); // Redirect if class ID is missing
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log general error
                String classIdStr = request.getParameter("classId");
                if (classIdStr != null) {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=assignments&classId=" + classIdStr + "&create=error&message=file_upload_failed"); // Redirect with error
                } else {
                    response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=unexpected_error"); // Redirect if class ID is missing
                }
            }
        }
    
    /**
     * Displays the list of students for a given class.
     */
    private void showStudentList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId")); // Get class ID

            // Get student list from DAO
            List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId);
            
            // Get class information to display class name/code
            LopHoc lopHoc = lopHocDAO.getLopHocById(classId);

            // Set attributes for the JSP
            request.setAttribute("studentList", studentList);
            request.setAttribute("lopHoc", lopHoc);
            
            request.getRequestDispatcher("/views/teacher/viewStudentList.jsp").forward(request, response); // Forward to JSP

        } catch (NumberFormatException e) {
            // Redirect if classId is invalid
            response.sendRedirect(request.getContextPath() + "/teacherGetFromDashboard?action=lophoc&error=invalidClassId");
        } catch (Exception e) {
            e.printStackTrace(); // Log error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading student list.");
        }
    }
    
    /**
     * Updates the note for a specific schedule session.
     */
    private void updateScheduleNote(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID
            String noteText = request.getParameter("noteText"); // Get note text
            
            LichHocDAO lichHocDAO = new LichHocDAO();
            lichHocDAO.updateNote(scheduleId, noteText); // Update note in DB
            
            response.setStatus(HttpServletResponse.SC_OK); // Set status to OK
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid schedule ID format."); // Send error for bad ID
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update note."); // Send error for general failure
        }
    }
    
    /**
     * Displays the attendance taking page for a specific schedule session.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showAttendancePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID
            
            // Get schedule details from DB
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);
            
            // Validate: Ensure schedule exists and is for today's date (cannot take attendance for past/future)
            if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
                response.sendRedirect(request.getContextPath() + "/TeacherDashboard?error=attendance_not_allowed"); // Redirect if not valid
                return;
            }
            
            // Get student list with their attendance status for this schedule
            List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);
            
            // Set attributes for the JSP
            request.setAttribute("studentList", studentList);
            request.setAttribute("scheduleId", scheduleId);
            request.setAttribute("currentNotes", schedule.getGhiChu()); // Set current notes
            
            request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response); // Forward to JSP

        } catch (NumberFormatException e) {
            System.err.println("Invalid schedule ID in showAttendancePage: " + e.getMessage()); // Log error
            response.sendRedirect(request.getContextPath() + "/TeacherDashboard?error=invalid_schedule_id"); // Redirect on invalid ID
        } catch (Exception e) {
            e.printStackTrace(); // Log general error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading attendance page.");
        }
    }

    /**
     * Saves attendance records for a given schedule session.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void saveAttendance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String saveStatus = "error"; // Initialize save status
        int scheduleId = 0; // Initialize schedule ID

        try {
            scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId); // Fetch schedule details

            // Validate: Ensure schedule exists and is for today's date
            if (schedule == null || !schedule.getNgayHoc().isEqual(java.time.LocalDate.now())) {
                response.sendRedirect(request.getContextPath() + "/TeacherDashboard?error=save_forbidden"); // Redirect if invalid
                return; 
            }

            String scheduleNotes = request.getParameter("scheduleNotes"); // Get notes
            String[] studentIds = request.getParameterValues("studentId"); // Get array of student IDs

            if (studentIds != null) { // Process if student IDs are present
                List<DiemDanh> attendanceList = new ArrayList<>(); // List to store attendance records
                for (String studentIdStr : studentIds) { // Loop through each student
                    int studentId = Integer.parseInt(studentIdStr); 
                    String status = request.getParameter("status_" + studentId); // Get attendance status (e.g., "Present", "Absent")
                    DiemDanh record = new DiemDanh(null, studentId, scheduleId, status, ""); // Create attendance record
                    attendanceList.add(record); // Add to list
                }

                // Save or update each attendance record in the database
                for (DiemDanh record : attendanceList) {
                    diemDanhDAO.saveOrUpdateAttendance(record); 
                }

                lichHocDAO.updateNote(scheduleId, scheduleNotes); // Update schedule notes
                lichHocDAO.markAttendanceAsCompleted(scheduleId); // Mark attendance as complete for this session

                saveStatus = "success"; // Set status to success
            }

        } catch (NumberFormatException e) {
            saveStatus = "error"; // Set status to error for invalid ID format
            e.printStackTrace(); 
        } catch (Exception e) {
            saveStatus = "error"; // Set status to error for general exceptions
            e.printStackTrace(); 
        } finally {
            if (scheduleId != 0) { // If schedule ID is valid
                request.setAttribute("saveStatus", saveStatus); // Set save status for JSP

                // Reload data to reflect changes in the JSP
                List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId); 
                LichHoc updatedSchedule = lichHocDAO.getLichHocById(scheduleId); 

                request.setAttribute("studentList", studentList); // Set student list
                request.setAttribute("scheduleId", scheduleId); // Set schedule ID
                request.setAttribute("currentNotes", updatedSchedule.getGhiChu()); // Set updated notes

                request.getRequestDispatcher("/views/teacher/takeAttendance.jsp").forward(request, response); // Forward to JSP
            } else {
                response.sendRedirect(request.getContextPath() + "/TeacherDashboard?error=save_attendance_failed"); // Redirect on critical error
            }
        }
    }

    /**
     * Retrieves and displays a list of classes taught by the logged-in teacher,
     * with filtering and pagination capabilities.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void getLopHocList(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession(); 
        TaiKhoan user = (TaiKhoan) session.getAttribute("user"); // Get user from session

        if (user == null) { // Check if user is logged in
            response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login if not
            return; 
        }

        // Get filter/pagination parameters, provide default empty/zero values if null
        String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
        String courseParam = request.getParameter("course") == null ? "0" : request.getParameter("course");
        String yearParam = request.getParameter("creationYear") == null ? "0" : request.getParameter("creationYear");
        String pageStr = request.getParameter("page") == null ? "1" : request.getParameter("page");

        int courseId = 0; 
        int currentPage = 1; 
        int creationYear = 0; 
        int itemsPerPage = 10; 

        try {
            courseId = Integer.parseInt(courseParam); // Parse course ID
            currentPage = Integer.parseInt(pageStr); // Parse current page
            creationYear = Integer.parseInt(yearParam); // Parse creation year
        } catch (NumberFormatException e) {
            System.err.println("Parameter parsing error: " + e.getMessage()); // Log parsing errors
            // Optionally, set error message in request for JSP display
        }

        int idTaiKhoan = user.getID_TaiKhoan(); // Get user's account ID (teacher's ID)

        GiaoVien_TruongHoc gv = giaoVienDAO.getGiaoVienByID(idTaiKhoan); 
        if (gv == null) { // Check if teacher info is found
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=user_info_not_found"); // Redirect if not
            return; 
        }

        // Fetch total count of filtered classes and the list of classes for the current page
        int totalItems = lopHocDAO.getFilteredLopHocCount(idTaiKhoan, keyword, courseId, creationYear); 
        List<LopHoc> lopHocList = lopHocDAO.getFilteredLopHoc(idTaiKhoan, keyword, courseId, creationYear, currentPage, itemsPerPage); 

        // Fetch data for filter dropdowns
        List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc(); 
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears(); 

        int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage); 
        if (totalPages == 0) totalPages = 1; // Ensure at least 1 page if no items

        request.setAttribute("gv", gv); // Set teacher object
        request.setAttribute("lopHocList", lopHocList); // Set filtered class list
        request.setAttribute("khoaHocList", khoaHocList); // Set course list for filter
        request.setAttribute("yearList", yearList); // Set year list for filter
        request.setAttribute("currentPage", currentPage); // Set current page
        request.setAttribute("totalPages", totalPages); // Set total pages

        // Set current filter values back to request to pre-fill the form on JSP
        request.setAttribute("keyword", keyword); 
        request.setAttribute("selectedCourse", courseId); 
        request.setAttribute("selectedYear", creationYear); 

        request.getRequestDispatcher("views/teacher/viewAttendedClasses.jsp").forward(request, response); // Forward to JSP
    }
}