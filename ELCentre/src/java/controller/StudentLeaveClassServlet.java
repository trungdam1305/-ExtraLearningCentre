package controller;

import dal.HocSinhDAO;
import dal.ThongBaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.ThongBao;

import java.io.IOException;
import java.time.LocalDateTime;

public class StudentLeaveClassServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        String classCode = request.getParameter("classCode");
        if (classCode == null || classCode.trim().isEmpty()) {
            session.setAttribute("message", "❌ Thiếu mã lớp cần rời.");
            response.sendRedirect("StudentViewClassServlet");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);

        // Tạo nội dung thông báo
        String noiDung = "📤 Học sinh yêu cầu rời khỏi lớp " + classCode + ".";

        ThongBao thongBao = new ThongBao();
        thongBao.setID_TaiKhoan(idTaiKhoan);
        thongBao.setNoiDung(noiDung);
        thongBao.setThoiGian(LocalDateTime.now());

        boolean success = ThongBaoDAO.insertRequestLeaveClass(thongBao);

        if (success) {
            session.setAttribute("message", "✅ Yêu cầu rời lớp của bạn đang được xem xét. Vui lòng kiểm tra thông báo.");
        } else {
            session.setAttribute("message", "❌ Gửi yêu cầu thất bại. Vui lòng thử lại.");
        }

        response.sendRedirect("StudentViewClassServlet");
    }

    @Override
    public String getServletInfo() {
        return "Xử lý học sinh gửi yêu cầu rời lớp";
    }
}
