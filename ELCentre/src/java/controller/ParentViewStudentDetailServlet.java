package controller;

import dal.HocSinhDAO;
import dal.LopHocDAO;
import dal.PhuHuynhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.HocSinh;
import model.LopHoc;
import model.TaiKhoan;

import java.io.IOException;
import java.util.List;
import model.PhuHuynh;

public class ParentViewStudentDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // Kiểm tra đăng nhập và vai trò phụ huynh
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Lấy ID_HocSinh từ tham số
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("ParentDashboardServlet");
            return;
        }

        try {
            int idHocSinh = Integer.parseInt(idParam);
            int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
            // Lấy thông tin học sinh
            HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);


            // Lấy danh sách lớp học đã đăng ký
            List<LopHoc> danhSachLop = LopHocDAO.getLopHocByHocSinhId(idHocSinh);

            request.setAttribute("phuHuynh", phuHuynh);
            request.setAttribute("hocSinh", hocSinh);
            request.setAttribute("danhSachLop", danhSachLop);

            request.getRequestDispatcher("/views/parent/parentViewStudentDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ParentDashboardServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
