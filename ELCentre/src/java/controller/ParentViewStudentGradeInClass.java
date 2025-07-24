package controller;

import dal.DiemDAO;
import dal.HocSinhDAO;
import dal.LopHocDAO;
import dal.PhuHuynhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Diem;
import model.HocSinh;
import model.LopHoc;
import model.TaiKhoan;
import java.time.ZoneId;
import java.util.Date;

import java.io.IOException;
import model.PhuHuynh;

public class ParentViewStudentGradeInClass extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TaiKhoan user = (TaiKhoan) request.getSession().getAttribute("user");
        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        String idHocSinhStr = request.getParameter("idHocSinh");
        String classCode = request.getParameter("classCode");

        if (idHocSinhStr == null || classCode == null) {
            response.sendRedirect("ParentDashboardServlet");
            return;
        }
                int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        PhuHuynh phuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);

        try {
            int idHocSinh = Integer.parseInt(idHocSinhStr);
            HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
            LopHoc lopHoc = LopHocDAO.getLopHocByClassCode(classCode);
            Diem diem = DiemDAO.getDiemByHocSinhAndLop(idHocSinh, lopHoc.getID_LopHoc());

            request.setAttribute("phuHuynh", phuHuynh);
            request.setAttribute("hocSinh", hocSinh);
            request.setAttribute("lopHoc", lopHoc);
Date thoiGianCapNhatDate = null;
if (diem.getThoiGianCapNhat() != null) {
    thoiGianCapNhatDate = Date.from(diem.getThoiGianCapNhat().atZone(ZoneId.systemDefault()).toInstant());
}
request.setAttribute("diem", diem);
request.setAttribute("thoiGianCapNhat", thoiGianCapNhatDate);

            request.getRequestDispatcher("/views/parent/parentViewStudentGradeInClass.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ParentDashboardServlet");
        }
    }
    
    public static void main(String[] args) {
    int idHocSinh = 1; // ✅ thay bằng ID thật trong DB nếu cần
    String classCode = "TOAN06A"; // ✅ thay bằng classCode thật trong DB nếu cần

    // Lấy thông tin học sinh
    HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
    System.out.println("👶 Học sinh: " + (hocSinh != null ? hocSinh.getHoTen() : "Không tìm thấy"));

    // Lấy thông tin lớp học theo classCode
    LopHoc lopHoc = LopHocDAO.getLopHocByClassCode(classCode);
    if (lopHoc != null) {
        System.out.println("🏫 Lớp học: " + lopHoc.getTenLopHoc() + " (ClassCode: " + lopHoc.getClassCode() + ")");
    } else {
        System.out.println("❌ Không tìm thấy lớp học với mã: " + classCode);
    }

    // Lấy điểm theo học sinh và lớp
    if (lopHoc != null) {
        Diem diem = DiemDAO.getDiemByHocSinhAndLop(idHocSinh, lopHoc.getID_LopHoc());
        if (diem != null) {
            System.out.println("\n📊 Điểm:");
            System.out.println("- Kiểm tra: " + diem.getDiemKiemTra());
            System.out.println("- Bài tập: " + diem.getDiemBaiTap());
            System.out.println("- Giữa kỳ: " + diem.getDiemGiuaKy());
            System.out.println("- Cuối kỳ: " + diem.getDiemCuoiKy());
            System.out.println("- Tổng kết: " + diem.getDiemTongKet());
            System.out.println("- Cập nhật lúc: " + diem.getThoiGianCapNhat());
        } else {
            System.out.println("❌ Chưa có điểm cho học sinh này trong lớp học này.");
        }
    }
}

}
