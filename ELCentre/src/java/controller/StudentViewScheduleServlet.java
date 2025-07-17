package controller;

import dal.HocSinhDAO;
import dal.LichHocDAO;
import dal.SlotHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.DiemDanh;
import model.LichHoc;
import model.SlotHoc;
import model.TaiKhoan;

public class StudentViewScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Nếu chưa đăng nhập hoặc không phải vai trò học sinh → redirect
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        
        List<DiemDanh> attendanceList = new ArrayList<>();
        
        // --- Sort by week ---
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
        List<LichHoc> scheduleList = lichHocDAO.HSgetLichHocTrongTuan(idHocSinh, startOfWeek, endOfWeek);
        List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();
        
        Map<String, LichHoc> scheduleMap = new HashMap<>();
        LocalDate homNay = LocalDate.now();
        for (LichHoc lh : scheduleList) {
            String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
            scheduleMap.put(key, lh);
        }
        List<LocalDate> weekDates = java.util.stream.IntStream.range(0, 7)
            .mapToObj(startOfWeek::plusDays)
            .collect(java.util.stream.Collectors.toList());
        
        // Định dạng ngày tháng
        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY'-W'ww");
        
        request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter));
        request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString());
        request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString());
        request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter)); 
        // Gửi dữ liệu chính
        request.setAttribute("scheduleMap", scheduleMap);
        request.setAttribute("timeSlots", timeSlots);
        request.setAttribute("weekDates", weekDates);
        request.getRequestDispatcher("/views/student/studentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
