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
        String action =request.getParameter("action");
        
        if("register".equals(action)) {
            String fullName = request.getParameter("fullname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");

            // Kiểm tra mật khẩu khớp
            if (!password.equals(confirm)) {
                String errorMsg = "Mật khẩu không khớp";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            TaiKhoanDAO dao = new TaiKhoanDAO();

            // Kiểm tra xem email đã tồn tại hay chưa
            if (dao.checkEmailExists(email)) {
                String errorMsg = "Email đã tồn tại";
                response.sendRedirect(request.getContextPath() + "/views/register.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                return;
            }

            TaiKhoan user = new TaiKhoan();
            user.setEmail(email);
            user.setMatKhau(password); 
            user.setID_VaiTro(2);
            user.setTrangThai("HoatDong");
            user.setNgayTao(LocalDateTime.now());
            user.setUserType("Local");

            boolean success = dao.register(user);

            if (success) {
                String msg = "Đăng ký thành công, hãy đăng nhập";
                response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode(msg, "UTF-8"));
            } else {
                String errorMsg = "Đăng ký thất bại! Vui lòng thử lại";
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
    