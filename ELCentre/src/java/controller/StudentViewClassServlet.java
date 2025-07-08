package controller;

import dal.HocSinhDAO;
import dal.HocSinh_LopHocDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;

public class StudentViewClassServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra quyền truy cập
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);

        List<LopHoc> dsLopHoc = HocSinh_LopHocDAO.getLopHocDaDangKyByHocSinhId(idHocSinh);

        request.setAttribute("dsLopHoc", dsLopHoc);
        request.getRequestDispatcher("/views/student/studentViewClass.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách lớp học mà học sinh đã đăng ký";
    }
}
