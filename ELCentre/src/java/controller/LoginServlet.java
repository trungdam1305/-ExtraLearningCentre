package controller;

import dao.TaiKhoanDAO;
import dao.UserLogsDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.TaiKhoan;
import model.UserLogs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author vkhan
 */
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
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
        //processRequest(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=Vui lòng nhập email và mật khẩu");
            return;
        }
        
        try {
            TaiKhoan user = TaiKhoanDAO.login(email, password);

            if (user != null) {
                // Lưu session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Ghi log đăng nhập
                UserLogs log = new UserLogs();
                log.setID_TaiKhoan(user.getID_TaiKhoan());
                log.setHanhDong("Đăng nhập hệ thống");
                log.setThoiGian(LocalDateTime.now());
                UserLogsDAO.insertLog(log);

                // Chuyển đến trang chính
                response.sendRedirect("HomePage.jsp");
            } else {
                response.sendRedirect("login.jsp?error=Thông tin đăng nhập không đúng hoặc tài khoản đã bị khóa.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Đã xảy ra lỗi hệ thống.");
        }
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
