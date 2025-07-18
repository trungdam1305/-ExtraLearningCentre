/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.GiaoVien_LopHocDAO;
import dal.GiaoVienDAO;
import dal.LichHocDAO;
import dal.SlotHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.LichHoc;
import model.SlotHoc;
import model.TaiKhoan;

/**
 *
 * @author admin
 */
public class TeacherDashboard extends HttpServlet {
   
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
            out.println("<title>Servlet TeacherDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TeacherDashboard at " + request.getContextPath () + "</h1>");
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
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    //Session to get user's information
    HttpSession session = request.getSession();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");
    if (user == null && user.getID_VaiTro() != 3) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp"); //null => go to login site
        return;
    }
    //get idTaiKhoan
    int idTaiKhoan = user.getID_TaiKhoan();
    GiaoVienDAO gvDao = new GiaoVienDAO();
    
    // get numHocSinh, numLopHoc and luongGV to display in the dashboard
    int numHocSinh = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(idTaiKhoan);
    int numLopHoc = GiaoVien_LopHocDAO.teacherGetTongSoLopHoc(idTaiKhoan);
    double luongGV = gvDao.getLuongTheoTaiKhoan(user.getID_TaiKhoan());
    DecimalFormat df = new DecimalFormat("#,###");
    String luongGv = df.format(luongGV);
    
    // request and send to jsp 
    request.setAttribute("gv", gvDao.getGiaoVienByID(idTaiKhoan));
    request.setAttribute("numHocSinh", numHocSinh);
    request.setAttribute("numLopHoc", numLopHoc);
    request.setAttribute("luongGV", luongGv);
    
    // Execute sort by week
    LocalDate startOfWeek; //initiate start of wwek
    String viewDateParam = request.getParameter("viewDate");
    String weekParam = request.getParameter("week"); 

    if (weekParam != null && !weekParam.isEmpty()) {
        int year = Integer.parseInt(weekParam.substring(0, 4));//weekParam form like 2025-Wxx
        int weekNumber = Integer.parseInt(weekParam.substring(6));
        // calculate Monday from year and weekNumber
        startOfWeek = LocalDate.of(year, 1, 1)
                .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, weekNumber)
                .with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
        // when user select nextweek or previous week
        startOfWeek = LocalDate.parse(viewDateParam);
    } else {
        // default: get current week
        startOfWeek = LocalDate.now().with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    }
    
    LocalDate endOfWeek = startOfWeek.plusDays(6);

    // get data from db
    LichHocDAO lichHocDAO = new LichHocDAO();
    SlotHocDAO slotHocDAO = new SlotHocDAO();
    
    List<LichHoc> scheduleList = lichHocDAO.getLichHocTrongTuan(idTaiKhoan, startOfWeek, endOfWeek);
    List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();

    // switch schedule to map for easier access
    Map<String, LichHoc> scheduleMap = new HashMap<>();
    LocalDate homNay = LocalDate.now();
    for (LichHoc lh : scheduleList) {
        // check if today => can take attendance
        if (lh.getNgayHoc().isEqual(homNay)) {
            lh.setCoTheSua(true);
        }
        String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
        scheduleMap.put(key, lh);
    }

    // Create weekdays to display in the header
    List<LocalDate> weekDates = java.util.stream.IntStream.range(0, 7)
            .mapToObj(startOfWeek::plusDays)
            .collect(java.util.stream.Collectors.toList());

    // format day
    DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY'-W'ww");

    // request schedule components and send to jsp
    request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter));
    request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString());
    request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString());
    request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter));

    request.setAttribute("scheduleMap", scheduleMap);
    request.setAttribute("timeSlots", timeSlots);
    request.setAttribute("weekDates", weekDates);
    
    // request to jsp
    request.getRequestDispatcher("views/teacher/teacherDashboard.jsp").forward(request, response);
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
