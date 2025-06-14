package controller;

import dao.TaiKhoanDAO;
import dao.UserLogsDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.TaiKhoan;
import model.UserLogs;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.net.URLEncoder;

import api.VerifyRecaptcha;
import api.EmailSender; 
import jakarta.mail.MessagingException; 

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

        // Xác thực Captcha
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean isValidCaptcha = VerifyRecaptcha.verify(gRecaptchaResponse);

        if (!isValidCaptcha) {
            String error = "Vui lòng xác nhận bạn không phải là robot.";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
            return;
        }

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            String errorMsg = "Vui lòng nhập email và mật khẩu";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
            return;
        }

        try {
            TaiKhoan user = TaiKhoanDAO.login(email, password);

            if (user != null) {
                if ("Inactive".equalsIgnoreCase(user.getTrangThai())) {
                    String errorMsg = "Tài khoản của bạn đang chờ phê duyệt.";
                    response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                    return;
                }
                UserLogs log = new UserLogs();
                log.setID_TaiKhoan(user.getID_TaiKhoan());
                log.setHanhDong("Đăng nhập hệ thống");
                log.setThoiGian(LocalDateTime.now());
                UserLogsDAO.insertLog(log);

                // ✅ Gửi email thông báo đăng nhập
                try {
                    String subject = "Thông báo đăng nhập thành công";
                    String body = "Xin chào " + user.getEmail() +
                                  ",\nBạn đã đăng nhập thành công vào hệ thống lúc " +
                                  LocalDateTime.now() + ".\n\nNếu không phải bạn, hãy đổi mật khẩu ngay.";
                    EmailSender.sendEmail(user.getEmail(), subject, body);
                } catch (MessagingException e) {
                    e.printStackTrace(); // Không cản trở login nếu gửi mail lỗi
                }

                // Điều hướng sau khi login
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

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng nhập";
    }
}
