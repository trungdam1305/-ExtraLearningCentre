package controller;

import api.EmailSender;
import dal.ThongBaoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author vkhan
 */
public class AdviceServlet extends HttpServlet {

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
            out.println("<title>Servlet AdviceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdviceServlet at " + request.getContextPath () + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        // Lấy dữ liệu từ Form
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String soDienThoai = request.getParameter("soDienThoai");
        String noiDung = request.getParameter("noiDung");
        
        // Gộp nội dung tư vấn lại
        String fullContent = "[TƯ VẤN] Họ tên: " + hoTen + ", Email: " + email + ", SĐT: " + soDienThoai + ", Nội dung: " + noiDung;
        
        try {
            // Ghi vào bảng ThongBao
            ThongBaoDAO.insertThongBaoTuVan(fullContent);
            
            // Gửi email xác nhận
            EmailSender.send(email, 
                    "Xác nhận đăng ký tư vấn", 
                    "Cảm ơn bạn đã đăng ký tư vấn tại ELCentre.\n\nChúng tôi sẽ sớm liên hệ lại với bạn." 
                    );
            
            // Chuyển hướng tới trang cảm ơn
            response.sendRedirect("advice-success.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
        
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Xử lý yêu cầu đăng kí tư vấn";
    }
}
