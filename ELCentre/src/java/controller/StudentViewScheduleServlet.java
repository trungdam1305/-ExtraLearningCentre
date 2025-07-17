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
         //Session to get user's information
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // not student => return to login
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        //get idTaiKhoan
        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        
        List<DiemDanh> attendanceList = new ArrayList<>();
        
        // --- Sort by week ---
        LocalDate startOfWeek;
        String viewDateParam = request.getParameter("viewDate");//initiate start of wwek
        String weekParam = request.getParameter("week"); 

        if (weekParam != null && !weekParam.isEmpty()) {
        //weekParam form like 2025-Wxx
        int year = Integer.parseInt(weekParam.substring(0, 4));
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
        List<LichHoc> scheduleList = lichHocDAO.HSgetLichHocTrongTuan(idHocSinh, startOfWeek, endOfWeek);
        List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();
        
        // switch schedule to map for easier access
        Map<String, LichHoc> scheduleMap = new HashMap<>();
        LocalDate homNay = LocalDate.now();
        for (LichHoc lh : scheduleList) {
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
        request.getRequestDispatcher("/views/student/studentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
