package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.TaiKhoanDAO;
import model.TaiKhoan;
import jakarta.servlet.http.*;
import java.net.URLDecoder;
import java.net.URLEncoder;

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
            TaiKhoan user = dao.findByEmail(email);

            if (user != null) {
                request.setAttribute("foundUser", user);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/views/forgotPassword.jsp").forward(request, response);
            } else {
                String error = "Không tìm thấy tài khoản với email này.";
                response.sendRedirect(request.getContextPath() + "/views/forgotPassword.jsp?error=" + URLEncoder.encode(error, "UTF-8"));
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
