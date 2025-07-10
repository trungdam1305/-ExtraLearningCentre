/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.GiaoVien_LopHocDAO;
import dal.GiaoVienDAO;
import dal.LichHocDAO;
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
import java.util.List;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.LichHoc;
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
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // --- Lấy các thông số chung (giữ nguyên) ---
        GiaoVien_LopHocDAO gvLhDAO = new GiaoVien_LopHocDAO();
        int numLopHoc = GiaoVien_LopHocDAO.teacherGetTongSoLopHoc(user.getID_TaiKhoan());
        int numHocSinh = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(user.getID_TaiKhoan());
        GiaoVienDAO dao = new GiaoVienDAO();
        double luongGV = dao.getLuongTheoTaiKhoan(user.getID_TaiKhoan());
        DecimalFormat df = new DecimalFormat("#,###");
        String luongGv = df.format(luongGV);
        GiaoVien_TruongHoc gv = GiaoVienDAO.getGiaoVienByID(user.getID_TaiKhoan());

        // --- LOGIC XỬ LÝ NGÀY/TUẦN ĐÃ ĐƯỢC NÂNG CẤP ---
        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        LocalDate startDate;
        LocalDate endDate;
        String displayRange;
        String viewMode = "week"; // Mặc định là xem theo tuần

        // Lấy các tham số điều khiển ngày tháng từ request
        String filterDateParam = request.getParameter("filterDate");
        String selectedWeekParam = request.getParameter("selectedWeek");
        String viewDateParam = request.getParameter("viewDate");

        if (filterDateParam != null && !filterDateParam.isEmpty()) {
            // ƯU TIÊN 1: LỌC THEO NGÀY CỤ THỂ
            viewMode = "day";
            startDate = endDate = LocalDate.parse(filterDateParam);
            displayRange = "Ngày " + startDate.format(displayFormatter);
        } else {
            // XEM THEO TUẦN (như cũ)
            LocalDate viewMonday;
            java.time.temporal.WeekFields weekFields = java.time.temporal.WeekFields.ISO;

            if (selectedWeekParam != null && !selectedWeekParam.isEmpty()) {
                // Ưu tiên 2: Người dùng chọn tuần
                try {
                    int year = Integer.parseInt(selectedWeekParam.substring(0, 4));
                    int week = Integer.parseInt(selectedWeekParam.substring(6));
                    viewMonday = LocalDate.of(year, 1, 1)
                            .with(weekFields.weekOfWeekBasedYear(), week)
                            .with(java.time.temporal.TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
                } catch (Exception e) {
                    viewMonday = LocalDate.now().with(DayOfWeek.MONDAY);
                }
            } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
                // Ưu tiên 3: Người dùng nhấn nút Tuần trước/sau
                try {
                    viewMonday = LocalDate.parse(viewDateParam);
                } catch (Exception e) {
                    viewMonday = LocalDate.now().with(DayOfWeek.MONDAY);
                }
            } else {
                // Mặc định: Tuần hiện tại
                viewMonday = LocalDate.now().with(DayOfWeek.MONDAY);
            }
            startDate = viewMonday;
            endDate = startDate.plusDays(6);
            displayRange = "Tuần từ " + startDate.format(displayFormatter) + " - " + endDate.format(displayFormatter);
        }

        // Lấy danh sách lịch học trong khoảng thời gian đã xác định
        List<LichHoc> fullList = LichHocDAO.getLichHocTrongTuan(user.getID_TaiKhoan(), startDate, endDate);

        // --- Phân trang (giữ nguyên) ---
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try { page = Integer.parseInt(pageParam); } catch (NumberFormatException e) { page = 1; }
        }
        int pageSize = 10;
        int totalItems = fullList.size();
        List<LichHoc> pageList = fullList.subList(Math.max(0, (page - 1) * pageSize), Math.min(totalItems, page * pageSize));
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        if(totalPages == 0) totalPages = 1;


        // --- Gửi dữ liệu tới JSP ---
        request.setAttribute("numLopHoc", numLopHoc);
        request.setAttribute("numHocSinh", numHocSinh);
        request.setAttribute("gv", gv);
        request.setAttribute("luongGV", luongGv);

        request.setAttribute("tkbTrongTuan", pageList);
        request.setAttribute("displayWeekRange", displayRange);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Gửi các tham số để giữ lại trạng thái trên form
        request.setAttribute("filterDateValue", filterDateParam); 

        // Tạo link cho các nút điều hướng
        DateTimeFormatter urlDateFormatter = DateTimeFormatter.ISO_LOCAL_DATE;
        request.setAttribute("previousWeekLink", startDate.minusWeeks(1).format(urlDateFormatter));
        request.setAttribute("nextWeekLink", startDate.plusWeeks(1).format(urlDateFormatter));
        request.setAttribute("currentViewDate", startDate.format(urlDateFormatter));

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
