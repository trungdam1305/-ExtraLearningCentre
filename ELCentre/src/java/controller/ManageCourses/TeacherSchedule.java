package controller.ManageCourses;

import dal.LichHocDAO;
import model.LichHoc;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class TeacherSchedule extends HttpServlet {

    private LichHocDAO lichHocDAO = new LichHocDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idTKGiaoVienStr = request.getParameter("idTKGiaoVien");
        int idTKGiaoVien;
        try {
            idTKGiaoVien = Integer.parseInt(idTKGiaoVienStr);
        } catch (NumberFormatException e) {
            request.setAttribute("err", "ID giáo viên không hợp lệ");
            request.getRequestDispatcher("/views/teacher/teacher_Schedule.jsp").forward(request, response);
            return;
        }
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
        List<LichHoc> lichHocList = dao.getLichDayByTeacherAndMonth(idTKGiaoVien, year, month);

        Set<Integer> scheduleDays = lichHocList.stream()
                .filter(lh -> lh.getNgayHoc() != null)
                .map(lh -> lh.getNgayHoc().getDayOfMonth())
                .collect(Collectors.toSet());

        request.setAttribute("idTKGiaoVien", idTKGiaoVien);
        request.setAttribute("lichHocList", lichHocList);
        request.setAttribute("scheduleDays", scheduleDays);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("currentYear", now.getYear());

        request.getRequestDispatcher("/views/teacher/teacher_Schedule.jsp").forward(request, response);
    }
}
