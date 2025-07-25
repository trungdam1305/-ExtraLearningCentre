package controller;

import dal.TaiKhoanDAO;
import dal.ThongBaoDAO;
import model.TaiKhoan;
import model.ThongBao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;

public class adminActionWithAdvice extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "createPendingAccount":
                    createPendingAccount(request, session);
                    session.setAttribute("successMessage", "Tạo tài khoản ở trạng thái Pending thành công.");
                    break;
                case "delete":
                    deleteAdvice(request, session);
                    session.setAttribute("successMessage", "Xoá yêu cầu tư vấn thành công.");
                    break;
                case "markRead":
                    markAdviceAsRead(request, session);
                    session.setAttribute("successMessage", "Cập nhật trạng thái thành công.");
                    break;
                default:
                    session.setAttribute("errorMessage", "Hành động không hợp lệ.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Đã có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect("adminGetFromDashboard?action=yeucautuvan");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ThongBao tb = ThongBaoDAO.getThongBaoByID(id);
            if (tb != null) {
                request.setAttribute("tuvan", tb);
                request.getRequestDispatcher("/views/admin/updateAdvice.jsp").forward(request, response);
            } else {
                session.setAttribute("errorMessage", "Không tìm thấy tư vấn.");
                response.sendRedirect("adminGetFromDashboard?action=yeucautuvan");
            }
        }
    }

    private void createPendingAccount(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        String hoTen = request.getParameter("hoTen");
        String sdt = request.getParameter("sdt");

        String matKhauMacDinh = "123456"; // nên hash
        TaiKhoan tk = new TaiKhoan(email, matKhauMacDinh, 3, "HocSinh", sdt, "Pending", LocalDateTime.now());
        TaiKhoanDAO.insertPendingAccount(email, matKhauMacDinh, sdt, hoTen);
    }

    private void deleteAdvice(HttpServletRequest request, HttpSession session) {
        int id = Integer.parseInt(request.getParameter("id"));
        ThongBaoDAO.deleteThongBaoByID(id);
    }

    private void markAdviceAsRead(HttpServletRequest request, HttpSession session) {
        int id = Integer.parseInt(request.getParameter("id"));
        ThongBaoDAO.updateStatus(id, "Đã đọc");
    }
}
