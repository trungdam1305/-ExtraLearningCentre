package controller;

import dal.HocSinhDAO;
import dal.KhoaHocDAO;
import dal.LopHocDAO;
import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.LopHoc;
import model.TaiKhoan;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

public class LoadClassToTransferServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (user == null || user.getID_VaiTro() != 4) {
            out.println("<div style='color:red;'>❌ Bạn chưa đăng nhập hoặc không có quyền truy cập.</div>");
            return;
        }

        String classCode = request.getParameter("classCode");
        if (classCode == null || classCode.trim().isEmpty()) {
            out.println("<div style='color:red;'>❌ Thiếu mã lớp.</div>");
            return;
        }

        // Lấy ID học sinh
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(user.getID_TaiKhoan());

        // Lấy ID khóa học từ classCode
        int khoaHocId = KhoaHocDAO.getKhoaHocIdByClassCode(classCode);

        // Lấy danh sách mã lớp mà học sinh đã đăng ký trong khóa
        List<String> classCodesDaDangKy = LopHocDAO.getClassCodesByStudentInCourse(idHocSinh, khoaHocId);

        // Lấy tất cả lớp trong khóa học
        List<LopHoc> dsLopCungKhoa = LopHocDAO.getAllClassesInSameCourse(khoaHocId);

        // Loại trừ các lớp đã đăng ký
        List<LopHoc> lopDeChuyen = dsLopCungKhoa.stream()
                .filter(lop -> !classCodesDaDangKy.contains(lop.getClassCode()))
                .collect(Collectors.toList());

        if (lopDeChuyen.isEmpty()) {
            out.println("<div style='color: #888;'>⚠️ Bạn đã đăng ký tất cả các lớp trong khóa này. Không còn lớp để chuyển.</div>");
            return;
        }

        // Form chọn lớp để chuyển
        out.println("<form action='SendTransferRequestServlet' method='post'>");
        out.println("<input type='hidden' name='currentClassCode' value='" + classCode + "'/>");
        out.println("<label><strong>Chọn lớp muốn chuyển đến:</strong></label><br>");
        out.println("<select name='newClassCode' required style='padding: 6px; margin: 10px 0;'>");
        for (LopHoc lop : lopDeChuyen) {
            out.println("<option value='" + lop.getClassCode() + "'>" +
                    lop.getTenLopHoc() + " (" + lop.getSiSo() + " học sinh)</option>");
        }
        out.println("</select><br>");
        out.println("<button type='submit' class='action-btn transfer'>Gửi yêu cầu chuyển lớp</button>");
        out.println("</form>");
    }

    //iểm tra dữ liệu
    public static void main(String[] args) {
        String email = "hocsinh4@example.com";
        String password = "hspass4";
        try {
            TaiKhoan user = TaiKhoanDAO.login(email, password);
            if (user == null) {
                System.out.println("❌ Đăng nhập thất bại: Sai email hoặc mật khẩu.");
                return;
            }
            if (!"Active".equalsIgnoreCase(user.getTrangThai())) {
                System.out.println("❌ Tài khoản chưa được kích hoạt.");
                return;
            }

            int idTaiKhoan = user.getID_TaiKhoan();
            int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);

            System.out.println("🧑 Tài khoản: " + user.getEmail());
            System.out.println("🎯 ID_TaiKhoan: " + idTaiKhoan + ", ID_HocSinh: " + idHocSinh);

            List<LopHoc> lopDangHoc = LopHocDAO.getLopHocDaDangKyByHocSinhId(idHocSinh);
            if (lopDangHoc.isEmpty()) {
                System.out.println("⚠️ Học sinh chưa đăng ký lớp nào.");
                return;
            }

            LopHoc lopHienTai = lopDangHoc.get(0);
            String classCode = lopHienTai.getClassCode();
            int khoaHocId = KhoaHocDAO.getKhoaHocIdByClassCode(classCode);

            System.out.println("📘 Lớp hiện tại: " + classCode + " | Khóa học ID: " + khoaHocId);

            List<String> classCodesDaDangKy = LopHocDAO.getClassCodesByStudentInCourse(idHocSinh, khoaHocId);
            List<LopHoc> dsLopCungKhoa = LopHocDAO.getAllClassesInSameCourse(khoaHocId);

            List<LopHoc> lopDeChuyen = dsLopCungKhoa.stream()
                    .filter(lop -> !classCodesDaDangKy.contains(lop.getClassCode()))
                    .collect(Collectors.toList());

            System.out.println("\n✅ Các lớp CÓ THỂ CHUYỂN đến:");
            if (lopDeChuyen.isEmpty()) {
                System.out.println("⚠️ Học sinh đã đăng ký tất cả lớp trong khóa.");
            } else {
                for (LopHoc lop : lopDeChuyen) {
                    System.out.println(" - " + lop.getClassCode() + " | " + lop.getTenLopHoc() + " | Sĩ số: " + lop.getSiSo());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
