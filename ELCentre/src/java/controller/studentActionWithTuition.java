/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.HocPhiDAO;
import dal.HocSinhDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HocPhi;
import model.TaiKhoan;

/**
 *
 * @author wrx_Chur04
 */
public class studentActionWithTuition extends HttpServlet {
   
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
            out.println("<title>Servlet studentActionWithTuition</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet studentActionWithTuition at " + request.getContextPath () + "</h1>");
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
        String action = request.getParameter("action") ; 
        switch(action) {
            case "view" : 
                doView(request, response) ; 
                break ; 
        }
    } 

    protected void doView(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession() ; 
        String ID_LopHoc = request.getParameter("idLop") ; 
        String TenLopHoc = request.getParameter("TenLopHoc") ; 
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");
        int idTaiKhoan = user.getID_TaiKhoan();
        int idHocSinh = HocSinhDAO.getHocSinhIdByTaiKhoanId(idTaiKhoan);
        PrintWriter out = response.getWriter() ; 
        
        ArrayList<HocPhi> hocphis = HocPhiDAO.GetAllInforHocPhiLopHocHocSinh(ID_LopHoc , idHocSinh ) ; 
        if (hocphis != null ) {
            request.setAttribute("hocphis", hocphis);
            request.setAttribute("TenLopHoc", TenLopHoc);
            request.getRequestDispatcher("/views/student/studentReceiveHocPhi.jsp").forward(request, response);
        }
        
    }
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
