package controller;

import dal.LopHocDAO;
import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import dal.PhuHuynhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HocSinh;
import model.LopHoc;
import model.GiaoVien;
import model.TaiKhoan;

import java.io.IOException;
import model.PhuHuynh;

public class ParentViewClassDetailServlet extends HttpServlet {

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

        // ✅ Lấy id học sinh từ URL
        String idHocSinhParam = request.getParameter("idHocSinh");
        String classCode = request.getParameter("classCode");

        if (idHocSinhParam == null || classCode == null) {
            response.sendRedirect(request.getContextPath() + "/ParentDashboardServlet");
            return;
        }

        try {
            int idHocSinh = Integer.parseInt(idHocSinhParam);
            int idTaiKhoan = user.getID_TaiKhoan();
            int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
            PhuHuynh ph = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
            HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
            LopHoc lop = LopHocDAO.getLopHocByClassCode(classCode);
            GiaoVien giaoVien = GiaoVienDAO.getGiaoVienById(lop.getID_GiaoVien());

            // ✅ Đẩy dữ liệu sang JSP
            request.setAttribute("phuHuynh", ph);
            request.setAttribute("hocSinhInfo", hocSinh);
            request.setAttribute("lopHoc", lop);
            request.setAttribute("giaoVien", giaoVien);

            request.getRequestDispatcher("/views/parent/parentViewClassDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ParentDashboardServlet");
        }
    }
}
