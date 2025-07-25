/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import api.EmailSender;
import dal.ThongBaoDAO;
import model.ThongBao;

/**
 *
 * @author vkhan
 */
public class SendAdviceMailServlet extends HttpServlet {

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
            out.println("<title>Servlet SendAdviceMailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendAdviceMailServlet at " + request.getContextPath () + "</h1>");
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
        try {
            String idRaw = request.getParameter("id");
            String subject = request.getParameter("subject");
            String content = request.getParameter("content");

            int id = Integer.parseInt(idRaw);
            ThongBao tb = ThongBaoDAO.getThongBaoById(id);
            if (tb == null) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thông báo.");
                response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
                return;
            }

            String email = extractEmail(tb.getNoiDung());
            if (email == null || email.isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy địa chỉ email trong nội dung.");
                response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
                return;
            }

            EmailSender.sendEmail(email, subject, content);

            request.getSession().setAttribute("successMessage", "Email đã được gửi thành công đến: " + email);
            response.sendRedirect(request.getContextPath() + "/adminGetFromDashboard?action=yeucautuvan");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Đã xảy ra lỗi khi gửi email.");
            response.sendRedirect(request.getContextPath() + "/views/admin/adminApproveRegisterUser.jsp");
        }
    }
    // Hàm tách mail từ nội dung thông báo
    //private String extractEmail(String noiDung) {
    //    String keyword = "Email:";
    //    int index = noiDung.indexOf(keyword);
    //    if (index != -1) {
    //        int start = index + keyword.length();
    //        int end = noiDung.indexOf(",", start);
    //        if (end == -1) end = noiDung.length();
    //        return noiDung.substring(start, end).trim();   
    //    }
    //    return null;
    //}
    
    private String extractEmail(String noiDung) {
        String regex = "(?i)email\\s*:?\\s*([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+)";
        java.util.regex.Matcher matcher = java.util.regex.Pattern.compile(regex).matcher(noiDung);
        if (matcher.find()) {
            return matcher.group(1);
        }
        return null;
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Xử lý việc gửi mail tư vấn";
    }// </editor-fold>

}
