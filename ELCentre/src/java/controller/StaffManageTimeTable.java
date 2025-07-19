/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.KhoaHocDAO;
import dal.KhoiHocDAO;
import dal.LichHocDAO;
import dal.LopHocDAO;
import dal.SlotHocDAO;
import dal.StaffDAO;
import dal.HocSinhDAO; 
import dal.DiemDanhDAO; 

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
        if (user != null) {
            ArrayList<Staff> staffs = staffDAO.getNameStaff(user.getID_TaiKhoan()); 
            request.setAttribute("staffs", staffs); 
        } else {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        // --- End Staff Header ---

        String action = request.getParameter("action");
        if (action == null) { // Default action if no action parameter
            action = "listClasses"; 
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

    // Method to display the list of classes (initial page)
    private void showClassListPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String courseIdParam = request.getParameter("courseId");
        String khoiIdParam = request.getParameter("khoiId");
        String yearParam = request.getParameter("creationYear");
        String pageParam = request.getParameter("page");
        int pageSize = 8; 

        Integer courseId = (courseIdParam != null && !courseIdParam.isEmpty()) ? Integer.valueOf(courseIdParam) : null;
        Integer khoiId = (khoiIdParam != null && !khoiIdParam.isEmpty()) ? Integer.valueOf(khoiIdParam) : null;
        Integer creationYear = (yearParam != null && !yearParam.isEmpty()) ? Integer.valueOf(yearParam) : null;
        int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

        List<LopHoc> activeClassList = lopHocDAO.getFilteredActiveClasses(keyword, courseId, khoiId, creationYear, currentPage, pageSize);
        int totalItems = lopHocDAO.countFilteredActiveClasses(keyword, courseId, khoiId, creationYear);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc();
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc();
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears();
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
        request.getRequestDispatcher("/views/staff/manageTimeTable.jsp").forward(request, response);
    }
    
    private void showClassScheduleGrid(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException { // Keep SQLException here as DAO calls can throw it
    
    int classId;
    try {
        classId = Integer.parseInt(request.getParameter("classId"));
    } catch (NumberFormatException e) {
        // Vẫn cần try-catch cho phần parse classId vì nó là tham số quan trọng
        System.err.println("Invalid classId parameter: " + request.getParameter("classId"));
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid class ID provided.");
        return;
    }

    // --- Logic để xác định ngày bắt đầu của tuần ---
    // Sử dụng DayOfWeek.MONDAY để luôn căn vào Thứ Hai mà không cần Locale
    // Mặc định, Java.time sử dụng ISO week date standard, nơi Thứ Hai là ngày 1.
    LocalDate startOfWeek; 
    String viewDateParam = request.getParameter("viewDate"); // Từ các nút "Tuần trước/sau" (YYYY-MM-DD)
    String weekParam = request.getParameter("week"); // Từ input type="week" (YYYY-Www)

    if (weekParam != null && !weekParam.isEmpty()) {
        // LocalDate.parse với WeekFields là cách xử lý chuẩn, nhưng bạn muốn ít Locale.
        // Có thể cân nhắc đưa logic này sang một helper method nếu thực sự muốn giấu.
        // Tuy nhiên, việc sử dụng WeekFields là cách chính xác nhất để parse YYYY-Www.
        // Giữ lại WeekFields cho tính chính xác, nhưng chỉ định rõ Locale một lần.
        WeekFields weekFields = WeekFields.of(DayOfWeek.MONDAY, 4); // Bắt đầu tuần là Thứ 2, tuần đầu tiên có ít nhất 4 ngày.
        startOfWeek = LocalDate.parse(weekParam + "-1", DateTimeFormatter.ISO_WEEK_DATE); // YYYY-Www-D (D=1 cho Thứ 2)
                                                                                          // Hoặc: LocalDate.of(year, 1, 1).with(weekFields.weekOfYear(), weekNumber).with(DayOfWeek.MONDAY);
                                                                                          // Nhưng cách trên gọn hơn nếu bạn chấp nhận ISO_WEEK_DATE
    } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
        // Khi người dùng chọn tuần tới hoặc tuần trước (đã ở định dạng YYYY-MM-DD)
        startOfWeek = LocalDate.parse(viewDateParam, DateTimeFormatter.ISO_LOCAL_DATE);
    } else {
        // Mặc định: lấy tuần hiện tại (Thứ Hai của tuần này)
        startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
    }
    
    LocalDate endOfWeek = startOfWeek.plusDays(6); // Chủ nhật của tuần

    // --- Lấy dữ liệu từ DB ---
    LopHoc lopHoc = lopHocDAO.getLopHocById(classId);
    if (lopHoc == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class not found.");
        return;
    }
    
    List<LichHoc> scheduleList = lichHocDAO.getLichHocTrongTuanForClass(classId, startOfWeek, endOfWeek);
    List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc(); 

    // --- Chuyển đổi lịch thành Map để truy cập dễ dàng ---
    Map<String, LichHoc> scheduleMap = new HashMap<>();
    LocalDate homNay = LocalDate.now();
    if (scheduleList != null) { 
        for (LichHoc lh : scheduleList) {
            // Thiết lập coTheSua (có thể điểm danh/sửa) nếu là buổi học hôm nay
            lh.setCoTheSua(lh.getNgayHoc().isEqual(homNay)); 
            
            String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
            scheduleMap.put(key, lh);
        }
    }

    // --- Tạo danh sách ngày trong tuần để hiển thị trên header của bảng ---
    List<LocalDate> weekDates = IntStream.range(0, 7)
                                         .mapToObj(startOfWeek::plusDays)
                                         .collect(Collectors.toList());

    // --- Định dạng cho hiển thị và liên kết, sử dụng default locale nếu không muốn chỉ định vi-VN ---
    // Để có tiếng Việt "Thứ Hai", bạn vẫn cần Locale. Nếu không dùng Locale, sẽ là "MONDAY" hoặc "Mon".
    // Tôi sẽ giữ Locale ở đây để đảm bảo đúng ngôn ngữ cho người dùng Việt Nam.
    // Nếu bạn thực sự muốn bỏ hoàn toàn, hãy xóa Locale.forLanguageTag("vi-VN")
    Locale displayLocale = Locale.forLanguageTag("vi-VN"); 
    DateTimeFormatter displayDateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy", displayLocale);
    DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY-'W'ww", displayLocale);

    // --- Đặt các thuộc tính vào request và gửi đến JSP ---
    request.setAttribute("lopHoc", lopHoc);
    request.setAttribute("scheduleMap", scheduleMap);
    request.setAttribute("timeSlots", timeSlots);
    request.setAttribute("weekDates", weekDates);

    // Dùng ISO_LOCAL_DATE cho các link điều hướng vì nó đơn giản và dễ parse
    request.setAttribute("prevWeekStart", startOfWeek.minusWeeks(1).format(DateTimeFormatter.ISO_LOCAL_DATE)); 
    request.setAttribute("nextWeekStart", startOfWeek.plusWeeks(1).format(DateTimeFormatter.ISO_LOCAL_DATE)); 
    
    // Chuỗi hiển thị phạm vi tuần
    String displayWeekRange = "Tuần từ: " + startOfWeek.format(displayDateFormatter) + 
                              " đến " + endOfWeek.format(displayDateFormatter);
    request.setAttribute("displayWeekRange", displayWeekRange);

    // Giá trị cho input type="week"
    request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter));

    request.getRequestDispatcher("/views/staff/classScheduleDetail.jsp").forward(request, response);
}

    @Override
    public String getServletInfo() {
        return "Servlet for managing staff time tables and attendance records.";
    }

    private void saveAttendance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String saveStatus = "error"; // Initialize status for saving attendance
        int scheduleId = 0; // Initialize schedule ID
        int classId = Integer.parseInt(request.getParameter("classId"));
        try {
            scheduleId = Integer.parseInt(request.getParameter("scheduleId")); // Get schedule ID from request
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId); // Fetch schedule details


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
                request.setAttribute("classId", classId);
                request.setAttribute("studentList", studentList); // Set student list
                request.setAttribute("scheduleId", scheduleId); // Set schedule ID
                request.setAttribute("currentNotes", updatedSchedule.getGhiChu()); // Set updated notes

                request.getRequestDispatcher("/views/staff/takeAttendancePage.jsp").forward(request, response); // Forward to JSP
            }
        }
    }

   private void showAttendancePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            int classId = Integer.parseInt(request.getParameter("classId"));
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            
            //get schedule from db
            LichHoc schedule = lichHocDAO.getLichHocById(scheduleId);
            
            //get studentList from db
            List<DiemDanh> studentList = diemDanhDAO.getDiemDanhInfoForSchedule(scheduleId);
            
            //set Attribute
            request.setAttribute("studentList", studentList);
            request.setAttribute("scheduleId", scheduleId);
            request.setAttribute("currentNotes", schedule.getGhiChu());
            request.setAttribute("schedule", schedule);
            request.setAttribute("classId", classId);
            //request jsp
            request.getRequestDispatcher("/views/staff/takeAttendancePage.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("WRONG ScheduleID");
            response.sendRedirect(request.getContextPath() + "/teacher-schedule?error=invalid_id");
        }
    }
}