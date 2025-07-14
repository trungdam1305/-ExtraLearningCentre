package controller;

import dal.HocSinhDAO;
import dal.LichHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.HocSinh;
import model.LichHoc;
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
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);

        List<LichHoc> lichHocList = LichHocDAO.getLichHocByHocSinhId(idHocSinh);

        // Define time slots and days of the week
        List<String> timeSlots = Arrays.asList("07:00 - 09:00", "09:30 - 11:30", "13:30 - 15:30", "16:00 - 18:00");
        List<String> daysOfWeek = Arrays.asList("Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "Chủ nhật");

        // Pre-process timetable data for efficiency
        Map<String, Map<String, String>> timetableData = new HashMap<>();
        for (String slot : timeSlots) {
            Map<String, String> dayMap = new HashMap<>();
            for (String day : daysOfWeek) {
                dayMap.put(day, ""); // Default empty
            }
            timetableData.put(slot, dayMap);
        }

        // Populate timetable data from lichHocList
        for (LichHoc lh : lichHocList) {
            if (lh.getSlotThoiGian() != null && lh.getNgayHoc() != null && lh.getTenLopHoc() != null) {
                String slot = lh.getSlotThoiGian().trim();
                String day = lh.getNgayHoc().format(DateTimeFormatter.ISO_DATE);
                // Ensure slot and day exist in timetableData before adding
                if (timetableData.containsKey(slot) && timetableData.get(slot).containsKey(day)) {
                    timetableData.get(slot).put(day, lh.getTenLopHoc());
                } else {
                    // Log mismatch for debugging
                    System.out.println("Mismatch: slot=" + slot + ", day=" + day + " not found in timeSlots/daysOfWeek");
                }
            }
        }

        // Set attributes for JSP
        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("lichHocList", lichHocList);
        request.setAttribute("timeSlots", timeSlots);
        request.setAttribute("daysOfWeek", daysOfWeek);
        request.setAttribute("timetableData", timetableData);

        // Debug logging
        System.out.println("lichHocList size: " + lichHocList.size());
        for (LichHoc lh : lichHocList) {
            System.out.println("LichHoc: ngayHoc=" + lh.getNgayHoc() + ", slotThoiGian=" + lh.getSlotThoiGian() + ", tenLopHoc=" + lh.getTenLopHoc());
        }
        System.out.println("timeSlots: " + timeSlots);
        System.out.println("daysOfWeek: " + daysOfWeek);

        request.getRequestDispatcher("/views/student/studentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}