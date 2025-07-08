package controller.ManageCourses;

import dal.LichHocDAO;
import model.LichHoc;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

public class ManageSchedule extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LocalDate now = LocalDate.now();
        int month = now.getMonthValue();
        int year = now.getYear();

        try {
            if (request.getParameter("month") != null) {
                month = Integer.parseInt(request.getParameter("month"));
            }
            if (request.getParameter("year") != null) {
                year = Integer.parseInt(request.getParameter("year"));
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid month/year parameters: " + e.getMessage());
        }

        LichHocDAO dao = new LichHocDAO();
        List<LichHoc> lichHocList = dao.getLichHocByMonth1(year, month);
        System.out.println("lichHocList size: " + lichHocList.size());

        Set<Integer> scheduleDays = lichHocList.stream()
                .filter(lh -> lh.getNgayHoc() != null)
                .map(lh -> lh.getNgayHoc().getDayOfMonth())
                .collect(Collectors.toSet());

        request.setAttribute("lichHocList", lichHocList);
        request.setAttribute("scheduleDays", scheduleDays);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("currentYear", now.getYear());

        request.getRequestDispatcher("/views/admin/manageSchedule.jsp").forward(request, response);
    }
    
    
    public static void main(String[] args) {
        LocalDate now = LocalDate.now();
        int month = now.getMonthValue();
        int year = now.getYear();

        try {
            // Có thể sửa tháng/năm tại đây nếu muốn test
            month = 7; // July
            year = 2025;

            LichHocDAO dao = new LichHocDAO();
            List<LichHoc> lichHocList = dao.getLichHocByMonth1(year, month);

            Set<Integer> scheduleDays = lichHocList.stream()
                    .filter(lh -> lh.getNgayHoc() != null)
                    .map(lh -> lh.getNgayHoc().getDayOfMonth())
                    .collect(Collectors.toSet());

            System.out.println("🗓 Danh sách lịch học tháng " + month + "/" + year + ":");
            for (LichHoc lh : lichHocList) {
                System.out.println("- Ngày học: " + lh.getNgayHoc() + ", Lớp: " + lh.getID_LopHoc());
            }

            System.out.println("\n📅 Các ngày có lịch học: " + scheduleDays);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to manage course schedules";
    }
}
