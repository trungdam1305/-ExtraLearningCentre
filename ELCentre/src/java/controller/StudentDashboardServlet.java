package controller;

import dal.HocSinhDAO;
import dal.HocSinh_LopHocDAO;
import dal.LichHocDAO;

import dal.ThongBaoDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import dao.TaiKhoanDAO;

public class StudentDashboardServlet extends HttpServlet {

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
        System.out.println("ID_TaiKhoan từ session: " + idTaiKhoan);

        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("ID_HocSinh từ DB: " + idHocSinh);
        
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        
        List<LopHoc> dsLopHoc = HocSinh_LopHocDAO.getLopHocDaDangKyByHocSinhId(idHocSinh);

        List<ThongBao> dsThongBao = new ArrayList<>();
        try {
            dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoan);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<LichHoc> lichHocSapToi = LichHocDAO.getUpcomingScheduleByHocSinhId(idHocSinh);
        System.out.println("Số lượng lịch học sắp tới: " + lichHocSapToi.size());
        for (LichHoc lh : lichHocSapToi) {
            System.out.println("→ " + lh.getNgayHoc() + " | " + lh.getTenLopHoc() + " | " + lh.getSlotThoiGian());
        }
        
        request.setAttribute("hocSinhInfo", hocSinh);
        request.setAttribute("dsLopHoc", dsLopHoc);
        request.setAttribute("dsThongBao", dsThongBao);
        request.setAttribute("lichHocSapToi", lichHocSapToi);
        request.getRequestDispatcher("/views/student/studentDashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị dashboard học sinh";
    }
    
//    public static void main(String[] args) {
//        String email = "hocsinh4@example.com"; // thay đổi tại đây
//
//        String password = "hspass4";             // thay đổi tại đây
//
//        try {
//            TaiKhoan user = TaiKhoanDAO.login(email, password);
//
//            if (user == null) {
//                System.out.println("❌ Đăng nhập thất bại: Sai email hoặc mật khẩu.");
//                return;
//            }
//
//            if ("Inactive".equalsIgnoreCase(user.getTrangThai())) {
//                System.out.println("❌ Tài khoản chưa được kích hoạt.");
//                return;
//            }
//
//            int idTaiKhoan = user.getID_TaiKhoan();
//            int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
//
//            System.out.println("===== ĐĂNG NHẬP THÀNH CÔNG =====");
//            System.out.println("Tài khoản: " + user.getEmail());
//            System.out.println("ID_TaiKhoan: " + idTaiKhoan);
//            System.out.println("ID_HocSinh : " + idHocSinh);
//
//            System.out.println("\n→ THÔNG BÁO:");
//            List<ThongBao> dsThongBao = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoan);
//            System.out.println("Số lượng: " + dsThongBao.size());
//            for (ThongBao tb : dsThongBao) {
//                System.out.println(" - " + tb.getNoiDung() + " | " + tb.getThoiGian());
//            }
//
//            System.out.println("\n→ LỚP HỌC ĐÃ ĐĂNG KÝ:");
//            List<LopHoc> dsLopHoc = HocSinh_LopHocDAO.getLopHocDaDangKyByHocSinhId(idHocSinh);
//            System.out.println("Số lượng: " + dsLopHoc.size());
//            for (LopHoc lop : dsLopHoc) {
//                System.out.println(" - " + lop.getTenLopHoc() + " | Khóa: " + lop.getTenKhoaHoc());
//            }
//
//            System.out.println("\n→ LỊCH HỌC SẮP TỚI:");
//            List<LichHoc> lichHocSapToi = LichHocDAO.getUpcomingScheduleByHocSinhId(idHocSinh);
//            System.out.println("Số lượng: " + lichHocSapToi.size());
//            for (LichHoc lh : lichHocSapToi) {
//                System.out.println(" - " + lh.getNgayHoc() + " | Lớp: " + lh.getTenLopHoc() + " | Slot: " + lh.getSlotThoiGian());
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

}
