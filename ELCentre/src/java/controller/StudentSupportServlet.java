/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.HoTroDAO;
import dal.HocSinhDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HoTro;
import model.TaiKhoan;

/**
 *
 * @author vkhan
 */
public class StudentSupportServlet extends HttpServlet {

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
            out.println("<title>Servlet StudentSupportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StudentSupportServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        ArrayList<HoTro> hotros = HoTroDAO.getHoTroByIdTaiKhoan(user.getID_TaiKhoan()) ; 
        if (hotros == null ) {
            request.setAttribute("message", "Không có yêu cầu hỗ trợ nào đã được gửi!");
            request.getRequestDispatcher("/views/student/studentReceiveHoTro.jsp").forward(request, response);
        } else {
            session.setAttribute("hotros",hotros );
            request.getRequestDispatcher("/views/student/studentReceiveHoTro.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        String ID_TaiKhoan = request.getParameter("idTaiKhoan") ; 
        String tenHoTro = request.getParameter("tenHoTro") ; 
        String moTa = request.getParameter("moTa") ; 
        String HoTen = HocSinhDAO.getNameHocSinhToSendSupport(ID_TaiKhoan) ; 
        boolean s1 = HoTroDAO.sendHoTroByIdTaiKhoan(HoTen, tenHoTro, moTa, ID_TaiKhoan) ; 
        if (s1) {
            ArrayList<HoTro> hotros = HoTroDAO.getHoTroByIdTaiKhoan(user.getID_TaiKhoan()) ; 
             session.setAttribute("hotros",hotros );
            request.getRequestDispatcher("/views/student/studentReceiveHoTro.jsp").forward(request, response);
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
