
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
import java.util.List;

public class StudentPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 4) {
            System.out.println("Chuyển hướng đến login.jsp vì user null hoặc không phải học sinh");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        System.out.println("ID_TaiKhoan: " + idTaiKhoan);
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh: " + idHocSinh);
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        System.out.println("HocSinh: " + hocSinh);
        List<HocPhi> dsHocPhi = HocPhiDAO.getHocPhiByHocSinhId(idHocSinh);
        System.out.println("Danh sách học phí (size): " + dsHocPhi.size());
        for (HocPhi hp : dsHocPhi) {
            System.out.println("HocPhi: ID_HocPhi=" + hp.getID_HocPhi() +
                ", MonHoc=" + hp.getMonHoc() +
                ", ID_LopHoc=" + hp.getID_LopHoc() +
                ", TongHocPhi=" + hp.getTongHocPhi() +
                ", SoTienDaDong=" + hp.getSoTienDaDong() +
                ", ConThieu=" + hp.getConThieu() +
                ", PhuongThucThanhToan=" + hp.getPhuongThucThanhToan() +
                ", TinhTrangThanhToan=" + hp.getTinhTrangThanhToan() +
                ", NgayThanhToan=" + hp.getNgayThanhToan() +
                ", NgayThanhToan Class=" + (hp.getNgayThanhToan() != null ? hp.getNgayThanhToan().getClass().getName() : "null") +
                ", GhiChu=" + hp.getGhiChu());
        }

        int tongHocPhi = 0;
        int tongDaDong = 0;
        int tongConThieu = 0;
        for (HocPhi hp : dsHocPhi) {
            tongHocPhi += hp.getTongHocPhi() != null ? hp.getTongHocPhi() : 0;
            tongDaDong += hp.getSoTienDaDong() != null ? hp.getSoTienDaDong() : 0;
            tongConThieu += hp.getConThieu() != null ? hp.getConThieu() : 0;
        }
        System.out.println("Tổng học phí: " + tongHocPhi + ", Đã đóng: " + tongDaDong + ", Còn thiếu: " + tongConThieu);

        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("dsHocPhi", dsHocPhi);
        request.setAttribute("tongHocPhi", tongHocPhi);
        request.setAttribute("tongDaDong", tongDaDong);
        request.setAttribute("tongConThieu", tongConThieu);

        request.getRequestDispatcher("/views/student/studentPayment.jsp").forward(request, response);
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


    // ✅ Hàm main test
    public static void main(String[] args) throws Exception {
        String email = "hocsinh17@example.com";
        String password = "hspass17";

        TaiKhoan user = TaiKhoanDAO.login(email, password);
        if (user == null) {
            System.out.println("❌ Đăng nhập thất bại.");
            return;
        }

        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(user.getID_TaiKhoan());
        List<HocPhi> dsHocPhi = HocPhiDAO.getHocPhiByHocSinhId(idHocSinh);


        System.out.println("\n📘 Chi tiết các khoản học phí:");
        for (HocPhi hp : dsHocPhi) {
            System.out.println("- Môn: " + hp.getMonHoc()
                + " | Tổng: " + hp.getTongHocPhi()
                + " | Đã đóng: " + hp.getSoTienDaDong()
                + " | Thiếu: " + hp.getConThieu()
                + " | Trạng thái: " + hp.getTinhTrangThanhToan());
        }
    }
}
