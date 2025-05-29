/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.GiaoVienDAO;
import dal.LopHocDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.GiaoVien;
import model.LopHoc;

/**
 *
 * @author admin
 */
public class HomePage extends HttpServlet {
   
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
            out.println("<title>Servlet HomePage</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomePage at " + request.getContextPath () + "</h1>");
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
        HttpSession session = request.getSession();
        List<GiaoVien> danhSachGV = GiaoVienDAO.HomePageGetGiaoVien();
        session.setAttribute("danhSachGV", danhSachGV);
        LopHocDAO lopHocDAO = new LopHocDAO();
        List<LopHoc> danhSachLopHoc = lopHocDAO.getAllLopHoc();
        request.setAttribute("danhSachLopHoc", danhSachLopHoc);
        setGiaoVienCoDinh(session);
        
        
        request.getRequestDispatcher(   "views/HomePage.jsp").forward(request, response);
    } 
private void setGiaoVienCoDinh(HttpSession session) {
    String[] tenGiaoVien = {
        "Đàm Quang Trung",
        "Vũ Văn Chủ",
        "Vũ Minh Hoàng",
        "Đỗ Huy Đô",
        "Ngô Xuân Tuấn Dũng"
    };
    
    GiaoVienDAO giaoVienDAO = new GiaoVienDAO();
    
    for (int i = 0; i < tenGiaoVien.length; i++) {
        GiaoVien gv = giaoVienDAO.getGiaoVienByHoTen(tenGiaoVien[i]);
        session.setAttribute("giaoVien" + (i + 1), gv);
    }
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
        processRequest(request, response);
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
