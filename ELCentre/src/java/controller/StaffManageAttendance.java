// Author: trungdam
// Servlet: StaffManageAttendance
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
import dal.NopBaiTapDAO;
import dal.TaiBaiTapDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.DiemDanh;
import model.HocSinh;
import model.KhoaHoc;
import model.KhoiHoc;
import model.LichHoc;
import model.LopHoc;

/**
 *
 * @author admin
 */
public class StaffManageAttendance extends HttpServlet {
    private final KhoaHocDAO khoaHocDAO = new KhoaHocDAO();
    private final NopBaiTapDAO nopBaiTapDAO = new NopBaiTapDAO();
    private LopHocDAO lopHocDAO = new LopHocDAO();
    private DiemDanhDAO diemDanhDAO = new DiemDanhDAO(); // Initialize DAO
    private LichHocDAO lichHocDAO = new LichHocDAO();
    private HocSinhDAO hocSinhDAO = new HocSinhDAO();// Initialize DAO
    private TaiBaiTapDAO taiBaiTapDAO = new TaiBaiTapDAO();
    private final GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
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
            out.println("<title>Servlet StaffManageAttendance</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffManageAttendance at " + request.getContextPath () + "</h1>");
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
    /**
     * Displays the attendance report for a specific class.
     * Fetches class details, student list, class schedule, and attendance records.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showClassAttendanceReport(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        // Get classId parameter from the request
        int classId = Integer.parseInt(request.getParameter("classId"));
        
        // Fetch class details, student list, class schedule, and attendance map using DAOs
        LopHoc lopHoc = lopHocDAO.getLopHocById(classId); // Get class information
        List<HocSinh> studentList = hocSinhDAO.getHocSinhByLopHoc(classId); // Get list of students in the class
        List<LichHoc> scheduleList = lichHocDAO.getAllSchedulesForClass(classId); // Get all schedules for the class
        Map<String, DiemDanh> attendanceMap = diemDanhDAO.getAttendanceMapForClass(classId); // Get attendance records for the class
        
        // Set attributes to be available in the JSP
        request.setAttribute("lopHoc", lopHoc);
        request.setAttribute("studentList", studentList);
        request.setAttribute("scheduleList", scheduleList);
        request.setAttribute("attendanceMap", attendanceMap);
        
        // Forward the request to the JSP page for displaying the attendance report
        request.getRequestDispatcher("/views/staff/classAttendanceReport.jsp").forward(request, response);
    } catch (Exception e) {
        // Print stack trace for debugging purposes
        e.printStackTrace();
        // Optionally, redirect to an error page or display a user-friendly error message
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading class attendance report.");
    }
}
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action"); // Get the action parameter
        if (action == null) action = ""; // Default action if not provided
        
        HttpSession session = request.getSession();
        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            response.sendRedirect("views/login.jsp"); // Redirect to login page if not logged in
            return;
        }
        
        // Handle different actions
        switch (action){
            case "showClassAttendanceReport":
                showClassAttendanceReport(request, response); // Show attendance report for a specific class
                break;    
            default: 
                showClassListPage(request, response); // Default: show the list of classes for attendance
                break;
                
        }
        
    }    

    /** * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /**
     * Displays a paginated and filtered list of active classes for attendance management.
     * Allows filtering by keyword, course, grade (khoi), and creation year.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private void showClassListPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get filter and pagination parameters from the request
        String keyword = request.getParameter("keyword"); // Search keyword for class names
        String courseIdParam = request.getParameter("courseId"); // Course ID filter
        String khoiIdParam = request.getParameter("khoiId"); // Grade (KhoiHoc) ID filter
        String yearParam = request.getParameter("creationYear"); // Creation year filter
        String pageParam = request.getParameter("page"); // Current page number

        int pageSize = 8; // Number of classes to display per page
        
        KhoiHocDAO khoiHocDAO = new KhoiHocDAO(); // Initialize DAO for grades

        // Parse filter parameters, defaulting to null if not provided or invalid
        Integer courseId = (courseIdParam != null && !courseIdParam.isEmpty()) ? Integer.valueOf(courseIdParam) : null;
        Integer khoiId = (khoiIdParam != null && !khoiIdParam.isEmpty()) ? Integer.valueOf(khoiIdParam) : null;
        Integer creationYear = (yearParam != null && !yearParam.isEmpty()) ? Integer.valueOf(yearParam) : null;
        
        // Parse current page parameter, defaulting to 1 if not provided or invalid
        int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

        // Fetch filtered list of active classes with pagination
        List<LopHoc> activeClassList = lopHocDAO.getFilteredActiveClasses(keyword, courseId, khoiId, creationYear, currentPage, pageSize);
        // Count total filtered active classes for pagination calculation
        int totalItems = lopHocDAO.countFilteredActiveClasses(keyword, courseId, khoiId, creationYear);
        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        // Fetch lists for filter dropdowns
        List<KhoaHoc> khoaHocList = khoaHocDAO.adminGetAllKhoaHoc(); // All courses
        List<KhoiHoc> khoiHocList = khoiHocDAO.getAllKhoiHoc(); // All grades
        List<Integer> yearList = lopHocDAO.getDistinctCreationYears(); // Distinct creation years for classes

        // Set attributes for the JSP to display
        request.setAttribute("activeClassList", activeClassList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("khoaHocList", khoaHocList);
        request.setAttribute("khoiHocList", khoiHocList);
        request.setAttribute("yearList", yearList);
        
        // Set selected filter values to retain state in the form
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedCourseId", courseId);
        request.setAttribute("selectedKhoiId", khoiId);
        request.setAttribute("selectedYear", creationYear);
        
        // Forward the request to the check attendance JSP page
        request.getRequestDispatcher("/views/staff/checkAttendance.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // For this servlet, POST requests are processed the same way as GET requests for simplicity.
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