package controller;

import dal.ThongBaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.ThongBao;

import java.io.IOException;
import java.time.LocalDateTime;

public class SendTransferRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra đăng nhập và quyền
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        String currentClassCode = request.getParameter("currentClassCode");
        String newClassCode = request.getParameter("newClassCode");

        if (currentClassCode == null || newClassCode == null
                || currentClassCode.trim().isEmpty() || newClassCode.trim().isEmpty()) {
            session.setAttribute("message", "❌ Thiếu thông tin chuyển lớp.");
            response.sendRedirect("StudentViewClassServlet");
            return;
        }

        // Tạo thông báo yêu cầu chuyển lớp
        String noiDung = "📤 Học sinh yêu cầu chuyển từ lớp " + currentClassCode + " sang lớp " + newClassCode + ".";
        ThongBao tb = new ThongBao();
        tb.setID_TaiKhoan(user.getID_TaiKhoan());
        tb.setNoiDung(noiDung);
        tb.setThoiGian(LocalDateTime.now());

        boolean success = ThongBaoDAO.insertRequestChangeClass(tb);

        if (success) {
            session.setAttribute("message", "✅ Yêu cầu chuyển lớp của bạn đang được xem xét. Vui lòng kiểm tra thông báo.");
        } else {
            session.setAttribute("message", "❌ Gửi yêu cầu thất bại. Vui lòng thử lại.");
        }

        response.sendRedirect("StudentViewClassServlet");
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý yêu cầu chuyển lớp của học sinh";
    }
}
