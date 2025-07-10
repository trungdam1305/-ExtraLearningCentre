package controller.ManageCourses;

import dal.LopHocDAO;
import dal.LichHocDAO;
import model.LichHoc;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;


public class StudentSchedule extends HttpServlet {
    private LopHocDAO lopHocDAO = new LopHocDAO();
        private LichHocDAO lichHocDAO = new LichHocDAO();


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idGiaoVienStr = request.getParameter("idGiaoVien");
        int idHocSinh;
        try {
            idHocSinh = Integer.parseInt(idGiaoVienStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID giáo viên không hợp lệ");
            return;
        }

        try {
            List<LichHoc> schedules = lichHocDAO.getStudentSchedule(idHocSinh);
            request.setAttribute("schedules", schedules);
            request.getRequestDispatcher("/views/student/student_Schedule.jsp").forward(request, response);
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy lịch dạy: " + e.getMessage());
        }
    }
}