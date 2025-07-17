package controller;

import dal.HocSinhDAO;
import dal.LopHocDAO;
import static dal.LopHocDAO.getLopHocByKhoaHocId;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;

import java.io.IOException;
import java.util.List;
import model.HocSinh;
import model.TaiKhoan;

public class StudentViewLopTrongKhoaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idKhoaStr = request.getParameter("idKhoaHoc");
        if (idKhoaStr == null || idKhoaStr.isEmpty()) {
            response.sendRedirect("StudentEnrollClassServlet");
            return;
        }
                TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        int idTaiKhoan = user.getID_TaiKhoan();
        System.out.println("ID_TaiKhoan từ session: " + idTaiKhoan);

        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh từ DB: " + idHocSinh);
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        try {
            int idKhoa = Integer.parseInt(idKhoaStr);
            List<LopHoc> dsLop = LopHocDAO.getLopHocByKhoaHocId(idKhoa);
            request.setAttribute("hocSinhInfo", hocSinh);
            request.setAttribute("idKhoaHoc", idKhoa);
            request.setAttribute("dsLop", dsLop);
            request.getRequestDispatcher("/views/student/studentViewLopTrongKhoa.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("StudentEnrollClassServlet?error=invalid_khoahoc_id");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách lớp học trong một khóa học cụ thể";
    }
    
//        public static void main(String[] args) {
//        int idKhoaHoc = 1; // thay bằng ID_KhoaHoc bạn muốn test
//        List<LopHoc> list = getLopHocByKhoaHocId(idKhoaHoc);
//
//        System.out.println("===== DANH SÁCH LỚP THUỘC KHÓA HỌC ID = " + idKhoaHoc + " =====");
//        if (list.isEmpty()) {
//            System.out.println("⚠️ Không có lớp học nào thuộc khóa học này.");
//            return;
//        }
//
//        int i = 1;
//        for (LopHoc lop : list) {
//            System.out.println("------ Lớp " + (i++) + " ------");
//            System.out.println("ID lớp học     : " + lop.getID_LopHoc());
//            System.out.println("ClassCode      : " + lop.getClassCode());
//            System.out.println("Tên lớp        : " + lop.getTenLopHoc());
//            System.out.println("Tên khóa học   : " + lop.getTenKhoaHoc());
//            System.out.println("Sĩ số hiện tại : " + lop.getSiSo());
//            System.out.println("Sĩ số tối thiểu: " + lop.getSiSoToiThieu());
//            System.out.println("Sĩ số tối đa   : " + lop.getSiSoToiDa());
//            System.out.println("Ngày tạo       : " + lop.getNgayTao());
//            System.out.println("Ghi chú        : " + lop.getGhiChu());
//            System.out.println();
//        }
//    }

}
