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
    private DiemDanhDAO diemDanhDAO = new DiemDanhDAO(); // Khởi tạo DAO
    private LichHocDAO lichHocDAO = new LichHocDAO();
    private HocSinhDAO hocSinhDAO = new HocSinhDAO();// Khởi tạo DAO
    private TaiBaiTapDAO taiBaiTapDAO = new TaiBaiTapDAO();
    private final GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        switch (action){
            case "showClassAttendanceReport":
                showClassAttendanceReport(request, response);
                break; 
            default: showClassListPage(request, response);
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
    private void showClassListPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String courseIdParam = request.getParameter("courseId");
        String khoiIdParam = request.getParameter("khoiId");
        String yearParam = request.getParameter("creationYear");
        String pageParam = request.getParameter("page");
        int pageSize = 8; 
        KhoiHocDAO khoiHocDAO = new KhoiHocDAO();
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
        request.getRequestDispatcher("/views/staff/checkAttendance.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
