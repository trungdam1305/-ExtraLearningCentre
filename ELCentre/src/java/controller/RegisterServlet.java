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
 *
 * @author vkhan
 */

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // trống
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");  // Đã được truyền từ URL và readonly
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String phone = request.getParameter("phone");
        String roleStr = request.getParameter("vaitro");

        int roleId;
        try {
            roleId = Integer.parseInt(roleStr);
        } catch (NumberFormatException e) {
            redirectWithError("Vai trò không hợp lệ.", request, response);
            return;
        }

        // Không cho đăng ký vai trò quản trị
        if (roleId == 1) {
            redirectWithError("Bạn không thể đăng ký vai trò quản trị viên.", request, response);
            return;
        }

        // Validate input
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

        TaiKhoanDAO dao = new TaiKhoanDAO();

        if (dao.checkEmailExists(email)) {
            redirectWithError("Email đã tồn tại trong hệ thống.", request, response); return;
        }

        TaiKhoan user = new TaiKhoan();
        user.setEmail(email);
        user.setMatKhau(password);
        user.setSoDienThoai(phone);
        user.setID_VaiTro(roleId);
        user.setTrangThai("Inactive");
        user.setNgayTao(LocalDateTime.now());
        user.setUserType(dao.getUserTypeByRoleId(roleId));

        boolean success = dao.register(user);
        if (!success) {
            redirectWithError("Đăng ký thất bại. Vui lòng thử lại.", request, response);
            return;
        }

        // Lấy ID tài khoản mới tạo
        TaiKhoan created = dao.getTaiKhoanByEmail(email);
        int idTaiKhoan = created.getID_TaiKhoan();

        // Nếu là học sinh thì tạo bản ghi học sinh
        if (roleId == 4) {
            HocSinh hs = new HocSinh();
            hs.setID_TaiKhoan(idTaiKhoan);
            hs.setHoTen(fullName);
            hs.setTrangThai("Inactive");
            hs.setNgayTao(LocalDateTime.now());
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

        String msg = "Tài khoản đã được tạo, vui lòng chờ quản trị viên phê duyệt.";
        response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode(msg, "UTF-8"));
    }

    private void redirectWithError(String error, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    
    
    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Xử lý đăng ký tài khoản người dùng mới";
    }
}