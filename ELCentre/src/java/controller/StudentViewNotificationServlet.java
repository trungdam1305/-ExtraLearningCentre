package controller;

import dal.HocSinhDAO;
import dal.ThongBaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.ThongBao;

import java.io.IOException;
import java.util.List;
import model.HocSinh;

public class StudentViewNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra đăng nhập và vai trò học sinh
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh từ DB: " + idHocSinh);
        
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        
        try {
            List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoan);
            request.setAttribute("dsThongBao", dsThongBao);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dsThongBao", null);
        }
        
        request.setAttribute("hocSinhInfo", hocSinh);
        request.getRequestDispatcher("/views/student/studentViewNotification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách thông báo cho học sinh";
    }
}
