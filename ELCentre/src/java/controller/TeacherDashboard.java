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
    
    // --- BƯỚC 1: XÁC THỰC VÀ LẤY THÔNG TIN NGƯỜI DÙNG ---
    HttpSession session = request.getSession();
    TaiKhoan user = (TaiKhoan) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }

    // --- BƯỚC 2: TẢI DỮ LIỆU THỐNG KÊ CHO DASHBOARD ---
    int idTaiKhoan = user.getID_TaiKhoan();
    GiaoVienDAO gvDao = new GiaoVienDAO();
    
    // Lấy các thông tin thống kê
    int numHocSinh = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(idTaiKhoan);
    int numLopHoc = GiaoVien_LopHocDAO.teacherGetTongSoLopHoc(idTaiKhoan);
    double luongGV = gvDao.getLuongTheoTaiKhoan(user.getID_TaiKhoan());
    DecimalFormat df = new DecimalFormat("#,###");
    String luongGv = df.format(luongGV);
    
    // Gửi thông tin người dùng và thống kê sang JSP
    request.setAttribute("gv", gvDao.getGiaoVienByID(idTaiKhoan));
    request.setAttribute("numHocSinh", numHocSinh);
    request.setAttribute("numLopHoc", numLopHoc);
    request.setAttribute("luongGV", luongGv);
    
    // --- BƯỚC 3: XỬ LÝ LOGIC LỌC THEO TUẦN ---
    LocalDate startOfWeek;
    String viewDateParam = request.getParameter("viewDate");
    String weekParam = request.getParameter("week"); // Tham số từ <input type="week">

    if (weekParam != null && !weekParam.isEmpty()) {
        // Trường hợp người dùng chọn một tuần cụ thể (định dạng: "2025-W28")
        int year = Integer.parseInt(weekParam.substring(0, 4));
        int weekNumber = Integer.parseInt(weekParam.substring(6));
        // Tính ngày đầu tuần (Thứ Hai) từ năm và số tuần
        startOfWeek = LocalDate.of(year, 1, 1)
                .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, weekNumber)
                .with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
        // Trường hợp người dùng nhấn nút "Tuần trước" hoặc "Tuần sau"
        startOfWeek = LocalDate.parse(viewDateParam);
    } else {
        // Mặc định: lấy tuần hiện tại
        startOfWeek = LocalDate.now().with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
    }

    LocalDate endOfWeek = startOfWeek.plusDays(6);

    // --- BƯỚC 4: LẤY DỮ LIỆU LỊCH HỌC TỪ DATABASE ---
    LichHocDAO lichHocDAO = new LichHocDAO();
    SlotHocDAO slotHocDAO = new SlotHocDAO();
    
    List<LichHoc> scheduleList = lichHocDAO.getLichHocTrongTuan(idTaiKhoan, startOfWeek, endOfWeek);
    List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();

    // Chuyển danh sách lịch học thành Map để dễ dàng truy cập trong JSP
    Map<String, LichHoc> scheduleMap = new HashMap<>();
    LocalDate homNay = LocalDate.now();
    for (LichHoc lh : scheduleList) {
        // Kiểm tra xem buổi học có phải là hôm nay không để cho phép điểm danh
        if (lh.getNgayHoc().isEqual(homNay)) {
            lh.setCoTheSua(true);
        }
        String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
        scheduleMap.put(key, lh);
    }

    // --- BƯỚC 5: CHUẨN BỊ CÁC THUỘC TÍNH ĐỂ GỬI SANG JSP ---
    // Tạo danh sách các ngày trong tuần để hiển thị trên header của bảng
    List<LocalDate> weekDates = java.util.stream.IntStream.range(0, 7)
            .mapToObj(startOfWeek::plusDays)
            .collect(java.util.stream.Collectors.toList());

    // Định dạng ngày tháng
    DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY'-W'ww");

    // ✅ CÁC THUỘC TÍNH MỚI BẠN YÊU CẦU THÊM VÀO
    request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter));
    request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString());
    request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString());
    request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter)); // Dữ liệu cho <input type="week">

    // Gửi dữ liệu chính
    request.setAttribute("scheduleMap", scheduleMap);
    request.setAttribute("timeSlots", timeSlots);
    request.setAttribute("weekDates", weekDates);
    
    // --- BƯỚC 6: CHUYỂN TIẾP ĐẾN TRANG JSP ---
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
