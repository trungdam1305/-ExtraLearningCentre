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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList ; 
import model.TaiKhoan ; 
import dal.TaiKhoanDAO ; 
import model.HocSinh ;
import dal.HocSinhDAO ; 
import model.GiaoVien ; 
import dal.GiaoVienDAO ; 


/**
 *
 * @author wrx_Chur04
 */
public class adminGetFromDashboard extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet adminGetFromDashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminGetFromDashboard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") ; 
        PrintWriter out = response.getWriter() ; 
        HttpSession session = request.getSession() ; 
        switch(action) {
            case "taikhoan" :
                ArrayList<TaiKhoan> taikhoans = new ArrayList<TaiKhoan>() ; 
                taikhoans =  TaiKhoanDAO.adminGetAllTaiKhoan() ; 
                if (taikhoans.isEmpty() ){
                    
                    
                } else {
                    session.setAttribute("taikhoans", taikhoans);
                    request.getRequestDispatcher("/views/admin/adminReceiveUsers.jsp").forward(request, response);
                }
                
                break ; 
                
                
            case "hocsinh": 
                ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>() ; 
                hocsinhs =  HocSinhDAO.adminGetAllHocSinh(); 
                if (hocsinhs.isEmpty() ){
                    
                    
                } else {
                    session.setAttribute("hocsinhs", hocsinhs);
                    request.getRequestDispatcher("/views/admin/adminReceiveHocSinh.jsp").forward(request, response);
                }
                
                break ; 
                
            case "giaovien": 
                ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>() ; 
                giaoviens =  GiaoVienDAO.admminGetAllGiaoVien() ; 
                if (giaoviens == null  ){
                    out.print("huhuhuu");
                    
                } else {
                   request.setAttribute("giaoviens", giaoviens);


                    request.getRequestDispatcher("/views/admin/adminReceiveGiaoVien.jsp").forward(request, response);
                }
                
                break ; 
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
    }// </editor-fold>

}
