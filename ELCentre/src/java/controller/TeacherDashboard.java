// Author: trungdam
// Servlet: TeacherDashboard
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.GiaoVien_LopHocDAO;
import dal.GiaoVienDAO;
import dal.LichHocDAO;
import dal.SalaryDAO;
import dal.SlotHocDAO;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.LichHoc;
import model.SalaryInfo;
import model.SlotHoc;
import model.TaiKhoan;
import model.ThongBao;

/**
 *
 * @author admin
 */
public class TeacherDashboard extends HttpServlet {
    SalaryDAO salaryDAO = new SalaryDAO();
    /** * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TeacherDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TeacherDashboard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Set content type and encoding for the response
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    // Get the current user session
    HttpSession session = request.getSession();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");
    
    // Validate if the user is logged in and has the teacher role (ID_VaiTro = 3)
    if (user == null || user.getID_VaiTro() != 3) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp"); // Redirect to login page if not authenticated or not a teacher
        return;
    }
    
    // Get the account ID of the logged-in teacher
    int idTaiKhoan = user.getID_TaiKhoan();
    GiaoVienDAO gvDao = new GiaoVienDAO();
    
    ArrayList<ThongBao> thongbaos = ThongBaoDAO.getThongBaoByTaiKhoanIdD(idTaiKhoan) ; 
    
    
    // Fetch dashboard statistics for the teacher
    int numHocSinh = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(idTaiKhoan); // Total students taught by this teacher
    int numLopHoc = GiaoVien_LopHocDAO.teacherGetTongSoLopHoc(idTaiKhoan); // Total classes taught by this teacher
    double luongGV = gvDao.getLuongTheoTaiKhoan(user.getID_TaiKhoan()); // Teacher's salary
    
    // Format the salary for display (e.g., with thousands separator)
    DecimalFormat df = new DecimalFormat("#,###");
    String luongGv = df.format(luongGV);
    
    // Set dashboard statistics as request attributes for the JSP
    request.setAttribute("gv", gvDao.getGiaoVienByID(idTaiKhoan)); // Teacher's personal information
    request.setAttribute("numHocSinh", numHocSinh); 
    request.setAttribute("numLopHoc", numLopHoc);
    
    
    // --- Logic for displaying weekly schedule ---
    LocalDate startOfWeek; // Variable to store the start date of the displayed week
    String viewDateParam = request.getParameter("viewDate"); // Parameter from navigation buttons (YYYY-MM-DD)
    String weekParam = request.getParameter("week"); // Parameter from HTML input type="week" (YYYY-Www)

    if (weekParam != null && !weekParam.isEmpty()) {
        // If 'week' parameter is provided (e.g., from an HTML week input)
        int year = Integer.parseInt(weekParam.substring(0, 4)); // Extract year (e.g., "2025-Wxx" -> 2025)
        int weekNumber = Integer.parseInt(weekParam.substring(6)); // Extract week number (e.g., "2025-W12" -> 12)
        
        // Calculate the Monday of the specified week using ISO week fields
        startOfWeek = LocalDate.of(year, 1, 1)
                .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, weekNumber)
                .with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
        // If 'viewDate' parameter is provided (e.g., from "Previous Week" / "Next Week" links)
        startOfWeek = LocalDate.parse(viewDateParam); // Parse the YYYY-MM-DD string to LocalDate
    } else {
        // Default: Get the Monday of the current week if no parameters are provided
        startOfWeek = LocalDate.now().with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    }
    
    LocalDate endOfWeek = startOfWeek.plusDays(6); // Calculate Sunday of the current week

    // Initialize DAOs for fetching schedule data
    LichHocDAO lichHocDAO = new LichHocDAO();
    SlotHocDAO slotHocDAO = new SlotHocDAO();
    
    // Get the teacher's schedule for the determined week
    List<LichHoc> scheduleList = lichHocDAO.getLichHocTrongTuan(idTaiKhoan, startOfWeek, endOfWeek);
    // Get all available time slots
    List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();

    // Transform schedule list into a map for easier access (key: slot ID + day of week, value: LichHoc object)
    Map<String, LichHoc> scheduleMap = new HashMap<>();
    LocalDate homNay = LocalDate.now(); // Get today's date for attendance marking
    for (LichHoc lh : scheduleList) {
        // Check if the schedule date is today to enable attendance marking
        if (lh.getNgayHoc().isEqual(homNay)) {
            lh.setCoTheSua(true); // Mark as editable/attendable
        }
        String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
        scheduleMap.put(key, lh);
    }

    // Create a list of dates for the week to display in the schedule table header
    List<LocalDate> weekDates = java.util.stream.IntStream.range(0, 7)
            .mapToObj(startOfWeek::plusDays)
            .collect(java.util.stream.Collectors.toList());

    // Define date formatters for display purposes
    DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY'-W'ww");
    int idGv = GiaoVienDAO.getGiaoVienByID(idTaiKhoan).getID_GiaoVien();
    List<SalaryInfo> salaryList;
        try {
            salaryList = salaryDAO.calculateTeacherSalary(idGv, "15-06-2025", "14-07-2025");
            request.setAttribute("luongGV", salaryList);
        } catch (SQLException ex) {
            Logger.getLogger(TeacherDashboard.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    
    // Set schedule-related attributes for the JSP
    request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter)); // Display range of the week
    request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString()); // Link for previous week
    request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString()); // Link for next week
    request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter)); // Value for HTML input type="week"
    request.setAttribute("thongbaos", thongbaos);
    request.setAttribute("scheduleMap", scheduleMap); // The map of schedules
    request.setAttribute("timeSlots", timeSlots); // All defined time slots
    request.setAttribute("weekDates", weekDates); // Dates for each day of the current week
    
    // Forward the request to the teacher dashboard JSP page
    request.getRequestDispatcher("views/teacher/teacherDashboard.jsp").forward(request, response);
}
    /** * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}