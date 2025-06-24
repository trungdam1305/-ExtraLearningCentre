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

/**
 * Servlet dùng để xử lý đăng nhập người dùng.
 */
public class LoginServlet extends HttpServlet {

    // Giao tiếp bằng phương thức GET -> chuyển hướng người dùng tới trang đăng nhập
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
    }

    // Xử lý đăng nhập bằng phương thức POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận dữ liệu tiếng Việt
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Bước 1: Xác thực reCAPTCHA từ Google
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean isValidCaptcha = VerifyRecaptcha.verify(gRecaptchaResponse);
        if (!isValidCaptcha) {
            String error = "Vui lòng xác nhận bạn không phải là robot.";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
            return;
        }

        // Bước 2: Kiểm tra input email/mật khẩu có bị bỏ trống không
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            String errorMsg = "Vui lòng nhập email và mật khẩu";
            response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
            return;
        }

        try {
            // Bước 3: Kiểm tra thông tin đăng nhập bằng DAO
            TaiKhoan user = TaiKhoanDAO.login(email, password);

            if (user != null) {
                // Nếu tài khoản chưa được kích hoạt
                if ("Inactive".equalsIgnoreCase(user.getTrangThai())) {
                    String errorMsg = "Tài khoản của bạn đang chờ phê duyệt.";
                    response.sendRedirect(request.getContextPath() + "/views/login.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
                    return;
                }

                // Lưu người dùng vào session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                System.out.println("Session created. User: " + session.getAttribute("user"));

                // Ghi lại log lịch sử đăng nhập
                UserLogs log = new UserLogs();
                log.setID_TaiKhoan(user.getID_TaiKhoan());
                log.setHanhDong("Đăng nhập hệ thống");
                log.setThoiGian(LocalDateTime.now());
                UserLogsDAO.insertLog(log);

                // Gửi email thông báo đăng nhập
                try {
                    String subject = "Thông báo đăng nhập thành công";
                    String body = "Xin chào " + user.getEmail() +
                                  ",\nBạn đã đăng nhập thành công vào hệ thống lúc " +
                                  LocalDateTime.now() + ".\n\nNếu không phải bạn, hãy đổi mật khẩu ngay.";
                    EmailSender.sendEmail(user.getEmail(), subject, body);
                } catch (MessagingException e) {
                    e.printStackTrace(); // Gửi mail lỗi không cản trở quá trình đăng nhập
                }

                // Điều hướng người dùng đến đúng giao diện dashboard theo vai trò
                if (user.getID_VaiTro() == 1) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/adminDashboard.jsp");
                } else if (user.getID_VaiTro() == 4) {
                    response.sendRedirect(request.getContextPath() + "/views/student/studentDashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login.jsp");
                }

            } else {
                // Sai thông tin đăng nhập hoặc tài khoản chưa được kích hoạt
                String errorMsg = "Thông tin đăng nhập không đúng hoặc tài khoản chưa được kích hoạt bởi admin.";
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