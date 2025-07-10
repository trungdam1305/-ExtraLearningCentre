package controller;

import dal.HocSinhDAO;
import dal.TruongHocDAO;
import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import model.HocSinh;
import model.TaiKhoan;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import model.TruongHoc;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 5 * 1024 * 1024,   // 5MB
                 maxRequestSize = 10 * 1024 * 1024) // 10MB
public class StudentEditProfileServlet extends HttpServlet {

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
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        HocSinh hocSinh = HocSinhDAO.getHocSinhById(idHocSinh);
        List<TruongHoc> dsTruongHoc = TruongHocDAO.getAllSchools();
        request.setAttribute("dsTruongHoc", dsTruongHoc);
        request.setAttribute("hocSinh", hocSinh);
        request.getRequestDispatcher("/views/student/studentEditProfile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        if (user == null || user.getID_VaiTro() != 4) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        int idTruongHoc = Integer.parseInt(request.getParameter("idTruongHoc"));

        // Nhận dữ liệu
        String hoTen = request.getParameter("hoTen");
        String ngaySinhStr = request.getParameter("ngaySinh");
        String gioiTinh = request.getParameter("gioiTinh");
        String diaChi = request.getParameter("diaChi");
        String lopDangHoc = request.getParameter("lopDangHoc");
        String sdtPhuHuynh = request.getParameter("sdtPhuHuynh");
        String ghiChu = request.getParameter("ghiChu");

        // Ảnh đại diện
        Part filePart = request.getPart("profileImage");
        String fileName = filePart.getSubmittedFileName();
        String avatarPath = null;
        if (fileName != null && !fileName.isEmpty()) {
            String uploadsDir = getServletContext().getRealPath("/") + "uploads";
            File dir = new File(uploadsDir);
            if (!dir.exists()) dir.mkdirs();
            String filePath = uploadsDir + File.separator + fileName;
            filePart.write(filePath);
            avatarPath = "uploads/" + fileName;
        }

        // Parse ngày sinh
        LocalDate ngaySinh = null;
        try {
            ngaySinh = LocalDate.parse(ngaySinhStr);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Gán vào model
        HocSinh hs = new HocSinh();
        hs.setID_HocSinh(idHocSinh);
        hs.setID_TruongHoc(idTruongHoc); // ✅ QUAN TRỌNG
        hs.setHoTen(hoTen);
        hs.setNgaySinh(ngaySinh);
        hs.setGioiTinh(gioiTinh);
        hs.setDiaChi(diaChi);
        hs.setLopDangHocTrenTruong(lopDangHoc);
        hs.setSDT_PhuHuynh(sdtPhuHuynh);
        hs.setGhiChu(ghiChu);
        if (avatarPath != null) {
            hs.setAvatar(avatarPath);
        }

        // Cập nhật
        boolean updateSuccess = HocSinhDAO.updateHocSinh(hs);
        if (updateSuccess) {
            response.sendRedirect("StudentEditProfileServlet?success=1");
        } else {
            response.sendRedirect("StudentEditProfileServlet?error=1");
        }
    }

    @Override
    public String getServletInfo() {
        return "Xử lý hiển thị và cập nhật hồ sơ học sinh";
    }
    
    
    public static void main(String[] args) {
        String email = "hocsinh4@example.com"; // chỉnh sửa email học sinh muốn test
        String password = "hspass4";

        try {
            TaiKhoan user = TaiKhoanDAO.login(email, password);
            if (user == null) {
                System.out.println("❌ Đăng nhập thất bại: Sai email hoặc mật khẩu.");
                return;
            }
            if ("Inactive".equalsIgnoreCase(user.getTrangThai())) {
                System.out.println("❌ Tài khoản chưa được kích hoạt.");
                return;
            }

            int idTaiKhoan = user.getID_TaiKhoan();
            int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);

            // 🔽 Tạo đối tượng HocSinh mới với thông tin muốn cập nhật
            HocSinh hs = new HocSinh();
            hs.setID_HocSinh(idHocSinh);
            hs.setID_TruongHoc(2); // ⚠️ ID_TruongHoc phải tồn tại trong bảng TruongHoc
            hs.setHoTen("Phạm Thị Hồng Ngọc");
            hs.setNgaySinh(LocalDate.of(2007, 9, 20));
            hs.setGioiTinh("Nữ");
            hs.setDiaChi("Hà Nội");
            hs.setLopDangHocTrenTruong("11A5");
            hs.setSDT_PhuHuynh("0900111122");
            hs.setGhiChu("Cập nhật sau");
            hs.setAvatar("uploads/avatar_test.jpg");

            // 🟢 Gọi DAO để cập nhật
            boolean success = HocSinhDAO.updateHocSinh(hs);
            if (success) {
                System.out.println("✅ Cập nhật học sinh thành công!");
            } else {
                System.out.println("❌ Cập nhật học sinh thất bại!");
            }

            // 🔍 Kiểm tra lại
            HocSinh updated = HocSinhDAO.getHocSinhById(idHocSinh);
            System.out.println("----- THÔNG TIN SAU CẬP NHẬT -----");
            System.out.println("Họ tên:       " + updated.getHoTen());
            System.out.println("Ngày sinh:    " + updated.getNgaySinh());
            System.out.println("Giới tính:    " + updated.getGioiTinh());
            System.out.println("Địa chỉ:      " + updated.getDiaChi());
            System.out.println("Trường học ID:" + updated.getID_TruongHoc());
            System.out.println("Lớp:          " + updated.getLopDangHocTrenTruong());
            System.out.println("SĐT PH:       " + updated.getSDT_PhuHuynh());
            System.out.println("Ghi chú:      " + updated.getGhiChu());
            System.out.println("Avatar:       " + updated.getAvatar());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    
}
