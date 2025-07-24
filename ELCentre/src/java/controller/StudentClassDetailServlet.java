package controller;

import dal.LopHocDAO;
import dal.GiaoVienDAO;
import dal.HocSinhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;
import model.GiaoVien;
import model.TaiKhoan;
import model.HocSinh;

import java.io.IOException;

public class StudentClassDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idHocSinh = -1;

        if (null == user.getID_VaiTro()) {
            // Không phải học sinh hoặc phụ huynh
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        // ✅ Nếu là phụ huynh: lấy từ URL
        else // ✅ Nếu là học sinh: lấy từ tài khoản
        switch (user.getID_VaiTro()) {
            case 4:
                idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(user.getID_TaiKhoan());
                break;
            case 5:
                String idHocSinhParam = request.getParameter("idHocSinh");
                if (idHocSinhParam != null) {
                    try {
                        idHocSinh = Integer.parseInt(idHocSinhParam);
                    } catch (NumberFormatException e) {
                        System.out.println("❌ Lỗi chuyển đổi ID_HocSinh từ URL");
                        response.sendRedirect("ParentDashboardServlet");
                        return;
                    }
                } else {
                    response.sendRedirect("ParentDashboardServlet");
                    return;
                }   break;
            default:
                // Không phải học sinh hoặc phụ huynh
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
        }

        if (idHocSinh == -1) {
            System.out.println("❌ Không tìm thấy ID_HocSinh");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);

        // Lấy classCode
        String classCode = request.getParameter("classCode");
        if (classCode == null || classCode.isEmpty()) {
            response.sendRedirect("ParentDashboardServlet");
            return;
        }

        LopHoc lop = LopHocDAO.getLopHocByClassCode(classCode);
        if (lop == null) {
            response.sendRedirect("ParentDashboardServlet");
            return;
        }

        GiaoVien gv = GiaoVienDAO.getGiaoVienById(lop.getID_GiaoVien());

        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("lopHoc", lop);
        request.setAttribute("giaoVien", gv);

        request.getRequestDispatcher("/views/student/studentClassDetail.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị chi tiết lớp học và giáo viên cho học sinh hoặc phụ huynh";
    }
}
