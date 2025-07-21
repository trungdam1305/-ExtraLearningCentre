/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HoTroDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.HoTro;

/**
 *
 * @author wrx_Chur04
 */
public class staffGetSupportRequests extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet staffGetSupportRequests</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet staffGetSupportRequests at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                HttpSession session = request.getSession();
                ArrayList<HoTro> HoTroList = HoTroDAO.adminGetHoTroDashBoard();
                session.setAttribute("HoTroList", HoTroList);
                request.getRequestDispatcher("/views/staff/staffViewHoTro.jsp").forward(request, response);
                

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ID_HoTro = request.getParameter("id") ; 
        String phanHoi = request.getParameter("phanHoi") ; 
        String daDuyet = request.getParameter("daDuyet") ; 
        if (daDuyet.equalsIgnoreCase("daduyet") ) {
            boolean s1 = HoTroDAO.duyetHoTroOK(ID_HoTro, phanHoi) ; 
             HttpSession session = request.getSession();
            ArrayList<HoTro> HoTroList = HoTroDAO.adminGetHoTroDashBoard();
                session.setAttribute("HoTroList", HoTroList);
                request.getRequestDispatcher("/views/staff/staffViewHoTro.jsp").forward(request, response);
        } else {
            boolean s2 = HoTroDAO.duyetHoTroKhongOK(ID_HoTro, phanHoi) ;
             HttpSession session = request.getSession();
            ArrayList<HoTro> HoTroList = HoTroDAO.adminGetHoTroDashBoard();
                session.setAttribute("HoTroList", HoTroList);
                request.getRequestDispatcher("/views/staff/staffViewHoTro.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}