package controller;

import dal.HocSinhDAO;
import dal.TruongHocDAO;
import dao.TaiKhoanDAO;
import model.TaiKhoan;
import model.HocSinh;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

public class RegisterServlet extends HttpServlet {

    private final TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();
    private final HocSinhDAO hocSinhDAO = new HocSinhDAO();
    private final TruongHocDAO truongHocDAO = new TruongHocDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String phone = request.getParameter("soDienThoai");
        String userType = request.getParameter("userType"); // HocSinh, GiaoVien, PhuHuynh

        if (isEmpty(fullName) || isEmpty(email) || isEmpty(phone) || isEmpty(userType)) {
            redirectWithError("Vui lòng nhập đầy đủ thông tin.", request, response);
            return;
        }

        if (taiKhoanDAO.checkEmailExists(email)) {
            redirectWithError("Email đã tồn tại trong hệ thống.", request, response);
            return;
        }

        int roleId = getRoleIdFromUserType(userType);
        if (roleId == -1) {
            redirectWithError("Vai trò không hợp lệ.", request, response);
            return;
        }

        // Sinh mật khẩu tự động cho học sinh
        String password = generatePassword(userType);

        TaiKhoan user = new TaiKhoan();
        user.setEmail(email);
        user.setMatKhau(password);
        user.setSoDienThoai(phone);
        user.setID_VaiTro(roleId);
        user.setTrangThai("Inactive");
        user.setNgayTao(LocalDateTime.now());
        user.setUserType(userType);

        boolean success = taiKhoanDAO.register(user);
        if (!success) {
            redirectWithError("Đăng ký thất bại. Vui lòng thử lại.", request, response);
            return;
        }

        TaiKhoan created = taiKhoanDAO.getTaiKhoanByEmail(email);
        int idTaiKhoan = created.getID_TaiKhoan();

        // Học sinh
        if (userType.equals("HocSinh")) {
            handleHocSinhRegistration(request, response, idTaiKhoan, fullName, phone);
        } else {
            redirectWithError("Hiện tại chỉ hỗ trợ đăng ký học sinh.", request, response);
        }
    }

    private void handleHocSinhRegistration(HttpServletRequest request, HttpServletResponse response,
                                           int idTaiKhoan, String fullName, String phone) throws IOException, ServletException {
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String tenTruongHoc = request.getParameter("tenTruongHoc");
        String lopDangHoc = request.getParameter("lopDangHoc");

        LocalDate ngaySinh = null;
        if (dob != null && !dob.isEmpty()) {
            try {
                ngaySinh = LocalDate.parse(dob);
            } catch (Exception e) {
                redirectWithError("Định dạng ngày sinh không hợp lệ.", request, response);
                return;
            }
        } else {
            redirectWithError("Vui lòng chọn ngày sinh.", request, response);
            return;
        }

        int tuoi = LocalDate.now().getYear() - ngaySinh.getYear();
        if (lopDangHoc != null && lopDangHoc.matches("^12.*") && tuoi < 17) {
            redirectWithError("Tuổi không hợp lệ với lớp 12.", request, response);
            return;
        }

        int idTruongHoc = truongHocDAO.getOrInsertTruongHoc(tenTruongHoc);

        String maHocSinh = generateMaHocSinh();
        while (hocSinhDAO.isMaHocSinhDuplicate(maHocSinh)) {
            maHocSinh = generateMaHocSinh();
        }

        HocSinh hs = new HocSinh();
        hs.setID_TaiKhoan(idTaiKhoan);
        hs.setMaHocSinh(maHocSinh);
        hs.setHoTen(fullName);
        hs.setNgaySinh(ngaySinh);
        hs.setGioiTinh(gender);
        hs.setDiaChi(address);
        hs.setID_TruongHoc(idTruongHoc);
        hs.setSDT_PhuHuynh(phone);
        hs.setTrangThai("Inactive");
        hs.setNgayTao(LocalDateTime.now());
        hs.setLopDangHocTrenTruong(lopDangHoc);
        hs.setTrangThaiHoc("Chờ học");
        hs.setAvatar(null);
        hs.setGhiChu(null);

        try {
            hocSinhDAO.insertHocSinh(hs);
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode("Tài khoản đã được tạo, vui lòng chờ phê duyệt.", "UTF-8"));
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError("Lỗi khi lưu thông tin học sinh.", request, response);
            return;
        }
    }

    private String generatePassword(String role) {
        int rand = new Random().nextInt(9999 - 1 + 1) + 1;
        return (role.equals("HocSinh") ? "hspass" : "user") + rand;
    }

    private int getRoleIdFromUserType(String userType) {
        return switch (userType) {
            case "HocSinh" -> 4;
            case "GiaoVien" -> 3;
            case "PhuHuynh" -> 5;
            default -> -1;
        };
    }

    private void redirectWithError(String error, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String generateMaHocSinh() {
        int rand = new Random().nextInt(9999 - 1 + 1) + 1;
        return "HS" + String.format("%04d", rand);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng ký tài khoản học sinh";
    }
}
