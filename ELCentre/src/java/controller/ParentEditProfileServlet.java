package controller;

import dal.PhuHuynhDAO;
import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import model.HocSinh;
import model.PhuHuynh;
import model.TaiKhoan;

import java.io.File;
import java.io.IOException;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 5 * 1024 * 1024,   // 5MB
                 maxRequestSize = 10 * 1024 * 1024) // 10MB
public class ParentEditProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        PhuHuynh ph = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
        List<HocSinh> dsCon = PhuHuynhDAO.getListCon(idPhuHuynh);

        
        request.setAttribute("phuHuynh", ph);
        request.setAttribute("dsCon", dsCon);
        request.getRequestDispatcher("/views/parent/parentEditProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getID_VaiTro() != 5) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int idTaiKhoan = user.getID_TaiKhoan();
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);

        String hoTen = request.getParameter("hoTen");
        String soDienThoai = request.getParameter("soDienThoai");
        String diaChi = request.getParameter("diaChi");
        String ghiChu = request.getParameter("ghiChu");

        // Lấy avatar cũ từ DB để giữ lại nếu không upload mới
        PhuHuynh currentPhuHuynh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
        String currentAvatar = currentPhuHuynh.getAvatar();

        // Xử lý avatar mới nếu có
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
        } else {
            avatarPath = currentAvatar; // ❗ Giữ lại avatar cũ nếu không upload mới
        }

        if (fileName != null && !fileName.isEmpty()) {
            String uploadsDir = getServletContext().getRealPath("/") + "uploads";
            File dir = new File(uploadsDir);
            if (!dir.exists()) dir.mkdirs();

            String filePath = uploadsDir + File.separator + fileName;
            filePart.write(filePath);
            avatarPath = "uploads/" + fileName;
        }

        // Gán thông tin mới vào model
        PhuHuynh ph = new PhuHuynh();
        ph.setID_PhuHuynh(idPhuHuynh);
        ph.setHoTen(hoTen);
        ph.setSDT(soDienThoai);
        ph.setDiaChi(diaChi);
        ph.setGhiChu(ghiChu);
        if (avatarPath != null) {
            ph.setAvatar(avatarPath);
        }

        boolean updateSuccess = PhuHuynhDAO.updatePhuHuynh(ph);
        if (updateSuccess) {
            response.sendRedirect("ParentEditProfileServlet?success=1");
        } else {
            response.sendRedirect("ParentEditProfileServlet?error=1");
        }
    }

    @Override
    public String getServletInfo() {
        return "Xử lý hiển thị và cập nhật hồ sơ phụ huynh";
    }
    
    public static void main(String[] args) {
    String email = "phuhuynh1@example.com";  // ✅ Email tài khoản phụ huynh
    String password = "phupass1";

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
        int idPhuHuynh = PhuHuynhDAO.getPhuHuynhIdByTaiKhoanId(idTaiKhoan);
        System.out.println("🔍 ID Phụ huynh: " + idPhuHuynh);

        // 📝 Tạo đối tượng PhuHuynh mới với dữ liệu cập nhật
        PhuHuynh ph = new PhuHuynh();
        ph.setID_PhuHuynh(idPhuHuynh);
        ph.setHoTen("Trần Thị Thu Hằng");
        ph.setSDT("0988123456");
        ph.setDiaChi("Tp. Hồ Chí Minh");
        ph.setGhiChu("Cập nhật từ servlet main test");
        ph.setAvatar("uploads/test-avatar.jpg");

        // 🟢 Cập nhật
        boolean updated = PhuHuynhDAO.updatePhuHuynh(ph);
        if (updated) {
            System.out.println("✅ Cập nhật thông tin phụ huynh thành công!");
        } else {
            System.out.println("❌ Cập nhật thất bại.");
        }

        // 🔍 Kiểm tra lại
        PhuHuynh updatedPh = PhuHuynhDAO.getPhuHuynhById(idPhuHuynh);
        System.out.println("------ THÔNG TIN SAU CẬP NHẬT ------");
        System.out.println("Họ tên     : " + updatedPh.getHoTen());
        System.out.println("SĐT        : " + updatedPh.getSDT());
        System.out.println("Địa chỉ    : " + updatedPh.getDiaChi());
        System.out.println("Ghi chú    : " + updatedPh.getGhiChu());
        System.out.println("Avatar     : " + updatedPh.getAvatar());
    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
