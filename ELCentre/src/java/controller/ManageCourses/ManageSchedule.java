/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManageCourses;

import dal.LichHocDAO;
import model.LichHoc;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;


/**
 *
 * @author Vuh26
 */
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String csrfToken = request.getParameter("csrfToken");
        if (!csrfToken.equals(session.getAttribute("csrfToken"))) {
            request.setAttribute("err", "Yêu cầu không hợp lệ!");
            doGet(request, response);
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int day = Integer.parseInt(request.getParameter("day"));
                int month = Integer.parseInt(request.getParameter("month"));
                int year = Integer.parseInt(request.getParameter("year"));

                // Tạo LocalDate từ day, month, year
                LocalDate deleteDate = LocalDate.of(year, month, day);

                // Xóa tất cả lịch học trong ngày
                LichHocDAO dao = new LichHocDAO();
                boolean success = dao.deleteLichHocByDate1(deleteDate);

                if (success) {
                    request.setAttribute("suc", "Xóa tất cả lịch học trong ngày " + day + "/" + month + "/" + year + " thành công!");
                } else {
                    request.setAttribute("err", "Không được xóa lịch học trong quá khứ!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("err", "Dữ liệu ngày không hợp lệ!");
            } catch (Exception e) {
                System.out.println("Error in deleteLichHocByDate1: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("err", "Đã xảy ra lỗi khi xóa lịch học!");
            }
        }

        // Làm mới trang
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to manage course schedules";
    }
}