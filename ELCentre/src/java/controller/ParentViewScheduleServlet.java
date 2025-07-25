// Author: trungdam
// Servlet: ParentViewScheduleServlet
package controller;

import dal.HocSinhDAO;
import dal.LichHocDAO;
import dal.PhuHuynhDAO;
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
import model.DiemDanh; // Although not used here, keep for consistency if attendance is added later
import model.HocSinh;
import model.LichHoc;
import model.PhuHuynh;
import model.SlotHoc;
import model.TaiKhoan;

public class ParentViewScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the current user session
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // If the user is not logged in or is not a parent (ID_VaiTro = 5), redirect to login page
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get the parent's account ID
        int idTaiKhoanPhuHuynh = user.getID_TaiKhoan();
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhByTaiKhoanId(idTaiKhoanPhuHuynh);

        // Get list of children associated with this parent
        List<HocSinh> childrenList = new ArrayList<>();
        if (phuHuynh != null) {
            // Assuming PhuHuynhDAO or HocSinhDAO has a method to get children by parent ID or phone
            // For now, using getHocSinhByPhuHuynhPhone as per ParentDashboardServlet
            childrenList = HocSinhDAO.getHocSinhByPhuHuynhPhone(phuHuynh.getSDT());
        }

        // --- Determine which child's schedule to display ---
        int idHocSinhToView = -1;
        HocSinh selectedHocSinh = null;

        String idHocSinhParam = request.getParameter("idHocSinh");
        if (idHocSinhParam != null && !idHocSinhParam.isEmpty()) {
            try {
                int requestedIdHocSinh = Integer.parseInt(idHocSinhParam);
                // Validate if the requested student ID belongs to the current parent
                for (HocSinh child : childrenList) {
                    if (child.getID_HocSinh() == requestedIdHocSinh) {
                        idHocSinhToView = requestedIdHocSinh;
                        selectedHocSinh = child;
                        break;
                    }
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid idHocSinh parameter: " + idHocSinhParam);
            }
        }

        // If no valid idHocSinh param, or if it doesn't belong to the parent,
        // default to the first child in the list
        if (selectedHocSinh == null && !childrenList.isEmpty()) {
            selectedHocSinh = childrenList.get(0);
            idHocSinhToView = selectedHocSinh.getID_HocSinh();
        }

        // If after all logic, no student can be selected (e.g., parent has no children registered)
        if (selectedHocSinh == null) {
            request.setAttribute("errorMessage", "Không tìm thấy học sinh nào liên kết với tài khoản của bạn.");
            request.setAttribute("phuHuynhInfo", phuHuynh);
            request.setAttribute("dsCon", childrenList);
            request.getRequestDispatcher("/views/parent/parentViewSchedule.jsp").forward(request, response);
            return;
        }

        // --- Logic to determine the start of the week for schedule display ---
        LocalDate startOfWeek;
        String viewDateParam = request.getParameter("viewDate"); // Parameter from "Previous/Next Week" buttons (YYYY-MM-DD)
        String weekParam = request.getParameter("week"); // Parameter from HTML input type="week" (YYYY-Www)

        if (weekParam != null && !weekParam.isEmpty()) {
            int year = Integer.parseInt(weekParam.substring(0, 4));
            int weekNumber = Integer.parseInt(weekParam.substring(6));
            startOfWeek = LocalDate.of(year, 1, 1)
                    .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, weekNumber)
                    .with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        } else if (viewDateParam != null && !viewDateParam.isEmpty()) {
            startOfWeek = LocalDate.parse(viewDateParam);
        } else {
            startOfWeek = LocalDate.now().with(java.time.temporal.TemporalAdjusters.previousOrSame(java.time.DayOfWeek.MONDAY));
        }

        LocalDate endOfWeek = startOfWeek.plusDays(6); // Calculate Sunday of the current week

        // --- Fetch data from the database ---
        LichHocDAO lichHocDAO = new LichHocDAO();
        SlotHocDAO slotHocDAO = new SlotHocDAO();

        // Get the selected student's schedule for the determined week
        List<LichHoc> scheduleList = lichHocDAO.HSgetLichHocTrongTuan(idHocSinhToView, startOfWeek, endOfWeek);

        // Get all available time slots
        List<SlotHoc> timeSlots = slotHocDAO.getAllSlotHoc1();

        // --- Transform schedule list into a map for easier access by slot and day of week ---
        Map<String, LichHoc> scheduleMap = new HashMap<>();
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
        request.setAttribute("phuHuynhInfo", phuHuynh);
        request.setAttribute("dsCon", childrenList); // List of children for dropdown
        request.setAttribute("selectedHocSinh", selectedHocSinh); // The specific child whose schedule is being viewed

        request.setAttribute("displayWeekRange", "Tuần từ " + startOfWeek.format(displayFormatter) + " đến " + endOfWeek.format(displayFormatter));
        
        // Include the selected student's ID in navigation links to maintain context
        request.setAttribute("previousWeekLink", startOfWeek.minusWeeks(1).toString() + "&idHocSinh=" + idHocSinhToView);
        request.setAttribute("nextWeekLink", startOfWeek.plusWeeks(1).toString() + "&idHocSinh=" + idHocSinhToView);
        request.setAttribute("selectedWeekValue", startOfWeek.format(weekInputFormatter));
        
        request.setAttribute("scheduleMap", scheduleMap);
        request.setAttribute("timeSlots", timeSlots);
        request.setAttribute("weekDates", weekDates);

        // Forward the request to the parent view schedule JSP page
        request.getRequestDispatcher("/views/parent/parentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For this servlet, POST requests are handled the same way as GET requests (idempotent operation).
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for parents to view their children's schedules.";
    }
}