package controller;

import dal.PhuHuynhDAO;
import dal.ThongBaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.PhuHuynh;
import model.TaiKhoan;
import model.ThongBao;

import java.io.IOException;
import java.util.List;

public class ParentViewNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // ✅ Kiểm tra đăng nhập và vai trò phụ huynh
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);

        try {
            List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoan);
            request.setAttribute("dsThongBao", dsThongBao);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dsThongBao", null);
        }

        request.setAttribute("phuHuynh", phuHuynh);
        request.getRequestDispatcher("/views/parent/parentViewNotification.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách thông báo cho phụ huynh";
    }
}
