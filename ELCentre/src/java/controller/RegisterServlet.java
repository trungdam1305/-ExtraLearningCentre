package controller;

import dal.HocSinhDAO;
import dao.TaiKhoanDAO;
import model.TaiKhoan;
import model.HocSinh;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 * Servlet này xử lý đăng ký tài khoản từ form đăng ký người dùng.
 */
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không xử lý GET - chỉ xử lý POST từ form đăng ký
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập encoding UTF-8 cho cả request và response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");  // Gửi từ URL, chỉ đọc
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String phone = request.getParameter("phone");
        String roleStr = request.getParameter("vaitro");

        int roleId;
        try {
            roleId = Integer.parseInt(roleStr); // Ép kiểu vai trò từ String -> int
        } catch (NumberFormatException e) {
            redirectWithError("Vai trò không hợp lệ.", request, response);
            return;
        }

        // Không cho phép đăng ký tài khoản quản trị viên (ID = 1)
        if (roleId == 1) {
            redirectWithError("Bạn không thể đăng ký vai trò quản trị viên.", request, response);
            return;
        }

        // Kiểm tra dữ liệu đầu vào
        if (isEmpty(fullName)) {
            redirectWithError("Họ và tên không được để trống.", request, response); return;
        }
        if (isEmpty(email)) {
            redirectWithError("Email không được để trống.", request, response); return;
        }
        if (isEmpty(phone)) {
            redirectWithError("Số điện thoại không được để trống.", request, response); return;
        }
        if (isEmpty(password) || isEmpty(confirm)) {
            redirectWithError("Mật khẩu và xác nhận không được để trống.", request, response); return;
        }
        if (!password.equals(confirm)) {
            redirectWithError("Mật khẩu xác nhận không khớp.", request, response); return;
        }

        // Kiểm tra email đã tồn tại chưa
        TaiKhoanDAO dao = new TaiKhoanDAO();
        if (dao.checkEmailExists(email)) {
            redirectWithError("Email đã tồn tại trong hệ thống.", request, response); return;
        }

        // Tạo đối tượng tài khoản và gán thông tin
        TaiKhoan user = new TaiKhoan();
        user.setEmail(email);
        user.setMatKhau(password);
        user.setSoDienThoai(phone);
        user.setID_VaiTro(roleId);
        user.setTrangThai("Inactive"); // Chờ phê duyệt
        user.setNgayTao(LocalDateTime.now());
        user.setUserType(dao.getUserTypeByRoleId(roleId));

        // Đăng ký tài khoản vào hệ thống
        boolean success = dao.register(user);
        if (!success) {
            redirectWithError("Đăng ký thất bại. Vui lòng thử lại.", request, response);
            return;
        }

        // Lấy lại tài khoản vừa tạo để lấy ID
        TaiKhoan created = dao.getTaiKhoanByEmail(email);
        int idTaiKhoan = created.getID_TaiKhoan();

        // Nếu là học sinh (ID = 4) thì tạo bản ghi học sinh tương ứng
        if (roleId == 4) {
            HocSinh hs = new HocSinh();
            hs.setID_TaiKhoan(idTaiKhoan);
            hs.setHoTen(fullName);
            hs.setTrangThai("Inactive");
            hs.setNgayTao(LocalDateTime.now());

            // Các thông tin khác để null - sẽ cập nhật sau
            hs.setNgaySinh(null);
            hs.setGioiTinh(null);
            hs.setDiaChi(null);
            hs.setSDT_PhuHuynh(null);
            hs.setTenTruongHoc(null);
            hs.setGhiChu(null);

            try {
                new HocSinhDAO().insertHocSinh(hs);
            } catch (SQLException e) {
                e.printStackTrace();
                redirectWithError("Lỗi khi lưu thông tin học sinh.", request, response);
                return;
            }
        }

        // Gửi thông báo thành công và chuyển hướng về trang đăng nhập
        String msg = "Tài khoản đã được tạo, vui lòng chờ quản trị viên phê duyệt.";
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode(msg, "UTF-8"));
    }

    // Hàm tiện ích chuyển hướng về trang đăng ký với thông báo lỗi
    private void redirectWithError(String error, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
    }

    // Hàm kiểm tra chuỗi rỗng hoặc null
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng ký tài khoản người dùng mới";
    }
}