package controller;

import dao.TaiKhoanDAO;
import dao.UserLogsDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.UserLogs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.net.URLEncoder;

/**
 *
 * @author vkhan
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            String errorMsg = "Vui lòng nhập email và mật khẩu";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
            return;
        }

        try {
            TaiKhoan user = TaiKhoanDAO.login(email, password);

            if (user != null) {
                // Kiểm tra trạng thái tài khoản
                if ("Inactive".equalsIgnoreCase(user.getTrangThai())) {
                    String errorMsg = "Tài khoản của bạn đang chờ phê duyệt.";
                    response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                    return;
                }
        
                // Lưu session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Ghi log đăng nhập
                UserLogs log = new UserLogs();
                log.setID_TaiKhoan(user.getID_TaiKhoan());
                log.setHanhDong("Đăng nhập hệ thống");
                log.setThoiGian(LocalDateTime.now());
                UserLogsDAO.insertLog(log);

                // Điều hướng đăng nhập
                if (user.getID_VaiTro() == 1) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/adminDashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/HomePage");
                }
            } else {
                String errorMsg = "Thông tin đăng nhập không đúng hoặc tài khoản đã bị khóa.";
                response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
            String errorMsg = "Đã xảy ra lỗi hệ thống.";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
        }
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập";
    }
}