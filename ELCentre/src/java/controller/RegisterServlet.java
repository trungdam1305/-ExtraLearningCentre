package controller;

import dao.TaiKhoanDAO;
import model.TaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDateTime;

/**
 *
 * @author vkhan
 */

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
       
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String confirm = request.getParameter("confirm");
            String roleStr = request.getParameter("vaitro");
            int roleId = 0;

            
            try {
                roleId = Integer.parseInt(roleStr);
            } catch (NumberFormatException e) {
                String errorMsg = "Vai trò không hợp lệ";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            // Không cho đăng ký tài khoản Admin
            if (roleId == 1) {
                String errorMsg = "Bạn không thể đăng ký vai trò Quản trị viên.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }
            
            //Kiểm tra mật khẩu 
            if (password.length() < 8) {
                String errorMsg = "Mật khẩu phải có ít nhất 8 ký tự.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            if (password.contains(" ")) {
                String errorMsg = "Mật khẩu không được chứa khoảng trắng.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            if (!password.matches(".*[a-z].*")) {
                String errorMsg = "Mật khẩu phải chứa ít nhất một chữ thường (a-z).";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            if (!password.matches(".*[A-Z].*")) {
                String errorMsg = "Mật khẩu phải chứa ít nhất một chữ hoa (A-Z).";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            if (!password.matches(".*[0-9].*")) {
                String errorMsg = "Mật khẩu phải chứa ít nhất một chữ số (0-9).";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            if (!password.matches(".*[!@#$%^&*()_+\\-={}\\[\\]:;\"'<>,.?/\\\\|].*")) {
                String errorMsg = "Mật khẩu phải chứa ít nhất một ký tự đặc biệt.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }
            
            // Kiểm tra nhập lại mật khẩu
            if (!password.equals(confirm)) {
                String errorMsg = "Mật khẩu xác nhận không khớp.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            TaiKhoanDAO dao = new TaiKhoanDAO();

            // Kiểm tra xem email đã tồn tại hay chưa
            if (dao.checkEmailExists(email)) {
                String errorMsg = "Email đã tồn tại trong hệ thống.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }


  
            String trangThai = "Inactive";
            // Tạo đối tượng tài khoản
            TaiKhoan user = new TaiKhoan();
            user.setEmail(email);
            user.setMatKhau(password);
            user.setSoDienThoai(phone);
            user.setID_VaiTro(roleId);
            user.setTrangThai(trangThai);
            user.setNgayTao(LocalDateTime.now());
            // Lấy userType theo Id_vaitro
            String userType = dao.getUserTypeByRoleId(roleId);
            user.setUserType(userType);
            
            // Gọi TaiKhoanDAO lên để lưu user
            boolean success = dao.register(user);
            
            if (success) {
                String msg = "Tài khoản đã được tạo, chờ quản trị viên phê duyệt.";
                response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode(msg, "UTF-8"));
            } else {
                String errorMsg = "Đăng ký thất bại. Vui lòng thử lại.";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
            }
        }
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