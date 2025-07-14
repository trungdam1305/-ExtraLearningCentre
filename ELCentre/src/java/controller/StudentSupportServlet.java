package controller;

import dal.HoTroDAO;
import dal.HocSinhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HoTro;
import model.HocSinh;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;

public class StudentSupportServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);

        List<HoTro> danhSachHoTro = HoTroDAO.getHoTroByTaiKhoanId(idTaiKhoan);

        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("dsHoTro", danhSachHoTro);
        request.getRequestDispatcher("/views/student/studentSupport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh từ DB: " + idHocSinh);
        String tenHoTro = request.getParameter("tenHoTro");
        String moTa = request.getParameter("moTa");
        
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        if (tenHoTro != null && !tenHoTro.trim().isEmpty()) {
            HoTro hoTro = new HoTro();
            hoTro.setHoTen(hocSinh.getHoTen()); // hoặc lấy từ HocSinh nếu cần
            hoTro.setTenHoTro(tenHoTro);
            hoTro.setMoTa(moTa);
            hoTro.setID_TaiKhoan(idTaiKhoan);
            hoTro.setDaDuyet("Chờ duyệt");
            hoTro.setPhanHoi("");

            HoTroDAO.insertHoTro(hoTro);
        }
        request.setAttribute("hocSinhInfo", hocSinh);
        response.sendRedirect("StudentSupportServlet");
    }

    @Override
    public String getServletInfo() {
        return "Quản lý hỗ trợ của học sinh";
    }
}
