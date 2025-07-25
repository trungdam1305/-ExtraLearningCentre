// Author: trungdam
// Servlet: StaffManageTimeTable
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DiemDanhDAO;
import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import dal.KhoiHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.SlotHocDAO;
import dal.StaffDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter; // Potentially remove if processRequest is unused
import java.sql.SQLException; // Added for SQLException in DAO calls, good practice
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.WeekFields; 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import model.KhoaHoc;
import model.KhoiHoc;
import model.LichHoc;
import model.LopHoc;
import model.SlotHoc;
import model.Staff;
import model.TaiKhoan;
import model.HocSinh; 
import model.DiemDanh; 

/**
 *
 * @author admin
 */
public class StaffManageTimeTable extends HttpServlet {

    // Initialize DAOs
    private final LichHocDAO lichHocDAO;
    private final LopHocDAO lopHocDAO;
    private final SlotHocDAO slotHocDAO;
    private final StaffDAO staffDAO;
    private final HocSinhDAO hocSinhDAO; 
    private final DiemDanhDAO diemDanhDAO; 
    private final KhoaHocDAO khoaHocDAO; 
    private final KhoiHocDAO khoiHocDAO; 

    // Constructor to initialize DAOs (good practice for reusability)
    public StaffManageTimeTable() {
        this.lichHocDAO = new LichHocDAO();
        this.lopHocDAO = new LopHocDAO();
        this.slotHocDAO = new SlotHocDAO();
        this.staffDAO = new StaffDAO();
        this.hocSinhDAO = new HocSinhDAO();
        this.diemDanhDAO = new DiemDanhDAO();
        this.khoaHocDAO = new KhoaHocDAO();
        this.khoiHocDAO = new KhoiHocDAO();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * This method is generally avoided when doGet/doPost are overridden.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StaffManageTimeTable</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffManageTimeTable - Invalid Request</h1>");
            out.println("<p>This URL is not meant for direct access. Please use specific actions.</p>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    /**
     * Handles the HTTP <code>GET</code> method.
     * It dispatches to different helper methods based on the 'action' parameter.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        
        // --- Set Staff info for Header (common for all views) ---
        // Redirect to login if no user is found in session
        if (user != null && user.getID_VaiTro() == 2) {
            ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan()); 
            request.setAttribute("staffs", staffs); 
        } else {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        // --- End Staff Header ---

        String action = request.getParameter("action");
        if (action == null) { // Default action if no action parameter
            action = "listClasses"; // Default to listing classes
        }
        
        switch(action) {
            case "viewDetail": // Show class schedule grid
                try {
                    showClassScheduleGrid(request, response);
                } catch (SQLException e) {
                    System.err.println("Database error in showClassScheduleGrid: " + e.getMessage());
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while loading class schedule data.");
                }
                break;
            case "viewAttendance": // Show attendance form for a specific session
                showAttendancePage(request, response); 
                break;
            case "listClasses": // Default action: show class list for time table management
            default: // Handle any other unspecified actions as default
                showClassListPage(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * It dispatches to different helper methods based on the 'action' parameter.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) { // Default action if no action parameter
            action = ""; // Will fall through to default error
        }

        switch(action) {
            case "saveAttendance": // Save submitted attendance data
                saveAttendance(request, response); 
                break;
            default: // Invalid POST action
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action for POST request.");
                break;
        }
    }

    // --- Private methods for handling specific actions ---

    /**
     * Displays a paginated and filtered list of active classes.
     * This is typically the initial view for staff to select a class for timetable management.
     */
    private void showClassListPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword"); // Search keyword for class names
        String courseIdParam = request.getParameter("courseId"); // Course filter
        String khoiIdParam = request.getParameter("khoiId"); // Grade (KhoiHoc) filter
        String yearParam = request.getParameter("creationYear"); // Creation year filter
        String pageParam = request.getParameter("page"); // Current page for pagination
        int pageSize = 8; // Number of items per page 

        // Parse filter parameters, defaulting to null if not provided or invalid
        Integer courseId = (courseIdParam != null && !courseIdParam.isEmpty()) ? Integer.valueOf(courseIdParam) : null;
        Integer khoiId = (khoiIdParam != null && !khoiIdParam.isEmpty()) ? Integer.valueOf(khoiIdParam) : null;
        Integer creationYear = (yearParam != null && !yearParam.isEmpty()) ? Integer.valueOf(yearParam) : null;
        // Parse current page, defaulting to 1
        int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

        // Fetch filtered active classes and total count for pagination
        List<LopHoc> activeClassList = lopHocDAO.getFilteredActiveClasses(keyword, courseId, khoiId, creationYear, currentPage, pageSize);
        int totalItems = lopHocDAO.countFilteredActiveClasses(keyword, courseId, khoiId, creationYear);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        // Fetch data for filter dropdowns
        List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc();
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc();
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears();
        
        // Set attributes for the JSP
        request.setAttribute("activeClassList", activeClassList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("khoaHocList", khoaHocList);
        request.setAttribute("khoiHocList", khoiHocList);
        request.setAttribute("yearList", yearList);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("selectedKhoiId", khoiId);
        request.setAttribute("selectedYear", creationYear);
        
        // Forward to the JSP page for managing timetables
        request.getRequestDispatcher("/views/staff/manageTimeTable.jsp").forward(request, response);
    }
    
    /**
     * Displays the weekly schedule grid for a specific class.
     * Allows navigation between weeks.
     */
    private void showClassScheduleGrid(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException { // Keep SQLException here as DAO calls can throw it
        
        int classId;
        try {
            classId = Integer.parseInt(request.getParameter("classId"));
        } catch (NumberFormatException e) {
            // Handle invalid classId parameter
            System.err.println("Invalid classId parameter: " + request.getParameter("classId"));
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid class ID provided.");
            return;
        }

        // --- Logic to determine the start of the week ---
        // Default to ISO week date standard, where Monday is day 1.
        LocalDate startOfWeek; 
        String viewDateParam = request.getParameter("viewDate"); // From "Previous/Next Week" buttons (YYYY-MM-DD)
        String weekParam = request.getParameter("week"); // From input type="week" (YYYY-Www)

        if (weekParam != null && !weekParam.isEmpty()) {
            // Parse YYYY-Www format to a LocalDate.
            // WeekFields is used to define week properties (e.g., Monday as first day, min days in first week).
            WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY, 4); 
            try {
                // Parse YYYY-Www-D, where D=1 for Monday as the first day of the week
                startOfWeek = LocalDate.parse(weekParam + "-1", DateTimeFormatter.ISO_WEEK_DATE); 
            } catch (DateTimeParseException e) {
                // Fallback to current week if parsing fails
                System.err.println("Invalid week parameter format: " + weekParam + ". Defaulting to current week.");
                startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
            }
        } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
            // If navigating via "Previous/Next Week" buttons, the date is already in YYYY-MM-DD
            try {
                startOfWeek = LocalDate.parse(viewDateParam, DateTimeFormatter.ISO_LOCAL_DATE);
            } catch (DateTimeParseException e) {
                // Fallback to current week if parsing fails
                System.err.println("Invalid viewDate parameter format: " + viewDateParam + ". Defaulting to current week.");
                startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
            }
        } else {
            // Default: get the current week (Monday of this week)
            startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
        }
        
        LocalDate endOfWeek = startOfWeek.plusDays(6); // Sunday of the week

        // --- Fetch data from Database ---
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId); // Get class details
        if (lopHoc == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class not found.");
            return;
        }
        
        List<LichHoc> scheduleList = lichHocDAO.getLichHocTrongTuanForClass(classId, startOfWeek, endOfWeek); // Get schedules for the week
        List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc(); // Get all available time slots

        // --- Convert schedule list to a Map for easy access by slot and day of week ---
        Map<String, LichHoc> scheduleMap = new HashMap<>();
        LocalDate today = LocalDate.now();
        if (scheduleList != null) { 
            for (LichHoc lh : scheduleList) {
                // Set 'coTheSua' (can be edited/attended) if it's today's session
                lh.setCoTheSua(lh.getNgayHoc().isEqual(today)); 
                
                String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
                scheduleMap.put(key, lh);
            }
        }

        // --- Create a list of dates for the week to display in the table header ---
        List<LocalDate> weekDates = IntStream.range(0, 7)
                                             .mapToObj(startOfWeek::plusDays)
                                             .collect(Collectors.toList());

        // --- Formatters for display and links, using Vietnamese locale for day names ---
        Locale displayLocale = Locale.forLanguageTag("vi-VN"); 
        DateTimeFormatter displayDateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy", displayLocale);
        DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY-'W'ww", displayLocale);

        // --- Set attributes in the request and forward to JSP ---
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("scheduleMap", scheduleMap);
        request.setAttribute("timeSlots", timeSlots);
        request.setAttribute("weekDates", weekDates);

        // Use ISO_LOCAL_DATE for navigation links as it's simple and easy to parse
        request.setAttribute("prevWeekStart", startOfWeek.minusWeeks(1).format(DateTimeFormatter.ISO_LOCAL_DATE)); 
        request.setAttribute("nextWeekStart", startOfWeek.plusWeeks(1).format(DateTimeFormatter.ISO_LOCAL_DATE)); 
        
        // Display string for the week range
        String displayWeekRange = "Tuần từ: " + startOfWeek.format(displayDateFormatter) + 
                                  " đến " + endOfWeek.format(displayDateFormatter);
        request.setAttribute("displayWeekRange", displayWeekRange);

        // Value for the HTML input type="week"
        request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter));

        request.getRequestDispatcher("/views/staff/classScheduleDetail.jsp").forward(request, response);
    }

    /**
     * Handles saving attendance data submitted via POST request.
     * Updates attendance records and marks the schedule as completed.
     */
    private void saveAttendance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String saveStatus = "error"; // Initialize status for saving attendance
        int scheduleId = 0; // Initialize schedule ID
        int classId = 0; // Initialize class ID
        try {
            classId = Integer.parseInt(request.getParameter("classId")); // Get class ID
            scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID from request
            
            // LichHoc schedule = lichHocDAO.getLichHocById(scheduleId); // This line is not used after fetching

            String scheduleNotes = request.getParameter("scheduleNotes"); // Get notes from form
            String[] studentIds = request.getParameterValues("studentId"); // Get array of student IDs from checkboxes

            if (studentIds != null) { // Process if student IDs are present
                List<DiemDanh> attendanceList = new ArrayList<>(); // List to store attendance records
                for (String studentIdStr : studentIds) { // Loop through each student ID
                    int studentId = Integer.parseInt(studentIdStr); 
                    String status = request.getParameter("status_" + studentId); // Get attendance status (present/absent) for each student
                    // Create attendance record. Assuming ID_DiemDanh is auto-generated or handled by DAO logic (null here).
                    DiemDanh record = new DiemDanh(null, studentId, scheduleId, status, ""); 
                    attendanceList.add(record); // Add to list
                }

                // Save or update attendance records in the database
                for (DiemDanh record : attendanceList) {
                    diemDanhDAO.saveOrUpdateAttendance(record); 
                }

                lichHocDAO.updateNote(scheduleId, scheduleNotes); // Update schedule notes in DB
                lichHocDAO.markAttendanceAsCompleted(scheduleId); // Mark attendance as complete for this schedule
                saveStatus = "success"; // Set status to success
            }

        } catch (NumberFormatException e) {
            System.err.println("Invalid ID format in saveAttendance: " + e.getMessage());
            saveStatus = "error"; 
        } catch (Exception e) {
            saveStatus = "error"; // Set status to error if any other exception occurs
            e.printStackTrace(); // Print stack trace for debugging
            System.err.println("Error saving attendance: " + e.getMessage());
        } finally {
            // Always redirect back to the attendance page, even on error, to show results or error messages
            if (scheduleId != 0 && classId != 0) { 
                request.setAttribute("saveStatus", saveStatus); // Set save status for JSP
                
                // Reload and set attributes for the JSP to reflect changes
                // Fetch attendance info for all students for the specific schedule
                List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId); 
                LichHoc updatedSchedule = lichHocDAO.getLichHocById(scheduleId); // Get updated schedule details

                request.setAttribute("classId", classId);
                request.setAttribute("studentList", studentList); // Set student list with attendance
                request.setAttribute("scheduleId", scheduleId); // Set schedule ID
                request.setAttribute("currentNotes", updatedSchedule != null ? updatedSchedule.getGhiChu() : ""); // Set updated notes
                request.setAttribute("schedule", updatedSchedule); // Also pass the updated schedule object
                
                request.getRequestDispatcher("/views/staff/takeAttendancePage.jsp").forward(request, response); // Forward to JSP
            } else {
                 // If scheduleId or classId is invalid, redirect to a general error page or class list
                response.sendRedirect(request.getContextPath() + "/StaffManageTimeTable?message=invalid_params_for_attendance");
            }
        }
    }

    /**
     * Displays the attendance taking page for a specific schedule session.
     * Fetches students and their existing attendance status for that session.
     */
    private void showAttendancePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int classId = Integer.parseInt(request.getParameter("classId"));
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            
            // Get schedule details from DB
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);
            
            // Get student list with their attendance status for this schedule
            List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);
            
            // Set attributes for the JSP
            request.setAttribute("studentList", studentList);
            request.setAttribute("scheduleId", scheduleId);
            request.setAttribute("currentNotes", schedule != null ? schedule.getGhiChu() : ""); // Set current notes
            request.setAttribute("schedule", schedule); // Pass the schedule object
            request.setAttribute("classId", classId); // Pass class ID
            
            // Forward to the attendance taking JSP page
            request.getRequestDispatcher("/views/staff/takeAttendancePage.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("Invalid ScheduleID or ClassID in showAttendancePage: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/StaffManageTimeTable?error=invalid_id"); // Redirect on invalid ID
        } catch (Exception e) {
            System.err.println("Error in showAttendancePage: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while loading attendance page.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing staff time tables and attendance records.";
    }
}