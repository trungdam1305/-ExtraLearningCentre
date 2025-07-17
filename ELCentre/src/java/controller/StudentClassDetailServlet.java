package controller;

import dal.LopHocDAO;
import dal.GiaoVienDAO;
import dal.TaiBaiTapDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;
import model.GiaoVien;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;
import model.TaoBaiTap;

public class StudentClassDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

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
        
        // Retrieve assignments for the class
        TaiBaiTapDAO assignmentDAO = new TaiBaiTapDAO();
        List<TaoBaiTap> assignments = assignmentDAO.getAssignmentsByClassId(lop.getID_LopHoc());
        
        // Gửi dữ liệu về JSP
        request.setAttribute("lopHoc", lop);
        request.setAttribute("giaoVien", gv);
        request.setAttribute("assignments", assignments); // Add assignments to request
        request.getRequestDispatcher("/views/student/studentClassDetail.jsp").forward(request, response);
    }
   

    @Override
    public String getServletInfo() {
        return "Hiển thị chi tiết lớp học và giáo viên cho học sinh";
    }
}
