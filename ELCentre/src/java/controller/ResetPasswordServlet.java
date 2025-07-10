package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.TaiKhoanDAO;
import model.TaiKhoan;

public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            request.setAttribute("message", "❌ Phiên đăng nhập không hợp lệ.");
            request.getRequestDispatcher("/views/student/studentDashboard.jsp").forward(request, response);
            return;
        }

        String current = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");

        if (current == null || newPass == null || confirm == null ||
            current.trim().isEmpty() || newPass.trim().isEmpty() || confirm.trim().isEmpty()) {
            request.setAttribute("message", "❌ Vui lòng nhập đầy đủ thông tin.");
        } else if (!newPass.equals(confirm)) {
            request.setAttribute("message", "❌ Mật khẩu xác nhận không khớp.");
        } else if (!TaiKhoanDAO.checkPassword(user.getEmail(), current)) {
            request.setAttribute("message", "❌ Mật khẩu hiện tại không đúng.");
        } else {
            boolean updated = TaiKhoanDAO.updatePassword(user.getID_TaiKhoan(), newPass);
            if (updated) {
                request.setAttribute("message", "✅ Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("message", "❌ Có lỗi xảy ra khi đổi mật khẩu.");
            }
        }

        // ✅ Quay lại dashboard, hiển thị thông báo trong modal
        request.getRequestDispatcher("/views/student/studentDashboard.jsp").forward(request, response);
    }
}
