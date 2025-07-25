/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AdminDAO;
import dal.GiaoVienDAO;
import dal.HoTroDAO;
import dal.HocSinhDAO;
import dal.LopHocDAO;
import dal.ThongBaoDAO;
import dal.UserLogsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import model.Admin;
import model.HoTro;
import model.UserLogView;

/**
 *
 * @author wrx_Chur04
 */
public class adminGoToFirstPage extends HttpServlet {
   
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
            out.println("<title>Servlet adminGoToFirstPage</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminGoToFirstPage at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        LocalDate date = LocalDate.now();
         String datteBien = date.toString(); 
         ArrayList<Admin> admins  =  AdminDAO.getNameAdmin() ; 
         Integer tongSoHocSinhDangHoc = HocSinhDAO.adminGetTongSoHocSinhDangHoc();
         Integer tongSoGiaoVienDangDay = GiaoVienDAO.adminGetTongSoGiaoVienDangDay();
         Integer tongSoLopHocDangHoc = LopHocDAO.adminGetTongSoLopHocDangHoc();
         Integer tongSoHocSinhChoHoc = HocSinhDAO.adminGetTongSoHocSinhChoHoc();
         ArrayList<UserLogView> userLogsList =  UserLogsDAO.adminGetAllUserLogs(datteBien);
         ArrayList<HoTro> HoTroList = (ArrayList) HoTroDAO.adminGetHoTroDashBoard();
         Integer tongSoDonTuVan = ThongBaoDAO.getSoTuVan() ;
        request.setAttribute("admins", admins);
        request.setAttribute("ngayHomNay", datteBien);
        request.setAttribute("tongHS", tongSoHocSinhDangHoc);
        request.setAttribute("tongGV", tongSoGiaoVienDangDay);
        request.setAttribute("tongSoDonTuVan", tongSoDonTuVan);
        request.setAttribute("tongLH", tongSoLopHocDangHoc);
        request.setAttribute("hsChoHoc", tongSoHocSinhChoHoc);
        request.setAttribute("userLogsList", userLogsList);
        request.setAttribute("HoTroList", HoTroList);

            request.getRequestDispatcher("/views/admin/adminDashboard.jsp").forward(request, response);
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