package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.TaiKhoanDAO;
import dao.UserLogsDAO;
import model.TaiKhoan;
import jakarta.servlet.http.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import model.UserLogs;


/**
 *
 * @author vkhan
 */
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPasswordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        TaiKhoanDAO dao = new TaiKhoanDAO();

        if ("search".equals(action)) {
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            
            TaiKhoan user = dao.findByEmailAndPhone(email, phone);

            if (user != null && user.getSoDienThoai() != null && user.getSoDienThoai().equals(phone)) {
                request.setAttribute("foundUser", user);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
            } else {
                String error = "Email hoặc số điện thoại không chính xác.";
                response.sendRedirect(request.getContextPath() + "/views/forgotPassword.jsp?error=" + URLEncoder.encode(error, "UTF-8") 
                    + "&email=" + URLEncoder.encode(email, "UTF-8") 
                    + "&phone=" + URLEncoder.encode(phone, "UTF-8"));
            }

        } else if ("reset".equals(action)) {
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPassword)) {
                String error = "Mật khẩu xác nhận không khớp.";
                response.sendRedirect(request.getContextPath() + "/views/forgotPassword.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
                return;
            }

            boolean success = dao.updatePassword(email, newPassword);
            if (success) {
                String successMsg = "Mật khẩu đã được cập nhật. Hãy đăng nhập lại.";
                UserLogs log = new UserLogs();
                log.setID_TaiKhoan(dal.TaiKhoanDAO.adminGetIDTaiKhoanByEmail(email));
                log.setHanhDong("Reset mật khẩu tài khoản có ID tài khoản " + dal.TaiKhoanDAO.adminGetIDTaiKhoanByEmail(email));
                log.setThoiGian(LocalDateTime.now());
                UserLogsDAO.insertLog(log);
                response.sendRedirect(request.getContextPath() + "/views/login.jsp?success=" + URLEncoder.encode(successMsg, "UTF-8"));
            } else {
                String error = "Cập nhật mật khẩu thất bại. Vui lòng thử lại.";
                response.sendRedirect(request.getContextPath() + "/views/forgotPassword.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Xử lý chức năng quên mật khẩu";
    }
}
