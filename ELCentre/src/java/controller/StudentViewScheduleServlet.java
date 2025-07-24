// Author: trungdam
// Servlet: StudentViewScheduleServlet
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
import model.HocSinh;
import model.LichHoc;
import model.SlotHoc;
import model.TaiKhoan;

public class StudentViewScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current user session
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // If the user is not logged in or is not a student (ID_VaiTro = 4), redirect to login page
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Get the student's ID from the TaiKhoan ID
        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        
        // This variable is declared but not used in the provided snippet.
        // If intended for future use, it should be populated with attendance data.
        List<DiemDanh> attendanceList = new ArrayList<>();
        
        // --- Logic to determine the start of the week for schedule display ---
        LocalDate startOfWeek;
        String viewDateParam = request.getParameter("viewDate"); // Parameter from "Previous/Next Week" buttons (YYYY-MM-DD)
        String weekParam = request.getParameter("week"); // Parameter from HTML input type="week" (YYYY-Www)

        if (weekParam != null && !weekParam.isEmpty()) {
            // If 'week' parameter is provided (e.g., from a week input field)
            int year = Integer.parseInt(weekParam.substring(0, 4)); // Extract year
            int weekNumber = Integer.parseInt(weekParam.substring(6)); // Extract week number
            
            // Calculate Monday of the specified week using ISO week fields
            startOfWeek = LocalDate.of(year, 1, 1)
                    .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, weekNumber)
                    .with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
            // If 'viewDate' parameter is provided (e.g., from navigating weeks)
            startOfWeek = LocalDate.parse(viewDateParam); // Parse the date string
        } else {
            // Default: Get the Monday of the current week if no parameters are provided
            startOfWeek = LocalDate.now().with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        }

        LocalDate endOfWeek = startOfWeek.plusDays(6); // Calculate Sunday of the current week
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        // --- Fetch data from the database ---
        LichHocDAO lichHocDAO = new LichHocDAO();
        SlotHocDAO slotHocDAO = new SlotHocDAO();
        
        // Get the student's schedule for the determined week
        List<LichHoc> scheduleList = lichHocDAO.HSgetLichHocTrongTuan(idHocSinh, startOfWeek, endOfWeek);
        
        // Get all available time slots
        List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();
        
        // --- Transform schedule list into a map for easier access by slot and day of week ---
        Map<String, LichHoc> scheduleMap = new HashMap<>();
        // LocalDate homNay = LocalDate.now(); // This variable is declared but not used.
        for (LichHoc lh : scheduleList) {
            String key = lh.getID_SlotHoc() + "-" + lh.getNgayHoc().getDayOfWeek().getValue();
            scheduleMap.put(key, lh);
        }
        
        // --- Create a list of dates for the week to display in the header of the schedule grid ---
        List<LocalDate> weekDates = java.util.stream.IntStream.range(0, 7)
                .mapToObj(startOfWeek::plusDays)
                .collect(java.util.stream.Collectors.toList());
        
        // --- Define date formatters for display and for the week input field ---
        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        DateTimeFormatter weekInputFormatter = DateTimeFormatter.ofPattern("YYYY'-W'ww");
        
        // --- Set attributes for the JSP to display schedule components and navigation links ---
        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter));
        request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString()); // Link for previous week
        request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString()); // Link for next week
        request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter)); // Value for HTML input type="week"
        
        request.setAttribute("scheduleMap", scheduleMap); // Map of schedules for quick lookup
        request.setAttribute("timeSlots", timeSlots); // List of time slots
        request.setAttribute("weekDates", weekDates); // List of dates for the current week

        // Forward the request to the student view schedule JSP page
        request.getRequestDispatcher("/views/student/studentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For this servlet, POST requests are handled the same way as GET requests (idempotent operation).
        doGet(request, response);
    }
}