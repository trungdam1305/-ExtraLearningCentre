package controller;

import dal.HocSinhDAO;
import dal.LichHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
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

        List<LichHoc> lichHocList = LichHocDAO.getLichHocByHocSinhId(idHocSinh);

        request.setAttribute("lichHocList", lichHocList);
        request.getRequestDispatcher("/views/student/studentViewSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
