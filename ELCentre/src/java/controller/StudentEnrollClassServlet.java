package controller;

import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.KhoaHoc;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;
import model.HocSinh;

public class StudentEnrollClassServlet extends HttpServlet {
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
        
        List<KhoaHoc> danhSachKhoaHoc = KhoaHocDAO.getAllKhoaHocDangMo();
        
        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("dsKhoaHoc", danhSachKhoaHoc);
        request.getRequestDispatcher("/views/student/studentEnrollClass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); 
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách khóa học để học sinh đăng ký";
    }
}
