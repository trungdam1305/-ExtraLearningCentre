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
import model.HocSinh;
import dal.HocSinhDAO;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HocSinh_ChiTietHoc ; 
import dal.HocSinh_ChiTietDAO ; 

/**
 *
 * @author wrx_Chur04
 */
public class adminActionWithStudent extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet adminActionWithStudent</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminActionWithStudent at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                doView(request, response);
                break;

            case "viewDiem":
                doViewDiem(request, response) ; 
                break;

            case "update":
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    protected void doView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter() ; 
        String ID = request.getParameter("id");
        String ID_TaiKhoan = request.getParameter("idtaikhoan") ; 
        ArrayList<HocSinh> hocsinhs = HocSinhDAO.adminGetHocSinhByID(ID_TaiKhoan);
        if (hocsinhs != null) {
            request.setAttribute("hocsinhs", hocsinhs);
            request.getRequestDispatcher("/views/admin/adminViewHocSinhChiTiet.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Không có thông tin của học sinh này");
            request.getRequestDispatcher("/views/admin/adminViewHocSinhChiTiet.jsp").forward(request, response);
        }

    }
    
    
    protected void doViewDiem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter() ; 
        String ID = request.getParameter("id");
        String ID_TaiKhoan = request.getParameter("idtaikhoan") ; 
        
        ArrayList<HocSinh_ChiTietHoc> hocsinhchitiets = HocSinh_ChiTietDAO.adminGetAllLopHocCuaHocSinh(ID) ; 
        if (hocsinhchitiets != null ){
            request.setAttribute("hocsinhchitiets", hocsinhchitiets);
            request.getRequestDispatcher("views/admin/adminViewDiemHocSinh.jsp").forward(request, response);
        } else {
            
            out.print("okkokokok");
        }
    }
}
