package controller;

import dal.HocPhiDAO;
import dal.HocSinhDAO;
import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HocPhi;
import model.HocSinh;
import model.TaiKhoan;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien_ChiTietDay;

public class StudentPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        int idTaiKhoan = user.getID_TaiKhoan();

        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);

        ArrayList<GiaoVien_ChiTietDay> lophocs = HocPhiDAO.GetAllLopHocDangHocChiTietHocSinhToSendHocPhi(idHocSinh);

        if (lophocs == null) {
            request.setAttribute("message", "Không có biểu lớp nào để xem biểu học phí");
            request.getRequestDispatcher("/views/student/studentPayment.jsp").forward(request, response);
        } else {
            session.setAttribute("lophocs", lophocs);
            request.getRequestDispatcher("/views/student/studentPayment.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị thông tin học phí của học sinh";
    }

}