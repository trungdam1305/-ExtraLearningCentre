package controller;

import dal.LopHocDAO;
import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;
import model.GiaoVien;
import model.TaiKhoan;

import java.io.IOException;
import model.HocSinh;

public class StudentClassDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
                int idTaiKhoan = user.getID_TaiKhoan();
        System.out.println("ID_TaiKhoan từ session: " + idTaiKhoan);

        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh từ DB: " + idHocSinh);
        
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        // Kiểm tra đăng nhập và vai trò học sinh
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Lấy mã lớp học từ URL (classCode)
        String classCode = request.getParameter("classCode");
        System.out.println("🔍 ClassCode từ request: " + classCode);
        if (classCode == null || classCode.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet");
            return;
        }

        // Lấy thông tin lớp học theo classCode
        LopHoc lop = LopHocDAO.getLopHocByClassCode(classCode);
        if (lop == null) {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet");
            return;
        }

        // Lấy thông tin giáo viên theo ID_GiaoVien
        GiaoVien gv = GiaoVienDAO.getGiaoVienById(lop.getID_GiaoVien());
        if (gv == null) {
            response.sendRedirect(request.getContextPath() + "/StudentViewClassServlet");
            return;
        }

        // Gửi dữ liệu về JSP
        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("lopHoc", lop);
        request.setAttribute("giaoVien", gv);
        request.getRequestDispatcher("/views/student/studentClassDetail.jsp").forward(request, response);
    }
   

    @Override
    public String getServletInfo() {
        return "Hiển thị chi tiết lớp học và giáo viên cho học sinh";
    }
}
